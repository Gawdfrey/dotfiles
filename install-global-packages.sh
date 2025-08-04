#!/bin/bash

# Install Node.js LTS and set as default
nvm install --lts
nvm use --lts
nvm alias default lts/*

# Install global npm packages
while read package; do
    npm install -g $package
done < global-npm-packages.txt