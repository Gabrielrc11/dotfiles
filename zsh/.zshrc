# Starship
eval "$(starship init zsh)"

#Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY   # grava cada comando na hora, não só ao sair
setopt SHARE_HISTORY        # compartilha histórico entre terminais abertos
setopt EXTENDED_HISTORY     # salva data/hora de cada comando
setopt HIST_IGNORE_DUPS     # não repete comando igual seguido
setopt HIST_IGNORE_SPACE    # comando começando com espaço não vai pro histórico
fastfetch
