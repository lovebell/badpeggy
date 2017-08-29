#!/bin/bash
INSTDIR=/opt/badpeggy
echo installing Bad Peggy to $INSTDIR ... 
./uninstall.sh "$INSTDIR"
sudo mkdir /opt/badpeggy
sudo cp -r --preserve=all * $INSTDIR
sudo chmod 755 $INSTDIR/badpeggy
sudo chmod 755 $INSTDIR/*install.sh
sudo ln -s $INSTDIR/badpeggy /usr/bin/
sudo cp badpeggy.desktop /usr/share/applications/
echo done.
