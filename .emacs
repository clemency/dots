(setq user-full-name "Ryohei Yokoyama")
(setq user-mail-address "yokoyama.net@gmail.com")

(setq load-path
      (append
       (list
        (expand-file-name "~/elisp")
        (expand-file-name "~/elisp/w3m")
        (expand-file-name "~/elisp/mew")
        )
       load-path))

(cd "~/")

;;文字コード
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq menu-bar-mode nil)

(global-set-key "\C-x." 'tags-serach)

;;triger eshell-command
(global-set-key "\C-x," 'eshell-command)

(put 'scroll-left 'disabled nil)

(defun perl-eval (beg end)
  "Run selected region as Perl code"
  (interactive "r")
  (shell-command-on-region beg end "perl")
                                        ;feeds the region to perl on STDIN
  )
(global-set-key "\M-\C-p" 'perl-eval)

;; javascript-mode
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|json\\|jsn\\)\\'" 'javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
(setq js-indent-level 4)

;;mew
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;;Optional setup (Read Mail menu for Emacs 21):
(if (boundp 'read-mail-command)
    (setq read-mail-command 'mew))

;;Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))


;;full screen
(when (eq window-system 'mac)
  (add-hook 'window-setup-hook
            (lambda ()
              (set-frame-parameter nil 'fullscreen 'fullboth))))

;; ECB
(setq load-path (cons (expand-file-name "~/elisp/ecb-2.32") load-path))
(load-file "~/elisp/cedet-1.0pre4/common/cedet.el")
(setq semantic-load-turn-useful-things-on t)
(require 'ecb)
(setq ecb-tip-of-the-day nil)
(setq ecb-windows-width 0.25)
(defun ecb-toggle ()
  (interactive)
  (if ecb-minor-mode
      (ecb-deactivate)
    (ecb-activate)))
(global-set-key [f2] 'ecb-toggle)

;;color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)


;;transparent
;;Color
(if window-system (progn
   (set-background-color "Black")
   (set-foreground-color "LightGray")
   (set-cursor-color "Gray")
   (set-frame-parameter nil 'alpha 100)
   ))

;;window 行ったり来たり
(windmove-default-keybindings)

;;; エスケープシーケンスを処理する
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(iswitchb-mode t)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(defun memo ()
  (interactive)
  (add-change-log-entry 
   nil
   (expand-file-name "~/ChangeLog")))
(define-key ctl-x-map "M" 'memo)

;;キルリングのサマリー
(autoload 'kill-summary "kill-summary" nil t)

;;最近使ったファイル　recentf-open-files
;;(recentf-mode)

;;履歴の保存
;;(require 'session)
;;(add-hook 'after-init-hook 'session-initialize)

;;(setq default-input-method "MacOSX") 

(define-key key-translation-map [?\x8a5] [?\\])
(define-key key-translation-map [?\xd5c] [?\\])
(define-key key-translation-map [?\x40008a5] [?\C-\\])
(define-key key-translation-map [?\x80008a5] [?\M-\\])
(define-key key-translation-map [?\xc0008a5] [?\C-\M-\\])

;;migemo
;;;; c/migemo -- incremental searches by ro-maji
;; base
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict") ; PATH of migemo-dict
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)

;; use cache
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1024)
;; charset encoding
(setq migemo-coding-system 'utf-8-unix)

(load-library "migemo")
;; initialization
(migemo-init)

;;キルリング
(require 'browse-kill-ring)


;;; windows.el
;; 分割されたウィンドウを切り替えることができる。
;; さらにu、分割形態を保存することもできる。
;;
;; キーバインド C-z にを変更。デフォルトは C-c C-w。
;; 変更しない場合は，以下の 3 行を削除する。
;; C-z n   前のウィンドウ
;; C-z p   後のウィンドウ
;; C-z !   現在のウィンドウを破棄
;; C-z C-m メニューの表示
;; C-z ;   ウィンドウの一覧をc表示
(setq win:switch-prefix "\C-z")
(define-key global-map win:switch-prefix nil)

(require 'windows)
;; 新規にフレームを作らない
(setq win:use-frame nil)
(win:startup-with-window)
;; C-x C-c で終了するとそのときのウィンドウの状態を保存する
;; C-x C なら保存しない
(define-key ctl-x-map "\C-c" 'see-you-again)
(define-key ctl-x-map "C" 'save-buffers-kill-emacs)
;; *migemo* のようなバッファも保存
(setq revive:ignore-buffer-pattern "^ \\*")
;; キーバインドの追加
(add-hook 'win:add-hook
          '(lambda ()
             (define-key win: "\C-c\C-g" 'clgrep)
             ))
(define-key win:switch-map "\C-m" 'win-menu)
(define-key win:switch-map ";" 'win-switch-menu)

;;; backtabでバッファ全体を untabify と indent
(global-set-key [backtab] 'untabify-and-indent-whole-buffer)
(defun untabify-and-indent-whole-buffer ()
  (interactive)
  (untabify (point-min) (point-max))
  (indent-region (point-min) (point-max)))

(global-set-key "\C-\\" 'undo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNU GLOBAL(gtags)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))

(require 'anything-config)
(anything-iswitchb-setup)

;;(win-load-all-configurations)

;;eshell
;; Emacs起動時にEshellを起動
(add-hook 'after-init-hook (lambda() (eshell) ))

;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))
;; 補完時にサイクルする
(setq eshell-cmpl-cycle-completions t)
;;補完候補がこの数値以下だとサイクルせずに候補表示
(setq eshell-cmpl-cycle-cutoff-length 5)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)

;; prompt文字列の変更
(setq eshell-prompt-function
      (lambda ()
        (concat "["(eshell/pwd)
                (if (= (user-uid) 0) "]\n# " "]$ ")
                )))
;; 変更したprompt文字列に合う形でpromptの初まりを指定(C-aで"$ "の次にカーソルがくるようにする)
;; これの設定を上手くしとかないとタブ補完も効かなくなるっぽい
(setq eshell-prompt-regexp "^[^#$]*[$#] ")

;;; キーバインドの変更
(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map "\C-a" 'eshell-bol)
               (define-key eshell-mode-map "\M-p" 'eshell-previous-matching-input-from-input)
               (define-key eshell-mode-map "\M-n" 'eshell-next-matching-input-from-input)
               )))
(add-hook 'after-init-hook (lambda() (eshell)))

;;(require 'tramp)
;;(setq tramp-default-method "sshx")
;;(add-to-list
;;  'tramp-multi-connection-function-alist
;;  '("sshx" tramp-multi-connect-rlogin "ssh -t -t %h -l %u /bin/sh%n"))
;;

;;font
(set-face-attribute 'default nil
                    :family "monaco"
                    :height 160)


;;; 使いやすいほうのバッファリスト
(define-key global-map "\C-x\C-b" 'electric-buffer-list)

;;; 使いやすいほうのディアー
(load "dired-x")

;;; outline-minor-mode をマシに

;;;; text-mode の時に outline-minor-mode
(add-hook 'text-mode-hook '(lambda () (outline-minor-mode t)))

;;;; fold-dwim 3つ覚えるだけで伸縮自在に
(autoload 'fold-dwim-toggle
  "fold-dwim"
  "try to show any hidden text at the cursor" t)
(autoload 'fold-dwim-hide-all
  "fold-dwim" "hide all folds in the buffer" t)
(autoload 'fold-dwim-show-all
  "fold-dwim" "show all folds in the buffer" t)
(define-key global-map "\C-c\C-o" 'fold-dwim-toggle)
(define-key global-map "\C-c\C-m" 'fold-dwim-hide-all)
(define-key global-map "\C-c\C-k" 'fold-dwim-show-all)

