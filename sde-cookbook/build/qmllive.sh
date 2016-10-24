#!/bin/bash
#
# Usage: dlt-viewer.sh <qmakepath>
# 

srcdir=dlt-viewer
builddir=$srcdir/build
gitrepo=http://github.com/GENIVI/dlt-viewer.git
qmakepath=$1

echo "Building $srcdir from git repo $gitrepo"

rm -rf $srcdir
git clone $gitrepo $srcdir
mkdir $builddir
cd $builddir
$qmakepath ../BuildDltViewer.pro
make && sudo make install

