#!/bin/bash

brew update

brew install awsebcli

eb --version

eb init

eb create --cfg common

exit