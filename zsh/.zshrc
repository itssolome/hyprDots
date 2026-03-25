# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vars
export SUDO_PROMPT="If you want continue 
type your password %u: "

# load engine

autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%F{red} %b%f'

# zsh options
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

# prompt
eval "$(starship init zsh)"

# command not found
command_not_found_handler() {
	printf "%s%s? I don't know what is it\n" "$acc" "$0" >&2
    return 127
}

#  ▄▄▄·▄▄▌  ▄• ▄▌ ▄▄ • ▪   ▐ ▄ .▄▄ · 
# ▐█ ▄███•  █▪██▌▐█ ▀ ▪██ •█▌▐█▐█ ▀. 
#  ██▀·██▪  █▌▐█▌▄█ ▀█▄▐█·▐█▐▐▌▄▀▀▀█▄
# ▐█▪·•▐█▌▐▌▐█▄█▌▐█▄▪▐█▐█▌██▐█▌▐█▄▪▐█
# .▀   .▀▀▀  ▀▀▀ ·▀▀▀▀ ▀▀▀▀▀ █▪ ▀▀▀▀ 

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8


# Compilation flags
export ARCHFLAGS="-arch x86_64"

# bin path
export PATH=$PATH:/home/itssolome/.local/bin

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#·▄▄▄▄• ▄▌ ▐ ▄  ▄▄· ▄▄▄▄▄▪         ▐ ▄ .▄▄ · 
#▐▄▄·█▪██▌•█▌▐█▐█ ▌▪•██  ██ ▪     •█▌▐█▐█ ▀. 
#██▪ █▌▐█▌▐█▐▐▌██ ▄▄ ▐█.▪▐█· ▄█▀▄ ▐█▐▐▌▄▀▀▀█▄
#██▌.▐█▄█▌██▐█▌▐███▌ ▐█▌·▐█▌▐█▌.▐▌██▐█▌▐█▄▪▐█
#▀▀▀  ▀▀▀ ▀▀ █▪·▀▀▀  ▀▀▀ ▀▀▀ ▀█▄▀▪▀▀ █▪ ▀▀▀▀ 

# fzf improvement
function fzf-lovely(){

if [ "$1" = "h" ]; then
  fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
    echo {} is a binary file ||
    (bat --style=numbers --color=always {} ||
    highlight -O ansi -l {} ||
    coderay {} ||
    rougify {} ||
    cat {}) 2> /dev/null | head -500'

else
  fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
    echo {} is a binary file ||
    (bat --style=numbers --color=always {} ||
    highlight -O ansi -l {} ||
    coderay {} ||
    rougify {} ||
    cat {}) 2> /dev/null | head -500'
fi
}


# ▄▄▄     • ▌ ▄ ·.    ▄ •▄ 
# ▀▄ █·   ·██ ▐███▪   █▌▄▌▪
# ▐▀▀▄    ▐█ ▌▐▌▐█·   ▐▀▀▄·
# ▐█•█▌   ██ ██▌▐█▌   ▐█.█▌
# .▀  ▀   ▀▀  █▪▀▀▀   ·▀  ▀

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

#  ▄▄▄· ▄▄▌  ▪   ▄▄▄· .▄▄ · ▄▄▄ ..▄▄ · 
# ▐█ ▀█ ██•  ██ ▐█ ▀█ ▐█ ▀. ▀▄.▀·▐█ ▀. 
# ▄█▀▀█ ██▪  ▐█·▄█▀▀█ ▄▀▀▀█▄▐▀▀▪▄▄▀▀▀█▄
# ▐█ ▪▐▌▐█▌▐▌▐█▌▐█ ▪▐▌▐█▄▪▐█▐█▄▄▌▐█▄▪▐█
#  ▀  ▀ .▀▀▀ ▀▀▀ ▀  ▀  ▀▀▀▀  ▀▀▀  ▀▀▀▀ 
alias lt=taskbook

alias cat=bat

alias clock="tty-clock -c -C 4 -f '%d/%m/%Y'"

alias cls=clear
alias cl=clear
alias lc=clear

alias g=git
alias gc='git clone'
alias ga='git add'
alias gaa='git add .'
alias gcm='git commit'
alias gc-m='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gst='git status'
alias gbm='git branch -M main'
alias gb='git branch'
alias grao='git remote add origin'
alias gch='git checkout'
alias gi='git init'

alias ls='eza -a --icons'
alias l='eza -a --icons'
alias ll='eza -l --icons -a'
alias ltree='eza --tree --level=2 --icons'
alias ..='cd ..'
alias ...=cd
alias n=nvim
alias neo=nvim
# alias vim=nvim

alias q=exit
alias r=ranger
alias b=btop
alias fixhour='sudo ntpd -qg && sudo hwclock -w'
alias udb='sudo updatedb'
alias sozsh='source ~/.config/zsh/.zshrc'
alias mion='amixer sset Capture cap'
alias mioff='amixer sset Capture nocap'

alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias sstd='sudo systemctl start docker.socket && sudo systemctl start docker.service'
alias sspd='sudo systemctl stop docker.socket && sudo systemctl stop docker.service'

alias sstms='sudo systemctl start mssql-server'
alias sspms='sudo systemctl stop mssql-server'

alias ssttor='sudo systemctl start tor'
alias ssptor='sudo systemctl stop tor'

alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mainten="yay -Sc --noconfirm && sudo pacman -Scc --noconfirm"
alias up="yay -Syu --noconfirm && sudo pacman -Syu --noconfirm"
alias mirrors="sudo reflector --verbose --latest 10 --country 'Colombia' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias i="yay -S"
alias s="yay -Ss"

alias sysfetch="clear && bash /home/itssolome/.local/bin/sysfetch"

alias swof="sudo swapoff -a"
alias swon="sudo swapon -a"

alias yt="mov-cli -s youtube"
alias ani="mov-cli -s anime"

alias vcp="pnpm dlx shadcn@latest init --preset b2fA --template vite"

# Gentleman Alias
alias fzfbat='fzf --preview="bat --theme=paradise --color=always {}"'
alias fzfnvim='nvim $(fzf --preview="bat --theme=paradise --color=always {}")'


#·▄▄▄▄•      ▐▄• ▄ ▪  ·▄▄▄▄  ▄▄▄ .
#▪▀·.█▌▪      █▌█▌▪██ ██▪ ██ ▀▄.▀·
#▄█▀▀▀• ▄█▀▄  ·██· ▐█·▐█· ▐█▌▐▀▀▪▄
#█▌▪▄█▀▐█▌.▐▌▪▐█·█▌▐█▌██. ██ ▐█▄▄▌
#·▀▀▀ • ▀█▄▀▪•▀▀ ▀▀▀▀▀▀▀▀▀▀•  ▀▀▀ 

eval "$(zoxide init zsh)"

#  ▐ ▄ ▪  ▄▄▄▄▄ ▄▄·  ▄ .▄    
# •█▌▐███ •██  ▐█ ▌▪██▪▐█    
# ▐█▐▐▌▐█· ▐█.▪██ ▄▄██▀▐█    
# ██▐█▌▐█▌ ▐█▌·▐███▌██▌▐▀    
# ▀▀ █▪▀▀▀ ▀▀▀ ·▀▀▀ ▀▀▀ ·    

clear; nitch

# ·▄▄▄ ▄▄▄· .▄▄ · ▄▄▄▄▄·▄▄▄▄▄▄ .▄▄▄▄▄ ▄▄·  ▄ .▄
# ▐▄▄·▐█ ▀█ ▐█ ▀. •██  ▐▄▄·▀▄.▀·•██  ▐█ ▌▪██▪▐█
# ██▪ ▄█▀▀█ ▄▀▀▀█▄ ▐█.▪██▪ ▐▀▀▪▄ ▐█.▪██ ▄▄██▀▐█
# ██▌.▐█ ▪▐▌▐█▄▪▐█ ▐█▌·██▌.▐█▄▄▌ ▐█▌·▐███▌██▌▐▀
# ▀▀▀  ▀  ▀  ▀▀▀▀  ▀▀▀ ▀▀▀  ▀▀▀  ▀▀▀ ·▀▀▀ ▀▀▀ ·

# clear; fastfetch

# fzf
eval "$(fzf --zsh)"

# nvm directory
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm

export PNPM_HOME="/home/itssolome/.local/share/pnpm"
case ":$PATH:" in
	*":$PNPM_HOME:"*) ;;
	*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pnpm end

# ███████╗███╗   ██╗██████╗      ██████╗ ███████╗    ██████╗  ██████╗ ████████╗███████╗
# ██╔════╝████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝    ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
# █████╗  ██╔██╗ ██║██║  ██║    ██║   ██║█████╗      ██║  ██║██║   ██║   ██║   ███████╗
# ██╔══╝  ██║╚██╗██║██║  ██║    ██║   ██║██╔══╝      ██║  ██║██║   ██║   ██║   ╚════██║
# ███████╗██║ ╚████║██████╔╝    ╚██████╔╝██║         ██████╔╝╚██████╔╝   ██║   ███████║
# ╚══════╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝         ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝



export PATH=$PATH:/home/itssolome/.spicetify
