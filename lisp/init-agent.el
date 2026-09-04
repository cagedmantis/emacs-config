;;; init-agent.el --- Run CLI coding agents (Claude Code, ...) in Emacs -*- lexical-binding: t; -*-

;;; Commentary:
;; Run terminal-based coding agents inside Emacs.  Each agent runs in an `eat'
;; terminal buffer rooted at the current project, so its full-screen TUI
;; renders correctly (plain `term'/`ansi-term' do not handle these well).
;;
;; Agents are configured in `agent-cli-commands' (an alist of NAME -> shell
;; command), so any CLI agent works -- Anthropic Claude Code, Aider, OpenAI
;; Codex, Google Gemini, etc.  Add your own there.
;;
;; Usage:
;;   M-x agent-start          pick an agent, open it in the project root
;;   M-x agent-start-claude   shortcut for Claude Code
;; The chosen CLI must be installed and on PATH.

;;; Code:

(require 'project)

(defgroup agent nil
  "Run CLI coding agents inside Emacs."
  :group 'tools)

(defcustom agent-cli-commands
  '(("claude" . "claude")      ; Anthropic Claude Code
    ("aider"  . "aider")       ; Aider
    ("codex"  . "codex")       ; OpenAI Codex CLI
    ("gemini" . "gemini"))     ; Google Gemini CLI
  "Alist mapping a coding-agent NAME to the shell command that launches it.
Used by `agent-start'.  Add your own agents here; the value may include
arguments (e.g. \"aider --model sonnet\")."
  :type '(alist :key-type string :value-type string)
  :group 'agent)

;; eat provides a terminal capable of hosting the agents' full-screen TUIs.
(use-package eat
  :ensure t
  :commands (eat eat-make))

(declare-function eat-make "eat")

(defun agent--project-root ()
  "Return the current project root, or `default-directory' if none."
  (if-let* ((proj (project-current)))
      (project-root proj)
    default-directory))

(defun agent-start (name)
  "Start coding agent NAME (from `agent-cli-commands') in the project root.
Runs in an `eat' terminal buffer so the agent's TUI renders correctly."
  (interactive
   (list (completing-read "Coding agent: "
                          (mapcar #'car agent-cli-commands) nil t)))
  (let* ((cmdline (cdr (assoc name agent-cli-commands)))
         (parts (and cmdline (split-string-and-unquote cmdline)))
         (program (car parts))
         (switches (cdr parts))
         (default-directory (agent--project-root)))
    (unless program
      (user-error "No command configured for agent %S" name))
    (unless (executable-find program)
      (user-error "Agent CLI %S not found on PATH (looked for %s)" name program))
    (apply #'eat-make (format "agent: %s" name) program nil switches)
    (pop-to-buffer (format "*agent: %s*" name))))

(defun agent-start-claude ()
  "Start Claude Code in the current project (shortcut for `agent-start')."
  (interactive)
  (agent-start "claude"))

(provide 'init-agent)
;;; init-agent.el ends here
