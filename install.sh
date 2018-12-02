#!/usr/bin/env bash

MACHINE_REPO=${MACHINE_REPO:-https://github.com/markosamuli/linux-machine.git}
MACHINE=${MACHINE:-$HOME/.machine}

###
# Download repository with Git
###
function download_machine {
    # Do we need to download the machine repository?
    if [ ! -d "$MACHINE" ]; then
        echo "*** Cloning linux-machine from GitHub..."
        git clone $MACHINE_REPO $MACHINE
    fi
}

###
# Check that Git is installed
###
function setup_git {
    command -v git 1>/dev/null 2>&1 || {
        echo "Git is not installed."
        exit 1
    }
}

###
# Run setup script
###
function setup_machine {
    cd $MACHINE
    ./setup
}

setup_git

download_machine

setup_machine
