# dotfiles

Minhas configurações para **Arch Linux** com **Hyprland** (Wayland), gerenciadas com [GNU Stow](https://www.gnu.org/software/stow/).

## Conteúdo

| Pacote   | Destino                         | Descrição                                                        |
| -------- | ------------------------------- | ---------------------------------------------------------------- |
| `hypr`   | `~/.config/hypr/hyprland.lua`   | Config do Hyprland em Lua: monitores, tema escuro, input, binds |
| `waybar` | `~/.config/waybar/`             | Barra flutuante em "ilhas", estilo CSS e menu de energia        |
| `zsh`    | `~/.zshrc`                      | Starship, autosuggestions, syntax highlighting e histórico      |

Além disso:

- `pkglist.txt` — pacotes dos repositórios oficiais
- `aurlist.txt` — pacotes do AUR

## Instalação

```sh
# 1. Clonar
git clone https://github.com/Gabrielrc11/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Pacotes oficiais
sudo pacman -S --needed - < pkglist.txt

# 3. Pacotes do AUR (requer yay)
yay -S --needed - < aurlist.txt

# 4. Criar os symlinks
stow hypr waybar zsh
```

Se já existirem arquivos no destino, o Stow vai acusar conflito. Faça backup e remova-os antes, ou use `stow --adopt` (que move os arquivos existentes para dentro do repositório — confira com `git diff` depois).

Para remover os links de um pacote: `stow -D <pacote>`.

### Atualizar as listas de pacotes

```sh
pacman -Qqen > pkglist.txt   # pacotes nativos instalados explicitamente
pacman -Qqem > aurlist.txt   # pacotes externos (AUR)
```

## Destaques

### Hyprland

- Dois monitores: notebook (`eDP-1`, 60 Hz) e AOC externo (`HDMI-A-1`, 100 Hz), ambos com escala 1.20
- Tema escuro para GTK (`adw-gtk3-dark`) e Qt (`qt6ct`)
- Layouts de teclado `br` e `us-intl`, alternando com `Super + Espaço`
- Gesto de 3 dedos na horizontal para trocar de workspace

Atalhos principais (`Super` = tecla Windows):

| Atalho                    | Ação                                  |
| ------------------------- | ------------------------------------- |
| `Super + Q`               | Terminal (kitty)                      |
| `Super + E`               | Gerenciador de arquivos (Dolphin)     |
| `Super + R`               | Launcher (hyprlauncher)               |
| `Super + C`               | Fechar janela                         |
| `Super + V`               | Alternar janela flutuante             |
| `Super + J`               | Alternar divisão (dwindle)            |
| `Super + setas`           | Mover foco                            |
| `Super + 1–0`             | Ir para workspace                     |
| `Super + Shift + 1–0`     | Mover janela para workspace           |
| `Super + S`               | Workspace especial (scratchpad)       |
| `Super + Shift + S`       | Captura de área para o clipboard      |
| `Super + M`               | Sair do Hyprland                      |

### Waybar

- Barra flutuante no topo com módulos agrupados
- Workspaces, relógio com calendário, CPU/RAM/temperatura, layout do teclado, volume, brilho, perfil de energia e bateria
- Menu de energia (`scripts/power.sh`) usando o `hyprlauncher` em modo dmenu, com confirmação antes de desligar/reiniciar/sair

### Zsh

- Prompt [Starship](https://starship.rs/)
- Plugins `zsh-autosuggestions` e `zsh-syntax-highlighting` (pacotes do Arch)
- Histórico de 50 mil comandos, compartilhado entre terminais e com data/hora
- `fastfetch` ao abrir o terminal

## Requisitos

- Arch Linux (ou derivado)
- `stow`, `yay`
- Fonte com ícones Nerd Font (`ttf-jetbrains-mono-nerd`) para os ícones da Waybar
