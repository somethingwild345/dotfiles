#!/bin/bash

npm i -g nginxbeautifier
npm i -g markdownlint

GO111MODULE=on go get golang.org/x/tools/gopls@latest

# formatters & diagnostics
cargo install stylua --force
npm i -g @fsouza/prettierd
npm i -g eslint_d
go get golang.org/x/tools/cmd/goimports
