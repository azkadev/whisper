#!/bin/sh

rm -rf build*
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .

cd ..

mkdir -p build-android-arm64-v8a
cd build-android-arm64-v8a

cmake .. -DCMAKE_TOOLCHAIN_FILE=${ANDROID_SDK}/ndk/24.0.8215888/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=21
cmake --build .

cd ..

mkdir -p build-android-armeabi-v7a
cd build-android-armeabi-v7a


cmake .. -DCMAKE_TOOLCHAIN_FILE=${ANDROID_SDK}/ndk/24.0.8215888/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=21
cmake --build .

cd ..

mkdir -p build-android-x86_64
cd build-android-x86_64


cmake .. -DCMAKE_TOOLCHAIN_FILE=${ANDROID_SDK}/ndk/24.0.8215888/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=x86_64 -DANDROID_PLATFORM=21
cmake --build .


cd ..

mkdir -p build-android-x86
cd build-android-x86


cmake .. -DCMAKE_TOOLCHAIN_FILE=${ANDROID_SDK}/ndk/24.0.8215888/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=x86 -DANDROID_PLATFORM=21
cmake --build .

