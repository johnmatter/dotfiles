
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniconda3/bin/conda
    eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

# host-specific configs
set host (hostname)
set host_config ~/.config/fish/conf.d/hostname-$host.fish
if test -f $host_config
    source $host_config
end

# bash-style aliases
function vi; nvim $argv; end
function vim; nvim $argv; end

# use startship for prompt
starship init fish | source
# starship preset gruvbox-rainbow -o ~/.config/starship.toml
starship preset no-runtime-versions -o ~/.config/starship.toml
