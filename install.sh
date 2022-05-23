#!/bin/bash

set -e

ROVER_VERSION="v0.5.1"
ARCHITECTURE=$(arch)
OS=$(uname -s)

has_cargo() {
  set +e
  if ! command -v cargo; then
    echo 1
  else
    echo 0
  fi
  set -e
}

install_from_source () {
  local -r INSTALL_CARGO=$(has_cargo)

  if [ "$INSTALL_CARGO" -eq "1" ]; then
    echo "==> Installing Rust toolchain"
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
  fi

  echo "==> Installing Rover from source"

  mkdir -p /tmp/rover
  wget -O - https://github.com/apollographql/rover/tarball/${ROVER_VERSION} | tar xz -C /tmp/rover --strip-components=1

  pushd /tmp/rover
  cargo run --release -- install
  popd

  mkdir -p node_modules/.bin
  mv /tmp/rover/target/release/rover node_modules/.bin

  echo "==> Cleaning up"
  rm -Rf /tmp/rover
  if [ "$INSTALL_CARGO" -eq "1" ]; then
    rm -Rf $HOME/.cargo
  fi
}

install_with_curl(){
  curl -sSL https://rover.apollo.dev/nix/$ROVER_VERSION | sh
  mkdir -p node_modules/.bin
  mv $HOME/.rover/bin/rover node_modules/.bin
}

if [ "$ARCHITECTURE" = "aarch64" -a "$OS" = "Linux" ]; then
  install_from_source
else
  install_with_curl
fi
