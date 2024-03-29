(setq inhibit-splash-screen t)
(print "Starting to process .emacs")
;(require 'labburn-theme)
(add-to-list 'load-path "~/.emacs.d/elisp")
(tool-bar-mode -1)
;(require 'site-gentoo)

;; key bindings

                                        ;(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "S-r") 'revert-buffer)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key "\C-x\C-r" 'revert-buffer)
(global-set-key "\C-xm" 'browse-url-at-point)
(when window-system
    (global-unset-key "\C-z")) ; iconify-or-deiconify-frame (C-x C-z)
;(global-set-key "\C-x\C-b" 'bs-show)
(global-set-key "\C-x\C-b" 'list-buffers)

;(global-set-key "\C-x\C-d" 'insert-rest)
;(global-set-key "<next>" 

;; mouse bindings

;; (autoload 'alt-mouse-set-font "alt-font-menu"
;;   "interactively choose font using mouse" t)
;; (global-set-key [(shift down-mouse-1)] 'alt-mouse-set-font) 


;; (unless window-system
;; ;; fake it so I can scroll a line at a time with the keyboard
;;   (setq imwheel-scroll-interval 1)
;;   (defun imwheel-scroll-down-some-lines ()
;;     (interactive)
;;     (scroll-down imwheel-scroll-interval))
;;   (defun imwheel-scroll-up-some-lines ()
;;     (interactive)
;;     (scroll-up imwheel-scroll-interval))
;;   (global-set-key "\M-s" 'imwheel-scroll-up-some-lines)
;;   (global-set-key "\M-r" 'imwheel-scroll-down-some-lines)
;; )
;(global-set-key [down] 'next-line)
;(global-set-key [up] 'previous-line)



;(setq slime-truncate-lines nil)
(setq split-width-threshold 200)



;; (if (= emacs-major-version 23)
;;     (progn
;;       (add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m/")

;; 	(require 'w3m-ems))
;;   (require 'w3m))

;;  (require 'w3m-load)

;(add-to-list 'load-path "/home/muggli/emacs-library/haskell-mode-2.8.0")
 (setq tramp-default-method "ssh")
(setq tramp-use-ssh-controlmaster-options "-S ~/.ssh/nfs1")
;(makunbound 'tramp-use-ssh-controlmaster-options)

(when (>= emacs-major-version 24)
  (require 'package)


  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)  
;  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))




;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;  ;                        ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa" . "https://melpa.org/packages/")))


;; (package-initialize)

;; (when (>= emacs-major-version 24)
;;   (require 'package)
;;   (package-initialize)
;;   (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;   )


 (setq browse-url-browser-function 'w3m-browse-url)
 (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut



;; hack to detect if this an oldish version of emacs (specfically if the 1's place is 1, eg emacs v 21.3.1)

;(set-default-font "Consolas-6")
;(set-default-font "ProFont-9")
;; (insert (prin1-to-string (w32-select-font))) (determine font in use)
;(set-default-font "-ADBO-Source Serif Pro-normal-normal-normal-*-12-*-*-*-*-0-iso10646-1")
;(set-default-font "-ADBO-Source Serif Pro-normal-normal-normal-*-13-*-*-*-*-0-iso10646-1")
;(set-default-font "-ADBO-Source Serif Pro-normal-normal-normal-*-14-*-*-*-*-0-iso10646-1")
(if  (eq system-type 'windows-nt)

    (progn ;; Windows stuff
      (print "Detected Windows")
      (add-to-list 'load-path "h:/emacs-library") ; your SLIME directory
;;      (set-default-font "-outline-Bitstream Vera Sans Mono-normal-r-normal-normal-13-*-96-96-c-*-iso10646-1" )

      (require 'telnet)
      (setq telnet-program "c:/emacs/bin/telnet.exe")
      (defun telnet (host)
        "Open a network login connection to host named HOST (a string).
   Communication with HOST is recorded in a buffer `*telnet-HOST*'.
   Normally input is edited in Emacs and sent a line at a time."
        (interactive "sOpen telnet connection to host: ")
        (let* ((comint-delimiter-argument-list '(?\  ?\t))
               (name (concat "telnet-" (comint-arguments host 0 nil) ))
               (buffer (get-buffer (concat "*" name "*")))
               process)
          (cond ((string-equal system-type "windows-nt")
                 (setq telnet-new-line "\n")))
          (if (and buffer (get-buffer-process buffer))
              (pop-to-buffer (concat "*" name "*"))
            (pop-to-buffer (make-comint name telnet-program nil host))
            (setq process (get-buffer-process (current-buffer)))
            (set-process-filter process 'telnet-initial-filter)
            (accept-process-output process)      (telnet-mode)
            (setq comint-input-sender 'telnet-simple-send)
            (setq telnet-count telnet-initial-count))))

      (require 'telnet)

      (defun my-telnet()
        "invokes telnet in separate comint buffer"
        (interactive)
        (let ((ip-addr-end 72))
          (setq ip-addr-end (read-string "What is the last num of the =
ip-address ? "))
          (make-telnet ip-addr-end)))

      (defun telnet-mikev()
        "telnets to mikev"
        (interactive)
        (let ((ip-addr-end 39))
          (setq ip-addr-end (read-string "What is the last num of the ip address ? "))
          (make-telnet ip-addr-end)))

      (defun make-telnet ( ip-addr-end )
        "Creates or Connects to telnet process"
        (interactive)
        (make-comint (concat "telnet-" ip-addr-end) "telnet" nil
                     (concat "149\.199\.170\." ip-addr-end))
        (switch-to-buffer (concat "*telnet-" ip-addr-end "*"))
        (shell-mode)
        (abbrev-mode 1)
        (insert "
")
        (comint-send-input))

      (push "C:/clisp-2.34" exec-path)


      (add-to-list 'load-path "c:/slime/") ; your SLIME directory
      (setq inferior-lisp-program "C:/clisp-2.34/lisp") ; your Lisp system
;      (require 'slime)
;      (slime-setup)
      
      (setq mouse-buffer-menu-mode-mult 1)
      
      (setq buffers-menu-max-size 20))
  (progn ;; unix stuff
    (print "Detected Unix")
    ;;(set-foreground-color "color-22")
;;    (set-background-color "color-253")
;    (add-to-list 'load-path "/home/muggli/emacs-library") ; your SLIME directory
;    (add-to-list 'load-path "/proj/isimco/users/muggli/lisp/slime") ; your SLIME directory
    (add-to-list 'load-path "/home/muggli/emacs-library/ecb-2.40") ; your SLIME directory
    
    (setq inferior-lisp-program "/proj/isimco/users/muggli/lisp/sbcl-1.0.19-lin32/bin/sbcl --core /proj/isimco/users/muggli/lisp/sbcl-1.0.19-lin32/lib/sbcl/sbcl.core") ; your Lisp system
;    (require 'slime)
;    (slime-setup)
;;    (set-default-font "-*-lucidatypewriter-medium-*-*-*-12-*-*-*-*-*-*-*")
    (add-to-list 'load-path "/proj/isimco/users/muggli/emacs-w3m/share/emacs/site-lisp/w3m/"))) ; your w3m directory

    

(set-foreground-color "black")
;;(set-background-color "grey90")
(set-cursor-color "red")







;(global-highlight-changes)
;(global-font-lock-mode)
(setq buffers-menu-max-size 20)
(setq column-number-mode t)

(setq make-backup-files t)
;;(setq mouse-buffer-menu-mode-mult 1)
(setq truncate-partial-width-windows nil)
(setq vc-follow-symlinks t)


;;;;;;;;;;;   indentation stuff ;;;;;;;;;;;;;;;;;;


;;(c-set-style "linux")
;;; always use 4 spaces
;;(setq c-basic-offset 4)
(setq default-tab-width 4)
;;; don't use tabs
(setq-default indent-tabs-mode nil); 


;; (defun dxr-common-style ()
;;   "my custom cc mode"
;;   (c-set-style "linux")
;;    ;;; always use 4 spaces
;;   (setq c-basic-offset 4)
;;    ;;; don't use tabs
;;   (setq indent-tabs-mode nil))

;; (add-hook 'c-mode-common-hook 'dxr-common-style)

;; use stroustrup style C 
(setq c-default-style "stroustrup")

;; make return key also indent in C mode
;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent) 

(show-paren-mode)




;;; set the window height
(setq compilation-window-height 20)

;;; sets compilation window to scroll with progress.
(setq compilation-scroll-output t)





;; (require 'tabbar)
;; (tabbar-mode)
;(require 'verilog-mode) 
;(require 'python-mode) 
;(require 'python)
;(require 'ruby-mode)
;(require 'clojure-mode)

(setq auto-mode-alist
      (append 
              '(;("\\.py$"  . python-mode)
                ("\\.t$" . makefile-mode)
                ("\\.v$"     . verilog-mode)
                ("\\.c$" . c++-mode)
                ("\\.rb$" . ruby-mode)
;                ("\\.clj$" . clojure-mode)
                ("\\.h$" . c++-mode)) 
              auto-mode-alist))



;; (autoload 'python "python-mode"
;;    "Major mode for editing Python scripts." t)
(autoload 'verilog-mode "verilog-mode"
   "Major mode for editing Verilog modules." t)

;; (defun high-on1 ()
;;         (setq my-keywords '(("\\(setq\\|font-lock\\|keywords\\)" 
;;         (0 my-new-face))))
;;         (setq font-lock-keywords (append font-lock-keywords my-keywords))
;; )

;; (defun high-on2 ( expname)
;;         (interactive "Bexpname: ")
;;         (setq my-temp (concat "\\(" expname "\\)" ))
;;         ;; Not sure about the line below...
;; 	(setq my-keywords (list my-temp '(0 font-lock-keyword-face)))
;;         ;;(setq my-keywords (my-temp (0 my-new-face)))  
;;         (setq font-lock-keywords (append font-lock-keywords my-keywords))
;; )

;; we want dired not not make always a new buffer if visiting a directory
;; but using only one dired buffer for all directories.
(defadvice dired-advertised-find-file (around dired-subst-directory activate)
  "Replace current buffer if file is a directory."
  (interactive)
  (let ((orig (current-buffer))
        (filename (dired-get-filename)))
    ad-do-it
    (when (and (file-directory-p filename)
               (not (eq (current-buffer) orig)))
      (kill-buffer orig))))



(setq gnus-select-method
         '((nnimap "mail-imap"
             (nnimap-address "mail"))))
(setq nnimap-list-pattern "*")

;;(unless window-system
;;  (xterm-mouse-mode 1)
;;  (mwheel-install))

(ansi-color-for-comint-mode-on)



;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  )
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
;;   ;; Your init file should contain only one such instance.
;;  '(font-lock-builtin-face ((((type tty) (class color)) (:foreground "blue"))))
;;  '(font-lock-comment-face ((t (:foreground "red" :weight bold))))
;;  '(font-lock-function-name-face ((t (:foreground "blue" :weight bold))))
;;  '(font-lock-keyword-face ((t (:foreground "blue"))))
;;  '(font-lock-string-face ((((type tty) (class color)) (:foreground "green"))))
;;  '(font-lock-type-face ((((type tty) (class color)) (:foreground "blue"))))
;;  '(font-lock-variable-name-face ((((type tty) (class color)) nil))))

;;make all yes or no's into y or n's
(fset 'yes-or-no-p 'y-or-n-p)

;; display the function name in the modline, in certain modes
(which-function-mode 1)

;;; all backups (*~ files) are in the hidden directory .backups
(setq backup-directory-alist (cons '("." . "~/.backups/") backup-directory-alist))


;;; don't create local backup files
(setq vc-cvs-stay-local nil)


;; Turn on the clock!
;;(autoload 'display-time "time" "clock in status bar" t) ;shut up compiler
;; (if (locate-library "time")
;;     (progn
;;       (require 'time)
;;       (defconst display-time-day-and-date t)
;;       (defconst display-time-24hr-format t)
;;       (display-time))
;;     (message "Get time.el from your distro."))
(display-time-mode)

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(tabbar-default-face ((t (:inherit variable-pitch :background "gray72" :foreground "gray20" :height 0.8)))))

;;(load-library "comint-scroll-to-bottom")
;;(add-hook 'comint-mode-hook 'comint-add-scroll-to-bottom)





;;(set-default-font "-sgi-*-medium-*-*-*-12-*-*-*-*-*-*-*")


(setq inhibit-splash-screen t)

;;(setq warning-suppress-types (cons '(undo discard-info) warning-suppress-types)) ;; seems to hang emacs when the stupid warning arises

;(add-to-list 'exec-path "/proj/isimco/users/muggli/python/python-2.6/bin")
(add-to-list 'exec-path "/proj/isimco/users/muggli/local-lin64/bin")
(add-to-list 'exec-path "/tools/xint/prod/bin")
;(require 'ipython)

;(require 'python)

;; (add-hook 'lisp-mode-hook
;;           (lambda ()
;;             (set (make-local-variable lisp-indent-function)
;;                  'common-lisp-indent-function)))

 
(defun size-sort-buffers ()
    "Put the buffer list in alphabetical order."
    (interactive)
    (dolist (buff (buffer-list-size-sorted)) (bury-buffer buff))
    (when (interactive-p) (list-buffers)))
  
 (defun buffer-list-size-sorted ()
    (sort (buffer-list) 
  	(function (lambda (a b) 
                (<
                 (buffer-size a)
                 (buffer-size b))))))

(defun buffers-total-size ()
  "Tells the combined size of all buffers"
  (interactive)
  (apply #'+ (mapcar #'buffer-size (buffer-list)))) 

(defun fname-sort-buffers ()
    "Put the buffer list in alphabetical order."
    (interactive)
    (dolist (buff (buffer-list-fname-sorted)) (bury-buffer buff))
    (when (interactive-p) (list-buffers)))

 (defun buffer-list-fname-sorted ()
    (sort (buffer-list) 
          (function (lambda (a b) 
                      (string<
                       (buffer-file-name a)
                       (buffer-file-name b))))))

(defun xcs-edit-current-buffer ()
  (interactive)
  (if buffer-read-only ; prevent the revert-buffer from overwriting changes by only allowing on read-only buffers
      (let ((fname (buffer-file-name (current-buffer))))
        (cd (file-name-directory fname))
        (shell-command (concatenate 'string "yes | xcs edit " (file-name-nondirectory fname)))
        (revert-buffer :noconfirm t))
    (print "Buffer is already read/write!")))

;(load-file "~/emacs-library/cedet-1.0pre6/common/cedet.el")
;(semantic-load-enable-gaudy-code-helpers)
;(semantic-load-enable-excessive-code-helpers)
;; (require 'semantic-ia)
;; (require 'semantic-gcc)
;; (require 'ede)
;; (global-ede-mode 1)



(put 'upcase-region 'disabled nil)

;;; cperl-mode is preferred to perl-mode                                        
;;; "Brevity is the soul of wit" <foo at acm.org>                               
(defalias 'perl-mode 'cperl-mode)
(setq cperl-indent-level 4)



;; ecb stuff
;(require 'ecb) ;; alternately use  (require 'ecb-autoloads) and then do ecb-activate when you need it

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(ansi-term-color-vector
   [unspecified "#2e2e2e" "#bc8383" "#7f9f7f" "#d0bf8f" "#6ca0a3" "#dc8cc3" "#8cd0d3" "#b6b6b6"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes

   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "0daf22a3438a9c0998c777a771f23435c12a1d8844969a28f75820dd71ff64e1" "6c5a5c47749e7992b4da3011595f5470f33e19f29b10564cd4f62faebbe36b91" "8150ded55351553f9d143c58338ebbc582611adc8a51946ca467bd6fa35a1075" "1dacaddeba04ac1d1a2c6c8100952283b63c4b5279f3d58fb76a4f5dd8936a2c" "8d805143f2c71cfad5207155234089729bb742a1cb67b7f60357fdd952044315" "1e9001d2f6ffb095eafd9514b4d5974b720b275143fbc89ea046495a99c940b0" "80ae3a89f1eca6fb94a525004f66b544e347c6f756aaafb728c7cdaef85ea1f5" default)))
 '(fci-rule-color "#eee8d5")
 '(haskell-mode-hook (quote (turn-on-haskell-simple-indent)) t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(org-agenda-files '("~/Dropbox/org/31oct2021.org"))
 '(magit-diff-options (quote ("--ignore-space-change" "--ignore-all-space")))
 '(nanowrimo-today-goal 12500)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (tabbar solarized-theme color-theme-solarized github-modern-theme arjen-grey-theme goose-theme grayscale-theme greymatters-theme klere-theme kosmos-theme spacegray-theme restclient yaml-mode intero yasnippet lsp-haskell exwm nanowrimo md4rd markdown-mode zenburn-theme labburn-theme rust-playground flymake-rust flycheck-rust cargo clojure-mode websocket w3 request rainbow-delimiters python-mode multi-term icicles haskell-mode git-rebase-mode git-commit-mode gerrit-download doremi-cmd cperl-mode column-enforce-mode cl-generic auto-complete auctex visual-fill-column auctex cdlatex clojure-mode cider w3m nrepl-sync magit haskell-mode flyspell-lazy ess elein ein clojure-mode-extra-font-locking clojure-cheatsheet)))
 '(pdf-view-midnight-colors (quote ("#6a737d" . "#fffbdd")))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(rainbow-identifiers-choose-face-function (quote rainbow-identifiers-cie-l*a*b*-choose-face) t)
 '(rainbow-identifiers-cie-l*a*b*-color-count 1024 t)
 '(rainbow-identifiers-cie-l*a*b*-lightness 80 t)
 '(rainbow-identifiers-cie-l*a*b*-saturation 25 t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(defun insert-rest ()
  (interactive)
  (insert "      if ()
        $display(\"PASSED\");
      else
        $display(\"FAIL\");
   end
endmodule
")
  (backward-char 84))



(setq common-lisp-hyperspec-root
      (if (file-exists-p "c:/emacs-22.1/share/doc/hyperspec/HyperSpec")
          "file:///c:/emacs-22.1/share/doc/hyperspec/HyperSpec/"
        "http://www.lispworks.com/reference/HyperSpec/"))
(require 'tramp)
(setq tramp-default-method "sshx")

(setq xscheme-default-command-line "scheme --library \"C:\\Program Files\\MIT-GNU Scheme\\lib\"") 
(add-to-list 'exec-path "C:/Program Files/MIT-GNU Scheme/bin/")
(require 'xscheme)



;; (setq slime-lisp-implementations
;;       '((kawa ("java" 
;; 	       "-cp" "C:\\Program Files\\Java\\jdk1.6.0_17\\lib\\tools.jar;C:\\java_software\\kawa-1.9.90.jar"
;; 	       "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n"
;; 	       "kawa.repl" "-s")
;;               :init kawa-slime-init)))

;; (defun kawa-slime-init (file _)
;;   (setq slime-protocol-version 'ignore)
;;   (let ((zip "C:/emacs-22.1/site-lisp/slime-2009-12-23/contrib/swank-kawa.zip")) ; <-- insert the right path
;;     (format "%S\n"
;;             `(begin (load ,(expand-file-name zip)) (start-swank ,file)))))


;;(require 'package)
;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("melpax" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives 
;;     '("marmalade" .
;;       "http://marmalade-repo.org/packages/") t)

;;(package-initialize)


;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code
;;    "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code
;;    "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code
;;    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


  (setq TeX-auto-save t)
    (setq TeX-parse-self t)
    (setq-default TeX-master nil)
    (add-hook 'LaTeX-mode-hook 'visual-line-mode)
    (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (setq reftex-plug-into-AUCTeX t)



;; copied from https://github.com/jimm/elisp/blob/master/eshell-customize.el
;; (defun curr-dir-git-branch-string (pwd)
;;   "Returns current git branch as a string, or the empty string if
;; PWD is not in a git repo (or the git command is not found)."
;;   (interactive)
;;   (when (and (eshell-search-path "git")
;;              (locate-dominating-file pwd ".git"))
;;     (let ((git-output (shell-command-to-string (concat "git branch | grep '\\*' | sed -e 's/^\\* //'"))))
;;       (concat "[g:"
;;               (if (> (length git-output) 0)
;;                   (substring git-output 0 -1)
;;                 "(no branch)")
;;               "] "))))

;; (defun pwd-repl-home (pwd)
;;   (interactive)
;;   (let* ((home (expand-file-name (getenv "HOME")))
;;           (home-len (length home)))
;;     (if (and
;;           (>= (length pwd) home-len)
;;            (equal home (substring pwd 0 home-len)))
;;         (concat "~" (substring pwd home-len))
;;       pwd)))
;; (setq eshell-prompt-function
;;       (lambda ()
;;         (concat
;;          (or (curr-dir-git-branch-string (eshell/pwd)))
;;          ((lambda (p-lst)
;;             (if (> (length p-lst) 3)
;;                 (concat
;;                  (mapconcat (lambda (elm) (if (zerop (length elm)) ""
;;                                             (substring elm 0 1)))
;;                             (butlast p-lst 3)
;;                             "/")
;;                  "/"
;;                  (mapconcat (lambda (elm) elm)
;;                             (last p-lst 3)
;;                             "/"))
;;               (mapconcat (lambda (elm) elm)
;;                          p-lst
;;                          "/")))
;;           (split-string (pwd-repl-home (eshell/pwd)) "/"))
;;          "$ ")))

    (defun doremi-tab-width (increment)
      "Change value of tab width incrementally."
      (interactive "p")
      (doremi (lambda (new-val)
                (setq tab-width (doremi-limit new-val 1 nil)))
              (or tab-width 8)
              increment))
;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

;; when cursor is on edge, move to the other side, as in a toroidal space
(setq windmove-wrap-around t )

(defalias 'list-buffers 'ibuffer)

 ;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
 ;;  ;; Replace "sbcl" with the path to your implementation
 ;;  (setq inferior-lisp-program "sbcl")


;; mac specific stuff
(if (eq system-type 'darwin)
    (progn 
					;(setq mac-option-modifier 'control)
      (setq mac-command-modifier 'control)
      (setq mac-control-modifier 'super)

  (setq exec-path (cons "/Applications/ghc-7.10.3.app/Contents/bin" (cons "/usr/local/bin" exec-path)))
					; merge mac clipboard with emacs clipboard (ahh, nice!)
  (setq x-select-enable-clipboard t)

  (setq mac-option-modifier 'meta))

  ;(set-default-font "Consolas-10")
  ;; (unless (eq 49 (aref emacs-version 1))
  ;;   (set-default-font "Consolas-10"))

  ; something for OS X if true
  ; optional something if not
)







; from http://mpastell.com/pweave/emacs.html
;Pnw-mode for Pweave reST documents
(defun Pnw-mode ()
       (require 'noweb-font-lock-mode)
       (noweb-mode)
       (setq noweb-default-code-mode 'python-mode)
       (setq noweb-doc-mode 'rst-mode))

(setq auto-mode-alist (append (list (cons "\\.Pnw$" 'Pnw-mode))
                   auto-mode-alist))

;Plw-mode for Pweave Latex documents
(defun Plw-mode ()
       (require 'noweb-font-lock-mode)
       (noweb-mode)
       (setq noweb-default-code-mode 'python-mode)
       (setq noweb-doc-mode 'latex-mode))

(setq auto-mode-alist (append (list (cons "\\.Plw$" 'Plw-mode))
                   auto-mode-alist))





; slime/sbcl/lisp stuff
(keyboard-translate ?\( ?\()
(keyboard-translate ?\[ ?\[)
(keyboard-translate ?\) ?\))
(keyboard-translate ?\] ?\])


;(require 'ein)





; window numbering
(require 'window-number)
(window-number-mode)

(window-number-meta-mode)

(global-set-key (kbd "C-c g") 'magit-status)

(add-to-list `exec-path "/Users/muggli/.local/share/virtualenvs/p-L-5FESAF/bin/")
(add-to-list `exec-path "/home/muggli/local/bin")
(setenv "SBCL_HOME" nil)

(setenv "LD_LIBRARY_PATH" "/home/muggli/git/cosmo/3rd_party_inst/boost/lib")

(setq compilation-skip-threshold 2)
(setq compilation-auto-jump-to-first-error nil)

(defun comint-fix-window-size ()
  "Change process window size."
  (when (derived-mode-p 'comint-mode)
    (set-process-window-size (get-buffer-process (current-buffer))
                         (window-height)
                         (window-width))))

(defun my-shell-mode-hook ()
  ;; add this hook as buffer local, so it runs once per window.
  (add-hook 'window-configuration-change-hook 'comint-fix-window-size nil t))

(add-hook 'shell-mode-hook 'my-shell-mode-hook)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)




(defun string/reverse (str)
  "Reverse the str where str is a string"
  (apply #'string
         (reverse
                (string-to-list str))))



(when (and (fboundp 'server-start)); (string-equal (getenv "TERM") 'xterm))
  (server-start)
  (defun fp-kill-server-with-buffer-routine ()
    (and server-buffer-clients (server-done)))
  (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))

(setenv "EDITOR" "emacsclient")
;(require 'python-mode)
(require 'python)

;(require 'ipython)



(setq py-python-command-args '("--matplotlib" "--colors" "LightBG"))

(setq backup-directory-alist
      `((".*" . ,"~/.emacs-autosave/")))
(setq auto-save-file-name-transforms
                `((".*" ,"~/.emacs-autosave/" t)))

;(add-to-list 'eshell-visual-commands "htop")

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

(defun ales/fill-paragraph (&optional P)
  "When called with prefix argument call `fill-paragraph'.
Otherwise split the current paragraph into one sentence per line."
  (interactive "P")
  (if (not P)
      (save-excursion 
        (let ((fill-column 12345678)) ;; relies on dynamic binding
          (fill-paragraph) ;; this will not work correctly if the paragraph is
                           ;; longer than 12345678 characters (in which case the
                           ;; file must be at least 12MB long. This is unlikely.)
          (let ((end (save-excursion
                       (forward-paragraph 1)
                       (backward-sentence)
                       (point-marker))))  ;; remember where to stop
            (beginning-of-line)
            (while (progn (forward-sentence)
                          (<= (point) (marker-position end)))
              (just-one-space) ;; leaves only one space, point is after it
              (delete-char -1) ;; delete the space
              (newline)        ;; and insert a newline
             ; (LaTeX-indent-line) ;; I only use this in combination with late, so this makes sense
              ))))
    ;; otherwise do ordinary fill paragraph
    (fill-paragraph P)))


(global-set-key (kbd "M-q") 'ales/fill-paragraph)
(put 'downcase-region 'disabled nil)


(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(setq org-export-headline-levels 10)
(setq truncate-lines nil)


(global-set-key [mouse-6] 'previous-buffer)
(global-set-key [mouse-7] 'next-buffer)
 

(require 'mouse-copy)
(global-set-key [down-mouse-8] 'mouse-drag-secondary-pasting)
(global-set-key [down-mouse-9] 'mouse-drag-secondary-moving)

(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))


;; (require 'lsp)
;; (require 'lsp-haskell)
;; (require 'haskell)
;; (add-hook 'haskell-mode-hook #'lsp)
;(lsp turn-on-haskell-indent turn-on-haskell-simple-indent)

(set-default 'truncate-lines nil)
(setq truncate-partial-width-windows nil)
(setq org-startup-truncated nil)

;; may slow down emacs
;; update the mode line to have line number and column number
;; (setq mode-line-position 
;;       '("%p (%l," (:eval (format "%d)" (1+ (current-column))))))
;; ;; force the update of the mode line so the column gets updated
;; (add-hook 'post-command-hook 'force-mode-line-update)

(setq column-number-indicator-zero-based nil)

(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 1))
(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 1))
(global-set-key [(control down)] 'gcm-scroll-down)
(global-set-key [(control up)]   'gcm-scroll-up)


;; menu-bar.el menu-set-font, x-select-font (or mouse-select-font for old fashion version)
;; frame.el set-frame-font
;; -ADBO-Source Code Pro-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1
;;(set-default-font "Source Code Pro-10")
(add-hook 'haskell-mode-hook
          (lambda () (local-set-key (kbd "C-c C-n") #'intero-restart)
            (local-set-key (kbd "C-c C-d") #'intero-mode)))
(global-set-key (kbd "C-c C-n") 'intero-restart)
(global-set-key (kbd "C-c C-d") 'intero-mode)

;; Bionano windows setup
(push "c:/msys64/usr/bin/" exec-path)

(setenv "PATH" (concat "C:\\Program Files\Putty;" (concat "C:\\msys64\\usr\\bin;" (getenv "PATH"))))
(setq tramp-default-method "plink")

(setq org-agenda-files '("c:/Users/mmuggli/OneDrive/org/"))

;(add-to-list 'load-path "~/.emacs.d/elisp/use-package")
;(load-library "use-package")
;(load-library "cascadia")

(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(avy-setup-default)
(global-set-key (kbd "C-c C-j") 'avy-resume)
(electric-indent-mode 't)


(require 'lsp)
(require 'lsp-haskell)
;; Hooks so haskell and literate haskell major modes trigger LSP setup
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp)


(setq org-enable-priority-commands t)
(setq org-default-priority ?C)
(setq org-lowest-priority ?D)
(setq org-priority-highest ?A)

(setq lsp-client-packages (remove-if (lambda (x) (eql 'lsp-ada x)) lsp-client-packages))
(require 'dap-python)


;(add-to-list 'tramp-remote-path "/Users/muggli/miniconda3/envs/mdm_python/bin")
(add-to-list 'tramp-remote-path "/home/users7/mmuggli/miniconda3/envs/pyls/bin")
(lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "pylsp")
                     :major-modes '(python-mode)
                     :remote? t
                     :server-id 'pylsp-remote))

;; from https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))
(setq vc-handled-backends nil)

(add-hook 'after-change-major-mode-hook (lambda() (electric-indent-mode -1)))
(require 'dap-python)

