return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = { lookahead = true },
      move = { set_jumps = true },
    }

    -- Selection
    local select = require 'nvim-treesitter-textobjects.select'
    local select_maps = {
      ['a='] = '@assignment.outer',
      ['i='] = '@assignment.inner',
      ['l='] = '@assignment.lhs',
      ['r='] = '@assignment.rhs',
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
      ['ai'] = '@conditional.outer',
      ['ii'] = '@conditional.inner',
      ['al'] = '@loop.outer',
      ['il'] = '@loop.inner',
      ['af'] = '@call.outer',
      ['if'] = '@call.inner',
      ['am'] = '@function.outer',
      ['im'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
    }
    for key, query in pairs(select_maps) do
      vim.keymap.set({ 'x', 'o' }, key, function() select.select_textobject(query, 'textobjects') end, { desc = 'TS: ' .. query })
    end

    -- Move
    local move = require 'nvim-treesitter-textobjects.move'
    local next_start = {
      [']f'] = '@call.outer',
      [']m'] = '@function.outer',
      [']c'] = '@class.outer',
      [']i'] = '@conditional.outer',
      [']l'] = '@loop.outer',
    }
    local next_end = {
      [']F'] = '@call.outer',
      [']M'] = '@function.outer',
      [']C'] = '@class.outer',
      [']I'] = '@conditional.outer',
      [']L'] = '@loop.outer',
    }
    local prev_start = {
      ['[f'] = '@call.outer',
      ['[m'] = '@function.outer',
      ['[c'] = '@class.outer',
      ['[i'] = '@conditional.outer',
      ['[l'] = '@loop.outer',
    }
    local prev_end = {
      ['[F'] = '@call.outer',
      ['[M'] = '@function.outer',
      ['[C'] = '@class.outer',
      ['[I'] = '@conditional.outer',
      ['[L'] = '@loop.outer',
    }
    for key, query in pairs(next_start) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function() move.goto_next_start(query, 'textobjects') end, { desc = 'TS next: ' .. query })
    end
    for key, query in pairs(next_end) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function() move.goto_next_end(query, 'textobjects') end, { desc = 'TS next end: ' .. query })
    end
    for key, query in pairs(prev_start) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function() move.goto_previous_start(query, 'textobjects') end, { desc = 'TS prev: ' .. query })
    end
    for key, query in pairs(prev_end) do
      vim.keymap.set({ 'n', 'x', 'o' }, key, function() move.goto_previous_end(query, 'textobjects') end, { desc = 'TS prev end: ' .. query })
    end

    -- Swap
    local swap = require 'nvim-treesitter-textobjects.swap'
    vim.keymap.set('n', '<leader>na', function() swap.swap_next '@parameter.inner' end, { desc = 'Swap next parameter' })
    vim.keymap.set('n', '<leader>nm', function() swap.swap_next '@function.outer' end, { desc = 'Swap next function' })
    vim.keymap.set('n', '<leader>pa', function() swap.swap_previous '@parameter.inner' end, { desc = 'Swap previous parameter' })
    vim.keymap.set('n', '<leader>pm', function() swap.swap_previous '@function.outer' end, { desc = 'Swap previous function' })

    -- Repeatable moves
    local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
