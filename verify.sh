#!/bin/bash

gpg --import $2
./bsign --verify $1
result=$?
echo $result