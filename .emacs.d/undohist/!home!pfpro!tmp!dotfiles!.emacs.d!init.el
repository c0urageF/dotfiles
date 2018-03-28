
((digest . "843403fc6fbda1362b7a986b12a6f654") (undo-list nil (9252 . 10202) (t 23227 19348 295713 83000) nil (9204 . 9207) nil ("-" . -9204) ((marker . 9788) . -1) ("b" . -9205) ((marker . 9788) . -1) ("u" . -9206) ((marker . 9788) . -1) ("f" . -9207) ((marker . 9788) . -1) 9208 nil ("f" . -9208) ((marker . 9788) . -1) ("e" . -9209) ((marker . 9788) . -1) ("r" . -9210) ((marker . 9788) . -1) ("-" . -9211) ((marker . 9788) . -1) ("t" . -9212) ((marker . 9788) . -1) ("o" . -9213) ((marker . 9788) . -1) ("-" . -9214) ((marker . 9788) . -1) ("n" . -9215) ((marker . 9788) . -1) ("i" . -9216) ((marker . 9788) . -1) ("c" . -9217) ((marker . 9788) . -1) ("k" . -9218) ((marker . 9788) . -1) ("n" . -9219) ((marker . 9788) . -1) ("a" . -9220) ((marker . 9788) . -1) ("m" . -9221) ((marker . 9788) . -1) ("e" . -9222) ((marker . 9788) . -1) ("-" . -9223) ((marker . 9788) . -1) ("a" . -9224) ((marker . 9788) . -1) ("l" . -9225) ((marker . 9788) . -1) ("i" . -9226) ((marker . 9788) . -1) ("s" . -9227) ((marker . 9788) . -1) ("t" . -9228) ((marker . 9788) . -1) 9229 nil (9196 . 9229) ("elscre" . -9196) ((marker . 9788) . -6) ((marker . 9196) . -1) 9202 nil (9197 . 9202) nil ("m" . -9197) ((marker . 9788) . -1) ((marker . 9196) . -1) ("a" . -9198) ((marker . 9788) . -1) ((marker . 9196) . -1) ("c" . -9199) ((marker . 9788) . -1) ((marker . 9196) . -1) ("s" . -9200) ((marker . 9788) . -1) ((marker . 9196) . -1) (" " . -9201) ((marker . 9788) . -1) ((marker . 9196) . -1) ("l" . -9202) ((marker . 9788) . -1) ((marker . 9196) . -1) ("i" . -9203) ((marker . 9788) . -1) ((marker . 9196) . -1) ("s" . -9204) ((marker . 9788) . -1) ((marker . 9196) . -1) ("p" . -9205) ((marker . 9788) . -1) ((marker . 9196) . -1) ("関" . -9206) ((marker . 9788) . -1) ((marker . 9196) . -1) ("連" . -9207) ((marker . 9788) . -1) ((marker . 9196) . -1) 9208 nil (nil rear-nonsticky nil 9252 . 9253) (9149 . 9253) (t 23227 19328 480121 620000) nil (9149 . 9150) (t 23227 19291 552707 188000) nil (3048 . 3287) ("(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )" . -3048) (3024 . 3047) (2373 . 2374) (" " . -2373) ("
" . -3024) (2373 . 2374) (3023 . 3024) (2372 . 2373) (" " . 2372) (2362 . 3023) (" " . 2362) (2241 . 2363) (2099 . 2100) (" " . -2099) ("
" . -2241) (2099 . 2100) (2240 . 2241) (2098 . 2099) (" " . 2098) (2088 . 2240) (" " . 2088) (1951 . 2089) (1932 . 1935) ("	  " . -1932) (1912 . 1915) ("	  " . -1912) (1899 . 1901) ("	 " . -1899) (1884 . 1888) ("	" . -1884) (1871 . 1874) ("		 " . -1871) (1834 . 1837) ("		 " . -1834) (1821 . 1826) ("		" . -1821) (1807 . 1810) ("	  " . -1807) (1800 . 1802) ("  " . -1800) (1789 . 1791) ("  " . -1789) ("
" . -1945) (1926 . 1929) (1906 . 1909) (1893 . 1895) (1881 . 1882) (1868 . 1871) (1831 . 1834) (1821 . 1823) (1807 . 1810) (1800 . 1802) (1789 . 1791) (1921 . 1922) (1904 . 1905) (" " . -1904) (1887 . 1888) (" " . 1887) (1876 . 1877) (" " . 1876) (1865 . 1866) ("
" . 1865) (1865 . 1866) (" " . -1865) (1855 . 1856) (" " . -1855) (1821 . 1822) (" " . 1821) (1813 . 1814) (" " . 1813) (1802 . 1803) (" " . 1802) (1797 . 1798) ("
" . 1797) (1797 . 1798) (" " . -1797) (1788 . 1789) (" " . 1788) (1777 . 1921) (" " . 1777) (1459 . 1778) ("(custom-set-variables
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
		 messages \"
\")))))
 '(helm-delete-minibuffer-contents-from-point t)
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-mini-default-sources
   (quote
	(helm-source-buffers-list helm-source-ls-git-status helm-source-files-in-current-dir helm-source-ls-git helm-source-recentf helm-source-ghq)))
 '(helm-truncate-lines t t)
 '(initial-frame-alist (quote ((width . 110) (height . 140))))
 '(package-selected-packages
   (quote
	(yasnippet yaml-mode wgrep web-mode undohist undo-tree srefactor redo+ racer python-mode python py-autopep8 open-junk-file neotree multi-term moccur-edit json-mode js2-mode js-auto-format-mode jedi irony-eldoc igrep helm-swoop helm-ls-git helm-gtags helm-git-grep helm-ghq helm-ghc helm-company grep-a-lot grep+ flymake-python-pyflakes flycheck-rust flycheck-pyflakes flycheck-pycheckers flycheck-irony flycheck-haskell flycheck-cask company-web company-tern company-shell company-rtags company-jedi company-irony-c-headers company-irony company-ghc company-cmake company-cabal anzu add-node-modules-path ace-jump-mode ace-isearch abc-mode)))
 '(rtags-use-helm t))" . -1459) (t 23227 19291 404695 271000) (3039 . 3278) ("(custom-set-faces)" . -3039) (3015 . 3038) (2373 . 2374) (" " . -2373) ("
" . -3015) (2373 . 2374) (3014 . 3015) (2372 . 2373) (" " . 2372) (2362 . 3014) (" " . 2362) (2241 . 2363) (2099 . 2100) (" " . -2099) ("
" . -2241) (2099 . 2100) (2240 . 2241) (2098 . 2099) (" " . 2098) (2088 . 2240) (" " . 2088) (1951 . 2089) (1932 . 1935) ("	  " . -1932) (1912 . 1915) ("	  " . -1912) (1899 . 1901) ("	 " . -1899) (1884 . 1888) ("	" . -1884) (1871 . 1874) ("		 " . -1871) (1834 . 1837) ("		 " . -1834) (1821 . 1826) ("		" . -1821) (1807 . 1810) ("	  " . -1807) (1800 . 1802) ("  " . -1800) (1789 . 1791) ("  " . -1789) ("
" . -1945) (1926 . 1929) (1906 . 1909) (1893 . 1895) (1881 . 1882) (1868 . 1871) (1831 . 1834) (1821 . 1823) (1807 . 1810) (1800 . 1802) (1789 . 1791) (1921 . 1922) (1904 . 1905) (" " . -1904) (1887 . 1888) (" " . 1887) (1876 . 1877) (" " . 1876) (1865 . 1866) ("
" . 1865) (1865 . 1866) (" " . -1865) (1855 . 1856) (" " . -1855) (1821 . 1822) (" " . 1821) (1813 . 1814) (" " . 1813) (1802 . 1803) (" " . 1802) (1797 . 1798) ("
" . 1797) (1797 . 1798) (" " . -1797) (1788 . 1789) (" " . 1788) (1777 . 1921) (" " . 1777) (1459 . 1778) ("(custom-set-variables '(rtags-use-helm t))" . -18414) ("(custom-set-variables
 ;'(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t))" . -10952) ("(custom-set-variables
 '(initial-frame-alist (quote ((width . 110) (height . 140)))))" . -1459) (t 23227 18716 476764 910000) nil (8852 . 8857) nil ("g" . -8852) ("t" . -8853) ("a" . -8854) ("g" . -8855) ("s" . -8856) 8857 nil ("
" . -8904) 8905 nil (nil rear-nonsticky nil 8904 . 8905) (8805 . 8905) nil (8804 . 8805) nil (8805 . 9211) (t 23227 18680 50385 34000) nil undo-tree-canary))
