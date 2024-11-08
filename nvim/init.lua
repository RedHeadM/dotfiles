-- based on nvim-lua/kickstart.nvim

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Theme 1nspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- { -- Theme inspired by Atom
  --   'kyazdani42/nvim-palenight.lua',
  --   priority = 1000,
  --   -- config = function()
  --   --   vim.cmd.colorscheme 'palenight'
  --   -- end,
  -- },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        -- theme = 'onedark',
        theme = 'palenight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
{
    "machakann/vim-sandwich",
    event = "VeryLazy",
},

-- "gcc" in normal mode and "gc" to comment visual regions/lines
{ 'numToStr/Comment.nvim', opts = {} },

-- Fuzzy Finder (files, lsp, etc)
{ 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

-- Fuzzy Finder Algorithm which requires local dependencies to be built.
-- Only load if `make` is available. Make sure you have the system
-- requirements installed.
{
  'nvim-telescope/telescope-fzf-native.nvim',
  -- NOTE: If you are having trouble with this installation,
  --       refer to the README for telescope-fzf-native for more instructions.
  build = 'make',
  cond = function()
    return vim.fn.executable 'make' == 1
  end,
},

-- Nvimtree (File Explorer)
{
  'nvim-tree/nvim-tree.lua',
  -- lazy = true,
    -- event = "VeryLazy",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
},

-- {
--   'nvim-treesitter/nvim-treesitter-context',
--   lazy = true,
--     -- event = "VeryLazy",
--   dependencies = {
--     'nvim-treesitter/nvim-treesitter',
--   },
-- },

-- refactoring and auto debug prints
{
  'ThePrimeagen/refactoring.nvim',
  -- lazy = true,
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
},

-- Git diff
{
  'sindrets/diffview.nvim',
  -- lazy = true,
    event = "VeryLazy",
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
},

{ -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    pcall(require('nvim-treesitter.install').update { with_sync = true })
  end,
},

 -- import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true
-- disable highlight with ESC
vim.keymap.set(
	"n",
	"<esc>",
	":noh <CR>",
	{ noremap = true, desc = '[esc] disable highlight' }
)

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.o.background = "dark"

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
callback = function()
  vim.highlight.on_yank()
end,
group = highlight_group,
pattern = '*',
})



-- [[ indent-blankline ]]
require("ibl").setup {
    indent = {char = "┊" },
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}

-- controll C to save
vim.keymap.set(
	{ 'n', 'v','i' },
	"<C-s>",
	":w <CR> ",
	{ noremap = true, desc = '[esc] disable highlight' }
)
-- [[ Configure Telescope ]]
-- fn to shorten file path:https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1873229658
vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "\t\t.*$")
			vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
		end)
	end,
})
-- shortenPath function to shorten a path to a specified maximum length
function shortenPath(path, maxLength)
    -- Default maxLength to 20 if not provided
    maxLength = maxLength or 20

    -- Split the path into components using "/" as the separator
    local parts = {}
    for part in string.gmatch(path, "[^/]+") do
        table.insert(parts, part)
    end

    -- If the path is already within maxLength characters, return it unchanged
    if #path <= maxLength then
        return path
    end

    -- Initialize the shortened path with the first directory
    local shortened = { parts[1] }
    local length = #parts[1]

    -- Iterate over the middle directories, keeping the last part intact
    local i = 2
    while i < #parts do
        local middle_length = length + 3 + #parts[#parts]  -- +3 for "/.../"
        if middle_length + #parts[i] + #parts[#parts] <= maxLength then
            -- Add the middle part if adding it doesn't exceed maxLength
            table.insert(shortened, parts[i])
            length = length + 1 + #parts[i]  -- +1 for "/"
        else
            -- If adding the next part would exceed maxLength, break here
            table.insert(shortened, "...")
            break
        end
        i = i + 1
    end

    -- Add the last directory part to the shortened path
    table.insert(shortened, parts[#parts])

    -- Join the components back together with "/"
    return table.concat(shortened, "/")
end

local function filenameFirst(_, path)
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	if parent == "." then return tail end
        parent= shortenPath(parent, 40)
        -- parent = string.format("%s\t\t%s", parent, tail)
	-- return string.format("%s\t\t%s", tail, parent)
	return string.format("%s/%s", parent, tail)
end
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
pickers = {
    find_files = {
            path_display = filenameFirst,
    }
	},
defaults = {
  mappings = {
    i = {
      ['<C-u>'] = false,
      ['<C-d>'] = false,
    },
  },
},
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', function()
  require('telescope.builtin').buffers({sort_mru=true,ignore_current_buffer =true})
end, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
-- You can pass additional configuration to telescope to change theme, layout, etc.
require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  winblend = 10,
  previewer = false,
})
end, { desc = '[/] Fuzzily search in current buffer' })


-- [[ search telescope ]]
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
-- Add languages to be installed here that you want installed for treesitter
ensure_installed = {'bash', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'yaml', 'vim','cmake','json','markdown','make','toml','comment','dockerfile','diff', 'vimdoc','diff','cmake'},

-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- require'treesitter-context'.setup{
--   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--   line_numbers = true,
--   multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
--   trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--   mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
--   -- Separator between context and content. Should be a single character string, like '-'.
--   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--   separator = nil,
--   zindex = 20, -- The Z-index of the context window
--   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- }
--
-- vim.keymap.set('n', '<leader>n', function() require("treesitter-context").go_to_context() end, {silent = true,  desc = 'Goto [c]ontext'})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {  desc = 'Goto prev [d]iagnostic'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {  desc = 'Goto next [d]iagnostic'})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {  desc = '[e]xpand diagnostic'})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {  desc = '[q]quickfix document list diagnostic'})

-- [[Movment]]
vim.keymap.set('n', 'H', '^', { desc = 'Move begining of Line' })
vim.keymap.set('n', 'L', 'g_')
vim.keymap.set('v', 'H', '^', { desc = 'Move begining of Line' })
vim.keymap.set('v', 'L', 'g_')
vim.keymap.set('n', 'J', '5j')
vim.keymap.set('n', 'K', '5k')

vim.keymap.set('v', 'J', '5j')
vim.keymap.set('v', 'K', '5k')
-- Keep selection when indenting/outdenting.
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', function() require('telescope.builtin').lsp_document_symbols({ ignore_symbols = { "variable" } }) end , '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
-- see https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
  -- clangd = {},
  -- gopls = {},
  bashls = {},
  yamlls = {},
  -- pyright = {},-- python
  pylsp  = {-- python
    -- https://jdhao.github.io/2023/07/22/neovim-pylsp-setup/
    plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
    },
  },
  dockerls = {},
  clangd = {}, -- C++
  cmake = {},
  marksman = {}, -- markdown
  -- texlab = {}, -- latex
  taplo = {}, -- TOML
  azure_pipelines_ls = {},
  -- tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true
}

lsp_path = require('lspconfig').util.path
mason_lspconfig.setup_handlers {
  function(server_name)
    if server_name == "pyright" then
      -- pyrigh set automatically pyenv if setup
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        before_init = function(_, config)
          if vim.env.VIRTUAL_ENV then
            local p = lsp_path.join(vim.env.VIRTUAL_ENV, "bin", "python")
            config.settings.python.pythonPath = p
          end
        end,
      }

    else
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }
    end
  end,
}

-- [[ Configure nvim-cmp ]]
-- A completion engine
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}


---- TODO move to nvim-tree-config.lua
-- disable netrw at the very start of your init.lua (strongly advised)
--
-- [[ search telescope ]]

-- vim.keymap.set('n', '<leader>p', require("nvim-tree.api").tree.toggle(), { desc = '[p] toogle file tree' })
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = '[t] file tree toogle' })
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- TODO: 
-- jumpmovment https://www.youtube.com/watch?v=2KLFjhGjmbI&ab_channel=CodetotheMoon
-- fzf symoles, word search
-- debug prints https://github.com/andrewferrier/debugprint.nvim
-- alternative debug prints https://github.com/ThePrimeagen/refactoring.nvim 
-- git add visual blocks https://vi.stackexchange.com/questions/10368/git-fugitive-how-to-git-add-a-visually-selected-chunk-of-code
--

-- ThePrimeagen/refactoring.nvim  debug prints
-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.

-- Print var refactoring
require('refactoring').setup({
    prompt_func_return_type = {
        python = false,
        cpp = true,
        c = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
        python = false,
        cpp = true,
        c = true,
    },
  -- overriding printf statement for cpp
  print_var_statements = {
      -- add a custom printf statement for cpp
      python = {
          'print(f"DEBUG: %s {%s}")'
      }
  }
})
-- require("telescope").load_extension("refactoring")
vim.api.nvim_set_keymap(
	"n",
	"<leader>rp",
	":lua require('refactoring').debug.printf({below = false})<CR>",
	{ noremap = true, desc = '[r]efactoring [p]rint' }
)
-- Remap in normal mode and passing { normal = prue } will automatically find the variable under the cursor and print it
vim.api.nvim_set_keymap("n", "<leader>rd", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", { noremap = true , desc = '[r]efactoring print [debug] var'})
-- Remap in visual mode will print whatever is in the visual selection
vim.api.nvim_set_keymap("v", "<leader>rd", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true, desc = '[r]efactoring print [d]ebug var' })
-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { desc = '[r]efactoring [c]clean' })
-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false, desc = '[r]efactoring: extract [f]unction'  })
-- vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false, desc = '[r]efactoring: [e]xtract function to [f]ile'})
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false, desc = '[r]efactoring: extract [v]ar'})
