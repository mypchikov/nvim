vim.o.number = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.incsearch = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4


vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
     {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons',
	config = function()
      require('lualine').setup({
        options = { theme = 'everforest' }
      })
    end}
	},
	{
      'sainnhe/everforest',
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.everforest_enable_italic = false
        vim.g.everforest_transparent_background = 2
		vim.cmd.colorscheme('everforest')
      end
    },
	{ 
		'wakatime/vim-wakatime', 
		lazy = false 
	},
	{
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
		"nvim-telescope/telescope-file-browser.nvim",
    },
	config = function()
	require("telescope").load_extension("file_browser")
	vim.keymap.set("n", "<leader>fp", "<cmd>Telescope file_browser<cr>")
	vim.keymap.set("n", "<leader>ff", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>")

	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>o", builtin.find_files, {})
	vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
	end
}
})
