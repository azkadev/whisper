FROM ubuntu

WORKDIR /app/

ADD ./ /app/

RUN apt-get update

RUN apt-get install -y \
    sudo \
    wget \
    unzip \
    lz4 

RUN sudo dpkg --force-all -i ./whisper.deb

CMD ["index", "run"]

