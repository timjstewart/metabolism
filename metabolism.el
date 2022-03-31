;;; metabolism -- Helm Tab Management
;;; Author: Tim Stewart <tim.j.stewart at gmail dot com>

(defun metabolism--tabs ()
  "Returns a list of unique tabs.  Uniqueness of tab names is not enforced by tab-bar"
  (cl-remove-if (lambda (tab-name)
                  (equal tab-name "*helm*"))
                (delete-dups (mapcar (lambda (tab)
                                       (cdr (assq 'name tab)))
                                     (tab-bar-tabs)))))

(defun metabolism--switch-to-tab (tab-name)
  (tab-bar-select-tab-by-name tab-name))

(defun metabolism--rename-tab (tab-name)
  (let ((new-name (read-string "Enter new name: " tab-name)))
    (when new-name
      (tab-bar-rename-tab-by-name tab-name new-name))))

(defun metabolism--close-tab (tab-name)
  (tab-bar-close-tab-by-name tab-name))

(defun metabolism--create-tab (tab-name)
  (tab-bar-new-tab-to (+ 1(length (metabolism--tabs))))
  (tab-bar-rename-tab tab-name))

(defun metabolism--transformer (candidates _source)
  "Returns a list of candidates based on which candidates match the currently
entered text."
  (or candidates
      (list helm-pattern)))

(defun metabolism-helm-tabs ()
  "Command that lets the user switch an existing tab or create a new tab."
  (interactive)
  (let* ((switch-to '((name . "Switch to Tab:")
                      (candidates . metabolism--tabs)
                      (action . (("Switch to Tab" . metabolism--switch-to-tab)
                                 ("Rename Tab" . metabolism--rename-tab)
                                 ("Close Tab" . metabolism--close-tab)))))
         (create    '((name . "Create Tab:")
                      (candidates . ())
                      (filtered-candidate-transformer . metabolism--transformer)
                      (action . (("Create Tab" . metabolism--create-tab))))))
    (helm :prompt "Tab: "
          :sources '(switch-to create))))

(provide 'metabolism)
