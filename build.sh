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

echo "preparing for Linux ..."
BUILD=BadPeggy$1
BUILDIR=tmp/$BUILD
SWTDIR=../swt
JREDIR=../jre-reduce
JRE_OUT=$BUILDIR/jre

. $JREDIR/version.inc
. $SWTDIR/version.inc

rm -f build/badpeggy$1_linux.zip
rm -f build/badpeggy$1_windows.zip
rm -rf $BUILDIR
mkdir -p $BUILDIR

cp $BADPEGGYJAR             $BUILDIR/
cp etc/badpeggy.desktop     $BUILDIR/
cp etc/scripts/badpeggy     $BUILDIR/
cp etc/scripts/install.sh   $BUILDIR/
cp etc/scripts/uninstall.sh $BUILDIR/
cp etc/images/badpeggy.png  $BUILDIR/

tr -d "\r" < LICENSE.txt      | cat > $BUILDIR/LICENSE
tr -d "\r" < etc/README.txt   | cat > $BUILDIR/README
tr -d "\r" < etc/LIESMICH.txt | cat > $BUILDIR/LIESMICH

chmod 755 $BUILDIR/badpeggy
chmod 755 $BUILDIR/install.sh
chmod 755 $BUILDIR/uninstall.sh

cp $SWTDIR/$SWT_VERSION/gtk-linux-x86_64/swt.jar $BUILDIR/

echo "reducing JRE for Linux ..."
rm -rf $JRE_OUT
tar xzf $JREDIR/versions/$JRE_VERSION/$JRE_UPDATE/jre-$JRE_VERSION$JRE_UPDATE-linux-x64.tar.gz -C $BUILDIR/
mv $BUILDIR/jre* $JRE_OUT
$JREDIR/jre-reduce.sh linux-x64 $JRE_OUT

echo "creating ZIP for Linux ..."
cd tmp
zip -9 -q -r -X ../build/badpeggy$1_linux.zip $BUILD
cd ..

echo "preparing for Windows ..."
rm $BUILDIR/badpeggy
rm $BUILDIR/badpeggy.png
rm $BUILDIR/badpeggy.desktop
rm $BUILDIR/*.sh
rm $BUILDIR/README
rm $BUILDIR/LIESMICH
rm $BUILDIR/LICENSE

cp LICENSE.txt                 $BUILDIR/LICENSE.txt
cp etc/README.txt              $BUILDIR/
cp etc/LIESMICH.txt            $BUILDIR/
cp etc/scripts/badpeggy*.cmd   $BUILDIR/
cp etc/scripts/install.vbs     $BUILDIR/
cp etc/images/badpeggy.ico     $BUILDIR/ 

cp $SWTDIR/$SWT_VERSION/win32-win32-x86_64/swt.jar $BUILDIR/

echo "reducing JRE for Windows ..."
rm -rf $JRE_OUT
tar xzf $JREDIR/versions/$JRE_VERSION/$JRE_UPDATE/jre-$JRE_VERSION$JRE_UPDATE-windows-x64.tar.gz -C $BUILDIR/
mv $BUILDIR/jre* $JRE_OUT
$JREDIR/jre-reduce.sh windows-x64 "$JRE_OUT"

echo "creating ZIP for Windows ..."
cd tmp
zip -9 -q -r -X ../build/badpeggy$1_windows.zip $BUILD
cd ..

rm -rf tmp

ls -lah ./build/badpeggy$1_linux.zip
ls -lah ./build/badpeggy$1_windows.zip
