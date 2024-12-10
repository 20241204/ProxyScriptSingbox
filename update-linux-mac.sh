#!/usr/bin/env bash
PWD=`pwd`/sources
cd ${PWD}
curl -SL --connect-timeout 30 -m 60 --speed-time 30 --speed-limit 1 --retry 2 -H "Connection: keep-alive" -k "https://raw.githubusercontent.com/20241204/docker-arch-sub-topfreeproxies/refs/heads/master/topfreeproxies/singbox-config-format.json" -o "config0.json" -O
