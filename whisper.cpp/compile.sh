#! /bin/sh

# cc -O3 -std=c11 -Wall -Wextra -Wno-unused-parameter -Wno-unused-function -pthread -c ggml.c -fPIC -lstdc++
# c++ -O3 -std=c++11 -Wall -Wextra -Wno-unused-parameter -Wno-unused-function -pthread -c whisper.cpp -fPIC -lstdc++
# c++ -O3 -std=c++11 -Wall -Wextra -Wno-unused-parameter -Wno-unused-function -pthread main.cpp whisper.o ggml.o --shared -o whisper.so -fPIC -lstdc++
gcc -pthread -O3 -mavx -mavx2 -mfma -mf16c -c ggml.c -fPIC -lstdc++
gcc -pthread -O3 -mavx -mavx2 -mfma -mf16c -c whisper.cpp -fPIC -lstdc++
g++ -pthread -O3 -std=c++11 -c main.cpp -fPIC -lstdc++
g++ -pthread -o ./whisper.so whisper.o ggml.o main.o --shared -fPIC -lstdc++
