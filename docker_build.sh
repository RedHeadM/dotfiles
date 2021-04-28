#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

main() {
	docker build --cache-from haskell:latest -t yanhan/zsh-git-prompt:0.1.0 .
}

main "$@"
# vim:noet
