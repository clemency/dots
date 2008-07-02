;;; mew-env.el --- Environment setup for Mew

;; Author:  Kazu Yamamoto <Kazu@Mew.org>
;; Created: Mar  6, 1997

;;; Code:

(require 'mew)

;; to avoid competition with mh-e.el, sigh.
(let ((ent (rassq 'mh-letter-mode auto-mode-alist)))
  (and ent (setq auto-mode-alist (delq ent auto-mode-alist))))

(defvar mew-connection-type1 nil
  "Connection type for many processes. 't' means PTY and 'nil' means PIPE.
PIPE is usually recommended for speed but some OSes such as Linux
requires PTY.")

(defvar mew-connection-type2 t
  "Connection type for processes that requires a password.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Emacsen
;;;

(if window-system (require 'faces))

(defvar mew-icon-p (featurep 'tool-bar))

(defvar mew-internal-utf-8p nil)
(if (fboundp 'utf-translate-cjk-mode) ;; Emacs 22.1 or later
    (setq mew-internal-utf-8p t))

(require 'mew-key)
(require 'mew-gemacs)
(require 'mew-mule3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Misc
;;;

(defun mew-mark () (marker-position (mark-marker)))

(defun mew-md5 (str) (md5 str nil nil 'binary))

(defun mew-timer (sec func) (run-at-time sec sec func))

(if (fboundp 'characterp)
    (defalias 'mew-characterp 'characterp)
  (defalias 'mew-characterp 'integerp))

(if (fboundp 'mouse-region-match)
    (defalias 'mew-mouse-region-p 'mouse-region-match)
  (defmacro mew-mouse-region-p (&rest args) nil))

(cond
 ((boundp 'auto-hscroll-mode) ;; Emacs 21.3.50 or later
  (defun mew-hscroll ()
    (set (make-local-variable 'auto-hscroll-mode) t)))
 ((boundp 'automatic-hscrolling) ;; Emacs 21.3 or earlier
  (defun mew-hscroll ()
    (set (make-local-variable 'automatic-hscrolling) t))))

(if (fboundp 'minibuffer-prompt-end)
    (defalias 'mew-minibuf-point-min 'minibuffer-prompt-end)
  (defalias 'mew-minibuf-point-min 'point-min))

(if (fboundp 'set-process-query-on-exit-flag)
    (defun mew-process-silent-exit (pro)
      (set-process-query-on-exit-flag pro nil))
  (defun mew-process-silent-exit (pro)
    (process-kill-without-query pro))) ;; Emacs 21.4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Sticky
;;;

(defun mew-front-sticky (beg end)
  (put-text-property beg end 'front-sticky t))

(defun mew-front-nonsticky (beg end)
  (put-text-property beg end 'front-sticky nil))

(defun mew-rear-sticky (beg end)
  (put-text-property beg end 'rear-nonsticky nil))

(defun mew-rear-nonsticky (beg end)
  (put-text-property beg end 'rear-nonsticky t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Overlay
;;;

(defun mew-overlay-make (beg end)
  (let ((ovl (make-overlay beg end)))
    (overlay-put ovl 'mew t)
    ovl))

(defun mew-overlay-delete (ovl)
  (and (overlay-get ovl 'mew) (delete-overlay ovl)))

(defun mew-overlay-delete-region (beg end)
  "Delete overlays in the region."
  (interactive "r")
  (mapcar 'mew-overlay-delete (overlays-in beg end))
  (if (fboundp 'remove-images) (remove-images beg end))) ;; xxx

(defun mew-overlay-delete-buffer ()
  (save-restriction
    (widen)
    (mew-overlay-delete-region (point-min) (point-max))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Face operations
;;;

(defalias 'mew-face-spec-set 'face-spec-set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; File operations
;;;

(cond
 ((fboundp 'make-symbolic-link)
  (defun mew-symbolic-link (filename newname &optional OK-IF-ALREADY-EXISTS)
    (if (file-directory-p (file-chase-links filename))
	(error "Cannot make a symbolic link to directory")
      (make-symbolic-link filename newname OK-IF-ALREADY-EXISTS)))
  (defun mew-link (filename newname &optional OK-IF-ALREADY-EXISTS)
    (if (file-directory-p (file-chase-links filename))
	(error "Cannot make a link to directory")
      (condition-case nil
	  (add-name-to-file filename newname OK-IF-ALREADY-EXISTS)
	(file-error
	 (copy-file filename newname OK-IF-ALREADY-EXISTS 'keepdate))))))
 (t
  (defun mew-symbolic-link (filename newname &optional OK-IF-ALREADY-EXISTS)
    (if (file-directory-p filename)
	(error "Cannot make a copy of directory")
      (copy-file filename newname OK-IF-ALREADY-EXISTS 'keepdate)))
  (defun mew-link (filename newname &optional OK-IF-ALREADY-EXISTS)
    (if (file-directory-p filename)
	(error "Cannot make a copy of directory")
      (copy-file filename newname OK-IF-ALREADY-EXISTS 'keepdate)))))

(if (and (fboundp 'set-file-times)
	 (memq system-type '(darwin windows-nt cygwin)))
    (defalias 'mew-set-file-times 'set-file-times)
  (defmacro mew-set-file-times (&rest args) nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Property
;;;

(defalias 'mew-buffer-substring 'buffer-substring-no-properties)

(if (fboundp 'match-string-no-properties)
    (defalias 'mew-match-string 'match-string-no-properties)
  (defalias 'mew-match-string 'match-string))

(defun mew-insert-buffer-substring (buf beg end)
  (insert (save-excursion (set-buffer buf) (mew-buffer-substring beg end))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Base64
;;;

(defun mew-base64-encode-string (str)
  (base64-encode-string str 'no-line-break))

(defun mew-base64-decode-string (str64)
  (condition-case nil
      (base64-decode-string str64)
    (error nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Language
;;;

;; to load the thread separator
(cond
 ((and (boundp 'current-language-environment)
       (string= current-language-environment "Japanese"))
  (require 'mew-lang-jp))
 ((and (boundp 'current-language-environment)
       (string= current-language-environment "Korean"))
  (require 'mew-lang-kr)))

(provide 'mew-env)

;;; Copyright Notice:

;; Copyright (C) 1997-2008 Mew developing team.
;; All rights reserved.

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;;
;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;; 2. Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.
;; 3. Neither the name of the team nor the names of its contributors
;;    may be used to endorse or promote products derived from this software
;;    without specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE TEAM AND CONTRIBUTORS ``AS IS'' AND
;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
;; PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE TEAM OR CONTRIBUTORS BE
;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
;; BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
;; OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
;; IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;;; mew-env.el ends here
