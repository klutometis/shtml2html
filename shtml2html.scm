(require-extension
 htmlprag
 (srfi 37))

(define doctypes
  `((xhtml-1.1
     . "<?xml version= \"1.0\" encoding= \"UTF-8\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">")))

(define default-doctype 'xhtml-1.1)

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
      (let ((doctype (cdr (if doctype
                              (assq doctype doctypes)
                              (assq default-doctype doctypes)))))
        (display doctype)
        (write-shtml-as-html (read))))))
