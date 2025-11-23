#!/bin/bash
# build.sh - merge FastBasic source files and compile

mktemp /tmp/xmonka.bas

# Concatenate in the proper order
cat  iconset.bas mon1to5.bas icons2.bas init.bas familiar.bas attacks.bas battlemsg.bas battlegraphics.bas battleflow.bas main.bas > /tmp/xmonka.bas

# Compile with FastBasic
fastbasic /tmp/xmonka.bas 
cp /tmp/xmonka.xex ./xmonka.xex


