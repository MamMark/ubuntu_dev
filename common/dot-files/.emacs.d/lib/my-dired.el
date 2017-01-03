;;
;; set-name is a front end to prevent dired-set-name from asking
;; for the new name for non-dired buffers.
;;
(defun set-name ()
  "(my-dired)dired-mode sets the mode-line-format variable to contain
the full directory path.  This command can be used to reset the buffer
name to NAME."
  (interactive)
  (if (equal major-mode 'dired-mode)
      (call-interactively 'dired-set-name)
    (dired-set-name nil)))

(defun dired-set-name (name)
  (interactive "snew Dired buffer identification: ")
  (if (equal major-mode 'dired-mode)
      (setq mode-line-buffer-identification
	    (list (concat "Dired: " name "    ")))
    (message "dired-set-name: not a dired buffer")
    (ding)))

(defun dired-short-name ()
  "shorten a dired buffer's name to just the last component"
  (interactive)
  (if (equal major-mode 'dired-mode)
      (let ((dirname (if (consp dired-directory)
			 (car dired-directory)
		       dired-directory)))
	(if (string-match "/$" dirname)
	    (setq dirname (substring dirname 0 -1)))
	(setq dirname (file-name-nondirectory dirname))
	(setq mode-line-buffer-identification
	      (list (concat "Dired: " dirname "    ")))
	(switch-to-buffer (current-buffer)))
    (message "dired-short-name: not a dired buffer")
    (ding)))

(defun dired-long-name ()
  "set a dired buffer's ident to the full path name"
  (interactive)
  (if (equal major-mode 'dired-mode)
      (let ((dirname (if (consp dired-directory)
			 (car dired-directory)
		       dired-directory)))
	(if (string-match "/$" dirname)
	    (setq dirname (substring dirname 0 -1)))
	(setq mode-line-buffer-identification
	      (list (concat "Dired: " dirname "    ")))
	(switch-to-buffer (current-buffer)))
    (message "dired-short-name: not a dired buffer")
    (ding)))

