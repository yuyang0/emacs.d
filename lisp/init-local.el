(when (file-exists-p *personal-load-file*)
 (load *personal-load-file*))

(provide 'init-local)