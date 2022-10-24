#include "whisper.h"

#define DR_WAV_IMPLEMENTATION
#include "dr_wav.h"
#include <cstdio>
#include <string>
#include <thread>
#include <vector>
#include <iostream>
#include "json/json.hpp"
#include <stdio.h>
using json = nlohmann::json;

extern "C"
{

    void print(std::string value)
    {
        std::cout << value << std::endl;
    }

    char *jsonToChar(json jsonData)
    {
        std::string result = jsonData.dump();
        char *ch = new char[result.size() + 1];
        strcpy(ch, result.c_str());
        return ch;
    }

    std::string charToString(char *value)
    {
        std::string result(value);
        return result;
    }

    char *stringToChar(std::string value)
    {
        char *ch = new char[value.size() + 1];
        strcpy(ch, value.c_str());
        return ch;
    }

    //  500 -> 00:05.000
    // 6000 -> 01:00.000
    std::string to_timestamp(int64_t t)
    {
        int64_t sec = t / 100;
        int64_t msec = t - sec * 100;
        int64_t min = sec / 60;
        sec = sec - min * 60;

        char buf[32];
        snprintf(buf, sizeof(buf), "%02d:%02d.%03d", (int)min, (int)sec, (int)msec);

        return std::string(buf);
    }

    // command-line parameters
    struct whisper_params
    {
        int32_t seed = -1; // RNG seed, not used currently
        int32_t n_threads = std::min(4, (int32_t)std::thread::hardware_concurrency());

        bool verbose = false;
        bool translate = false;
        bool print_special_tokens = false;
        bool no_timestamps = false;

        std::string language = "id";
        std::string model = "models/ggml-model-whisper-small.bin";
        std::string audio = "samples/jfk.wav";
    };

    json transcribe(json jsonBody)
    {
        whisper_params params;

        params.n_threads = jsonBody["threads"];
        params.verbose = jsonBody["is_verbose"];
        params.translate = jsonBody["is_translate"];
        params.language = jsonBody["language"];
        params.print_special_tokens = jsonBody["is_special_tokens"];
        params.no_timestamps = jsonBody["is_no_timestamps"];
        params.model = jsonBody["model"];
        params.audio = jsonBody["audio"];
        json jsonResult;
        jsonResult["@type"] = "transcribe";

        if (whisper_lang_id(params.language.c_str()) == -1)
        {
            jsonResult["@type"] = "error";
            jsonResult["message"] = "error: unknown language";
            return jsonResult;
        }

        if (params.seed < 0)
        {
            params.seed = time(NULL);
        }

        // whisper init

        struct whisper_context *ctx = whisper_init(params.model.c_str());
        std::string text_result = "";
        // for (int f = 0; f < (int)params.fname_inp.size(); ++f)
        // {
        const auto fname_inp = params.audio;
        // WAV input
        std::vector<float> pcmf32;
        {
            drwav wav;
            if (!drwav_init_file(&wav, fname_inp.c_str(), NULL))
            {
                jsonResult["@type"] = "error";
                jsonResult["message"] = " failed to open WAV file ";
                return jsonResult;
            }

            if (wav.channels != 1 && wav.channels != 2)
            {
                jsonResult["@type"] = "error";
                jsonResult["message"] = "must be mono or stereo";
                return jsonResult;
            }

            if (wav.sampleRate != WHISPER_SAMPLE_RATE)
            {
                jsonResult["@type"] = "error";
                jsonResult["message"] = "WAV file  must be 16 kHz";
                return jsonResult;
            }

            if (wav.bitsPerSample != 16)
            {
                jsonResult["@type"] = "error";
                jsonResult["message"] = "WAV file  must be 16 bit";
                return jsonResult;
            }

            int n = wav.totalPCMFrameCount;

            std::vector<int16_t> pcm16;
            pcm16.resize(n * wav.channels);
            drwav_read_pcm_frames_s16(&wav, n, pcm16.data());
            drwav_uninit(&wav);

            // convert to mono, float
            pcmf32.resize(n);
            if (wav.channels == 1)
            {
                for (int i = 0; i < n; i++)
                {
                    pcmf32[i] = float(pcm16[i]) / 32768.0f;
                }
            }
            else
            {
                for (int i = 0; i < n; i++)
                {
                    pcmf32[i] = float(pcm16[2 * i] + pcm16[2 * i + 1]) / 65536.0f;
                }
            }
        }

        // print some info about the processing
        {
            // printf("\n");
            if (!whisper_is_multilingual(ctx))
            {
                if (params.language != "en" || params.translate)
                {
                    params.language = "en";
                    params.translate = false;
                    // printf("%s: WARNING: model is not multilingual, ignoring language and translation options\n", __func__);
                }
            }
            // printf("%s: processing '%s' (%d samples, %.1f sec), %d threads, lang = %s, task = %s, timestamps = %d ...\n",
            //        __func__, fname_inp.c_str(), int(pcmf32.size()), float(pcmf32.size()) / WHISPER_SAMPLE_RATE, params.n_threads,
            //        params.language.c_str(),
            //        params.translate ? "translate" : "transcribe",
            //        params.no_timestamps ? 0 : 1);
            // printf("\n");
        }
        // run the inference
        {
            whisper_full_params wparams = whisper_full_default_params(WHISPER_SAMPLING_GREEDY);

            wparams.print_realtime = false;
            wparams.print_progress = false;
            wparams.print_timestamps = !params.no_timestamps;
            wparams.print_special_tokens = params.print_special_tokens;
            wparams.translate = params.translate;
            wparams.language = params.language.c_str();
            wparams.n_threads = params.n_threads;

            if (whisper_full(ctx, wparams, pcmf32.data(), pcmf32.size()) != 0)
            {
                jsonResult["@type"] = "error";
                jsonResult["message"] = "failed to process audio";
                return jsonResult;
            }

            // print result;
            if (!wparams.print_realtime)
            {

                const int n_segments = whisper_full_n_segments(ctx);
                for (int i = 0; i < n_segments; ++i)
                {
                    const char *text = whisper_full_get_segment_text(ctx, i);

                    std::string str(text);
                    text_result += str;
                    if (params.no_timestamps)
                    {
                        // printf("%s", text);
                        // fflush(stdout);
                    }
                    else
                    {
                        // const int64_t t0 = whisper_full_get_segment_t0(ctx, i);
                        // const int64_t t1 = whisper_full_get_segment_t1(ctx, i);

                        // printf("[%s --> %s]  %s\n", to_timestamp(t0).c_str(), to_timestamp(t1).c_str(), text);
                    }
                }
            }
        }
        // }
        jsonResult["text"] = text_result;
        // whisper_print_timings(ctx);
        whisper_free(ctx);
        return jsonResult;
    }

    char *request(char *body)
    {
        json jsonBody = json::parse(body);
        json jsonResult;

        if (jsonBody["@type"] == "getTextFromWavFile")
        {
            return jsonToChar(transcribe(jsonBody));
        }

        if (jsonBody["@type"] == "getVersion")
        {
            jsonResult["@type"] = "version";
            jsonResult["message"] = "version lib v0.0.0";
            return jsonToChar(jsonResult);
        }

        jsonResult["@type"] = "error";
        jsonResult["message"] = "method not found";
        return jsonToChar(jsonResult);
    }

    int main()
    {
        json jsonBody;
        jsonBody["@type"] = "al";
        print(transcribe(jsonBody).dump());
        return 0;
    }
}