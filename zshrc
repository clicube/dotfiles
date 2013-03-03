# .zshrc をコンパイルして .zshrc.zwc を生成
zcompile ~/.zshrc

#-------- キーバインド --------#
bindkey -e
bindkey "" backward-delete-char
bindkey "[3~" delete-char
bindkey "[1~" beginning-of-line
bindkey "[4~" end-of-line
bindkey ";5C" forward-word
bindkey ";5D" backward-word


#-------- 補完の設定 --------#
autoload -U compinit ; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'	# 補完候補の大文字小文字を無視
zstyle ':completion:*:default' menu select=1		# 補完候補を方向キーで選択
zstyle ':completion:*' use-cache true			# 補完キャッシュ
bindkey "[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*:processes' command 'ps x'		# kill で 'ps x' のリストから選択可能
setopt list_packed		# コンパクトに補完リストを表示
unsetopt auto_remove_slash	# 補完で末尾に補われた / を自動的に削除
setopt auto_param_slash		# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs		# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types		# 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
unsetopt menu_complete		# 補完の際に、可能なリストを表示してビープを鳴らすのではなく、
                          # 最初にマッチしたものをいきなり挿入
setopt auto_list		# ^Iで補完可能な一覧を表示する(補完候補が複数ある時に、一覧表示)
setopt auto_menu		# 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys		# カッコの対応などを自動的に補完
setopt auto_resume		# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt complete_aliases		# エイリアスもチェックして補完

#setopt auto_correct		# 補完時にスペルチェック
setopt correct			# スペルミスを補完
#setopt correct_all		# コマンドライン全てのスペルチェックをする


# 履歴による予測補完(man zshcontrib)
#autoload -U predict-on  ; predict-on


#-------- 履歴の設定 --------#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
unsetopt extended_history	# 履歴ファイルに開始時刻と経過時間を記録
setopt append_history		# 履歴を追加 (毎回 .zhistory を作るのではなく)
setopt inc_append_history	# 履歴をインクリメンタルに追加
setopt share_history		# 履歴の共有
setopt hist_ignore_all_dups 	# 重複するコマンド行は古い方を削除
setopt hist_ignore_dups		# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space	# スペースで始まるコマンド行はヒストリリストから削除
unsetopt hist_verify		# ヒストリを呼び出し  から実行する間に一旦編集可能を止める
setopt hist_reduce_blanks	# 余分な空白は詰めて記録
setopt hist_save_no_dups	# ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する。
setopt hist_no_store		# historyコマンドは履歴に登録しない
setopt hist_expand		# 補完時にヒストリを自動的に展開

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#-------- ディレクトリ移動関係の設定 --------#
setopt auto_cd			# ディレクトリのみで移動
setopt auto_pushd		# 普通に cd するときにもディレクトリスタックにそのディレクトリを入れる
setopt pushd_ignore_dups	# ディレクトリスタックに重複する物は古い方を削除
setopt pushd_to_home		# pushd 引数ナシ == pushd $HOME
setopt pushd_silent		# pushd,popdの度にディレクトリスタックの中身を表示しない
# pop command
alias pd='popd'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir" '



#-------- 表示関係の設定 --------#
# プロンプトの設定
autoload -U promptinit ; promptinit
autoload -U colors     ; colors
PROMPT="%{$fg[green]%}$USER%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}%{$reset_color%}[%{$fg[red]%}%~%{$reset_color%}]%(!.#.$) "
#RPROMPT="%{$fg[green]%}[%*]%{$reset_color%}"

# ターミナルのタイトルを動的変更
precmd() {
	[[ -t 1 ]] || return
	case $TERM in
		*xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;[%n@%m %~]\a"
		;;
		screen) print -Pn "\e]0;[%n@%m %~]\a"
		;;
	esac
}

# リストの色付け設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#export LS_COLORS='di=1;;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
if type dircolors >/dev/null
then # GNU ls
alias ls='ls --color=auto'
else # BSD ls
alias ls='ls -G'
fi 
# 補完候補も色つき表示
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# kill候補も色つき表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'


#-------- その他の設定 --------#
# 細かい設定
setopt no_beep			# コマンド入力エラーでBeepを鳴らさない
# setopt beep
#
setopt complete_in_word
#setopt extended_glob		# 拡張グロブを有効にする
#setopt brace_ccl		# ブレース展開機能を有効にする
#setopt equals			# =COMMAND を COMMAND のパス名に展開
setopt numeric_glob_sort	# 数字を数値と解釈してソートする
setopt path_dirs		# コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt print_eight_bit		# 補完候補リストの日本語を適正表示
setopt auto_name_dirs

#unsetopt flow_control		# (shell editor 内で) C-s, C-q を無効にする
#setopt no_flow_control		# C-s/C-q によるフロー制御を使わない
#setopt hash_cmds		# 各コマンドが実行されるときにパスをハッシュに入れる

setopt ignore_eof		# C-dでログアウトしない

setopt bsd_echo
#setopt no_hup			# ログアウト時にバックグラウンドジョブをkillしない
#setopt no_checkjobs		# ログアウト時にバックグラウンドジョブを確認しない
#setopt notify			# バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt long_list_jobs		# 内部コマンド jobs の出力をデフォルトで jobs -L にする

setopt magic_equal_subst	# コマンドラインの引数で --PREFIX=/USR などの = 以降でも補完できる
#setopt mail_warning
#setopt multios			# 複数のリダイレクトやパイプなど、必要に応じて TEE や CAT の機能が使われる
setopt short_loops		# FOR, REPEAT, SELECT, IF, FUNCTION などで簡略文法が使えるようになる
#setopt sun_keyboard_hack	# SUNキーボードでの頻出 typo ` をカバーする
setopt always_last_prompt	# カーソル位置は保持したままファイル名一覧を順次その場で表示
#setopt cdable_vars sh_word_split

setopt rm_star_wait		# rm * を実行する前に確認
#setopt rm_star_silent		# rm * を実行する前に確認しない
#setopt no_clobber		# リダイレクトで上書きを禁止
unsetopt no_clobber

#setopt no_unset			# 未定義変数の使用禁止

#setopt interactive_comments	# コマンド入力中のコメントを認める
#setopt chase_links		# シンボリックリンクはリンク先のパスに変換してから実行
#setopt print_exit_value	# 戻り値が 0 以外の場合終了コードを表示
#setopt single_line_zle		# デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
#setopt xtrace			# コマンドラインがどのように展開され実行されたかを表示する

export CORRECT_IGNORE='_*'

export EDITOR=vim

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias rake="noglob rake"

# 固有の設定を読み込む
if [ -f ~/.zshrc.mine ]; then
	source ~/.zshrc.mine
fi

