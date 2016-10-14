# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "bento/ubuntu-16.04"
  config.vm.box_check_update = false

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
     vb.gui = true
  
     # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "4096"]
     vb.cpus = 2
   end

  #
  # Start setting up the machine as a GENIVI SDE
  #

  # Install a desktop environment
  config.vm.provision "shell" do |s|
    s.inline = "apt-get update -y"
  end
  config.vm.provision "shell" do |s|
    s.inline = "apt-get install lubuntu-desktop -y"
  end

  config.vm.provision "shell" do |s|
    s.inline = "apt-get install cmake -y"
  end

  # Enable deb-src repos and install qt5 build dependencies
  config.vm.provision "shell", path: "cookbook/system-config/enable-all-deb-src.sh"
  config.vm.provision "shell", path: "cookbook/deps/qt5-dependencies.sh"

  # Define where to install Qt
  qtinstallprefix = "/opt/qt-5.7-git"
  qmakepath = qtinstallprefix + "/bin/qmake"
  qtcmakepath = qtinstallprefix + "/lib/cmake/"

  # Build Qt5 from git
  config.vm.provision "shell", privileged: false, 
      args: ["qt5", "5.7", "--prefix=" + qtinstallprefix + " -opensource -confirm-license"],
      path: "cookbook/build/qt5-git-builder.sh"

  # Build QtIVI
  config.vm.provision "shell", privileged: false, 
      args: ["qtivi", "http://code.qt.io/qt/qtivi.git", qmakepath],
      path: "cookbook/build/qmake-git-builder.sh"

  # Build QtApplicationManager
  config.vm.provision "shell", privileged: false, 
      args: ["qtapplicationmanager", "http://code.qt.io/qt/qtapplicationmanager.git", qmakepath],
      path: "cookbook/build/qmake-git-builder.sh"
  
  # Install template configuration for QtApplicationManager
  config.vm.provision "shell" do |s|
    s.inline = "cp -r qtapplicationmanager/template-opt/am /opt/"
  end
  config.vm.provision "shell" do |s|
    s.inline = "mkdir -p /opt/am/docs"
  end

  config.vm.provision "shell" do |s|
    s.inline = "chown -R vagrant:vagrant /opt/am"
  end

  # Build neptune-ui
  config.vm.provision "shell", privileged: false, 
      args: ["neptune-ui", "http://code.qt.io/qt-apps/neptune-ui.git", qmakepath],
      path: "cookbook/build/qmake-git-builder.sh"

  # Build dlt-viewer
  config.vm.provision "shell", privileged: false, 
      args: ["dlt-viewer", "http://github.com/GENIVI/dlt-viewer.git", qmakepath, "", "BuildDltViewer.pro"],
      path: "cookbook/build/qmake-git-builder.sh"

  # Build qmllive
  config.vm.provision "shell", privileged: false, 
      args: ["qmllive", "http://code.qt.io/qt-apps/qmllive.git", qmakepath],
      path: "cookbook/build/qmake-git-builder.sh"


  # Build qmllive
  config.vm.provision "shell", privileged: false, 
      args: ["gammaray", "https://github.com/KDAB/GammaRay.git", "-DGAMMARAY_BUILD_DOCS=off -DCMAKE_PREFIX_PATH=" + qtcmakepath],
      path: "cookbook/build/cmake-git-builder.sh"

  # Download and install target SDK
  # TODO: Make this download machine specific
  config.vm.provision "shell", privileged: false, 
      args: ["minnowboard"],
      path: "sde-cookbook/sdk/download-sdk.sh"

  # Configure qtcreator for use with target SDK
  config.vm.provision "shell", privileged: false, 
      args: ["Minnowboard"],
      path: "sde-cookbook/sdk/configure-qtcreator.sh"

end
