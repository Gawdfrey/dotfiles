#!/bin/bash

# Install VS Code extensions from list
while read extension; do
    code --install-extension $extension
done < vscode-extensions.txt