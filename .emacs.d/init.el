
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/info")
;; auto-installによってインストールされるEmacs Lispをロードパスに加える
;; デフォルトは ~/.emacs.d/auto-install/
(add-to-list 'load-path "~/.emacs.d/auto-install")
(add-to-list 'load-path "~/.emacs.d/private-conf")
(add-to-list 'load-path "~/.emacs.d/helm")

(require 'package)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C++関連
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
 '(auto-save-default nil)
 '(column-number-mode t)
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
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist
   (quote
	((top . 20)
	 (left . 950)
	 (width . 110)
	 (height . 140))))
 '(irony-additional-clang-options (quote ("-std=c++11")))
 '(make-backup-files nil)
 '(package-selected-packages
   (quote
	(igrep helm yasnippet undohist undo-tree rtags irony-eldoc flycheck-irony company-irony-c-headers company-irony)))
 '(py-indent-offset 4)
 '(rtags-use-helm t)
 '(ruby-insert-encoding-magic-comment nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python関連
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))


(add-hook 'python-mode-hook
  '(lambda()
    (setq tab-width 4) 
    (setq indent-tabs-mode nil)))

(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
            (define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)
			(define-key python-mode-map "\C-m" 'newline-and-indent)))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

(jedi:setup)
(define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
(setq jedi:complete-on-dot t)
(setq ac-sources
	  (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
(add-to-list 'ac-sources 'ac-source-filename)
(add-to-list 'ac-sources 'ac-source-jedi-direct)
(add-hook 'python-mode-hook
          (lambda ()
			(define-key python-mode-map "\C-ct" 'jedi:goto-definition)
			(define-key python-mode-map "\C-cb" 'jedi:goto-definition-pop-marker)
			(define-key python-mode-map "\C-cr" 'helm-jedi-related-names)))

(require 'py-autopep8)
(setq py-autopep8-options '("--max-line-length=200"))
(setq flycheck-flake8-maximum-line-length 200)
(py-autopep8-enable-on-save)

(flymake-mode t)
;;errorやwarningを表示する
(require 'flymake-python-pyflakes)
(flymake-python-pyflakes-load)


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

;; バックアップファイルを作らない
(setq make-backup-files nil)
;; オートセーブファイルを作らない
(setq auto-save-default nil)

(set-face-background 'region "custom-rogue ")

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be care
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(initial-frame-alist (quote ((width . 110) (height . 140)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; bat-mode
(setq auto-mode-alist 
       (append 
        (list (cons "\\.[bB][aA][tT]$" 'bat-mode))
        ;; For DOS init files
        (list (cons "CONFIG\\."   'bat-mode))
        (list (cons "AUTOEXEC\\." 'bat-mode))
        auto-mode-alist))

(autoload 'bat-mode "bat-mode"
      "DOS and Windows BAT files" t)

;; スクロール量を変更
(setq scroll-conservatively 35
scroll-margin 0
scroll-step 20) 

;; edit background color
(if window-system (progn

  (set-background-color "Black")
  (set-foreground-color "LightGray")
  (set-cursor-color "Gray")
  (set-frame-parameter nil 'alpha 90)
  ;; (set-frame-parameter nil 'alpha 80)
  ))

;; default to unified diffs
(setq diff-switches "-u")

;;Font設定
(add-to-list 'default-frame-alist '(font . "ricty-10.5"))

;; 文字サイズを変更
(set-face-attribute 'default nil :height 110)

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
(transient-mark-mode t)
(set-face-background 'region "DeepSkyBlue")

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

;; autoinsert
;; http://ymotongpoo.hatenablog.com/entry/2012/12/02/190248
(require 'autoinsert)
(setq user-id-string "id")
(setq user-full-name "full name")
(setq user-mail-address "mail address")

;; テンプレートのディレクトリ
(setq auto-insert-directory "~/.emacs.d/insert/")

;; 各ファイルによってテンプレートを切り替える
(setq auto-insert-alist
	  (nconc '(
			   ("\\.sh$" . ["template.sh" my-template])
			   ("\\.py$"   . ["template.py" my-template])
			   ("\\.pl$"   . ["template.pl" my-template])
			   ("\\.rb$" . ["template.rb" my-template])
			   ("\\.cpp$" . ["template.cpp" my-template])
			   ("\\.h$"   . ["template.h" my-template])
			   ) auto-insert-alist))

(require 'cl)
(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
	("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
	("%date%" . (lambda () (format-time-string "%Y-%m-%d %H:%M:%S")))
	("%mail%" . (lambda () (identity user-mail-address)))
	("%name%" . (lambda () (identity user-full-name)))
	("%id%" . (lambda () (identity user-id-string)))
))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
			(progn
			  (goto-char (point-min))
			  (replace-string (car c) (funcall (cdr c)) nil)))
		template-replacements-alists)
  (goto-char (point-max))
  (message "done."))
(add-hook 'find-file-not-found-hooks 'auto-insert)

;; リージョンを上書き入力
(delete-selection-mode t)

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

(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)	;過去のredoがundoされないようにする
;; 大量のundoに耐えられるようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

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
(require 'color-moccur)
(setq moccur-split-word t) ; スペースでくぎられた複数の単語にマッチさせる

(require 'moccur-edit)
;; その他color-moccur.elの設定
(setq moccur-split-word t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; grep
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'igrep)
;; igrepに-Ou8オプションをつけると出力がUTF-8になる
(igrep-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -Ou8"))
(igrep-find-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -Ou8"))

(require 'grep-a-lot)
(grep-a-lot-setup-keys)
;; igrepを扱う人向け
(grep-a-lot-advise igrep)

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

(find-function-setup-keys)

(require 'edit-list)

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
;; helm.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm)
(require 'helm-config)
(helm-mode 1)

;; C-hで前の文字削除
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; キーバインド
;;(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "C-x b") 'helm-for-files)
(define-key global-map (kbd "C-x C-b") 'helm-buffers-list)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; Emulate `kill-line' in helm minibuffer
(setq helm-delete-minibuffer-contents-from-point t)
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))


(global-set-key [f8] 'neotree-toggle)

;; 隠しファイルをデフォルトで表示
(setq neo-show-hidden-files t)

;; neotree でファイルを新規作成した後、自動的にファイルを開く
(setq neo-create-file-auto-open t)

;; delete-other-window で neotree ウィンドウを消さない
(setq neo-persist-show t)

;; キーバインドをシンプルにする
(setq neo-keymap-style 'concise)
