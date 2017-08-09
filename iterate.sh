#!/bin/bash
rm -rf ./out
./build.sh
./out/xsd2swift \
    -schema /Users/swright/github/StevenEWright/AppsBySteve/ios/shared/cpu/docs/xml/index.xsd \
    -out /Users/swright/github/StevenEWright/AppsBySteve/ios/shared/cpu/docs/xml/
./out/xsd2swift \
    -schema /Users/swright/github/StevenEWright/AppsBySteve/ios/shared/cpu/docs/xml/compound.xsd \
    -out /Users/swright/github/StevenEWright/AppsBySteve/ios/shared/cpu/docs/xml/
cp /Users/swright/github/StevenEWright/AppsBySteve/ios/shared/cpu/docs/xml/Sources/*.swift /Users/swright/Desktop/DoxyDoctor/DoxyDoctor/DoxygenTypes/
swiftformat /Users/swright/Desktop/DoxyDoctor/DoxyDoctor/DoxygenTypes t --indent 2
