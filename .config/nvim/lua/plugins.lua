local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ── Colorscheme ────────────────────────────────────────────────────────
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },

  -- ── LSP (Neovim 0.11+ API) ─────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        capabilities = capabilities,
      })
      vim.lsp.enable("clangd")

      -- LSP keymaps attach whenever any LSP connects
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf }
          local function map(key, fn, desc)
            vim.keymap.set("n", key, fn, vim.tbl_extend("force", opts, { desc = desc }))
          end
          map("gd",         vim.lsp.buf.definition,     "Go to definition")
          map("gD",         vim.lsp.buf.declaration,    "Go to declaration")
          map("K",          vim.lsp.buf.hover,          "Hover docs")
          map("gi",         vim.lsp.buf.implementation, "Go to implementation")
          map("gr",         vim.lsp.buf.references,     "References")
          map("<leader>rn", vim.lsp.buf.rename,         "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action,    "Code action")
          map("<leader>d",  vim.diagnostic.open_float,  "Show diagnostic")
          map("[d",         vim.diagnostic.goto_prev,   "Prev diagnostic")
          map("]d",         vim.diagnostic.goto_next,   "Next diagnostic")
        end,
      })
    end,
  },

  -- ── Autocompletion ─────────────────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, item)
            local labels = { nvim_lsp = "[LSP]", buffer = "[Buf]", path = "[Path]" }
            item.menu = labels[entry.source.name] or ""
            return item
          end,
        },
      })
    end,
  },

  -- ── Formatting (clang-format) ──────────────────────────────────────────
  -- Requires: sudo apt install clang-format
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c   = { "clang_format" },
          cpp = { "clang_format" },
        },
        format_on_save = {
          timeout_ms   = 500,
          lsp_fallback = true,
        },
      })
      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true })
      end, { desc = "Format file" })
    end,
  },

  -- ── Git Signs & Blame ──────────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "▁" },
          topdelete    = { text = "▔" },
          changedelete = { text = "▎" },
        },
        on_attach = function(bufnr)
          local gs   = package.loaded.gitsigns
          local map  = vim.keymap.set
          local opts = { buffer = bufnr }
          local function o(desc) return vim.tbl_extend("force", opts, { desc = desc }) end

          map("n", "]c",         gs.next_hunk,                 o("Next git hunk"))
          map("n", "[c",         gs.prev_hunk,                 o("Prev git hunk"))
          map("n", "<leader>gs", gs.stage_hunk,                o("Stage hunk"))
          map("n", "<leader>gr", gs.reset_hunk,                o("Reset hunk"))
          map("n", "<leader>gp", gs.preview_hunk,              o("Preview hunk"))
          map("n", "<leader>gb", gs.toggle_current_line_blame, o("Toggle git blame"))
          map("n", "<leader>gd", gs.diffthis,                  o("Diff this file"))
        end,
      })
    end,
  },

  -- ── Fuzzy Finder ───────────────────────────────────────────────────────
  -- Requires: sudo apt install ripgrep
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy      = "horizontal",
          sorting_strategy     = "ascending",
          layout_config        = { prompt_position = "top" },
          file_ignore_patterns = { "%.o", "%.a", "%.out", "node_modules" },
        },
      })
    end,
  },

  -- ── Syntax Highlighting ────────────────────────────────────────────────
  {
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.3",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "cpp", "lua", "python", "bash", "make" },
      highlight        = { enable = true },
      indent           = { enable = true },
    })
  end,
},
  -- ── LaTeX ──────────────────────────────────────────────────────────────
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method                  = "zathura"
      vim.g.vimtex_compiler_method              = "latexmk"
      vim.g.vimtex_view_forward_search_on_start = 1
    end,
  },

  -- ── File Tree ──────────────────────────────────────────────────────────
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      vim.g.loaded_netrw       = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        view     = { width = 30 },
        renderer = { group_empty = true },
        filters  = { dotfiles = false },
      })
    end,
  },

  -- ── Statusline ─────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options  = {
          theme                = "gruvbox",
          section_separators   = "",
          component_separators = "|",
        },
        sections = {
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "diagnostics", "encoding", "filetype" },
        },
      })
    end,
  },

  -- ── Keybinding Helper ──────────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },

  -- ── Auto Close Brackets ────────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

})
