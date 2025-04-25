local opt = vim.opt

-- Completion
opt.completeopt = { "menu", "menuone", "noinsert", "noselect", "preview" }
vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
-- Completion

-- Clipboard
vim.g.clipboard = "osc52"
-- Clipboard

-- Cursor Line
opt.cursorline = true
opt.updatetime = 250
-- Cursor Line

-- GUI Colors
opt.termguicolors = true
vim.cmd("syntax on")
-- GUI Colors

-- Indenting 
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
-- Indenting

-- Line numbers
opt.number = true
opt.relativenumber = true
-- Line Numbers

-- Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Netrw

-- Scrolling
opt.scrolloff = 10
-- Scrolling

-- Split Window
opt.splitbelow = true
-- Split Window

-- Status Line
opt.showmode = false
opt.laststatus = 3
opt.cmdheight = 1
-- Status Line

-- Tabs
opt.showtabline = 0

-- Text width
-- opt.colorcolumn = '80'
opt.linebreak = true
opt.textwidth = 80

-- Title String
opt.title = true
-- Title String

opt.mouse = ''
