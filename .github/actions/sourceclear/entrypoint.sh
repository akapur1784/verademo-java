#!/bin/sh -l
export SRCCLR_CUSTOM_MAVEN_COMMAND=-B package --file pom.xml
curl -sSL https://download.sourceclear.com/ci.sh | bash -s – scan --debug 
