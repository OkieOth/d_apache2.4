#!/bin/bash
scriptPos=${0%/*}

extraConfDir=/opt/extra-conf-enabled 
extraSitesDir=/opt/extra-sites-enabled 

if [ -d $extraConfDir ]; then
    # an extern configuration directory found ... if the directory is empty some
    # additional initialisation is 
    for f in $extraConfDir/*.conf; do
        if ! [ -f $f ]; then continue; fi
        name=${f##*/}
        destLink=/etc/apache2/conf-enabled/$name
        if ! [ -L $destLink ]; then
            echo "replace conf link: $name -> $destLink"
            rm -rf $destLink && ln -s $f $destLink
        else
            echo "create conf link: $name -> $destLink"
            ln -s $f $destLink
        fi 
    done
fi

if [ -d $extraSitesDir ]; then
    for f in $extraSitesDir/*.conf; do
        if ! [ -f $f ]; then continue; fi
        name=${f##*/}
        destLink=/etc/apache2/sites-enabled/$name
        if [ -L $destLink ]; then
            echo "replace site link: $name -> $destLink"
            rm -rf $destLink && ln -s $f $destLink
        else
            echo "create site link: $name -> $destLink"
            ln -s $f $destLink
        fi 
    done
fi

if [ -z $DEBUG_LEVEL ]; then
    DEBUG_LEVE=info
fi

apachectl -f /etc/apache2/apache2.conf -e info -DFOREGROUND


