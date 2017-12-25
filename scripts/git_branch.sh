#!/usr/bin/env bash
set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

git_status_branch_label=""
git_status_branch_format_default="#[fg=colour220]"
git_status_branch_format=""
git_status_failed="not git"

get_branch_label() {
	cd $(tmux display -p -F "#{pane_current_path}")
	git_status_branch_label="$(git describe --contains --all HEAD)"
}

get_branch_format() {
	git_status_branch_format=$(get_tmux_option "@git_status_branch_format" "$git_status_branch_format_default")
}

main() {
	get_branch_label
	get_branch_format
	if in_git_repo; then
		echo " ${git_status_branch_format}${git_status_branch_label}#[default]"
    fi
}
main
