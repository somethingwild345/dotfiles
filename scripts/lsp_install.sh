#!/bin/bash

npm i -g bash-language-server
npm i -g dockerfile-language-server-nodejs
npm i -g @prisma/language-server
npm i -g typescript typescript-language-server
npm i -g yaml-language-server
npm i -g nginxbeautifier
npm i -g markdownlint
npm i -g vscode-langservers-extracted

GO111MODULE=on go get golang.org/x/tools/gopls@latest

# formatters & diagnostics
cargo install stylua --force
npm i -g @fsouza/prettierd
npm i -g eslint_d
go get golang.org/x/tools/cmd/goimports
