set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
fish_add_path ~/.cargo/bin

function workspace; cd ~/workspace; end
function madrona-clap; cd ~/Music/madrona/clap/; end
function madrona-vm; cd ~/Music/madrona-vm; end
