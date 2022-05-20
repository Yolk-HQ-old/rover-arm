#!/bin/bash

set -e

ROVER_VERSION="v0.5.1"
ARCHITECTURE=$(arch)
OS=$(uname -s)

install_from_source () {
  echo "Installing rover from source"

  mkdir -p /tmp/rover
  wget -O - https://github.com/apollographql/rover/tarball/${ROVER_VERSION} | tar xz -C /tmp/rover --strip-components=1
  cd /tmp/rover
  cargo run --release -- install

  mkdir -p node_modules/.bin
  mv /tmp/rover/target/release/rover .
}

install_with_curl(){
  curl -sSL https://rover.apollo.dev/nix/$ROVER_VERSION | sh
  mkdir -p node_modules/.bin
  mv $HOME/.rover/bin/rover .
}

if [ "$ARCHITECTURE" = "aarch64" -a "$OS" = "Linux" ]; then
  install_from_source
else
  install_with_curl
fi
