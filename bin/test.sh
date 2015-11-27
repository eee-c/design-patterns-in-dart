#!/bin/bash -e

shopt -s extglob

for X in !(LICENSE|README.md|bin|packages|factory_method|reactor|visitor)
do
    # Change the current working directory to pattern directory
    cd $X
    echo "[TEST] $X "

    # Update pub
    echo -n "pub update"
    pub get >/dev/null
    echo " (done)"

    # Run the actual tests
    pub run test
    echo

    # Back to the top-level directory
    cd - >/dev/null
done
