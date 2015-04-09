;;; google-this-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (google-this-mode google-this-forecast google-this-cpp-reference
;;;;;;  google-this-clean-error-string google-this-error google-this-noconfirm
;;;;;;  google-this google-this-region google-this-symbol google-this-word
;;;;;;  google-this-line google-this-string google-this-lucky-search
;;;;;;  google-this-lucky-and-insert-url google-this-search) "google-this"
;;;;;;  "google-this.el" (21759 44598 705883 503000))
;;; Generated autoloads from google-this.el

(autoload 'google-this-search "google-this" "\
Write and do a google search.
Interactively PREFIX determines quoting.
Non-interactively SEARCH-STRING is the string to search.

\(fn PREFIX &optional SEARCH-STRING)" t nil)

(autoload 'google-this-lucky-and-insert-url "google-this" "\
Fetch the url that would be visited by `google-this-lucky'.

If you just want to do an \"I'm feeling lucky search\", use
`google-this-lucky-search' instead.

Interactively:
* Insert the URL at point,
* Kill the searched term, removing it from the buffer (it is killed, not
  deleted, so it can be easily yanked back if desired).
* Search term defaults to region or line, and always queries for
  confirmation.

Non-Interactively:
* Runs synchronously,
* Search TERM is an argument without confirmation,
* Only insert if INSERT is non-nil, otherwise return.

\(fn TERM &optional INSERT)" t nil)

(autoload 'google-this-lucky-search "google-this" "\
Exactly like `google-this-search', but use the \"I'm feeling lucky\" option.
PREFIX determines quoting.

\(fn PREFIX)" t nil)

(autoload 'google-this-string "google-this" "\
Google given TEXT, but ask the user first if NOCONFIRM is nil.
PREFIX determines quoting.

\(fn PREFIX &optional TEXT NOCONFIRM)" nil nil)

(autoload 'google-this-line "google-this" "\
Google the current line.
PREFIX determines quoting.
NOCONFIRM goes without asking for confirmation.

\(fn PREFIX &optional NOCONFIRM)" t nil)

(autoload 'google-this-word "google-this" "\
Google the current word.
PREFIX determines quoting.

\(fn PREFIX)" t nil)

(autoload 'google-this-symbol "google-this" "\
Google the current symbol.
PREFIX determines quoting.

\(fn PREFIX)" t nil)

(autoload 'google-this-region "google-this" "\
Google the current region.
PREFIX determines quoting.
NOCONFIRM goes without asking for confirmation.

\(fn PREFIX &optional NOCONFIRM)" t nil)

(autoload 'google-this "google-this" "\
Decide what the user wants to google (always something under point).
Unlike `google-this-search' (which presents an empty prompt with
\"this\" as the default value), this function inserts the query
in the minibuffer to be edited.
PREFIX argument determines quoting.
NOCONFIRM goes without asking for confirmation.

\(fn PREFIX &optional NOCONFIRM)" t nil)

(autoload 'google-this-noconfirm "google-this" "\
Decide what the user wants to google and go without confirmation.
Exactly like `google-this' or `google-this-search', but don't ask
for confirmation.
PREFIX determines quoting.

\(fn PREFIX)" t nil)

(autoload 'google-this-error "google-this" "\
Google the current error in the compilation buffer.
PREFIX determines quoting.

\(fn PREFIX)" t nil)

(autoload 'google-this-clean-error-string "google-this" "\
Parse error string S and turn it into googleable strings.

Removes unhelpful details like file names and line numbers from
simple error strings (such as c-like erros).

Uses replacements in `google-this-error-regexp' and stops at the first match.

\(fn S)" t nil)

(autoload 'google-this-cpp-reference "google-this" "\
Visit the most probable cppreference.com page for this word.

\(fn)" t nil)

(autoload 'google-this-forecast "google-this" "\
Search google for \"weather\".
With PREFIX, ask for location.

\(fn PREFIX)" t nil)

(defvar google-this-mode nil "\
Non-nil if Google-This mode is enabled.
See the command `google-this-mode' for a description of this minor mode.")

(custom-autoload 'google-this-mode "google-this" nil)

(autoload 'google-this-mode "google-this" "\
Toggle Google-This mode on or off.
With a prefix argument ARG, enable Google-This mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is `toggle'.
\\{google-this-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("google-this-pkg.el") (21759 44598 742866
;;;;;;  539000))

;;;***

(provide 'google-this-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; google-this-autoloads.el ends here
