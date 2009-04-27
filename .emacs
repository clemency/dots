(setq user-full-name "Ryohei Yokoyama")
(setq user-mail-address "yokoyama.net@gmail.com")

(if window-system (ns-grabenv "/opt/local/bin/zsh" '("source ~/.zshrc" "printenv")))

(setq load-path
      (append
       (list
        (expand-file-name "~/elisp")
        (expand-file-name "~/elisp/mew")
        (expand-file-name "/Applications/MacPorts/Emacs.app/Contents/Resources/share/emacs/site-lisp/w3m")
        (expand-file-name "~/elisp/navi2ch")
        )
       load-path))

(cd "~/")
(setq inhibit-startup-message t)
;;文字コード
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq menu-bar-mode nil)

(load "dired-x")

;;時計表示
(display-time)

;;行全体を削除
(setq kill-whole-line t)

;;行数列数表示
(setq line-number-mode t)
(setq column-number-mode t)

;;C-xlでgoto-lineを実行
(global-set-key "\C-xl" 'goto-line)

;;タブ幅
(setq default-tab-width 2)

(define-key global-map "\C-x>" 'indent-region)

;;ツールバー非表示
(tool-bar-mode 0)
(menu-bar-mode 0)

;;BSで選択範囲を消す
(delete-selection-mode 1)

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)

;;(utf-translate-cjk-mode t)

;;C-hでdelete
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\177" 'delete-char)

;;モード行の背景, 文字の色を変更
(set-face-background 'modeline "grey10")
(set-face-foreground 'modeline "light cyan")
(set-face-background 'highlight "grey10")
(set-face-foreground 'highlight "red")

;;color
(font-lock-mode 1)
(setq-default transient-mark-mode t)

(setq next-line-add-newline nil)

;;auto-complete
(global-set-key "\M-/" 'dabbrev-expand)
(setq dabbrev-case-fold-search nil)

;;paren
(show-paren-mode t)

;;ruby-mode
(autoload 'ruby-mode
  "ruby-mode" "Mode for editing ruby source files" t)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq indent-tabs-mode 't)
             (setq ruby-indent-level tab-width)
             ))
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))

(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("¥¥.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")

;; tab and indent
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys) 
             (setq tab-width 3)))
(setq ruby-indent-level 3)

(defalias 'perl-mode 'cperl-mode)

(setq cperl-indent-level 4
      cperl-continued-statement-offset 4
      cperl-close-paren-offset -4
      cperl-comment-column 40
      cperl-highlight-variables-indiscriminately t
      cperl-indent-parens-as-block t
      cperl-label-offset -4
      cperl-tab-always-indent nil
      cperl-font-lock t)
(add-hook 'cperl-mode-hook
          '(lambda ()
             (progn
               (setq indent-tabs-mode nil)
               (setq tab-width nil)
               )))
(setq auto-mode-alist
      (append (list (cons "\\.\\(pl\\|pm\\)$" 'cperl-mode))
              auto-mode-alist))


;;perldoc
;; モジュールソースバッファの場合はその場で、
;; その他のバッファの場合は別ウィンドウに開く。
(put 'perl-module-thing 'end-op
     (lambda ()
       (re-search-forward "\\=[a-zA-Z][a-zA-Z0-9_:]*" nil t)))
(put 'perl-module-thing 'beginning-op
     (lambda ()
       (if (re-search-backward "[^a-zA-Z0-9_:]" nil t)
           (forward-char)
         (goto-char (point-min)))))

(defun perldoc-m ()
  (interactive)
  (let ((module (thing-at-point 'perl-module-thing))
        (pop-up-windows t)
        (cperl-mode-hook nil))
    (when (string= module "")
      (setq module (read-string "Module Name: ")))
    (let ((result (substring (shell-command-to-string (concat "perldoc -m " module)) 0 -1))
          (buffer (get-buffer-create (concat "*Perl " module "*")))
          (pop-or-set-flag (string-match "*Perl " (buffer-name))))
      (if (string-match "No module found for" result)
          (message "%s" result)
        (progn
          (with-current-buffer buffer
            (toggle-read-only -1)
            (erase-buffer)
            (insert result)
            (goto-char (point-min))
            (cperl-mode)
            (toggle-read-only 1)
            )
          (if pop-or-set-flag
              (switch-to-buffer buffer)
            (display-buffer buffer)))))))

;;pod-mode
(require 'pod-mode)
(add-to-list 'auto-mode-alist
             '("\\.pod$" . pod-mode))

;;sintax indent
(defmacro mark-active ( )
  "Xemacs/emacs compatible macro"
  (if (boundp 'mark-active)
      'mark-active
    '(mark)))

(defun perltidy ( )
  "Run perltidy on the current region or buffer"
  (interactive)
                                        ; Inexplicably, save-excursion doesn't work here.
  (let ((orig-point (point)))
    (unless (mark-active) (mark-defun))
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)
    (goto-char orig-point)))
(global-set-key "\C-ct" 'perltidy)

;;cperl-prove
(eval-after-load "cperl-mode"
  '(add-hook 'cperl-mode-hook
             (lambda () (local-set-key "\C-cp" 'cperl-prove))))
(global-set-key "\C-cp" 'cperl-prove)
(defun cperl-prove ()
  "Run the current test."
  (interactive)
  (shell-command (concat "prove -v "
                         (shell-quote-argument (buffer-file-name)))))

(setq inferior-lisp-program "/usr/local/bin/clisp")

(defun eval-lisp ()
  "Run the current test."
  (interactive)
  (shell-command (concat "clisp "
                         (shell-quote-argument (buffer-file-name)))))
(defun eval-perl ()
  "Run the current test."
  (interactive)
  (shell-command (concat "perl "
                         (shell-quote-argument (buffer-file-name)))))

(defun  perl-find-module ()
  (interactive)
  (let
      (end begin module path-to-module)
    (save-excursion
      (setq begin (save-excursion (skip-chars-backward "a-zA-Z0-9_:") (point)))
      (setq end (save-excursion (skip-chars-forward "a-zA-Z0-9_:") (point)))
      (setq module (buffer-substring begin end))
      )
    (shell-command (concat "perldoc -lm " module) "*perldoc*")
    (save-window-excursion
      (switch-to-buffer "*perldoc*")
      (setq end (point))
      (setq begin (save-excursion (beginning-of-line) (point)))
      (setq path-to-module (buffer-substring begin end))
      )
    (message path-to-module)
    (find-file path-to-module)
    ))

(defun perl-generate-etags ()
  "Run the current test."
  (interactive)  
  (setq begin (save-excursion (skip-chars-backward "a-zA-Z0-9_:") (point)))
  (setq end (save-excursion (skip-chars-forward "a-zA-Z0-9_:") (point)))
  (setq module (buffer-substring begin end))
  
  (shell-command (concat "perldoc -lm " module) "*perldoc*")
  (save-window-excursion
    (switch-to-buffer "*perldoc*")
    (setq end (point))
    (setq begin (save-excursion (beginning-of-line) (point)))
    (setq path-to-module (buffer-substring begin end))
    )
  (message path-to-module)
  (shell-command (concat("etags --language=perl " path-to-module)))

  "Automatically create tags file."
  (let (tag-file (concat "/Users/caval/TAGS")))
  (message tag-file)
  ;;  (unless (file-exists-p tag-file)
  ;;  (shell-command (concat "prove -v "
  ;;         (shell-quote-argument (buffer-file-name))))
  )


;; タグの自動生成
;;(defadvice find-tag (before c-tag-file activate)

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
(setq iswitchb-buffer-ignore
      '(
        "*twittering-wget-buffer*"
        "*twittering-http-buffer*"
        "*WoMan-Log*"
				"*SKK annotation*"
				"*Completions*"
        ))


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
(setq migemo-command "/usr/local/bin/cmigemo")
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
                    :height 125)
(setq my-font "-*-*-medium-r-normal--14-*-*-*-*-*-fontset-hirakaku")
(setq fixed-width-use-QuickDraw-for-ascii t)
(setq mac-allow-anti-aliasing t)
(if (= emacs-major-version 22)
    (require 'carbon-font))
(set-default-font my-font)
(add-to-list 'default-frame-alist `(font . ,my-font))
(when (= emacs-major-version 23)
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0208
   '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
  (setq face-font-rescale-alist
	'(("^-apple-hiragino.*" . 1.2)
	  (".*osaka-bold.*" . 1.2)
	  (".*osaka-medium.*" . 1.2)
	  (".*courier-bold-.*-mac-roman" . 1.0)
	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	  (".*monaco-bold-.*-mac-roman" . 0.9)
	  ("-cdac$" . 1.3))))

;;;使いやすいほうのバッファリスト
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

(require 'tree-widget)
(require 'php-mode)

(define-key global-map [?¥] "\\")  ;;

(require 'twittering-mode)
(setq twittering-username "yokoyama.net@gmail.com")
(setq twittering-password "caval2")

(require 'navi2ch)

(setq w3m-command "/usr/local/bin/w3m")
(require 'w3m-load)
(setq w3m-use-cookies t)

;;Color
(if window-system (progn
   (set-background-color "Black")
   (set-foreground-color "LightGray")
   (set-cursor-color "Gray")
   (set-frame-parameter nil 'alpha 85)
   ))

;====================================
;フレーム位置設定(ウィンドウ） 
;====================================
(setq initial-frame-alist
			(append
       '((top . 0)    ; フレームの Y 位置(ピクセル数)
				 (left . 0)    ; フレームの X 位置(ピクセル数)
				 (width . 160)    ; フレーム幅(文字数)
				 (height . 65)   ; フレーム高(文字数)
				 ) initial-frame-alist))

;;(read-abbrev-file)

(setq backup-inhibited t)

;;dictionay.el
(global-set-key "\M-d" 'my-search-at-dictionary-app)

;;lookup.el
;; オートロードの設定
(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)
;; キーバインドの設定
(define-key ctl-x-map "l" 'lookup)
(define-key ctl-x-map "y" 'lookup-region)
(define-key ctl-x-map "\C-y" 'lookup-pattern)
