vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set smartindent")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    --[[{
      'sainnhe/gruvbox-material',
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_background = 'hard'
        vim.cmd.colorscheme('gruvbox-material')
      end
    },]]
    {
      "neanias/everforest-nvim",
      version = false,
      lazy = false,
      priority = 1000, -- make sure to load this before all the other start plugins
      -- Optional; default configuration will be used if setup isn't called.
      config = function()
          vim.cmd.colorscheme('everforest')
          vim.o.background="light"
      end,
    },
    --{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }}
}
local opts = {}

require("lazy").setup(plugins, opts)

local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua", "c", "haskell", "javascript", "java", "go", "html", "css", "json", "nasm", "sql","python"},
    highlight = { enable = true },
    indent = { enable = true },
})

require('lualine').setup {
  --theme = "everforest",
  options = {
    icons_enabled = false,
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
