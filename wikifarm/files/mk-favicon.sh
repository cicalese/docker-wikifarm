#!/bin/sh
convert -resize x16 -gravity center -crop 16x16+0+0 -background transparent -colors 256 -flatten logo.png favicon.ico
