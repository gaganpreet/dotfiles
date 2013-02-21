#!/bin/bash

for i in $(ls dotfiles/)
do
    cp -l dotfiles/$i ~/.$i
done
