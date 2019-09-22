FROM balenalib/rpi-raspbian:buster

RUN buildDeps="build-essential git debhelper gobject-introspection gtk-doc-dools libgirepository1.0-dev libglib2.0-dev libgnutls28-dev libgstreamer1.0-dev libgupnp-igd-1.0-dev autotools-dev dh-autoreconf dh-systemd gengetopt libavcodec-dev libavformat-dev libavutil-dev libconfig-dev libcurl4-openssl-dev libcurl4-openssl-dev libjansson-dev liblua5.3-dev libmicrohttpd-dev libnanomsg-dev libogg-dev libopus-dev librabbitmq-dev libre-dev libsofia-sip-ua-dev libsrtp2-dev libssl-dev libsystemd-dev libusrsctp-dev libwebsockets-dev pkg-config rename"
    echo 'APT::Install-Recommends "false";' >/etc/apt/apt.conf.d/00recommends \
    && echo 'APT::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
    && apt-get update \
    && apt-get install $buildDeps \
    && git clone --depth 1 --single-branch --branch libnice-0.16 /tmp/libnice \
    && cd /tmp/libnice \
    && dpkg-buildpackage -b --no-sign -rfakeroot \
    && dpkg -i ../libnice10_0.1.16-1_armhf.deb ../libnice-dev_0.1.16-1_armhf.deb \
    && cd /tmp \
    && apt-get source janus \
    && cd janus-0.6.1 \
    && dpkg-buildbackage -b --no-sign -rfakeroot \
    && dpkg -i ../janus_0.6.1-1_armhf.deb ../janus-tools_0.6.1-1_armhf.deb \
    && cd /
    && apt-get --purge remove $buildDeps \
    && apt-get --purge autoremove \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*
