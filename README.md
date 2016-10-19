# Introduction

This repository is an entry point to building the SDE VM for the Qt Automotive Spin of GENIVI Development Platform.


# How to build

The VM is built using Vagrant with VirtualBox as a backend, so make sure you have both Vagrant and VirtualBox installed.

First initialize the git submodules: 
```
git submodule init
git submodule update
```

To start the VM creation run `vagrant up`, this will take a while so please be patient and don't try to use the VM until it's done.


# Speeding up the build
You can use VAGRANT_NUM_CPUS and VAGRANT_RAM to change the amount of cores and RAM the VM gets, and MAKEFLAGS are set to -j(VAGRANT_NUM_CPUS+1) to speed up builds.

E.g. `VAGRANT_NUM_CPUS=6 VAGRANT_RAM=8192 vagrant up`.

If used over ssh you can disable graphical output by using vb.gui = false, see info in Vagrantfile.

