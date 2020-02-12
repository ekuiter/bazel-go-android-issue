#!/bin/bash

export BAZEL_VERSION=2.1.0
export ANDROID_NDK_VERSION=r20

sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get -y update
sudo apt-get -y install golang-go

sudo apt-get -y install pkg-config zip g++ zlib1g-dev unzip python3
wget -q https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh
bash ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh --user
rm ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

cd /home/vagrant
wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
rm android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
mv android-ndk-${ANDROID_NDK_VERSION} android-ndk