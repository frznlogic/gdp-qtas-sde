#!/bin/bash

qtbindir=$1/bin
pushd neptune-ui/apps/com.theqtcompany.i18ndemo/translations
./create_qm.sh --qtdir=$qtbindir
popd

# Checkout an older revision for now since the last couple of commits
# have introduced a bug in the window handling for music app
pushd neptune-ui
git checkout 0b60c96da74b9a348969946f8a12efb3aaeae391
popd
