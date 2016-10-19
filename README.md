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

In order to create the VM faster some settings can be changed in Vagrantfile, see the excerpt below.

```
   config.vm.provider "virtualbox" do |vb|
     # If you want to run vagrant up on a fast build server over ssh, comment
     # out the line below to run headless.
     vb.gui = true

     # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "4096"]
     vb.cpus = 2

     # Use something like this on a fast build server
     #vb.customize ["modifyvm", :id, "--memory", "8192"]
     #vb.cpus = 6
   end

```
