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

### Python (`python-mode`)

Same LSP bindings as Go/C++ (server auto-detected; format-on-save via ruff).

| Key | Command | Description |
|-----|---------|-------------|
| `C-c r` | `lsp-rename` | Rename the symbol at point. |
| `C-c j` | `lsp-find-definition` | Jump to definition. |
| `C-c d` | `lsp-describe-thing-at-point` | Show docs for the symbol at point. |
| `C-c ,` | `lsp-find-references` | List references. |
| `C-c i` | `lsp-find-implementation` | Find implementations. |
| `C-c t` | `lsp-find-type-definition` | Jump to the type definition. |
| `C-c s` | `lsp-execute-code-action` | Code actions / quick-fixes. |

### Assembly / WebAssembly

No custom key bindings — Assembly (`asm-mode`/`nasm-mode`, via `asm-lsp`) and
WebAssembly (`wat-ts-mode`, via `wat_server`) use the standard `lsp-mode`
bindings under the `s-l` prefix when a language server is installed.

## Installing external tools

Most language features (LSP, linting, formatting, debugging) stay silently off
until their external tool is installed. Commands below are macOS / Homebrew
first, with cross-platform notes. After installing, **restart Emacs (or the
daemon)** so `exec-path-from-shell` picks up the new `PATH`. Make sure the
relevant bin dirs are on `PATH`: `~/.local/bin` (uv/pipx), `~/.cargo/bin`
(cargo), your npm global prefix, and `/opt/homebrew/opt/llvm/bin` (LLVM).

### General (search, spelling)

```sh
brew install ripgrep      # consult-ripgrep (M-s r)
brew install aspell        # flyspell  (Linux: apt install aspell aspell-en)
```

### Go

```sh
brew install go
brew install golangci-lint                              # linter (errcheck/staticcheck/…)
# gopls, dlv (Delve) and the rest of `go-tools`:
#   in Emacs:  M-x go-install-tools
# or individually:
go install golang.org/x/tools/gopls@latest              # LSP
go install github.com/go-delve/delve/cmd/dlv@latest     # debugger (dap-mode)
```

### C / C++ (LLVM)

```sh
brew install llvm          # provides clangd (LSP), clang-tidy (lint), lldb-dap (debug)
# add LLVM to PATH (zsh):
echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
# Linux: apt install clangd clang-tidy lldb   (or the llvm packages)
```

### Python

```sh
brew install uv                                         # if not already present
uv tool install ruff                                    # format-on-save + lint
uv tool install "python-lsp-server[all]" --with python-lsp-ruff   # LSP (pylsp) + ruff lint
# debugging (dap-debug) — install into the PROJECT venv, not globally:
uv pip install debugpy        # or: pip install debugpy
```

### Assembly (amd64 / arm64)

```sh
brew install rust          # for cargo (or use rustup)
cargo install asm-lsp      # LSP for x86-64 + AArch64
brew install nasm          # assembler, for building .asm sources (optional)
```

### WebAssembly

```sh
# wat_server — WAT language server (g-plane/wasm-language-tools); see its
# README for the current install (e.g. `cargo install wasm-language-tools`).
brew install wasmtime      # run/debug compiled wasm (no Emacs DAP adapter for wasm)
# tree-sitter grammars (needs a C compiler, e.g. clang):
#   in Emacs:  M-x treesit-install-language-grammar RET wat
#              M-x treesit-install-language-grammar RET wast
```

### Infrastructure / config modes (LSP autostarts only if the server is present)

```sh
brew install terraform-ls                               # terraform
brew install cmake && uv tool install cmake-language-server   # cmake
npm install -g yaml-language-server                     # yaml
npm install -g vscode-langservers-extracted             # json (vscode-json-language-server)
npm install -g dockerfile-language-server-nodejs        # dockerfile (docker-langserver)
```

### Markdown

```sh
brew install pandoc        # markdown-command (preview/export)
```

### Coding agents (init-agent.el)

Install whichever you use; `agent-start` launches any of them. (Verify package
names against each project — they change.)

```sh
npm install -g @anthropic-ai/claude-code   # claude
uv tool install aider-chat                  # aider
npm install -g @openai/codex                # codex
npm install -g @google/gemini-cli           # gemini
```
