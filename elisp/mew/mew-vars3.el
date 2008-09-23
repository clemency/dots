;;; mew-vars3.el

;; Author:  Kazu Yamamoto <Kazu@Mew.org>
;; Created: May 10, 2006

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Highlight header
;;;

(defface mew-face-header-subject
  '((((class color) (type tty)) (:foreground "red" :bold t))
    (((class color) (background light)) (:foreground "Firebrick" :bold t))
    (((class color) (background dark))  (:foreground "OrangeRed" :bold t))
    (t (:bold t)))
  "*Face to highlight the value of Subject:"
  :group 'mew-highlight)

(defface mew-face-header-from
  '((((class color) (type tty)) (:foreground "yellow" :bold t))
    (((class color) (background light)) (:foreground "DarkOrange4" :bold t))
    (((class color) (background dark))  (:foreground "Gold" :bold t))
    (t (:bold t)))
  "*Face to highlight the value of From:"
  :group 'mew-highlight)

(defface mew-face-header-date
  '((((class color) (type tty)) (:foreground "green" :bold t))
    (((class color) (background light)) (:foreground "ForestGreen" :bold t))
    (((class color) (background dark))  (:foreground "LimeGreen" :bold t))
    (t (:bold t)))
  "*Face to highlight the value of Date:"
  :group 'mew-highlight)

(defface mew-face-header-to
  '((((class color) (type tty)) (:foreground "magenta" :bold t))
    (((class color) (background light)) (:foreground "DarkViolet" :bold t))
    (((class color) (background dark))  (:foreground "violet" :bold t))
    (t (:bold t)))
  "*Face to highlight the value of To:"
  :group 'mew-highlight)

(defface mew-face-header-key
  '((((class color) (type tty)) (:foreground "green" :bold t))
    (((class color) (background light)) (:foreground "ForestGreen" :bold t))
    (((class color) (background dark))  (:foreground "LimeGreen" :bold t))
    (t (:bold t)))
  "*Face to highlight by default"
  :group 'mew-highlight)

(defface mew-face-header-private
  '((((class color) (type tty)) (:bold t))
    (((class color) (background light)) (:bold t))
    (((class color) (background dark))  (:bold t))
    (t (:bold t)))
  "*Face to highlight private field-keys"
  :group 'mew-highlight)

(defface mew-face-header-important
  '((((class color) (type tty)) (:foreground "cyan" :bold t))
    (((class color) (background light)) (:foreground "MediumBlue" :bold t))
    (((class color) (background dark))  (:foreground "SkyBlue" :bold t))
    (t (:bold t)))
  "*Face to highlight important field-keys"
  :group 'mew-highlight)

(defface mew-face-header-marginal
  '((((class color) (type tty)) (:bold t))
    (((class color) (background light)) (:foreground "gray50" :bold t))
    (((class color) (background dark))  (:foreground "gray50" :bold t))
    (t (:bold t)))
  "*Face to highlight marginal field-values"
  :group 'mew-highlight)

(defface mew-face-header-warning
  '((((class color) (type tty)) (:foreground "red" :bold t))
    (((class color) (background light)) (:foreground "red" :bold t))
    (((class color) (background dark))  (:foreground "red" :bold t))
    (t (:bold t)))
  "*Face to highlight non-my-domain addresses on To:/Cc:/Bcc:"
  :group 'mew-highlight)

(defface mew-face-header-xmew
  '((((class color) (type tty)) (:foreground "yellow" :bold t))
    (((class color) (background light)) (:foreground "chocolate" :bold t))
    (((class color) (background dark))  (:foreground "chocolate" :bold t))
    (t (:bold t)))
  "*Face to highlight the value of X-Mew:"
  :group 'mew-highlight)

(defface mew-face-header-xmew-bad
  '((((class color) (type tty)) (:foreground "red" :bold t))
    (((class color) (background light)) (:foreground "red" :bold t))
    (((class color) (background dark))  (:foreground "red" :bold t))
    (t (:bold t)))
  "*Face to highlight the value of X-Mew: in bad cases"
  :group 'mew-highlight)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Highlight body
;;;

(defface mew-face-body-url
  '((((class color) (type tty)) (:foreground "red" :bold t))
    (((class color) (background light)) (:foreground "Firebrick" :bold t))
    (((class color) (background dark))  (:foreground "OrangeRed" :bold t))
    (t (:bold t)))
  "*Face to highlight URL in Message/Draft mode"
  :group 'mew-highlight)

(defface mew-face-body-comment
  '((((class color) (type tty)) (:foreground "blue"))
    (((class color) (background light)) (:foreground "gray50"))
    (((class color) (background dark))  (:foreground "gray50"))
    (t nil))
  "*Face to highlight comments in a body"
  :group 'mew-highlight)

(defface mew-face-body-cite1
  '((((class color) (type tty)) (:foreground "green"))
    (((class color) (background light)) (:foreground "ForestGreen"))
    (((class color) (background dark))  (:foreground "LimeGreen"))
    (t nil))
  "*Face to highlight the first citation"
  :group 'mew-highlight)

(defface mew-face-body-cite2
  '((((class color) (type tty)) (:foreground "cyan"))
    (((class color) (background light)) (:foreground "MediumBlue"))
    (((class color) (background dark))  (:foreground "SkyBlue"))
    (t nil))
  "*Face to highlight the second citation"
  :group 'mew-highlight)

(defface mew-face-body-cite3
  '((((class color) (type tty)) (:foreground "magenta"))
    (((class color) (background light)) (:foreground "DarkViolet"))
    (((class color) (background dark))  (:foreground "violet"))
    (t nil))
  "*Face to highlight the third citation"
  :group 'mew-highlight)

(defface mew-face-body-cite4
  '((((class color) (type tty)) (:foreground "yellow"))
    (((class color) (background light)) (:foreground "DarkOrange4"))
    (((class color) (background dark))  (:foreground "Gold"))
    (t nil))
  "*Face to highlight the forth citation"
  :group 'mew-highlight)

(defface mew-face-body-cite5
  '((((class color) (type tty)) (:foreground "red"))
    (((class color) (background light)) (:foreground "Firebrick"))
    (((class color) (background dark))  (:foreground "OrangeRed"))
    (t nil))
  "*Face to highlight the fifth citation"
  :group 'mew-highlight)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Highlight mark
;;;

(defface mew-face-mark-review
  '((((class color) (type tty)) (:foreground "cyan"))
    (((class color) (background light)) (:foreground "MediumBlue"))
    (((class color) (background dark))  (:foreground "SkyBlue"))
    (t (:bold t)))
  "*Face to highlight the review mark"
  :group 'mew-highlight)

(defface mew-face-mark-escape
  '((((class color) (type tty)) (:foreground "magenta"))
    (((class color) (background light)) (:foreground "DarkViolet"))
    (((class color) (background dark))  (:foreground "violet"))
    (t (:bold t)))
  "*Face to highlight the escape mark"
  :group 'mew-highlight)

(defface mew-face-mark-delete
  '((((class color) (type tty)) (:foreground "red"))
    (((class color) (background light)) (:foreground "Firebrick"))
    (((class color) (background dark))  (:foreground "OrangeRed"))
    (t (:bold t)))
  "*Face to highlight the delete mark"
  :group 'mew-highlight)

(defface mew-face-mark-unlink
  '((((class color) (type tty)) (:foreground "yellow"))
    (((class color) (background light)) (:foreground "DarkOrange4"))
    (((class color) (background dark))  (:foreground "Gold"))
    (t (:bold t)))
  "*Face to highlight the unlink mark"
  :group 'mew-highlight)

(defface mew-face-mark-refile
  '((((class color) (type tty)) (:foreground "green"))
    (((class color) (background light)) (:foreground "ForestGreen"))
    (((class color) (background dark))  (:foreground "LimeGreen"))
    (t (:bold t)))
  "*Face to highlight the refile mark"
  :group 'mew-highlight)

(defface mew-face-mark-unread
  '((t nil))
  "*Face to highlight the unread mark"
  :group 'mew-highlight)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Highlight eof
;;;

(defface mew-face-eof-message
  '((((class color) (type tty)) (:foreground "green" :bold t))
    (((class color) (background light)) (:foreground "ForestGreen" :bold t))
    (((class color) (background dark))  (:foreground "LimeGreen" :bold t))
    (t (:bold t)))
  "*Face to highlight the 'end of message' string"
  :group 'mew-highlight)

(defface mew-face-eof-part
  '((((class color) (type tty)) (:foreground "yellow" :bold t))
    (((class color) (background light)) (:foreground "DarkOrange4" :bold t))
    (((class color) (background dark))  (:foreground "Gold" :bold t))
    (t (:bold t)))
  "*Face to highlight the 'end of part' string"
  :group 'mew-highlight)


(provide 'mew-vars3)

;;; Copyright Notice:

;; Copyright (C) 1996-2008 Mew developing team.
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

;;; mew-vars.el ends here
