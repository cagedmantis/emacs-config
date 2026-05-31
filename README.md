# My Emacs Configuration

This is my Emacs configuration. It's an ever changing collection of configurations. Feel free to use it
or provide feedback.

## Minimum supported Emacs version

**Emacs 28.2.** The configuration must load and work on this version. Features that
require a newer Emacs are gated behind a version/feature check so they are simply
skipped on 28.2 rather than breaking startup.

## Coding agents in Emacs

Terminal-based coding agents (Anthropic **Claude Code** and others) run inside Emacs
via `lisp/init-agent.el`, in an [`eat`](https://codeberg.org/akib/emacs-eat) terminal
rooted at the current project.

- `M-x agent-start` — pick an agent and open it in the project root.
- `M-x agent-start-claude` — shortcut for Claude Code.

The selected CLI must be installed and on your `PATH`. Agents are configured in the
`agent-cli-commands` variable (defaults: `claude`, `aider`, `codex`, `gemini`); add
your own with any command line, e.g. `("aider" . "aider --model sonnet")`. To bind a
key, e.g. `(global-set-key (kbd "C-c v") #'agent-start)`.

## Key bindings

Bindings are defined across the `init-*`/`lang-*` files; this is the consolidated
reference. Having them in one place makes the whole keymap visible at a glance and
surfaces conflicts (e.g. a major-mode map shadowing a global prefix). Note that
per-mode bindings (Go, C/C++) shadow any global binding on the same key inside those
buffers.

### Global / windows

| Key | Command | Description |
|-----|---------|-------------|
| `C-x 1` | `init-toggle-delete-other-windows` | Maximize the current window, or restore the previous layout if already alone (reversible). |
| `C-c w` | `swap-meta-and-super` | macOS only: swap the Command/Option modifier mapping. |

### Project (project.el)

| Key | Command | Description |
|-----|---------|-------------|
| `C-c p` / `s-p` | `project-prefix-map` | Prefix for project commands: `f` find file, `p` switch project, `g` grep, `b` switch buffer, `c` compile, etc. |

### Completion & search (Vertico / Consult)

| Key | Command | Description |
|-----|---------|-------------|
| `C-x b` | `consult-buffer` | Switch buffer with live preview (buffers, recent files, bookmarks). |
| `M-y` | `consult-yank-pop` | Browse and insert from the kill ring. |
| `M-g g` | `consult-goto-line` | Jump to a line number with preview. |
| `M-g i` | `consult-imenu` | Jump to a symbol/definition in the buffer. |
| `M-g f` | `consult-flymake` | Jump between diagnostics. |
| `M-s l` | `consult-line` | Search lines in the current buffer (swiper-like). |
| `M-s r` | `consult-ripgrep` | Project-wide ripgrep search with preview. |
| `M-s d` | `consult-find` | Find files by name. |
| `M-A` | `marginalia-cycle` | (in minibuffer) cycle annotation detail. |

### Spelling

| Key | Command | Description |
|-----|---------|-------------|
| `C-q` | `flyspell-correct-wrapper` | Correct the misspelled word at point (in `flyspell-mode`). |

### Treemacs

| Key | Command | Description |
|-----|---------|-------------|
| `M-0` | `treemacs-select-window` | Jump to the Treemacs side window. |
| `C-x t t` | `treemacs` | Toggle the Treemacs file tree. |
| `C-x t d` | `treemacs-select-directory` | Open a directory in Treemacs. |

### Go (`go-mode`)

| Key | Command | Description |
|-----|---------|-------------|
| `C-c C-n` | `go-run` | Run the current package. |
| `C-c .` | `go-test-current-test` | Run the test at point. |
| `C-c f` | `go-test-current-file` | Run tests in the current file. |
| `C-c a` | `go-test-current-project` | Run all tests in the project. |
| `C-c r` | `lsp-rename` | Rename the symbol at point (gopls). |
| `C-c j` | `lsp-find-definition` | Jump to definition. |
| `C-c d` | `lsp-describe-thing-at-point` | Show docs for the symbol at point. |
| `C-c ,` | `lsp-find-references` | List references. |
| `C-c i` | `lsp-find-implementation` | Find implementations. |
| `C-c t` | `lsp-find-type-definition` | Jump to the type definition. |
| `C-c s` | `lsp-execute-code-action` | gopls code actions (e.g. Fill struct). |
| `C-c T` | `go-add-tags` | Add struct field tags. |

### C / C++ (`cc-mode`, clangd)

| Key | Command | Description |
|-----|---------|-------------|
| `C-c r` | `lsp-rename` | Rename the symbol at point (clangd). |
| `C-c j` | `lsp-find-definition` | Jump to definition. |
| `C-c d` | `lsp-describe-thing-at-point` | Show docs for the symbol at point. |
| `C-c ,` | `lsp-find-references` | List references. |
| `C-c i` | `lsp-find-implementation` | Find implementations. |
| `C-c t` | `lsp-find-type-definition` | Jump to the type definition. |
| `C-c s` | `lsp-execute-code-action` | clangd code actions / quick-fixes. |
| `C-c o` | `lsp-clangd-find-other-file` | Switch between header and implementation. |
