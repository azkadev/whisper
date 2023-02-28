## Cara Mengcompile ke shared library

1. Cross Platform
```bash
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
```

2. Untuk Android

```bash
cmake .. -DCMAKE_TOOLCHAIN_FILE=${ANDROID_SDK}/ndk/24.0.8215888/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a
cmake --build .
```



## Cara compile ke static program

```bash
cc  -O3 -std=c11   -pthread  -c whisper.cpp/ggml.c -o ggml.o
c++ -O3 -std=c++11 -pthread -c whisper.cpp/whisper.cpp -o whisper.o
c++ -O3 -std=c++11 -pthread whisper.cpp/examples/main/main.cpp whisper.o ggml.o -o main  -framework Accelerate
```