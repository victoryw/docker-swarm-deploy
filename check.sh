#!/usr/bin/env bash
for s in 21 22 23 24 25 26
do
     for d in 7001 7002 7003 7004 7005 7006 7007
        do
            url="http://10.135.2.$s:$d/life/servlet/com.ebao.life.system.support.SystemInfoServlet"
            file="$s.$d.out"
            curl url -o "$s.$d.out" --silent
            grep "session redis host: \[\], port: \[\], db: \[\]" ${file}
        done
done