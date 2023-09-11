;;; modeline-mac.el
;;
;; Copyright (C) 2020 classiclog
;; Author: classiclog <classiclog@vivaldi.net>
;; Version: 1.1 for macos 10.13
;; Keywords: EmacsMac.app, mac-input-source, mode-line
;; URL: http://github.com/classiclog/
;; Commentary: a modified mode-line for EmacsMac


;;; The Mode Line
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Mode-Line.html


;;; The Data Structure of the Mode Line 
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Mode-Line-Data.html


;;; A Modified Mode Line
;; https://www.gnu.org/software/emacs/manual/html_node/eintr/Mode-Line.html


;;; What is the best Emacs mode line package
;; https://www.reddit.com/r/emacs/comments/4n0n8o/what_is_the_best_emacs_mode_line_package/
;; "The best mode-line package is the one you define yourself."


;;; EmacsMac.app API mac-input-source
;; http://peccu.hatenablog.com/entry/2015/03/13/090000

(defun mac-input-source-cursor-color ()
  (set-cursor-color
    (if (string-match "inputmethod" (mac-input-source)) "hotpink" "turquoise"))
;   (if (string-match "\\.US$" (mac-input-source)) "turquoise" "hotpink"))
;   (if (string-match "\\.US$" (mac-input-source)) "firebrick" "blue"))
;   (if (string-match "\\.US$" (mac-input-source)) "blue" "firebrick"))
)

(defun mac-input-source-mode ()
  (mac-input-source-cursor-color)
; (if (string-match "inputmethod" (mac-input-source)) "[IM]" "[--]")
  (if (string-match "inputmethod" (mac-input-source)) "[あ]" "[　]")
; (if (string-match "\\.US$" (mac-input-source)) "[--]" "[IM]")
; (if (string-match "\\.US$" (mac-input-source)) "[Aa]" "[あ]")
)

(defun mac-input-evil-mode ()
  (if evil-mode "(Evil)" "")
)

(defun mac-input-evil-state ()
;  (powerline-evil-tag)
)

(defun mac-selected-keyboard-input-source-change-hook-func ()
  (force-mode-line-update)
)

(add-hook 'mac-selected-keyboard-input-source-change-hook
          'mac-selected-keyboard-input-source-change-hook-func)

(defun mac-input-source-theme ()
  (interactive)
  (setq-default mode-line-format
    (list ""
      '(:eval (mac-input-source-mode))
      'mode-line-front-space 
      'mode-line-mule-info
      'mode-line-modified
      'mode-line-frame-identification 
      'mode-line-buffer-identification 
      " "
      'mode-line-position  ;; evil-state comes on here
      " "
      'mode-line-modes 
      'mode-line-misc-info 
      'mode-line-end-spaces
;      "%b--"
;      '(line-number-mode "L%l--")
;      '(-3 . "%p")
      "-%-"
    )
  )
)


;;; default mode-line-format
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Mode-Line-Top.html

(defun minimal-theme ()
  (interactive)
  (setq-default mode-line-format
    (quote (
      (:eval (mac-input-source-mode))
      "%e"
      mode-line-front-space 
      mode-line-mule-info 
      mode-line-client 
      mode-line-modified 
      mode-line-remote 
      mode-line-frame-identification 
      mode-line-buffer-identification 
      "   " 
      mode-line-position  ;; evil-state comes on here
;      (vc-mode vc-mode)
      "  " 
      mode-line-modes 
      mode-line-misc-info 
      mode-line-end-spaces
      )
    )
  )
)


;;; a hypothetical example of a mode-line-format for Shell mode
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Mode-Line-Top.html

(defun hypothetical-shell-theme ()
  "Here is a hypothetical example of a mode-line-format that might be useful
  for Shell mode (in reality, Shell mode does not set mode-line-format).
  The variables line-number-mode, 
  column-number-mode and which-func-mode enable particular minor modes;
  as usual, these variable names are also the minor mode command names."
  (interactive)
  (setq-default mode-line-format
    (list "-"
      '(:eval (mac-input-source-mode))
      '(:eval (mac-input-evil-mode))
      'mode-line-mule-info
      'mode-line-modified
      'mode-line-frame-identification
      "%b--"
      ;; Note that this is evaluated while making the list.
      ;; It makes a mode line construct which is just a string.
      (getenv "HOST")
      ":"
      'default-directory
      "   "
      'global-mode-string
      "   %[("
      '(:eval (mode-line-mode-name))
      'mode-line-process
      'minor-mode-alist
      "%n"
      ")%]--"
      '(which-func-mode ("" which-func-format "--"))
      '(line-number-mode "L%l--")
      '(column-number-mode "C%c--")
      '(-3 "%p")))
  )


;;; a modified mode line
;;
;;    "Finally, a feature I really like: a modified mode line."
;;    -- Robert J. Chassell
;;
;; An Introduction to Programming in Emacs Lisp
;; https://www.gnu.org/software/emacs/manual/eintr.html
;; 16.14 A Modified Mode Line
;; https://www.gnu.org/software/emacs/manual/html_node/eintr/Mode-Line.html

(defun robert-j-chassell-theme ()
  "Set a Mode Line that tells me which machine, which directory,
  and which line I am on, plus the other customary information."
  (interactive)
  (setq-default mode-line-format
   (quote (
     (:eval (mac-input-source-mode))
     (:eval (mac-input-evil-mode))
     #("-" 0 1
       (help-echo
        "mouse-1: select window, mouse-2: delete others ..."))
     mode-line-mule-info
     mode-line-modified
     mode-line-frame-identification
     " "
     mode-line-buffer-identification
     " "
     (:eval (substring
             (system-name) 0 (string-match "\\..+" (system-name))))
     ":"
     default-directory
     #(" " 0 1
       (help-echo
        "mouse-1: select window, mouse-2: delete others ..."))
     (line-number-mode " Line %l ")
     global-mode-string
     #("   %[(" 0 6
       (help-echo
        "mouse-1: select window, mouse-2: delete others ..."))
     (:eval (mode-line-mode-name))
     mode-line-process
     minor-mode-alist
     #("%n" 0 2 (help-echo "mouse-2: widen" local-map (keymap ...)))
     ")%] "
     (-3 . "%P")
     ;;   "-%-"
     )))
)


;;; invocation
;;

;(mac-input-source-cursor-color)

(mac-input-source-theme)
;(minimal-theme)
;(hypothetical-shell-theme)
;(robert-j-chassell-theme)

;(set-face-attribute 'mode-line nil :foreground "#fff" :background "#FF0066")

