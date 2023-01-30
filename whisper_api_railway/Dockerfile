FROM ubuntu

WORKDIR /app/

ADD ./ /app/

RUN apt-get update

RUN apt-get install -y \
    sudo \
    wget \
    unzip \
    ffmpeg

RUN wget --quiet --show-progress http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
RUN wget -O ./data/ggml-model-whisper-base.bin https://huggingface.co/datasets/ggerganov/whisper.cpp/resolve/main/ggml-base.bin
RUN sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
RUN sudo dpkg --force-all -i ./whisper-api.deb

CMD ["index"]