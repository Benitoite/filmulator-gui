FROM kd6kxr/buildqtsvg:buildqtsvg

# add the dependencies 

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends build-essential locales cmake git curl libcrypto++-dev libexiv2-dev libpq-dev libjpeg-dev libraw-dev liblcms2-dev libsigc++-2.0-dev libtiff5-dev ca-certificates ssl-cert -y

# prepare the environment

ENV LANG en-US.UTF-8
ENV LANGUAGE en-US.UTF-8:en
ENV LC_ALL en-US.UTF-8

ENV QTDIR /opt/local/Qt
ENV PATH $QTDIR/bin:$PATH

# clone source code, checkout dev branch

RUN cd ~ && git clone https://github.com/CarVac/filmulator-gui.git && cd ~/filmulator-gui && git checkout dev

# compile

RUN cd ~/filmulator-gui/filmulator-gui && qmake filmulator-gui.pro && make -j$(nproc --all)

# SET ENTRYPOINT COMMAND

CMD bash

LABEL maintainer="kd6kxr@gmail.com"
