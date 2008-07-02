(setq user-full-name "Ryohei Yokoyama")
(setq user-mail-address "yokoyama.net@gmail.com")

(setq load-path
			(append
			 (list
				(expand-file-name "~/elisp")
				(expand-file-name "~/elisp/w3m")
				)
			 load-path))

(cd "~/")

;;文字コード
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq menu-bar-mode nil)

(require 'w3m-load)
(setq w3m-home-page "http://www.google.com")
(setq w3m-use-cookies t)
(setq w3m-cookie-accept-bad-cookies t)

(load "dired-x")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wl
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)


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
(set-terminal-coding-system 'utf-8)

(utf-translate-cjk-mode t)

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




(autoload 'cperl-mode
  "cperl-mode"
  "alternate mode for editing Perl programs" t)
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

(add-hook 'cperl-mode-hook
          '(lambda ()
             (progn
               (setq indent-tabs-mode nil)
               (setq tab-width nil)
               )))

;;perldoc
(global-set-key "\M-p" 'cperl-perldoc)	; alt-p

(global-set-key "\M-p" '(lambda ( ) (interactive)
;;(require 'w3m)
;;(w3m-goto-url "http://localhost:8020")
))

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
	;;				 (shell-quote-argument (buffer-file-name))))
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
(setq js-indent-level 4
)

;;mew
;;(autoload 'mew "mew" nil t)
;(autoload 'mew-send "mew" nil t)

;; Optional setup (Read Mail menu for Emacs 21):
;(if (boundp 'read-mail-command)
;    (setq read-mail-command 'mew))

;; Optional setup (e.g. C-xm for sending a message):
;;(autoload 'mew-user-agent-compose "mew" nil t)
;;(if (boundp 'mail-user-agent)
;;    (setq mail-user-agent 'mew-user-agent))
;;(If (fboundp 'define-mail-user-agent)
;;    (define-mail-user-agent
;;      'mew-user-agent
;;      'mew-user-agent-compose
;;      'mew-draft-send-message
;;      'mew-draft-kill
;;      'mew-send-hook))
;;

;;full screen
(mac-toggle-max-window)

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
(setq default-frame-alist
      (append (list
               '(alpha . (85 25))
               ) default-frame-alist))

;;window 行ったり来たり
(windmove-default-keybindings)

;;; エスケープシーケンスを処理する
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(iswitchb-mode t)

(require 'tramp)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(defun memo ()
  (interactive)e
    (add-change-log-entry 
     nil
     (expand-file-name "~/ChangeLog")))
(define-key ctl-x-map "M" 'memo)

;;キルリングのサマリー
(autoload 'kill-summary "kill-summary" nil t)

;;最近使ったファイル　recentf-open-files
(recentf-mode)

;;履歴の保存
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

 (setq default-input-method "MacOSX") 