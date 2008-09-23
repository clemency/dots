# 文字コードの設定
export LANG='ja_JP.UTF-8'

# パスの設定
PATH=/usr/local/bin:$PATH
export MANPATH=/usr/local/man:/usr/share/man

#-----------------------------------------------------------------
## プロンプト
##-----------------------------------------------------------------
## ユーザ名・ホスト名を左プロンプト表示、カレントディレクトリ名は
## 右プロンプト表示する。日本語のディレクトリ名も表示できるように、
## precmd() を使って毎回設定しなおしてみた。
##
##PROMPT="%B%n@%m[%(?.%!.ERROR:%?)]%b%% "
##precmd() { RPROMPT="[$PWD]" }
#PROMPT="[%(?.%!.ERROR:%?)]%b%% "
#PS1='[\u@\h \W]\$ '
#precmd() { RPROMPT="[$PWD]" }

PROMPT="[$USER@$HOST %~] "


# 関数
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }

# エイリアスの設定
alias ls='ls -G -l'
alias ll='ls -ltr'
alias vi='vim'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'


# ヒストリの設定
HISTFILE=~/.histfile
HISTSIZE=100000                       # メモリ内の履歴の数
SAVEHIST=100000                       # 保存される履歴の数
setopt extended_history               # 履歴ファイルに時刻を記録
function history-all { history -E 1 } # 全履歴の一覧を出力する

# 補完するかの質問は画面を超える時にのみに行う｡
LISTMAX=0

autoload -Uz compinit; compinit

# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# cdのタイミングで自動的にpushd
setopt auto_pushd 

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history

# 補完候補が複数ある時に、一覧表示
setopt auto_list

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完
setopt auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# ビープ音を鳴らさないようにする
setopt NO_beep

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# 重複したヒストリは追加しない
setopt hist_ignore_all_dups

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
setopt NO_list_types

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 8 ビット目を通すようになり、日本語のファイル名を表示可能
setopt print_eight_bit

# シェルのプロセスごとに履歴を共有
setopt share_history

# Ctrl+wで､直前の/までを削除する｡
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ディレクトリを水色にする｡
export LS_COLORS='di=01;36'

# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cd をしたときにlsを実行する
function chpwd() { ls }

# ^で､cd ..
function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup

# ディレクトリ名だけで､ディレクトリの移動をする｡
setopt auto_cd

# C-s, C-qを無効にする。
setopt NO_flow_control

export PERL5LIB=$HOME/local/lib/perl5:$HOME/local/lib/perl5/site_perl
export PATH=$PATH:/usr/bin:/opt/local/bin:/Users/caval/bin:/usr/local/bin/:/opt/local/bin:/Developer/Tools/:~/lib/flex_sdk_2/bin/:/usr/local/mysql/bin:$HOME/local/bin

autoload -U compinit compinit 
