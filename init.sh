#!/bin/bash

for i in $(ls dotfiles/*)
do
    cp -l $i ~/.$i
done
