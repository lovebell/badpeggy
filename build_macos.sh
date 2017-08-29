#!/bin/bash

set -e

if [[ ! ("$#" -eq 1) ]]; then
    echo 'need version'
    exit 1
fi

BADPEGGYJAR=build/badpeggy.jar
if [ ! -f $BADPEGGYJAR ]
then
    echo "$BADPEGGYJAR is missing"
    exit 2
fi

echo "preparing ..."
BUILD=BadPeggy$1
DPLDIR=deploy
APPDIR=$DPLDIR/__temp__.app
FINDIR=$DPLDIR/Bad\ Peggy.app
CONTDIR=$APPDIR/Contents
SWTDIR=../swt
JREDIR=../jre-reduce
DMGFILE=build/badpeggy$1.dmg

. $JREDIR/version.inc
. $SWTDIR/version.inc

rm -f $DMGFILE
rm -rf $CONTDIR

mkdir -p $CONTDIR/MacOS
mkdir    $CONTDIR/Resources

cp $BADPEGGYJAR             $CONTDIR/MacOS/
cp etc/scripts/badpeggy_osx $CONTDIR/MacOS/badpeggy
cp etc/Info.plist           $CONTDIR/
cp etc/images/badpeggy.icns $CONTDIR/Resources/ 

tr -d "\r" < LICENSE.txt | cat > $CONTDIR/MacOS/LICENSE

chmod 755 $CONTDIR/MacOS/badpeggy

cp -a $SWTDIR/$SWT_VERSION/cocoa-macosx-x86_64/swt.jar $CONTDIR/MacOS/

echo "reducing JRE ..."
tar xzf $JREDIR/versions/$JRE_VERSION/$JRE_UPDATE/jre-$JRE_VERSION$JRE_UPDATE-macosx-x64.tar.gz -C $CONTDIR/MacOS/
mv $CONTDIR/MacOS/jre* $CONTDIR/MacOS/jre
$JREDIR/jre-reduce.sh macosx-x64 $CONTDIR/MacOS/jre

mv $APPDIR "$FINDIR"
ln -s /Applications $DPLDIR/Applications

echo "creating DMG ..."
hdiutil create -volname "Bad Peggy" -srcfolder $DPLDIR $DMGFILE
hdiutil internet-enable -yes $DMGFILE

rm -rf $DPLDIR

ls -lah $DMGFILE
