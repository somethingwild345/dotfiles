#!/bin/bash

npm i -g nginxbeautifier
npm i -g markdownlint

# formatters & diagnostics
cargo install stylua --force
npm i -g @fsouza/prettierd
go install mvdan.cc/gofumpt@latest
