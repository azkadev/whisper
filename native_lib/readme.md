```bash
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
```

```bash
cmake .. -DCMAKE_TOOLCHAIN_FILE=${ANDROID_SDK}/ndk/24.0.8215888/build/cmake/android.toolchain.cmake -DANDROID_STL=c++_shared -DCMAKE_BUILD_TYPE=MinSizeRel -GNinja -DANDROID_ABI=arm64-v8a

cmake --build .
```