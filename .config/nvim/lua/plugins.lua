return { {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = { 'nvim-lua/plenary.nvim', -- optional but recommended
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    } },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
  end
}, {
  'romgrk/barbar.nvim',
  dependencies = { 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons'             -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  version = '^1.0.0' -- optional: only update when a new 1.x version is released
}, {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("lualine").setup()
  end
}, {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true
    require("nvim-tree").setup {}
    vim.keymap.set('n', '<leader>o', ':NvimTreeFindFile<CR>')
  end
}, {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = true
}, {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = true
  -- use opts = {} for passing setup options
  -- this is equivalent to setup({}) function
}, {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = true
  -- use opts = {} for passing setup options
  -- this is equivalent to setup({}) function
}, {
  "kylechui/nvim-surround",
  version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy"
  -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
  -- config = function()
  --     require("nvim-surround").setup({
  --         -- Put your configuration here
  --     })
  -- end
}, {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = function()
    -- Masonとmason-lspconfigの初期化
    require("mason").setup()
    require("mason-lspconfig").setup()
  end,
  -- Bufferが読み込まれるときをトリガーに遅延ロードする
  event = { "BufReadPre", "BufNewFile" }
}, {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  branch = "regexp", -- 最新のブランチ構成に合わせて調整
  config = true,
  keys = { {
    "<leader>vs",
    "<cmd>VenvSelect<cr>",
    desc = "Select Virtual Environment"
  } }
}, {
  "smoka7/hop.nvim",
  version = "*",
  opts = {
    keys = "etovxqpdygfblzhckisuran",
  },
  keys = {
    {
      "m",
      mode = { "n", "x", "o" },
      function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.ANY_DIRECTION,
        })
      end,
      desc = "Hop to pattern (Anywhere)",
    },
  },
}, {
  "aronjohanns/smooth-resize.nvim",
  opts = {}
}, {
  "lukoshkin/highlight-whitespace",
  opts = {
    tws = "\\s\\+$",
    clear_on_bufleave = false,
    palette = {
      markdown = {
        tws = "RosyBrown",
        ["\\S\\@<=\\s\\(\\.\\|,\\)\\@="] = "CadetBlue3",
        ["\\S\\@<= \\{2,\\}\\S\\@="] = "SkyBlue1",
        ["\\t\\+"] = "plum4",
      },
      other = {
        tws = "PaleVioletRed",
        ["\\S\\@<=\\s,\\@="] = "coral1",
        ["\\S\\@<=\\(#\\|--\\)\\@<! \\{2,3\\}\\S\\@=\\(#\\|--\\)\\@!"] = "LightGoldenrod3",
        -- ["\\(#\\|--\\)\\@<= \\{2,\\}\\S\\@="] = "#3B3B3B",
        -- ["\\S\\@<= \\{3,\\}\\(#\\|--\\)\\@="] = "#3B3B3B",
        ["\\t\\+"] = "plum4",
      },
    },
  }
} }
