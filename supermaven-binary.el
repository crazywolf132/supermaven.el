;;; supermaven-binary.el --- Supermaven binary management -*- lexical-binding: t; -*-

;;; Commentary:

;; This file contains functions for managing the Supermaven binary.

;;; Code:

(require 'url)
(require 'json)
(require 'supermaven-logger)

(defcustom supermaven-binary-path nil
  "Path to the Supermaven binary."
  :type 'string
  :group 'supermaven)

(defcustom supermaven-agent-version nil
  "The version of the Supermaven binary to download and use (nil means the latest version)."
  :type 'integer
  :group 'supermaven)

(defun supermaven--fetch-binary ()
  "Fetch the Supermaven binary."
  (let* ((platform (pcase system-type
                     ('darwin "macosx")
                     ('gnu/linux "linux")
                     ('windows-nt "windows")
                     (_ (error "Unsupported platform: %s" system-type))))
         (arch (cond
                ((string-match-p "^arm64-" system-configuration) "aarch64")
                ((string-match-p "^x86_64-" system-configuration) "x86_64")
                (t (error "Unsupported architecture: %s" system-configuration))))
         (url (format "https://supermaven.com/api/download-path?platform=%s&arch=%s&editor=neovim" platform arch))
         (_ (supermaven-log-debug (format "Fetching binary URL: %s" url)))
         (response (with-current-buffer
                       (url-retrieve-synchronously url)
                     (goto-char (point-min))
                     (re-search-forward "\n\n")
                     (let ((json-object-type 'hash-table))
                       (json-read))))
         (download-version (or supermaven-agent-version (gethash "version" response)))
         (download-url (gethash "downloadUrl" response))
         (download-url-with-version (replace-regexp-in-string "/[0-9][0-9]/" (format "/%d/" download-version) download-url))
         (_ (supermaven-log-debug (format "Download URL: %s" download-url-with-version)))
         (binary-dir (expand-file-name (format ".supermaven/sm-agent/%d/bin" download-version) (getenv "HOME")))
         (binary-path (expand-file-name (format "sm-agent%s" (if (eq system-type 'windows-nt) ".exe" "")) binary-dir)))

    (unless (file-exists-p binary-dir)
      (make-directory binary-dir t))

    (supermaven-log-info (format "Downloading Supermaven binary to %s" binary-path))
    (url-copy-file download-url-with-version binary-path t)

    (set-file-modes binary-path #o755)

    (setq supermaven-binary-path binary-path)
    binary-path))

(defun supermaven--ensure-binary ()
  "Ensure the Supermaven binary is available."
  (unless (and supermaven-binary-path (file-exists-p supermaven-binary-path))
    (condition-case err
        (setq supermaven-binary-path (supermaven--fetch-binary))
      (error
       (supermaven-log-error (format "Failed to fetch Supermaven binary: %s" (error-message-string err)))
       (signal (car err) (cdr err))))))

(provide 'supermaven-binary)

;;; supermaven-binary.el ends here
