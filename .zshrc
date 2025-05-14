# -----------------------------------------------------------------------------
# => ZAP PLUGIN MANAGER
# -----------------------------------------------------------------------------
ZAP_PATH="$HOME/.local/share/zap/zap.zsh"

# Check if zap.zsh exists
if [ ! -f "$ZAP_PATH" ]; then
  # Clone the repository if zap.zsh is not found
  git clone https://github.com/zap-zsh/zap.git "$HOME/.local/share/zap"
fi

# Source zap.zsh if it exists
if [ -f "$ZAP_PATH" ]; then
  source "$ZAP_PATH"
fi

# -----------------------------------------------------------------------------
# => HISTORY
# -----------------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# -----------------------------------------------------------------------------
# => AUTOCOMPLETION
# -----------------------------------------------------------------------------
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Better autocomplete
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:warnings' format '%F{red}-- no results --%f'

# -----------------------------------------------------------------------------
# => THEME COLORS
# -----------------------------------------------------------------------------
LIGHT_BLUE="#B6D6F2"      # primary, info_neutral_2
PALE_YELLOW="#FFF0AA"     # secondary
GREY_GREEN="#BBC4B9"      # accent, host_user_connector
PALE_ORANGE="#F2D3B6"     # notice
BRIGHT_RED="#FE5A59"      # info_negative
MINT_GREEN="#a9ffb4"      # info_positive
SOFT_PEACH="#F2C3A6"      # info_neutral_1
AQUA_MINT="#B3FFDE"       # info_special
SOFT_PINK="#FFAAAF"       # host
LIGHT_LIME="#CDFFAA"      # user

# -----------------------------------------------------------------------------
# => TYPEWRITTEN THEME
# -----------------------------------------------------------------------------
export TYPEWRITTEN_PROMPT_LAYOUT="pure_verbose"
export TYPEWRITTEN_CURSOR="beam"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_SYMBOL="$"
export TYPEWRITTEN_COLOR_MAPPINGS="\
primary:${LIGHT_BLUE};\
secondary:${PALE_YELLOW};\
accent:${GREY_GREEN};\
notice:${PALE_ORANGE};\
info_negative:${BRIGHT_RED};\
info_positive:${MINT_GREEN};\
info_neutral_1:${SOFT_PEACH};\
info_neutral_2:${LIGHT_BLUE};\
info_special:${AQUA_MINT}"
export TYPEWRITTEN_COLORS="\
host:${SOFT_PINK};\
host_user_connector:${GREY_GREEN};\
user:${LIGHT_LIME}"

# -----------------------------------------------------------------------------
# => ALIASES
# -----------------------------------------------------------------------------
# Basic aliases
alias ls="ls --color=auto"
alias ll="ls -la"
alias la="ls -a"
alias l="ls -lh"
alias grep="grep --color=auto"
alias python="python3"
alias pip="pip3"
alias mkdir="mkdir -p"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"

# Simplified navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# -----------------------------------------------------------------------------
# => PATH
# -----------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
# Adiciona Cargo (Rust) ao PATH se existir
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
# Adiciona npm global ao PATH se existir
[ -d "$HOME/.npm-global/bin" ] && export PATH="$HOME/.npm-global/bin:$PATH"

# -----------------------------------------------------------------------------
# => PLUGINS
# -----------------------------------------------------------------------------
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/fzf"
plug "hlissner/zsh-autopair"
plug "reobin/typewritten"

# -----------------------------------------------------------------------------
# => KEYBINDINGS
# -----------------------------------------------------------------------------
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

bindkey "^[[1;5C" forward-word                # Ctrl+Right
bindkey "^[[1;5D" backward-word               # Ctrl+Left
bindkey '^[[H' beginning-of-line              # Home
bindkey '^[[F' end-of-line                    # End
bindkey '^[[3~' delete-char                   # Delete

# -----------------------------------------------------------------------------
# => ADICIONAL ENVIROMENT VARIABLES
# -----------------------------------------------------------------------------
export EDITOR="vim"                           # Default Editor
export VISUAL="vim"                           # Visual Editor
export PAGER="less"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# -----------------------------------------------------------------------------
# => FZF SETUP
# -----------------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always {}'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fzf para hist  rico com Ctrl+R
function fzf-history-widget() {
  local selected
  selected=( $(fc -l 1 | fzf --query="$LBUFFER" --multi --reverse --height 40%) )
  local ret=$?
  if [ -n "$selected" ]; then
    local num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
