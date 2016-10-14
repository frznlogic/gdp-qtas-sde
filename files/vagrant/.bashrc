export PATH="$PATH:~/bin:~/gdp_sdk/bin"

alias ll='ls -alF'

# Set up yocto SDK environment
if [ -n "$USE_SDK" ] ; then
  SDK_SETUP=$(readlink -f ~/gdp-sdk/environment*)
  echo "bar: ", $SDK_SETUP
  if [ -f "$SDK_SETUP" ] ; then
    . $SDK_SETUP
    if [ $? = 0 ] ; then
      echo "NOTE: Yocto-SDK environment has been set up."
      echo "E.g. try echo \$CC", or which qmake
    else
      echo "SDK setup failed"
    fi
  else
    echo "Error: Unknown SDK environment file"
  fi
fi

