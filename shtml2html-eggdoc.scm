(require-extension eggdoc)
(let ((doc
       '((eggdoc:begin
          (name "shtml2html")
          (description "shtml2html serves SHTML as HTML over Apache.")
          (author "Peter Danenberg")
          (history
           (version "0.1" "Initial release"))
          (requires "htmlprag" "srfi-37")
          (usage)
          (download "shtml2html.egg")
          (documentation (p "shtml2html is meant to be used in conjunction with Apache's "
                            (url "http://httpd.apache.org/docs/2.0/mod/mod_ext_filter.html"
                                 (tt "mod_ext_filter"))
                            " for serving SHTML as HTML over Apache.")
                         (p "See " (url "#installation" "Installation") " for details."))
          (examples (p "For a sanity check over the command line:"
                       (blockquote (pre "echo '(html (head) (body (p \"harro\")))' | shtml2html --xhtml-1.1"))))
          (section "Installation"
                   (div (@ (id "installation"))
                        (p "Adding the following to "
                           (tt "httpd.conf,")
                           " for instance:")
                        (blockquote (pre
"ExtFilterDefine shtml-to-html intype=text/shtml outtype=text/html \\
    cmd=\"/usr/local/bin/shtml2html\"
<Directory \"/path/to/shtml\">
    AddType text/shtml .shtml
    SetOutputFilter shtml-to-html
</Directory>"))
                        (p "will transform all"
                           (tt ".shtml")
                           " files in "
                           (tt "/path/to/shtml")
                           " to HTML upon viewing.")))
          (license "GPL")))))
  (eggdoc->html doc))
