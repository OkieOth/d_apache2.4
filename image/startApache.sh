#!/bin/bash
scriptPos=${0%/*}

extraConfDir=/opt/extra-conf-enabled 
extraSitesDir=/opt/extra-sites-enabled 

if [ -d $extraConfDir ]; then
    # an extern configuration directory found ... if the directory is empty some
    # additional initialisation is 
    for f in $extraConfDir/*.conf; do
        if ! [ -f $f ]; then continue; fi
        if cp "$f" /etc/apache2/conf-enabled; then
            echo "copied configuration $f to /etc/apache2/conf-enabled"
        else
            echo "error while copy configuration $f to /etc/apache2/conf-enabled"
        fi
    done
fi

if [ -d $extraSitesDir ]; then
    for f in $extraSitesDir/*.conf; do
        if ! [ -f $f ]; then continue; fi
        if cp "$f" /etc/apache2/sites-enabled; then
            echo "copied configuration $f to /etc/apache2/sites-enabled"
        else
            echo "error while copy configuration $f to /etc/apache2/sites-enabled"
        fi
    done
fi

if [ -z $DEBUG_LEVEL ]; then
    DEBUG_LEVE=info
fi
if [ -f /var/run/apache2/apache2.pid ]; then
    rm -f /var/run/apache2/apache2.pid
fi

apachectl -f /etc/apache2/apache2.conf -e info -DFOREGROUND


