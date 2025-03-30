# Neovim Configuration

This repository contains my customized Neovim configuration, focused on a modern development workflow with LSP, Treesitter, Telescope, and a sleek status line.

## Features

- **LSP Integration**: Provides code navigation, completion, and diagnostics using Neovim's built-in LSP.
- **Treesitter Support**: Improved syntax highlighting and text object selection.
- **Telescope**: Fuzzy file searching and LSP integration.
- **Lualine**: A beautiful and functional status line.
- **fzf, fd, ripgrep**: Enhancing file searching and navigation.
- **nvim-notify**: Redirecting notifications away from the command line for a better experience.

## Key Features & Customizations

### LSP Configuration
- Uses Neovim's built-in LSP with Telescope for navigation.
- Custom keybindings for jumping to definitions, references, and implementations.
- Diagnostics shown in floating windows.

### Treesitter
- Provides enhanced syntax highlighting.
- Supports text objects for better code navigation.

### Telescope Configuration
- Uses `fd` and `ripgrep` for fast searching.
- Floating UI with left-side prompt and right-side preview.

### Statusline (Lualine)
- Displays LSP status, file encoding, and Git information.

### Notifications
- Replaces command-line messages with floating banners using `nvim-notify`.
- Tree-sitter updates and LSP messages are redirected to notifications.

## Troubleshooting

### Treesitter Delay on 'k' Key
If Treesitter text objects interfere with normal movement:
```vim
vim.keymap.set('n', 'k', 'k', { noremap = true, silent = true })
```

### LSP Showing Deprecated Warnings
Neovim 0.12 changes `vim.lsp.util.jump_to_location`, update to the new API.

## Future Improvements
- Custom Treesitter peek definitions without LSP fallback.
- More statusline customization.

## License
This configuration is open-source and free to use!

 
