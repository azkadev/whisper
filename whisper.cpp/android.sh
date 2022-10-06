#! /bin/sh

/home/hexaminate/Android/Sdk/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang -O3 -std=c11 -Wall -Wextra -Wno-unused-parameter -Wno-unused-function -pthread -c ggml.c -fPIC -lstdc++
/home/hexaminate/Android/Sdk/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang++ -O3 -std=c++11 -Wall -Wextra -Wno-unused-parameter -Wno-unused-function -pthread -c whisper.cpp -fPIC -lstdc++
/home/hexaminate/Android/Sdk/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang++ -O3 -std=c++11 -Wall -Wextra -Wno-unused-parameter -Wno-unused-function -pthread main.cpp whisper.o ggml.o -o main -fPIC -lstdc++
