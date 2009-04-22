(defun my-search-at-dictionary-app ()
  ""
  (interactive)
  (let* ((keyword (read-from-minibuffer
           " keyword: "
           (my-get-keyword)))
     (encoded-keyword (encode-coding-string keyword 'japanese-shift-jis)))
(unless (string= encoded-keyword "")
    (do-applescript (concat "
activate application \"Dictionary\"
tell application \"System Events\"
    tell application process \"Dictionary\"
        set value of text field 1 of group 1 of tool bar 1 of window 1 to \""
            encoded-keyword "\"
        click button 1 of text field 1 of group 1 of tool bar 1 of window 1
    end tell
end tell
")))))

(defun my-get-keyword ()
  ""
  (or (and
       transient-mark-mode
       mark-active
       (buffer-substring-no-properties
        (region-beginning) (region-end)))
      (thing-at-point 'word)))

(transient-mark-mode t)
