# /bin/sh

dart compile exe bin/whisper_server.dart -o linux/packaging/usr/local/bin/whisper
dart run packagex build -o ./release/whisper.deb