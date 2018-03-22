;; proxy
(setq url-proxy-services
      '(("http" . "http://localhost:3128")
        ("https" . "https://localhost:3128")))
(setq url-http-proxy-basic-auth-storage
      '(("http://localhost:3128" ("Proxy" . "base64string"))))
