(use alist-lib
     args
     htmlprag
     srfi-37
     usage)

;; (define doctype "<!DOCTYPE html>")

;; (display doctype)
;; (write-shtml-as-html (read))

(define doctypes
  `((xhtml-1.1
     . "<?xml version= \"1.0\" encoding= \"UTF-8\"?><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">")
    (html5 . "<!DOCTYPE html>")))

(define default-doctype (make-parameter 'html5))

(define options
  (make-parameter
   (list (args:make-option (h ? help) #:none "Help" (set! arg #t))
         (args:make-option (x xhtml) #:none "Output XHTML" (set! arg #t))
         (args:make-option (h html) #:none "Output HTML" (set! arg #t)))))

(define usage
  (make-usage
   (lambda (program)
     (format #t "Usage: ~a [OPTION]~%" program)
     (print (args:usage (options))))))

(receive (options arguments)
  (args:parse (command-line-arguments) (options))
  (let ((help? (option options 'help))
        (xhtml? (option options 'xhtml))
        (html? (option options 'html)))
    (cond (help? (usage))
          (xhtml? (display (alist-ref doctypes 'xhtml-1.1)))
          (else (display (alist-ref doctypes (default-doctype)))))
    (write-shtml-as-html (read))))
