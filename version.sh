#!/bin/bash
if [ $# -eq 0 ]
then
  echo "usage: $0 version"
  echo "example: $0 1.5"
  exit 1
fi
VERSION=$1
FNAME=src/coderslagoon/badpeggy/GUI.java
sed -i "" -E "s/(final\ static\ String\ VERSION\ = ).*$/\1\"$VERSION\";/" $FNAME
FNAME=MANIFEST.MF
sed -i "" -E "s/(Specification-Version:\ ).*/\1$VERSION/"  $FNAME
sed -i "" -E "s/(Implementation-Version:\ ).*/\1$VERSION/" $FNAME
FNAME=etc/Info.plist
sed -i "" -E "s/(<key>CFBundleShortVersionString<\/key><string>).*/\1$VERSION/" $FNAME
sed -i "" -E "s/(<key>CFBundleVersion<\/key><string>).*/\1$VERSION/"  		    $FNAME

