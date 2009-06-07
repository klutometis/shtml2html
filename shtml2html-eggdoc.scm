(require-extension eggdoc)
(let ((doc
       '((eggdoc:begin
          (name "shtml2html")
          (description "Reads shtml from stdin, stdouts {x}html")
          (author "Peter Danenberg")
          (history
           (version "0.1" "Initial release"))
          (requires "htmlprag" "srfi-37")
          (usage)
          (download "shtml2html.egg")
          (documentation (p "shtml2html is meant to be used with Apache's" (url "http://httpd.apache.org/docs/2.0/mod/mod_ext_filter.html" (tt "mod_ext_filter") ".")))
          (examples (p (tt "echo '(html (head) (body (p \"harro\")))'|shtml2html --xhtml-1.1")))
          (license "GPL")))))
  (eggdoc->html doc))
