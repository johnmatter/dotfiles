
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

set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH

# shortcuts
function vi; nvim $argv; end
function workspace; cd ~/workspace; end
function madrona-clap; cd ~/Music/madrona/clap/; end
function madrona-vm; cd ~/Music/madrona-vm; end
