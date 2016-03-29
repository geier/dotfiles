function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end
	
	if not set -q -g __fish_classic_git_functions_defined
		set -g __fish_classic_git_functions_defined

		function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
			if status --is-interactive
				set -e __fish_prompt_user
				commandline -f repaint ^/dev/null
			end
		end
		
		function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
			if status --is-interactive
				set -e __fish_prompt_host
				commandline -f repaint ^/dev/null
			end
		end
		
		function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
			if status --is-interactive
				set -e __fish_prompt_status
				commandline -f repaint ^/dev/null
			end
		end
	end

	set -l delim '%'


	set -l prompt_status
	if test $last_status -ne 0
		if not set -q __fish_prompt_status
			set -g __fish_prompt_status (set_color $fish_color_status)
		end
		set prompt_status "$__fish_prompt_status [$last_status]$__fish_prompt_normal"
	end

	if not set -q __fish_prompt_user
		set -g __fish_prompt_user (set_color $fish_color_user)
	end
	if not set -q __fish_prompt_host
		set -g __fish_prompt_host (set_color $fish_color_host)
	end

	if set -q VIRTUAL_ENV
		set -g __fish_virtual_env_status "("(set_color blue white)(basename "$VIRTUAL_ENV")(set_color normal)")"
	end
	
	# TODO: red username if run as root
	if set -q SSH_CONNECTION
		set -g __fish_color_user (set_color white)
		set -g __fish_color_host (set_color white)
		set -g __fish_prompt_user_host "$__fish_color_user$USER$__fish_prompt_normal@$__fish_color_host$__fish_prompt_hostname$__fish_prompt_normal"
	end

	echo -n -s "$__fish_virtual_env_status" "$__fish_prompt_user_host" (__fish_git_prompt) "$__fish_prompt_normal" "$prompt_status" "$delim" ' '
end
