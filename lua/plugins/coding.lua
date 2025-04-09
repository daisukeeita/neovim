require('mini.pairs').setup({})
require('mini.move').setup({})
require('mini.surround').setup({
  mappings = {
    add = 'gza', -- Add surrounding in Normal and Visual modes
    delete = 'gzd', -- Delete surrounding
    find = 'gzf', -- Find surrounding (to the right)
    find_left = 'gzF', -- Find surrounding (to the left)
    highlight = 'gzh', -- Highlight surrounding
    replace = 'gzr', -- Replace surrounding
    update_n_lines = '', -- Update `n_lines`

    suffix_last = '', -- Suffix to search with "prev" method
    suffix_next = '', -- Suffix to search with "next" method
  }
})

require('leap').create_default_mappings()
