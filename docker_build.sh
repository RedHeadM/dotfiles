#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

main() {
	docker build --cache-from ubuntu:latest -t nvim . #readhead/zsh-git-prompt:0.1.0 .
}

main "$@"
# vim:noet
