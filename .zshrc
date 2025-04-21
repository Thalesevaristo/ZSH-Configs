# Initialize Zap plugin manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# Key bindings
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias grep='grep --color=auto'
alias python="python3"

# Path additions
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# Cores do TYPEWRITTEN_COLOR_MAPPINGS
LIGHT_BLUE="#B6D6F2"         # primary, info_neutral_2
PALE_YELLOW="#FFF0AA"        # secondary
GREY_GREEN="#BBC4B9"         # accent, host_user_connector
PALE_ORANGE="#F2D3B6"        # notice
BRIGHT_RED="#FE5A59"         # info_negative
MINT_GREEN="#a9ffb4"         # info_positive
SOFT_PEACH="#F2C3A6"         # info_neutral_1
AQUA_MINT="#B3FFDE"          # info_special

SOFT_PINK="#FFAAAF"          # host
LIGHT_LIME="#CDFFAA"         # user

# Theme
export TYPEWRITTEN_PROMPT_LAYOUT="pure_verbose"
export TYPEWRITTEN_CURSOR="beam"
export TYPEWRITTEN_SYMBOL="$"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"

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

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "reobin/typewritten"

# Load and initialise completion system
autoload -Uz compinit
compinit
