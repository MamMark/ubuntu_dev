#!/usr/bin/emacs --script

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(defconst my-packages
  '(magit magithub magit-gh-pulls ghub))

(package-refresh-contents)
(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))
