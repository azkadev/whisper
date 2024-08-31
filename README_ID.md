# Whisper

Whisper adalah sebuah library opensource milik open ai yang berguna untuk mengubah / mendapatkan text dari sebuah audio


## Peringatan

Library ini di buat 100% tanpa menjiplak kode orang lain, jika anda ingin feature silahkan request (jangan menulis ulang lalu mengpublish di pub.dev) / tempat lainya tanpa mencamtumkan nama SAYA [AZKADEV](https://github.com/azkadev)


## Demo


## Status

Sudah siap di gunakan untuk umum / produksi 

## Features

1. Cross Platform
   - [x] linux
   - [x] android
   - [x] cli
   - [ ] windows
   - [ ] macos
   - [ ] web
   - [ ] ios
  
2. Realtime Transcribe
   - [ ] android
   - [ ] linux
   - [ ] macos
   - [ ] cli
   - [ ] windows
   - [ ] web
   - [ ] ios

3. Bisa Transcribe Semua jenis audio / video Tanpa perlu manual convert / rubah ke wav
   - [ ] android
   - [ ] linux
   - [ ] macos
   - [ ] cli
   - [ ] windows
   - [ ] web
   - [ ] ios

## Device Tested
| NAME            | OS                  | CPU             | GPU | RAM  |
|-----------------|---------------------|-----------------|-----|------|
| REALME 5        | LINEAGE OS ANDROID  | SNAPDRAGON 665  |     | 3GB  |
| MSI MODERN 14   | UBUNTU 24.04        | AMD RYZEN 5500u |     | 16GB |
| XIAOMI REDMI 4a | MIUI                |                 |     | 2GB  |
| ACER            | UBUNTU SERVER 24.04 |                 |     |      |

## Support

jika anda berharap saya menerapkan pada platform tertentu selain linux / android berikan saya donasi uang di github agar saya bisa membeli perangkat, karena saat ini perangkat saya hanya 2


## Kenapa Di Tulis ulang?

Di karenakan versi lama sangat kacau / berantakan, saya membuat ulang menggunakan style code yang hampir sama, namun semuanya di rubah agar bisa berjalan cross platform dan support semua feature terbaru dari sumber asli [Whisper.cpp]

## Bagaimana Ini Bekerja

Sebenarnya saya menggunakan 3 kerangka kerja agar library ini berjalan

1. Bagaimana bisa berjalan di DART
   secara contoh asli yang ada pada whisper.cpp terdapat sumber code untuk menjalankan di cli 
   yang harus menjalankan command seperti
   ./main bla bla bla bla -model path_to_model
   
   itu adalah sumber acuan pertama agar kita bisa mengubah sumber code.

   Contoh:
   ini adalah source asli

   saya menambah bagian sedikit, dan mengubah parameters data menjadi json, hal ini di karenakan json flexible sehingga sangat mudah di pakai dan di applikasikan ke berbagai program
   setelah itu saya membuat CMakeLists.txt ini untuk mengcompile semua source code cpp / c / native yang di butuhkan

2. Bagaimana Bisa berjalan di FLUTTER
   secara teori jika anda berhasil melakukan tadi menjalankan di dart maka akan berjalan di flutter hal ini karena flutter menggunakan bahasa dart

3. Bagaimana Bisa berjalan di web / wasm
   secara teori jika anda berhasil menjalankan di dart jika anda bisa mengubah style code dasar yang akan di gunakan secara general (SCHEMA) anda bisa menjalankan di web walaupun mungkin ada feature yang tidak bisa di gunakan seperti auto convert

## Kenapa harus support saya?

Di karenakan kebanyakan library hanya fokus pada platform tertentu tidak ingin / tidak ada rencana berjalan di semua platform oleh karena itu mungkin anda bisa mengsupport saya melalui hal di bawah

1. DONATE / SPONSOR
   Sebenarnya selain saya membuat library untuk orang umum / mempermudah saya juga ingin mendapat dana agar saya bisa mempercepat release baru, semakin banyak donate akan ada kesempatan untuk release baru program / support pada platform tertentu

2. FOLLOW SOCIAL MEDIA
   Saya ingin memperoleh penghasilan lainya sekaligus mengshare kontent tentang developer hal lainya mungkin jika anda tidak keberatan silahkan follow semuanya

## Install


## Cross platform?

tapi tidak ada tag dart di pub.dev? 

Hiraukan issue itu saya menambahkan flutter di library whisper sehingga library menjadi satu dan anda hanya merubah bagian import saja sesuai platform anda

## Quickstart


## Credit

1. [Whisper.cpp]()
2. [GGML]()

## FAQS

> Q: Akankah anda akan support dart penuh tanpa native library?
> A: Jika sumber uang saya banyak saya akan mengsupport penuh sehingga whisper akan berjalan sangat efficient

> Q: Saya ingin mengkomersialkan applikasi saya transcribe apakah saya harus membayar license / mencantumkan nama anda?
> A: Tidak perlu membayar license, ya sebaiknya anda mencantumkan saja nama saya / link social media saya

> Q: Saya ingin menambahkan di bot TELEGRAM | DISCORD | WA apakah bisa?
> A: Tentu namun saat ini saya hanya mengtest di cli di platform linux, jika anda berhasil compile library ke platform anda anda sudah bisa menggunakanya

# LICENSE

Tolong jangan mencoba membuat ulang code ini, jika ingin menambah silahkan cantumkan nama saya dan link github saya di project anda


