List<Map> api_schemes = [
  {
    "@type": "getTextFromWavFile",
    "is_translate": false,
    "threads": 12,
    "is_verbose": false,
    "language": "id",
    "is_special_tokens": false,
    "is_no_timestamps": false,
    "audio": "./audio.wav",
    "model": "./model.bin",
  },
  {
    "@type":"getVersion",
  }
];