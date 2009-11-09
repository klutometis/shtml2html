(require-extension
 htmlprag
 (srfi 37))

(define doctypes
  `((xhtml-1.1
     . "<?xml version= \"1.0\" encoding= \"UTF-8\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">")))

(define default-doctype 'xhtml-1.1)

(let ((doctype #f)
      (do-eval #f))
  (let ((xhtml-1.1-option
         (option '("xhtml-1.1")
                 #f
                 #f
                 (lambda (option name arg seeds)
                   (set! doctype 'xhtml-1.1)
                   seeds)))
        (do-eval-option
         (option '(#\e "eval")
                 #f
                 #f
                 (lambda (option name arg seeds)
                   (set! do-eval #t)
                   seeds))))
    (let ((args
           (args-fold
            (command-line-arguments)
            (list xhtml-1.1-option
                  do-eval-option)
            (lambda (option name arg seeds)
              (error "unrecognized option" name))
            cons
            '())))
      (let ((doctype (cdr (if doctype
                              (assq doctype doctypes)
                              (assq default-doctype doctypes)))))
        (display doctype)
        (if do-eval
            ;; do-eval is expensive; might as well have, say, an fcgi
            ;; server at this point. also, we don't have any support
            ;; for error streams. on the other hand, it doesn't follow
            ;; that i have to loop the read; what behooves it
            ;; otherwise, though? main problem: need an absolute path
            ;; to LOAD from; and syntax-case modules are too
            ;; expensive.
            ;;
            ;; fuck it: just do a generic templating framework; keep
            ;; this shit basic.
            (let loop ((doc (read)))
              (if (not (eof-object? doc))
                  (let ((value (eval doc)))
                    (if (pair? value)
                        (write-shtml-as-html value))
                    (loop (read)))))
            (write-shtml-as-html (read)))))))
