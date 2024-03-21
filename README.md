# Whisper

Whisper adalah project open source dari [openai](https://github.com/openai) untuk mengeluarkan text dari suara, project ini menggunakan [whisper.cpp](https://github.com/ggerganov/whisper.cpp), Dan menggunakan [FFMPEG](https://github.com/FFmpeg/FFmpeg) untuk mengconvert audio ke wav, Project ini bisa di jalankan di client side dan server side dan tidak memerlukan internet.

## Demo

1. Flutter App

https://user-images.githubusercontent.com/82513502/220721473-3303ab00-e272-4b58-bfe5-86fb9db05814.mp4



## NEED More Update And More Features?

Indonesia: jika anda ingin saya maintance terus project ini silahkan [donate ke saya](https://github.com/sponsors/azkadev)
<br>
English: if you want me to continue to maintain this project please [donate to me](https://github.com/sponsors/azkadev)

 
## Resources

Assets yang di perlukan.

1. [Datasets Whisper GGML](https://huggingface.co/datasets/ggerganov/whisper.cpp)

### Memory Usage

| Model  | Disk   | Mem    |
|--------|--------|--------|
| tiny   | 75 MB  | 125 MB |
| base   | 142 MB | 210 MB |
| small  | 466 MB | 600 MB |
| medium | 1.5 GB | 1.7 GB |
| large  | 2.9 GB | 3.3 GB |

### Roadmap Features

Features yang akan datang

1. [x] Cross Platform (Android / linux / windows / ios / macos)
2. [ ] Add FFMPEG KIT Cross Platform (Android / linux / windows / ios / macos)
3. [ ] Docs

### TESTED ON

| NO | OS                                   | CPU             | RAM     |
|----|--------------------------------------|-----------------|---------|
| 1  | Ubuntu 20.04                         | AMD RYZEN 5500U | 8GB     |
| 2  | Android 11                           | Snapdragon 665  | 3GB     |
| 3  | Android 5                            | Snapdragon 430  | 2GB     |
| 4  | Windows 11 Pro 22H2 (22621.1105)     | AMD RYZEN 3600  | 16GB    |
| 5  | Android 13                           | Snapdragon 730  | 4GB     |
| 6  | Pixel 3a API 33 AndroiD x64 emulator | Unknown         | Unknown |

Untuk devices lainya saya tidak tahu bisa / enggak karena saya tidak ada devices

## Contributors

1. [JeisonSanches](https://github.com/JeisonSanches) - [Whisper Flutter](https://github.com/azkadev/whisper_dart/tree/main/package/whisper_flutter)

## Quickstart
1. Dart
Jika anda ingin menggunakan whisper di cli / backend server anda menggunakan ini

- Install package dulu
```bash
dart pub add whisper_dart
```

- Tambahkan library

```dart
import "package:whisper_dart/whisper_dart.dart";
```

2. Flutter app

Jika anda ingin menggunakan whisper di app anda menggunakan ini

- Install package dulu
```bash
flutter pub add whisper_flutter
```

- Tambahkan library

```dart
import "package:whisper_flutter/whisper_flutter.dart";
```

### Code

```dart
Whisper whisper = Whisper();
var res = await whisper.request(
    whisperLib: "libwhisper.so", # jika anda menggunakan whisper flutter anda tidak perlu menambahkan whisperLib karena sudah automatis
    # pastikan audio yang kamu gunakan berformat wav ya
    whisperRequest: WhisperRequest.fromWavFile(
        audio: File(audio),
        model: File(model),
    ),
);
```
 
### Note

Untuk perangkat macOS, IOS saat ini saya belum mencoba karena gak ada device

<h3 align="center">Global Corporation</h3>

<h3 align="center">
  Welcome to Global Corporation profile!
  <img src="https://media.giphy.com/media/hvRJCLFzcasrR4ia7z/giphy.gif" width="28">
</h3>

<!-- Social icons section -->
<p align="center">
  <a href="https://www.instagram.com/global__corporation/"><img width="32px" alt="Instagram" title="Telegram" src="https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png"/></a>
  &#8287;&#8287;&#8287;&#8287;&#8287;
  <a href="https://t.me/GLOBAL_CORPORATION_ORG"><img width="32px" alt="Twitter" title="Telegram" src="https://upload.wikimedia.org/wikipedia/commons/8/82/Telegram_logo.svg"/></a>
  &#8287;&#8287;&#8287;&#8287;&#8287;
  <a href="https://twitter.com/global_corp_org"><img width="32px" alt="Twitter" title="Twitter" src="https://upload.wikimedia.org/wikipedia/commons/6/6f/Logo_of_Twitter.svg"/></a>
  &#8287;&#8287;&#8287;&#8287;&#8287;
  <a href="https://www.youtube.com/@global_Corporation"><img width="32px" alt="Youtube" title="Youtube" src="https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png"/></a>
  &#8287;&#8287;&#8287;&#8287;&#8287;
</p>


**Global Corporation**

adalah perusahaan terkemuka yang mengambil peran utama dalam mempercepat dan mempertahankan keamanan perusahaan. 

Dengan fokus yang tajam pada inovasi dan keunggulan teknologi

**Global Corporation** menyediakan solusi proaktif yang efektif untuk mengamankan operasional perusahaan dan mencegah potensi risiko merugikan. 

Dengan tim ahli yang berkomitmen, teknologi canggih, dan pendekatan holistik terhadap keamanan perusahaan, Global Corporation telah menjadi acuan utama bagi perusahaan lain yang mengutamakan keamanan dan keselamatan sebagai prioritas utama dalam bisnis mereka.


## Social Media

<h3 align="center">
  Telegram
  <img src="https://upload.wikimedia.org/wikipedia/commons/8/82/Telegram_logo.svg" width="20">
</h3>

1. [Group Developer Global Public](https://t.me/DEVELOPER_GLOBAL_PUBLIC)

## Product / Services

1. **Clone Bot / Userbot**
  Hai kamu ingin punya bot / userbot dengan banyak features?. 
  - **Features**:
    - **Repeat Message**
    - **Manage Chat Private / Channel / Group**
  - **Platform Support**:
    - **Telegram**
    - **Whatsapp**
    - **Twitter**
    - **Github**
    - **Google** 
2. **Products**
    - **Black Products**
    - **Group / Channel**
    - **Nsfw**
    - **Payment Gateway**
    - **Paid Promote**
    - **Pre Release / Beta**
    - **Promo Cheap**
    - **Source Code Bot / USerbot**
    - **Trade**
3. **Services**
    - **Developer**
    - **Goal**
    - **Partner**
    - **Promote**
    - **Recommendation**
    - **Sortcut Cheat Sheet**
    - **Terminate**
    - **Upgrade**

## Cara Beli Jasa / Products 

- **Lewat Telegram**
  Jika kamu ingin membeli bisa lewat telegram
  -  Buka Bot: https://t.me/GLOBAL_CORP_ORG_BOT
  -  Isi data pribadi / subscribe channel
  -  Tap Main menu pilih services / products
  -  Pilih Product / Services
  -  Pastikan coin mencukupi
  -  Isi data yang di butuhkan
  
Video Tutorial
[![Watch the video](https://img.youtube.com/vi/TY0Y21C6asM/maxresdefault.jpg)](https://www.youtube.com/watch?v=TY0Y21C6asM)

- **Lewat App**
  jika kamu ingin melihat prroduct / jasa dengan full demo kamu bisa beli lewat app
 


## 📺 Latest YouTube Videos

  <!-- prettier-ignore-start -->
  <!-- BEGIN YOUTUBE-CARDS -->
[![Cara beli ai telegram versi bot dan cara pakai| Global Corporation](https://ytcards.demolab.com/?id=7LZhoklvS9A&title=Cara+beli+ai+telegram+versi+bot+dan+cara+pakai%7C+Global+Corporation&lang=id&timestamp=1710937415&background_color=%230d1117&title_color=%23ffffff&stats_color=%23dedede&max_title_lines=1&width=250&border_radius=5 "Cara beli ai telegram versi bot dan cara pakai| Global Corporation")](https://www.youtube.com/watch?v=7LZhoklvS9A)
[![Ai Userbot Telegram Demo Cara Pakai Dan Beli | Global Corporation](https://ytcards.demolab.com/?id=4mAZ6EgAhUo&title=Ai+Userbot+Telegram+Demo+Cara+Pakai+Dan+Beli+%7C+Global+Corporation&lang=id&timestamp=1710936251&background_color=%230d1117&title_color=%23ffffff&stats_color=%23dedede&max_title_lines=1&width=250&border_radius=5 "Ai Userbot Telegram Demo Cara Pakai Dan Beli | Global Corporation")](https://www.youtube.com/watch?v=4mAZ6EgAhUo)
[![CARA BELI USERBOT TELEGRAM CLOUD  | Global Corporation](https://ytcards.demolab.com/?id=uiDJwK9r3Cg&title=CARA+BELI+USERBOT+TELEGRAM+CLOUD++%7C+Global+Corporation&lang=id&timestamp=1710900440&background_color=%230d1117&title_color=%23ffffff&stats_color=%23dedede&max_title_lines=1&width=250&border_radius=5 "CARA BELI USERBOT TELEGRAM CLOUD  | Global Corporation")](https://www.youtube.com/watch?v=uiDJwK9r3Cg)
[![Cara Top Up Automatis Menggunakan Payment Gateway Di GLOBAL BOT APP](https://ytcards.demolab.com/?id=ADqzS5ORJsU&title=Cara+Top+Up+Automatis+Menggunakan+Payment+Gateway+Di+GLOBAL+BOT+APP&lang=id&timestamp=1710721879&background_color=%230d1117&title_color=%23ffffff&stats_color=%23dedede&max_title_lines=1&width=250&border_radius=5 "Cara Top Up Automatis Menggunakan Payment Gateway Di GLOBAL BOT APP")](https://www.youtube.com/watch?v=ADqzS5ORJsU)
[![Cara Membeli Jasa Developer / Paid Promote / ADS / dll Di Telegram Bot | Global Corporation](https://ytcards.demolab.com/?id=TY0Y21C6asM&title=Cara+Membeli+Jasa+Developer+%2F+Paid+Promote+%2F+ADS+%2F+dll+Di+Telegram+Bot+%7C+Global+Corporation&lang=id&timestamp=1710717990&background_color=%230d1117&title_color=%23ffffff&stats_color=%23dedede&max_title_lines=1&width=250&border_radius=5 "Cara Membeli Jasa Developer / Paid Promote / ADS / dll Di Telegram Bot | Global Corporation")](https://www.youtube.com/watch?v=TY0Y21C6asM)
[![Global Userbot Telegram](https://ytcards.demolab.com/?id=Kyj1Zl04_68&title=Global+Userbot+Telegram&lang=id&timestamp=1710690464&background_color=%230d1117&title_color=%23ffffff&stats_color=%23dedede&max_title_lines=1&width=250&border_radius=5 "Global Userbot Telegram")](https://www.youtube.com/watch?v=Kyj1Zl04_68)
<!-- END YOUTUBE-CARDS -->
  <!-- prettier-ignore-end -->
