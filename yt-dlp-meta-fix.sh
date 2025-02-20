#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "usage: $0 <album name> [out dir] [ext]"
  echo "out dir default: out"
  echo "ext default: mp3"
  exit 1
fi

if [ -z "$2" ]; then
  out="out"
fi

if [ -z "$3" ]; then
  ext="mp3"
fi

album="$1"
mkdir "$out"
for i in *.$ext; do
  echo "$i"

  title=`echo "$i" | cut -d "-" -f2 | cut -c 6-9999 | cut -d "." -f1`
  track=`echo "$i" | cut -d "-" -f2 | cut -c 2-4`

  ffmpeg -i "$i" \
  -metadata album="$album" \
  -metadata title="$title" \
  -metadata track="$track" \
  -codec copy "$out/$i"
done
