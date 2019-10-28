FROM balenalib/raspberrypi3-debian

RUN buildDeps="build-essential git debhelper gobject-introspection gtk-doc-tools libgirepository1.0-dev libglib2.0-dev libgnutls28-dev libgstreamer1.0-dev libgupnp-igd-1.0-dev autotools-dev dh-autoreconf dh-systemd gengetopt libavcodec-dev libavformat-dev libavutil-dev libconfig-dev libcurl4-openssl-dev libcurl4-openssl-dev libjansson-dev liblua5.3-dev libmicrohttpd-dev libnanomsg-dev libogg-dev libopus-dev librabbitmq-dev libre-dev libsofia-sip-ua-dev libsrtp2-dev libssl-dev libsystemd-dev libusrsctp-dev libwebsockets-dev pkg-config rename fakeroot gir1.2-glib-2.0 libgirepository-1.0-1 pandoc brotli doxygen graphviz node-rollup-plugin-replace pigz rollup uglifyjs" \
    && echo "deb-src http://archive.raspbian.org/raspbian buster main contrib non-free rpi firmware" >> /etc/apt/sources.list \
    && echo 'APT::Install-Recommends "false";' >/etc/apt/apt.conf.d/00recommends \
    && echo 'APT::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
    && apt-get update \
    && apt-get install $buildDeps \
    && git clone --depth 1 --single-branch --branch libnice-0.16 https://salsa.debian.org/tzafrir/libnice.git /tmp/libnice \
    && cd /tmp/libnice \
    && dpkg-buildpackage -b --no-sign -rfakeroot \
    && dpkg -i ../libnice10_0.1.16-1_armhf.deb ../gir1.2-nice-0.1_0.1.16-1_armhf.deb ../libnice-dev_0.1.16-1_armhf.deb \
    && cd /tmp \
    && apt-get source janus \
    && cd janus-0.6.1 \
    && dpkg-buildpackage -b --no-sign -rfakeroot \
    && dpkg -i ../janus_0.6.1-1_armhf.deb ../janus-tools_0.6.1-1_armhf.deb \
    && cd / \
    && apt-get --purge remove $buildDeps \
    && apt-get --purge autoremove \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*
