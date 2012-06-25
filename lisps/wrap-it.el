(defun wrap-it (beg end left right)
  "wrap beg to end use left and right"
  (save-excursion (goto-char end)
                   (insert right)
                   (goto-char beg)
                   (insert left)))

(defmacro split-tags (symbols)
  `(let ((left (substring ,symbols 0 1)) (right (substring ,symbols 1 2)))
     (cons left right)))

(defmacro make-html-tags (tag)
  `(cons (formart "<%s>" ,tag) (formart "<%s/>" ,tag)))

(defmacro make-latex-tags (tag)
  `(cons (formart "\\begin{%s}" ,tag) (formart "\\end{%s}" ,tag)))

(defmacro wrap-cons (bounds symbols)
  `(wrap-it (car ,bounds) (cdr ,bounds) (car ,symbols) (cdr ,symbols)))

(defmacro warp-them (get-bounds get-tags)
  `(let ((bounds ,get-bounds)
         (tags ,get-tags))
     (let ((beg (car bounds))
           (end (cdr bounds))
           (lef (car tags))
           (rig (cdr tags)))
       (wrap-it beg end lef rig))))

(defun wrap-thing (thing symbols)
  "wrap the thing at point"
  (interactive "Sthing:\nssymbols:\n")
  (warp-them (bounds-of-thing-at-point thing) (split-tags symbols)))

(defun wrap-region (symbols)
  "wrap the region"
  (interactive "symbols:\n")
  (wrap-it ((region-beginning) . (region-end)) (split-tags symbols)))

(defun wrap-word (symbols)
  "wrap the word at point"
  (interactive "ssymbols:\n")
  (wrap-thing 'word symbols))

(defun wrap-word-quote ()
  "wrap the word at point"
  (interactive)
  (wrap-word "\"\""))

(defun wrap-line (symbols)
  "wrap the line at point"
  (interactive "ssymbols:\n")
  (wrap-thing 'line symbols))

(defun wrap-line-quote ()
  "wrap the line at point"
  (interactive)
  (wrap-line "\"\""))

(defun wrap-url (symbols)
  "wrap the url at point"
  (interactive "ssymbols:\n")
  (wrap-thing 'url symbols))

(defun wrap-url-quote ()
  "wrap the url at point"
  (interactive)
  (wrap-url "\"" "\""))



(provide 'wrap-it)
