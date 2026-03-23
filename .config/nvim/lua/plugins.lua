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
  -- colorscheme
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

-- LaTeX
{
  "lervag/vimtex",
  ft = "tex",
  config = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_view_forward_search_on_start = 1
  end,
},

  -- file tree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
  },

  -- syntax highlighting
  
config = function()
      vim.treesitter.language.register("lua")
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "python", "c", "bash" },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({ options = { theme = "gruvbox" } })
    end,
  },

  -- shows keybindings
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },

  -- auto close brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
})
