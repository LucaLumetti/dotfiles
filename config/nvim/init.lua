vim.g.mapleader = ','

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false
vim.opt.incsearch = false

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.smartindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.keymap.set({'n', 'x'}, 'cy', '"+y')
vim.keymap.set({'n', 'x'}, 'cp', '"+p')
vim.keymap.set({'n', 'x'}, 'x', '"_x')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'H', ':bp<cr>', opts)
vim.keymap.set('n', 'L', ':bn<cr>', opts)

local lazy = {}

function lazy.install(path)
    if not vim.loop.fs_stat(path) then
        print('Installing lazy.nvim....')
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            path,
        })
    end
end

function lazy.setup(plugins)
    -- You can "comment out" the line below after lazy.nvim is installed
    lazy.install(lazy.path)

    vim.opt.rtp:prepend(lazy.path)
    require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
    {'tpope/vim-surround'},
    {'tpope/vim-commentary'},
    {'nvim-treesitter/nvim-treesitter'},
    {'wikitopian/hardmode'},
    {'pineapplegiant/spaceduck'},
    {'nvim-lualine/lualine.nvim'},
    {'kenn7/vim-arsync'},
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'nvim-treesitter/playground'},
    {'mbbill/undotree'},
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {                                      -- Optional
          'williamboman/mason.nvim',
          build = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
      }
    },
    {'tpope/vim-fugitive'},
})

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'pyright',
    'clangd',
})
lsp.setup()


vim.opt.termguicolors = true
vim.cmd.colorscheme('spaceduck')
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
local tscope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tscope.find_files, {})
vim.keymap.set('n', '<leader>fg', tscope.live_grep, {})
vim.keymap.set('n', '<leader>fb', tscope.buffers, {})
vim.keymap.set('n', '<leader>fh', tscope.help_tags, {})
vim.keymap.set('n', '<C-p>', tscope.git_files, {})

require('lualine').setup()
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'c', 'lua', 'vim', 'help', 'python', 'javascript' },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    -- indent = {
    --     enable = true
    -- },
})

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<cr>')
vim.keymap.set('n', '<leader>rc', '<cmd>ReloadConfig<cr>')


vim.api.nvim_create_autocmd(
    {'VimEnter,BufNewFile,BufReadPost'},
    {
        desc = 'Activate HardMode',
        command = 'silent! call HardMode()',
    }
)

vim.g.HardMode_level = 'wannabe'

require("nvim-treesitter.configs").setup(
    {
        ensure_installed = "python",
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<BS>",
                scope_incremental = "<TAB>"
            }
        },
        indent = {
            enable = false
        },
        rainbow = {
            enable = true,
            extended_mode = true
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },
        context_commentstring = {
            enable = true
        }
    }
)
