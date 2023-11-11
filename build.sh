#!/bin/bash

if [ -z $1 ]; then echo 'must supply tag name'; exit 1; fi
TAGNAME=$1

echo 'Building for rootful'
make clean
if [ -f Reflex ]; then
	sed -i"" -e "s|^install-name:    '.*'|install-name:    '/Library/MobileSubstrate/DynamicLibraries/libFLEX.dylib'|" Reflex/FLEX.framework/FLEX.tbd
fi
make package FINALPACKAGE=1 PACKAGE_VERSION=${TAGNAME#v}+rootful

echo 'Building for rootless'
make clean
if [ -f Reflex ]; then
	sed -i"" -e "s|^install-name:    '.*'|install-name:    '/var/jb/Library/MobileSubstrate/DynamicLibraries/libFLEX.dylib'|" Reflex/FLEX.framework/FLEX.tbd
fi
make package THEOS_PACKAGE_SCHEME=rootless FINALPACKAGE=1 PACKAGE_VERSION=${TAGNAME#v}+rootless
