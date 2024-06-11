#!/bin/bash
set -e

echo ‘start build’

echo ‘build for simulator’

xcodebuild archive \
 -scheme $1 \
 -archivePath ~/Desktop/asdk-iphonesimulator.xcarchive \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO
 
if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi

echo ‘build for device’

 xcodebuild archive \
 -scheme $1 \
 -archivePath ~/Desktop/asdk-iphoneos.xcarchive \
 -sdk iphoneos \
 SKIP_INSTALL=NO

echo ‘make xc framework’

xcodebuild -create-xcframework \
 -framework ~/Desktop/asdk-iphonesimulator.xcarchive/Products/Library/Frameworks/"$1".framework \
 -framework ~/Desktop/asdk-iphoneos.xcarchive/Products/Library/Frameworks/"$1".framework \
 -output ~/Desktop/"$1".xcframework

rm ~/Desktop/asdk-iphonesimulator.xcarchive
rm ~/Desktop/asdk-iphoneos.xcarchive
