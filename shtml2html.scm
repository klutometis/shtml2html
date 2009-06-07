(require-extension
 htmlprag
 (srfi 37))

(define doctype-roots
  `((xhtml-1.1
     "<?xml version= \"1.0\" encoding= \"UTF-8\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">"
     (html (@ (xmlns "http://www.w3.org/1999/xhtml")
              (xml:lang "en"))))))

(define default-doctype 'xhtml-1.1)
(define default-document '(html))

(let ((doctype #f))
  (let ((xhtml-1.1-option
         (option '("xhtml-1.1")
                 #f
                 #f
                 (lambda (option name arg seeds)
                   (set! doctype 'xhtml-1.1)
                   seeds))))
    (let ((args
           (args-fold
            (command-line-arguments)
            (list xhtml-1.1-option)
            (lambda (option name arg seeds)
              (error "unrecognized option" name))
            cons
            '())))
      (let ((doctype-root (cdr (if doctype
                                   (assq doctype doctype-roots)
                                   (assq default-doctype doctype-roots)))))
        (display (car doctype-root))
        (let ((root (cadr doctype-root))
              (document (read)))
          (let ((rest-document (cdr (if (eof-object? document)
                                        default-document
                                        document))))
            (write-shtml-as-html (append (cadr doctype-root)
                                         (cdr (if (eof-object? document)
                                                  default-document
                                                  document))))))))))
