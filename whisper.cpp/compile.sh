#! /bin/sh
gcc -pthread -O3 -mavx -mavx2 -mfma -mf16c -c ggml.c -fPIC -lstdc++
g++ -pthread -O3 -std=c++11 -c main.cpp -fPIC -lstdc++
g++ -pthread -o azka.so ggml.o main.o --shared -fPIC -lstdc++
