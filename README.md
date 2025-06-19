# Modern Emacs Configuration

A modular, well-documented Emacs configuration focused on Go development with modern completion and editing enhancements.

## Overview

This configuration provides a clean, modern Emacs experience with emphasis on:
- **Go Development**: Primary language support with LSP, tools, and optimized workflow
- **Modern Completion**: Vertico + Orderless + Corfu stack for fast, flexible completion
- **Clean UI**: Minimal interface with Doom themes and enhanced modeline
- **Performance**: Optimized settings for smooth editing experience
- **Modularity**: Well-organized, documented modules for easy customization

## Features

### 🎯 Core Features
- **Modern Completion Stack**: Vertico (minibuffer), Corfu (in-buffer), Orderless (matching)
- **Language Server Protocol**: Full LSP support with automatic formatting and imports
- **Syntax Checking**: Flycheck integration with real-time error highlighting
- **Spell Checking**: aspell integration with automatic highlighting (macOS optimized)
- **Git Integration**: Magit for version control with visual diff indicators
- **Project Management**: Projectile for project-aware operations

### 🛠 Development Environment
- **Go Development**: 
  - LSP support via gopls
  - Automatic formatting and import organization
  - Comprehensive tool installation utilities
  - Go-specific key bindings
- **Multiple Language Support**: Ready configurations for Python, JavaScript, Ruby, C++, Rust, Swift
- **Tree-sitter**: Modern syntax highlighting (experimental)
- **Code Snippets**: YASnippet for code template expansion

### 🎨 User Interface
- **Themes**: Doom themes with doom-acario-dark as default
- **Modeline**: Enhanced doom-modeline with Git, LSP, and environment info
- **Icons**: Nerd Icons support for modern visual indicators
- **Font Management**: Automatic font selection with fallbacks
- **Clean Interface**: Removed toolbars, scrollbars, and menu bars

### ⚡ Performance Optimizations
- **Smart Scrolling**: Smooth scrolling with reduced lag
- **Garbage Collection**: Optimized GC thresholds
- **Lazy Loading**: use-package for efficient startup
- **File Handling**: Automatic backup management and compression support

## Installation

### Prerequisites
- **Emacs 26.3+** (recommended: Emacs 28+)
- **Git** for cloning and package management
- **aspell** for spell checking (macOS: `brew install aspell`)
- **Go tools** (if using Go development features)

### Quick Setup

1. **Backup existing configuration**:
   ```bash
   mv ~/.emacs.d ~/.emacs.d.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone https://github.com/cagedmantis/emacs-config.git ~/.emacs.d
   ```

3. **Start Emacs**:
   ```bash
   emacs
   ```
   
   Packages will be automatically downloaded on first startup.

4. **Optional: Install Go tools** (for Go development):
   ```
   M-x go-install-tools
   ```

## Directory Structure

```
~/.emacs.d/
├── init.el                 # Main entry point
├── lisp/                   # Core configuration modules
│   ├── init-package.el     # Package management
│   ├── init-defaults.el    # Core Emacs settings
│   ├── init-appearance.el  # UI and themes
│   ├── init-vertico.el     # Minibuffer completion
│   ├── init-corfu.el       # In-buffer completion
│   ├── init-language-server.el # LSP configuration
│   ├── lang-go.el          # Go development
│   └── ...                 # Other modules
├── system_type/            # Platform-specific settings
│   ├── darwin.el           # macOS configuration
│   └── gnu_linux.el        # Linux configuration
├── config/                 # Additional configurations
├── templates/              # File templates
└── packages/               # Installed packages
```

## Configuration Modules

### Core Modules
- **`init-package.el`**: Package management with MELPA and use-package
- **`init-defaults.el`**: Essential Emacs behavior and UTF-8 setup
- **`init-appearance.el`**: Themes, fonts, and visual enhancements

### Completion System
- **`init-orderless.el`**: Flexible completion matching
- **`init-vertico.el`**: Minibuffer completion with Consult and Marginalia
- **`init-corfu.el`**: In-buffer completion with Cape extensions
- **`init-company.el`**: Legacy completion (maintained for compatibility)

### Development Tools
- **`init-language-server.el`**: LSP configuration and hooks
- **`init-flycheck.el`**: Syntax checking and error highlighting
- **`init-git.el`**: Git integration with Magit
- **`init-projectile.el`**: Project management
- **`init-treemacs.el`**: File tree explorer

### Language Support
- **`lang-go.el`**: Go development with tools and key bindings
- **`lang-modes.el`**: Basic modes for various file types
- **Additional languages**: Python, JavaScript, Ruby, C++, Rust, Swift (disabled by default)

### Utilities
- **`init-spelling.el`**: Spell checking with flyspell
- **`init-yasnippet.el`**: Code snippet expansion
- **`init-treesit.el`**: Tree-sitter integration (experimental)

## Platform Support

### macOS (`system_type/darwin.el`)
- Environment variable inheritance from shell
- Keyboard modifier remapping (Cmd, Option, Fn keys)
- Font configuration with fallbacks
- aspell integration for spell checking
- Clipboard and selection handling

### Linux (`system_type/gnu_linux.el`)
- Placeholder for Linux-specific configurations
- Ready for customization based on desktop environment

## Key Bindings

### Completion
- `C-c p p` - Completion at point
- `C-c p f` - File path completion
- `C-c p d` - Dynamic abbreviation completion

### Go Development
- `C-c C-n` - Run Go program
- `C-c .` - Test current function
- `C-c f` - Test current file
- `C-c a` - Test entire project
- `C-c r` - LSP rename
- `C-c j` - Go to definition

### Navigation and Search
- `C-x b` - Buffer switching (Consult)
- `M-s r` - Ripgrep search
- `M-g g` - Go to line
- `M-g i` - Imenu navigation

### Project Management
- `C-c p` - Projectile prefix
- `C-c left/right` - Undo/redo window configuration

### macOS Specific
- `C-c w` - Swap meta and super keys (useful with external keyboards)

## Customization

### Adding Languages
1. Create or uncomment language configuration in `init.el`
2. Add corresponding `lang-*.el` file in `lisp/` directory
3. Configure LSP support in `init-language-server.el`

### Themes
Change theme in `lisp/init-appearance.el`:
```elisp
(load-theme 'doom-acario-dark t)  ; Current default
;; (load-theme 'doom-opera-light t)  ; Light alternative
```

### Platform-Specific Settings
Add customizations to appropriate file in `system_type/` directory.

### Performance Tuning
Adjust settings in `lisp/init-defaults.el`:
- `gc-cons-threshold` - Garbage collection frequency
- `auto-save-timeout` - Auto-save interval
- Completion delays and limits

## Troubleshooting

### Package Installation Issues
```bash
# Remove package directory and restart
rm -rf ~/.emacs.d/packages/
emacs
```

### LSP Not Working
1. Ensure language server is installed (e.g., `gopls` for Go)
2. Check LSP configuration in `init-language-server.el`
3. Restart Emacs or run `M-x lsp-restart-workspace`

### Spell Checking (macOS)
```bash
# Install aspell if missing
brew install aspell
```

### Font Issues
- Check available fonts in `init-appearance.el`
- Add your preferred font to the font selection logic

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes with appropriate documentation
4. Submit a pull request

### Development Guidelines
- Document all configuration changes
- Follow existing code style and organization
- Test changes across different platforms when possible
- Update README.md for significant changes

## License

This configuration is provided as-is for educational and personal use. Feel free to fork, modify, and share.

## Acknowledgments

- [Doom Emacs](https://github.com/doomemacs/doomemacs) - Inspiration for modern Emacs configurations
- [Vertico](https://github.com/minad/vertico) - Modern completion framework
- [LSP Mode](https://github.com/emacs-lsp/lsp-mode) - Language Server Protocol support
- The Emacs community for continuous innovation and support

---

**Note**: This configuration is actively maintained and evolves with new Emacs features and best practices. Check the git history for recent changes and improvements.