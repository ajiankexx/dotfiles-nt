#                   __ _          __ _     _       _         _               
#   ___ ___  _ __  / _(_) __ _   / _(_)___| |__   | | ____ _(_)___  ___ _ __ 
#  / __/ _ \| '_ \| |_| |/ _` | | |_| / __| '_ \  | |/ / _` | / __|/ _ \ '__|
# | (_| (_) | | | |  _| | (_| |_|  _| \__ \ | | | |   < (_| | \__ \  __/ |   
#  \___\___/|_| |_|_| |_|\__, (_)_| |_|___/_| |_| |_|\_\__,_|_|___/\___|_|   
#                        |___/                                               

# ajiankexx's config
abbr -a fastsource source .venv/bin/activate.fish
abbr -a cat_path "echo $abbr -a cat_path 'string join \n $PATH'abbr -a cat_path 'string join \n $PATH'abbr -a cat_path 'string join \n $PATH'(PATH) | tr ' ' '\n'"

abbr -a editfish vim ~/dotfiles-nt/.config/fish/config.fish
abbr -a sourcefish source ~/.config/fish/config.fish
abbr -a editnvim 'cd ~/dotfiles-nt/.config/nvim && nvim .'
abbr -a dotupdate 'cd ~/dotfiles-nt && ./dot_files.py update'

# abbreviations for git
abbr -a cdrtp cd ~/.local/share/nvim/lazy
abbr -a cdcfg cd ~/dotfiles-nt
abbr -a cdwork cd ~/work
abbr -a cddoc cd ~/doc

# abbr for atuin
abbr -a atns atuin search
abbr -a atni atuin import auto
abbr -a atnstats atuin stats
abbr -a atnhis atuin history

# abbr for docker
abbr -a docker sudo docker
abbr -a sdc sudo docker compose

# more effective tools 
abbr -a ls exa

abbr -a lzg lazygit
abbr -a gco git checkout
abbr -a gst git status
abbr -a gswt git switch
abbr -a gaa git add :/
abbr -a gad git add .
abbr -a gcm git commit
abbr -a gft git fetch
abbr -a gmg git merge
abbr -a gl git log
abbr -a gdf git diff
abbr -a ga git add
abbr -a gps git push
abbr -a gpl git pull
abbr -a grbs git rebase
abbr -a gdag git log --graph --abbrev-commit --decorate --format=format:"'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'" --all
abbr -a gdagol git log --all --decorate --oneline --graph
abbr -a gbrc git branch
abbr -a gcln git clone
abbr -a grst git reset
abbr -a grsr git restore

# abbreviations for jupyter
abbr -a jpt jupyter
abbr -a jptnb jupyter notebook
abbr -a jptnbcv jupyter nbconvert --to

# abbreviations for ll not to show hidden files
abbr -a ll ls -lFh

# abbreviations for windows copy and paste,
# those is for wsl
abbr -a wcp clip.exe
abbr -a wpst powershell.exe Get-Clipboard

# abbreviations for tmux
abbr -a tm tmux
abbr -a tmls tmux ls
abbr -a tmlsbf tmux list-buffers
abbr -a tmlscli tmux list-clients
abbr -a tmlscmd tmux list-commands
abbr -a tmlsk tmus list-keys
abbr -a tmlspn tmus list-panes
abbr -a tmlsss tmux list-session
abbr -a tmlswd tmux list-window
abbr -a tmnss tmux new-session -s
abbr -a tmatc tmux attach -t
abbr -a tmksv tmux kill-server
abbr -a tmkss tmux kill-session -t
abbr -a tmswt tmux switch -t
abbr -a tmrnss tmux rename-session -t
abbr -a tmrnwd tmux rename-window -t

# nv for nvim
abbr -a nv nvim

# use vim as the default editor
set --export EDITOR nvim
# go
set --export PATH $PATH /usr/local/go/bin
set --export PATH $PATH ~/go/bin # for gopls
# conda
set --export PATH $PATH ~/miniconda3/bin
# node
set --export PATH $PATH ~/node-v20.13.0-linux-x64/bin
# the directory where user lib pip will install
set --export PATH $PATH ~/.local/bin
# the directory where user cargo will install
set --export PATH $PATH ~/.cargo/bin
# the yarn bin
set --export PATH $PATH ~/.yarn/bin
# neovim path
set --export PATH $PATH /opt/nvim-linux64/bin
# node
set --export PATH ~/.nvm/versions/node/v24.1.0/bin $PATH

# this enable .. be cd ../, ... be cd ../../
# .... be cd ../../../
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr -a dotdot --regex '^\.\.+$' --function multicd
# this is for vi mode
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

# this will not be useful for wsl
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external line
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo '[N] '
        case insert
            set_color --bold green
            echo '[I] '
        case replace_one
            set_color --bold green
            echo '[R] '
        case visual
            set_color --bold brmagenta
            echo '[V] '
        case '*'
            set_color --bold red
            echo '[?] '
    end
    set_color normal
end

# required by markdown-preview.nvim
if test -e /mnt/c/Windows/System32/cmd.exe -a ! -e /usr/bin/cmd.exe
    sudo ln -s /mnt/c/Windows/System32/cmd.exe /usr/bin/cmd.exe
end

# y for yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

zoxide init fish | source

function nvimtest
    env NVIM_APPNAME="nvim-test" nvim $argv
end
