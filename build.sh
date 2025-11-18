#!/bin/bash
# build.sh - merge FastBasic source files and compile

mktemp /tmp/magical.bas

# Concatenate in the proper order
cat  monimg.bas init.bas familiar.bas battlemsg.bas main.bas > /tmp/magical.bas

# Compile with FastBasic
fastbasic /tmp/magical.bas 
cp /tmp/magical.xex ./magical.xex

# Remove temporary file
rm "/tmp/magical.bas"
