#!/bin/bash
#
# Wrapper around `swift build' that uses pkg-config in config.sh
# to determine compiler and linker flags.
#
# On macOS (Darwin), this script uses gtk-mac-bundler to create an app
#
. ./config.sh
export PACKAGES=.build/checkouts
[ -e $PACKAGES ] || export PACKAGES=Packages
gtk=`echo $PACKAGES/*Gtk*/Sources/Gtk/Gtk-3.0.swift`
[ -e $gtk ] || ./generate-wrapper.sh
swift build $CCFLAGS $LINKFLAGS "$@"
if [ `uname` = "Darwin" ]; then
	. ./app-bundle.sh
fi
