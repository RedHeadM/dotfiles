#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

main() {
	docker run \
		-it \
		--rm \
		--name zsh-git-prompt \
		nvim
		#readhead/zsh-git-prompt:0.1.0
}

main "$@"
# vim:noet
