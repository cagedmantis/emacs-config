;;; init-volatile-highlights.el --- Volatile highlights for visual feedback

;;; Commentary:
;;
;; This file configures volatile-highlights, a minor mode that provides
;; temporary visual feedback for various text operations in Emacs. It briefly
;; highlights regions of text that have been modified, helping users track
;; changes and understand the results of their editing actions.
;;
;; Key Features:
;; - Temporary highlighting of text changes
;; - Visual feedback for undo/redo operations
;; - Highlights for yank (paste) operations
;; - Automatic highlighting of modified regions
;; - Configurable highlight duration and appearance
;;
;; Highlighted Operations:
;; - Undo/redo: Shows what was undone or redone
;; - Yank/paste: Highlights inserted text
;; - Kill/delete: Shows what was removed
;; - Text insertion and modification
;; - Search and replace operations
;;
;; Visual Feedback:
;; - Brief colored overlay on affected text
;; - Automatically fades after a short duration
;; - Non-intrusive visual cues
;; - Helps track editing history and changes
;;
;; Performance:
;; - Lightweight implementation
;; - No impact on normal editing operations
;; - Efficient highlight management
;; - Automatic cleanup of expired highlights
;;
;; Integration:
;; - Works with all Emacs editing modes
;; - Compatible with other highlighting packages
;; - Respects theme color schemes
;; - Diminished in mode line for clean interface
;;
;; Dependencies:
;; - volatile-highlights: Visual feedback package
;; - diminish: Mode line cleanup

;;; Code:

(require 'volatile-highlights)
(volatile-highlights-mode t)
(diminish 'volatile-highlights-mode)

(provide 'init-volatile-highlights)

;;; init-volatile-highlights.el ends here
