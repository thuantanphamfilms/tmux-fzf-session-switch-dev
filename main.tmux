#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

default_key_bindings_goto="C-f"
default_width=55
default_height=10
defautl_without_prefix=false

tmux_option_goto="@fzf-goto-session"
tmux_option_goto_without_prefix="@fzf-goto-session-without-prefix"
tmux_option_width="@fzf-goto-win-width"
tmux_option_height="@fzf-goto-win-height"

get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

function set_goto_session_bindings {
	local key_bindings=$(get_tmux_option "$tmux_option_goto" "$default_key_bindings_goto")
	local without_prefix=$(get_tmux_option "$tmux_option_goto_without_prefix" "$defautl_without_prefix")
	local width=$(get_tmux_option "$tmux_option_width" "$default_width")
	local height=$(get_tmux_option "$tmux_option_height" "$default_height")

	if [ "$without_prefix" = true ]; then
		local key
		for key in $key_bindings; do
			tmux bind -n "$key" display-popup -w "$width" -h "$height" -y 15 -E "$CURRENT_DIR/scripts/switch_session_fzf.sh"
		done
	else
		local key
		for key in $key_bindings; do
			tmux bind "$key" display-popup -w "$width" -h "$height" -y 15 -E "$CURRENT_DIR/scripts/switch_session_fzf.sh"
		done
	fi
}

function main {
	set_goto_session_bindings
}
main
