FROM debian:8.6
RUN echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \ 
    apt-get update && \
    apt-get install -y --force-yes apache2 net-tools && \
    rm -rf /var/lib/apt/lists/* && \
    find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true && \
    find /usr/share/doc -empty|xargs rmdir || true && \
    rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* && \
    rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*

RUN a2enmod expires headers proxy_http proxy_ajp

RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log
COPY startApache.sh /startApache.sh

CMD ["/startApache.sh"]
