#!/usr/bin/env bash

DEV_GROUP=developers

set -e

DEV_GROUP_EXISTS=$(grep "^developers:" /etc/group)
if [ -z "${DEV_GROUP_EXISTS}" ]; then
    sudo groupadd "${DEV_GROUP}"
fi

sudo usermod -a -G "${DEV_GROUP}" "${USER}"

COMPILERS=(
    "byacc"
    "yacc"
    "bcc"
    "kgcc"
    "cc"
    "gcc"
    "*c++"
    "*g++"
    "x86_64-linux-gnu-gcc-9"
    "x86_64-linux-gnu-as"
)

for i in "${COMPILERS[@]}"; do
    for compiler in /usr/bin/${i}; do
        if [ -e "$compiler" ]; then
            echo "Found: $compiler"
            sudo chown ":${DEV_GROUP}" "${compiler}"
            sudo chmod 0750 "${compiler}"
        fi
    done
done
