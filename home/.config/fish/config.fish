if not status --is-interactive

    exit 0

else

    set -gx OS (uname)

    # Terminal colors
    set -gx TERM xterm-256color

    # Set language environment
    set -gx LANG en_US.UTF-8
    set -gx LANGUAGE en_US.UTF-8
    set -gx LC_ALL en_US.UTF-8
    set -gx LC_CTYPE en_US.UTF-8

    # Base aliases
    alias ll "ls -lah"
    alias vi "nvim"
    alias vim "nvim"

    # Plugins
    set fish_function_path $fish_function_path $HOME/.config/fish/plugins/plugin-foreign-env/functions

    # Homesick
    if test -d $HOME/.homesick
        source $HOME/.homesick/repos/homeshick/homeshick.fish > /dev/null 2>&1
    end

    # Global paths
    set -gx PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin $HOME/bin $PATH
    set -gx MANPATH /usr/share/man $MANPATH

    # OS specific paths
    switch $OS
        case Darwin
            set -gx PATH /opt/X11/bin /opt/X11/bin /usr/local/MacGPG2/bin $HOME/.pear/bin $PATH
            set -gx MANPATH /usr/local/man /usr/share/man /usr/local/share/man $MANPATH
            set -g fish_user_paths /usr/local/sbin $fish_user_paths

            # Homebrew
            set -gx HOMEBREW_NO_ANALYTICS 1
            set -gx HOMEBREW_NO_AUTO_UPDATE 1
            set -gx HOMEBREW_NO_GITHUB_API 1
            set -gx HOMEBREW_NO_INSECURE_REDIRECT 1
        case FreeBSD
            # null
        case '*'
            # null
    end


    # Colorize man
    set MANROFFOPT '-c'
    set LESS_TERMCAP_mb (tput bold; tput setaf 2)
    set LESS_TERMCAP_md (tput bold; tput setaf 6)
    set LESS_TERMCAP_me (tput sgr0)
    set LESS_TERMCAP_so (tput bold; tput setaf 3; tput setab 4)
    set LESS_TERMCAP_se (tput rmso; tput sgr0)
    set LESS_TERMCAP_us (tput smul; tput bold; tput setaf 7)
    set LESS_TERMCAP_ue (tput rmul; tput sgr0)
    set LESS_TERMCAP_mr (tput rev)
    set LESS_TERMCAP_mh (tput dim)

    # Composer
    if test -d $HOME/.composer/vendor/bin
        set -gx PATH $PATH $HOME/.composer/vendor/bin
    end

    # yarn
    if test -d $HOME/.yarn/bin
        set -gx PATH $PATH $HOME/.yarn/bin
    end

    # Set preferred editors and pagers
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx PAGER less
    set -gx MANPAGER 'less -X'

    # Neovim
    # set -gx NVIM_TUI_ENABLE_CURSOR_SHAPE 1

    # rvm
    if test -d /usr/local/rvm/bin
        set -x PATH $PATH /usr/local/rvm/bin
        rvm default > /dev/null 2>&1
    end

    if test -d $HOME/.rvm/bin
        set -x PATH $PATH $HOME/.rvm/bin
        rvm default > /dev/null 2>&1
    end

    # pyenv
    if test -d $HOME/.pyenv
        set -x PYENV_ROOT $HOME/.pyenv
        set -x PATH $PYENV_ROOT/bin $PATH
        source (pyenv init -|psub) > /dev/null 2>&1
    end

    # luaenv
    # if test -d $HOME/.luaenv
    #     set -x PATH $PATH $HOME/.luaenv/bin
    #     source (luaenv init -|psub) > /dev/null 2>&1
    # end

    # swiftenv
    # if test -d $HOME/.swiftenv
    #     set SWIFTENV_ROOT $HOME/.swiftenv
    #     set PATH $SWIFTENV_ROOT/bin $PATH
    #     status --is-interactive; and source (swiftenv init -|psub) > /dev/null 2>&1
    # end

    # Go
    if test -d $HOME/go
        set GOPATH $HOME/go
        set PATH $PATH $GOPATH/bin
    end

    # Rust
    # if test -d $HOME/.cargo
    #     source $HOME/.cargo/env > /dev/null 2>&1
    # end

    # acme.sh
    if test -d $HOME/.acme.sh
        set -gx PATH $PATH $HOME/.acme.sh
    end

    # myrepos
    if test -d $HOME/.myrepos
        set -gx PATH $PATH $HOME/.myrepos
    end

    # Source command abbreviations
    source $HOME/.config/fish/abbreviations.fish > /dev/null 2>&1

    # iTerm integration
    if test -e {$HOME}/.iterm2_shell_integration.fish
        source {$HOME}/.iterm2_shell_integration.fish
    end

    # ripgrep
    set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

end
