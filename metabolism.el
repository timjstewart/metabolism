(defun metabolism--tabs ()
  (mapcar (lambda (tab)
            (cdr (assq 'name tab)))
          (tab-bar-tabs)))

(defun metabolism--switch-to-tab (tab-name)
  (message "SWITCH: %s" tab-name)
  (tab-bar-select-tab-by-name tab-name))

(defun metabolism--rename-tab (tab-name)
  (let ((new-name (read-string "Enter new name: " tab-name)))
    (when new-name
    (tab-bar-rename-tab-by-name tab-name new-name))))

(defun metabolism--close-tab (tab-name)
  (tab-bar-close-tab-by-name tab-name))

(defun metabolism--create-tab (tab-name)
  (message "create tab: %s" tab-name))

(defun metabolism-helm-tabs ()
  "Command that lets the user switch an existing tab or create a new tab."
  (interactive)
  (let* ((switch-to '((name . "Switch to Tab:")
                      (candidates . metabolism--tabs)
                      (action . (("Switch to Tab" . metabolism--switch-to-tab)
                                ("Rename Tab" . metabolism--rename-tab)
                                ("Close Tab" . metabolism--close-tab))))))
    (helm :prompt "Tab: "
          :sources '(switch-to))))


(spacemacs/set-leader-keys "o t" 'metabolism-helm-tabs)

(provide 'metabolism)
