#!/usr/bin/env bash

MACHINE_REPO=https://github.com/markosamuli/linux-machine.git
MACHINE=$HOME/.machine

function download_machine {
    # Do we need to download the machine repository?
    if [ ! -d "$MACHINE" ]; then
        echo "*** Cloning linux-machine from GitHub..."
        git clone $MACHINE_REPO $MACHINE
    fi
}

function setup_git {
    command -v git 1>/dev/null 2>&1 || {
        echo "Git is not installed."
        exit 1
    }
}

function setup_machine {
    cd $MACHINE
    ./setup
}

# Git setup
setup_git

# Clone repository
download_machine

# Run setup
setup_machine