```bash
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
```

For Android

```bash
cmake .. -DCMAKE_TOOLCHAIN_FILE=${ANDROID_SDK}/ndk/24.0.8215888/build/cmake/android.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a

cmake --build .
```
