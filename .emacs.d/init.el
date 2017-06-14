(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/info")
;; auto-installによってインストールされるEmacs Lispをロードパスに加える
;; デフォルトは ~/.emacs.d/auto-install/
(add-to-list 'load-path "~/.emacs.d/auto-install")
(add-to-list 'load-path "~/.emacs.d/private-conf")
(add-to-list 'load-path "~/.emacs.d/helm")

(require 'package)
(setq url-proxy-services
      '(("http" . "http://localhost:3128")
        ("https" . "https://localhost:3128")))
(setq url-http-proxy-basic-auth-storage
	'(("http://localhost:3128" ("Proxy" . "base64string"))))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(fset 'package-desc-vers 'package--ac-desc-version)
(package-initialize)

;; thingatpt.elc読み込まれていない場合は読み込む
(require 'thingatpt)
;; org.elcを読み込む
(load "org")

(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;(add-to-list 'company-backends 'company-irony)

(when (locate-library "company")
  (global-company-mode 1)
  (global-set-key (kbd "C-M-i") 'company-complete)
  ;; (setq company-idle-delay nil) ; 自動補完をしない
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection))

(eval-after-load "irony"
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
     (add-to-list 'company-backends 'company-irony)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-hook 'c-mode-common-hook 'irony-mode)))

(when (require 'flycheck nil 'noerror)
  (custom-set-variables
   ;; エラーをポップアップで表示
   '(flycheck-display-errors-function
     (lambda (errors)
       (let ((messages (mapcar #'flycheck-error-message errors)))
         (popup-tip (mapconcat 'identity messages "\n")))))
   '(flycheck-display-errors-delay 0.5))
  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)
  (add-hook 'c-mode-common-hook 'flycheck-mode))

(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
       (flycheck-irony-setup))))

(when (require 'rtags nil 'noerror)
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (rtags-is-indexed)
                (local-set-key (kbd "M-.") 'rtags-find-symbol-at-point)
                (local-set-key (kbd "M-;") 'rtags-find-symbol)
                (local-set-key (kbd "M-@") 'rtags-find-references)
                (local-set-key (kbd "M-,") 'rtags-location-stack-back)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-display-errors-function
   (lambda
	 (errors)
	 (let
		 ((messages
		   (mapcar
			(function flycheck-error-message)
			errors)))
	   (popup-tip
		(mapconcat
		 (quote identity)
		 messages "
")))))
 '(irony-additional-clang-options (quote ("-std=c++11")))
 '(package-selected-packages
   (quote
	(helm yasnippet undohist undo-tree rtags irony-eldoc flycheck-irony company-irony-c-headers company-irony)))
 '(rtags-use-helm t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 基本設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;----
;; スタートアップページを表示しない
;;----
(setq inhibit-startup-message t)

;;複数ウィンドウを開かないようにする
(setq ns-pop-up-frames nil) 

;;----
;; ビープ音を消す
;;----
(setq ring-bell-function 'ignore)

;;----
;; カーソル行に下線を表示
;;----
(setq hl-line-face 'underline)
(global-hl-line-mode)

;;----
;; TABの表示幅
;;----
(setq-default tab-width 4)

;;----
;; ファイルサイズ表示
;;----
(size-indication-mode t)

;;----
;; タイトルバーにフルパス表示
;;----
(setq frame-title-format "%f")

(set-face-background 'region "custom-rogue ")

;;----
;; カラーテーマ
;;----
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'monokai t)
;; Color-Theme loading
(require 'color-theme)
(color-theme-initialize)
;; Select theme
(color-theme-ld-dark)

;;(load-theme 'ld-dark t)

;;Font設定
(add-to-list 'default-frame-alist '(font . "ricty-10.5"))

;; 現在行に色をつける
(global-hl-line-mode 1)
;; 色
(set-face-background 'hl-line "darkolivegreen")
;; 履歴を次回Emacs起動時にも保存する
(savehist-mode 1)
;; ファイル内のカーソルの位置を記憶する
(setq-default save-place t)
(require 'saveplace)
;; 対応する括弧を表示させる
(show-paren-mode 1)
;; シェルに合わせるため、C-hは後退に割り当てる
(global-set-key (kbd "C-h") 'delete-backward-char)
;; モードラインに時刻を表示する
(display-time)
;; 行番号・桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)
(require 'linum)
(global-linum-mode)
;; リージョンに色をつける
(transient-mark-mode 1)
;; GCを減らして軽くする(デフォルトの20倍)
(setq gc-cons-threshold (* 20 gc-cons-threshold))
;; ログの記録行数を増やす
(setq message-log-max 10000)
;; ミニバッファを先的に呼び出せるようにする
(setq enable-recursive-minibuffers t)
;; ダイアログボックスｗｐ使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)
;; 履歴をたくさん保存する
(setq history-length 1000)
;; キーストロークをエコーエリアに早く表示する
(setq echo-keystrokes 0.1)
;; 大きいファイルは開こうとした時に警告を発生させる
;; デフォルト10MB → 25MB
(setq large-file-warning-threshold (* 25 1024 1024))
;; ミニバッファで入力を取り消しても履歴に残す
;; 誤って取り消しで入力が失われるのを防ぐため
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))
;; yes → y
(defalias 'yes-or-no-p 'y-or-n-p)
;; ツールバーとスクロールバーを消す
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; バッファ・ファイル関係
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 現在位置のファイル・URLを開く
(ffap-bindings)

;; バッファ表示名変更
(require 'uniquify)
;; filename<dir>形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forword-angle-brackets)
;; *で囲まれたバッファ名は対象外とする
(setq uniquify-ignore-buffer-re "*[^*]+*")

;; バッファの切り替え
(iswitchb-mode 1)
;; バッファの読み取り関数を iswitchb にする
(setq read-buffer-function 'iswitchb-read-buffer)
;; 部分文字列の代わりに正規表現を使う場合は t に設定する
(setq iswitchb-regexp nil)
;; 新しいバッファを作成するときにいちいち聞いてこない
(setq iswitchb-prompt-newbuffer nil)

;; (require 'recentf-ext)
;; 最新ファイル500個保存する
;; (setq recentf-max-saved-items 500)
;; 最近使ったファイルを加えないファイルを正規表現で指定する
;; (setq recentf-exclude '("TAGS$" "/var/tmp/"))

(server-start)
(defun iconify-emacs-when-server-si-done ()
  (unless server-clients (iconify-frane)))
;; 編集が終了したらEmacsをアイコン化する(好み応じて)
(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
;; C-x C-cに割り当てる
(global-set-key (kbd "C-x C-c") 'server-edit)
;; M-x exitでEmacsを終了できるようにする
(defalias 'exit 'save-buffer-kill-emacs)

;; (require 'tempbuf)
;; ファイルを開いたら自動的にtempbufを有効にする
;; (add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
;; diredバッファに対してtempbufを有効にする
;; (add-hook 'dired-mode-hook 'trun-on-tempbuf-mode)

;; ファイルを自動で保存する
(require 'auto-save-buffers)
(run-with-idle-timer 2 t 'auto-save-buffers) ;アイドル2秒で保存


;;(require 'screen-lines)
;; text-modeかそれを継承したメジャーモードで自動的に有効にする
;;(add-hook 'text-mode-hook 'turn-on-screen-lines-mode)

;;(require 'redo+)
;;(global-set-key (kbd "C-M-/") 'redo)
;;(setq undo-no-redo t)	;過去のredoがundoされないようにする
;; 大量のundoに耐えられるようにする
;;(setq undo-limit 600000)
;;(setq undo-strong-limit 900000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete-config)
(global-auto-complete-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippetを置いているフォルダにパスを通す
(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/elpa/yasnippet"))

;; 既存スニペットを挿入する
;;(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
;;(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
;;(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

;;自分用のスニペットフォルダと，拾ってきたスニペットフォルダの2つを作っておきます．
;;(一つにまとめてもいいけど)
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mySnippets" 
        "~/.emacs.d/snippets"
        ))

;; yas起動
(yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Undo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

(when (require 'undohist nil t)
  (undohist-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; moccur
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'color-moccur)
;; (setq moccur-split-word t) ; スペースでくぎられた複数の単語にマッチさせる

;; (require 'moccur-edit)
;; その他color-moccur.elの設定
;; (setq moccur-split-word t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; grep
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'igrep)
;; igrepに-Ou8オプションをつけると出力がUTF-8になる
;; (igrep-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -Ou8"))
;; (igrep-find-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -Ou8"))

;; (require 'grep-a-lot)
;; (grep-a-lot-setup-keys)
;; igrepを扱う人向け
;; (grep-a-lot-advise igrep)

;; (require 'grep-edit)

;; (require 'col-highlight)
;; 1,2の内どれかを選ぶ
;; 1:常にハイライトする
;; (column-highlight-mode 1)
;; 2:何もしないとハイライトを始める
;; (toggle-highlight-column-when-idle 1)
;; (col-highlight-set-interval 6)		;ハイライトの秒数を変更する

;;(require 'multi-shell)
;; 指定しないと環境変数SHELLのシェルが使われる
;;(setq multi-shell-command "/bin/zsh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs lisp関連
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)

;; (require 'eldoc-extension)
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
;; (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
;; (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
;; (setq eldoc-idel-delay 0.2)
;; (setq eldoc-minor-mode-string "")

(find-function-setup-keys)

(require 'edit-list)

;; (require 'el-expecations)

;; (require 'open-junk-file)
;; ファイル名入力時に ~/junk/年-月-日-時分秒. が出てくる
;; (setq open-junk-file-format "~/junk/%Y-%m-%H%M%S.")

;; (require 'summarye)

(require 'hideif)
(add-hook 'c-mode-common-hook 'hide-ifdef-mode)

;;(witch-func-mode 1)
;;; すべてのメジャーモードに対してwitch-func-modeを適用する
;;(setq which-func-modes t)
;;; 画面上部に表示する場合は下の2行が必要
;;(delete (assoc 'witch-func-mode mode-line-format) mode-line-format)
;;(setq-default header-line-format '(which-func-modes ("" whic-func-format)))

(add-hook 'c-mode-common-hook (lambda () (flymake-mode t)))

;; (require 'ipa)



;; (require 'w3m-load)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-async-byte-compile.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'auto-async-byte-compile)
;; 自動バイトコンパイルを有効にするファイル名の正規表現
;; (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;(require 'sticky)
;;(use-sticky-key ";" sticky-alist:en) 	;JISキーボードでは sticky-alist:ja

(put 'upcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-install.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (install--elisp-from-emacswiki 'auto-install.el')
;;(require 'auto-install)
;; 起動時にEmacswikiのページ名を保管候補に加える
;;(setq auto-install-use-wget t)
;;(auto-install-update-emacswiki-package-name t)
;; install-elisp.el互換モードにする
;;(auto-install-compatibility-setup)
;; ediff関連のバッファを1つのフレームにまとめる
;;(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;(require 'helm-config)
;;(helm-mode 1)

