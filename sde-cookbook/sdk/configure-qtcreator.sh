#!/bin/bash

qtCreatorBinPath=/usr/bin/
name=$1
toolchainId="ProjectExplorer.ToolChain.Gcc:$name";
qtId=$name"_qt";
kitId=$name"_kit";
source gdp-sdk/environment-setup-*
abi="${TARGET_ARCH}-linux-generic-elf-${SITEINFO_BITS}bit"
compiler=`which $CXX`
qmake=`which qmake`
gdb=`which $GDB`
sysroot=$SDKTARGETSYSROOT

sudo $qtCreatorBinPath/sdktool addTC --id "$toolchainId" --name "$name" --abi $abi --path $compiler > /dev/null
if [ $? -ne 0 ]; then
    echo adding Toolchain failed
    exit 1
fi
sudo $qtCreatorBinPath/sdktool addQt --id "$qtId" --name "$name" --type "RemoteLinux.EmbeddedLinuxQt" --qmake $qmake > /dev/null
if [ $? -ne 0 ]; then
    echo adding Qt failed
    sudo $qtCreatorBinPath/sdktool rmTC --id "$toolchainId" > /dev/null
    exit 1
fi
sudo $qtCreatorBinPath/sdktool addKit --id "$kitId" --name "$name" --debuggerengine 1 --debugger $gdb --devicetype GenericLinuxOsType --sysroot $sysroot --toolchain "$toolchainId" --qt "$qtId" --mkspec "${OE_QMAKE_PLATFORM}"
    if [ $? -ne 0 ]; then
    echo adding Kit failed
    sudo $qtCreatorBinPath/sdktool rmTC --id "$toolchainId" > /dev/null
    sudo $qtCreatorBinPath/sdktool rmQt --id "$qtId" > /dev/null
    exit 1
fi

sudo -E sed -i 's,<value type="QString" key="QtPM4.mkSpecInformation"></value>,<value type="QString" key="QtPM4.mkSpecInformation">'$SDKTARGETSYSROOT'/usr/lib/qt5/mkspecs/linux-oe-g++</value>,' /usr/share/qtcreator/QtProject/qtcreator/profiles.xml

echo "Added Kit successfully";
