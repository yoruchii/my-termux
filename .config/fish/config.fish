if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ls='eza --icons -F -H --group-directories-first --git -1'
alias ll='ls -alF'
alias pgstart='pg_ctl -D ./postgres start'
alias pgstop='pg_ctl -D ./postgres stop'
alias pyhttp='python -m http.server'
alias py='python'
alias q='exit'
alias cl='clear'

set -x PATH ~/.local/bin $PATH
set -x PATH ~/.opencode/bin:$PATH


starship init fish | source

clear
banner

# pnpm
set -gx PNPM_HOME "/data/data/com.termux/files/home/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
