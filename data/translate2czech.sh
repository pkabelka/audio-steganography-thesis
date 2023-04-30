#!/bin/sh

find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/depth=/hloubka=/'
find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/only needed/potřebné/'
find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/half quantization/poloviční kvantování/'
find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/half sampling/poloviční vzorkování/'    
find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/high-pass half max frequency/horní propusť 1\/2 max frekv./'
find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/low-pass half max frequency/dolní propusť 1\/2 max frekv./'
find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/mp3 transcoding:/MP3 překódování:/'
find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/noise:/přidání šumu:/'
find . -type f -name '*.csv' -print0 | xargs -0 sed -i 's/min silence len=/min. délka ticha=/'
