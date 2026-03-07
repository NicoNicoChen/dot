--- OPTIONS ---
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.ruler = true
vim.opt.relativenumber = true
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.virtualedit = "block"
vim.opt.wrap = false

--- KEYBINDINGS ---
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Back to Normal Mode", remap = true })

--- AUTOCMD ---
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("go_to_last_location", { clear = true }),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("clost_with_q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("auto_create_directory", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("disable_auto_comment", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

--- LAZY.NVIM BOOTSTRAP ---
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
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"man",
				"rplugin",
				"spellfile",
				"shada",
			},
		},
	},
	spec = {
		{ "LazyVim/LazyVim", opts = { colorscheme = "tokyonight-night" } },
		{ import = "lazyvim.plugins" },
		{ import = "lazyvim.plugins.extras.coding.luasnip" },
		{ import = "lazyvim.plugins.extras.dap.core" },
		{ import = "lazyvim.plugins.extras.editor.illuminate" },
		{ import = "lazyvim.plugins.extras.editor.navic" },
		{ import = "lazyvim.plugins.extras.formatting.biome" },
		{ import = "lazyvim.plugins.extras.formatting.black" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.clangd" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.markdown" },
		{ import = "lazyvim.plugins.extras.lang.python" },
		{ import = "lazyvim.plugins.extras.lang.toml" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.yaml" },
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.lsp.none-ls" },
		{ import = "lazyvim.plugins.extras.test.core" },
		{ import = "lazyvim.plugins.extras.ui.treesitter-context" },
		{
			"HiPhish/rainbow-delimiters.nvim",
			lazy = true,
			event = "InsertEnter",
			config = function()
				require("rainbow-delimiters.setup").setup({
					strategy = {
						[""] = "rainbow-delimiters.strategy.global",
						vim = "rainbow-delimiters.strategy.local",
					},
					query = {
						[""] = "rainbow-delimiters",
						lua = "rainbow-blocks",
					},
					priority = {
						[""] = 110,
						lua = 210,
					},
					highlight = {
						"RainbowDelimiterRed",
						"RainbowDelimiterYellow",
						"RainbowDelimiterBlue",
						"RainbowDelimiterOrange",
						"RainbowDelimiterGreen",
						"RainbowDelimiterViolet",
						"RainbowDelimiterCyan",
					},
				})
				require("rainbow-delimiters").enable(vim.api.nvim_get_current_buf())
			end,
		},
		{
			"folke/snacks.nvim",
			opts = {
				indent = {
					enabled = true,
					chunk = {
						enabled = true,
						char = {
							corner_top = "╭",
							corner_bottom = "╰",
							horizontal = "─",
							vertical = "│",
							arrow = ">",
						},
					},
				},
			},
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			lazy = false,
			config = function()
				require("catppuccin").setup({
					flavour = "auto",
					background = {
						light = "latte",
						dark = "mocha",
					},
					transparent_background = false,
					float = {
						transparent = false,
						solid = false,
					},
					show_end_of_buffer = false,
					term_colors = false,
					dim_inactive = {
						enabled = false,
						shade = "dark",
						percentage = 0.15,
					},
					no_italic = false,
					no_bold = false,
					no_underline = false,
					styles = {
						comments = { "italic" },
						conditionals = { "italic" },
						loops = {},
						functions = {},
						keywords = {},
						strings = {},
						variables = {},
						numbers = {},
						booleans = {},
						properties = {},
						types = {},
						operators = {},
						miscs = {},
					},
					lsp_styles = {
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
							ok = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
							ok = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
					color_overrides = {
						mocha = {
							base = "#11111b",
							mantle = "#11111b",
						},
					},
					custom_highlights = function(colors)
						return {
							Comment = { fg = colors.subtext0 },
							CursorLineNr = { fg = colors.green, style = { "bold" } },
						}
					end,
					highlight_overrides = {
						all = function(colors)
							return {}
						end,
					},
					default_integrations = true,
					auto_integrations = true,
					integrations = {
						aerial = false,
						alpha = false,
						barbar = false,
						barbecue = {
							dim_dirname = false,
							bold_basename = false,
							dim_context = false,
							alt_background = false,
						},
						beacon = false,
						blink_cmp = {
							style = "bordered",
						},
						blink_indent = false,
						blink_pairs = false,
						buffon = false,
						coc_nvim = false,
						colorful_winsep = {
							enabled = false,
							color = "red",
						},
						dashboard = false,
						diffview = true,
						dropbar = {
							enabled = false,
							color_mode = false,
						},
						fern = false,
						fidget = false,
						flash = true,
						fzf = false,
						gitgraph = false,
						gitsigns = true,
						grug_far = false,
						harpoon = false,
						headlines = false,
						hop = false,
						indent_blankline = {
							enabled = false,
							scope_color = "lavender",
							colored_indent_levels = true,
						},
						leap = false,
						lightspeed = false,
						lir = {
							enabled = false,
							git_status = false,
						},
						lsp_saga = false,
						lualine = {
							all = function(colors)
								return {
									normal = {
										a = { bg = colors.lavender, gui = "italic" },
										b = { fg = colors.lavender },
									},
								}
							end,
							macchiato = {
								normal = {
									a = { bg = "#abcdef" },
								},
							},
						},
						markview = false,
						mason = true,
						mini = {
							enabled = false,
							indentscope_color = "lavender",
						},
						neotree = false,
						neogit = false,
						neotest = false,
						noice = false,
						notifier = false,
						cmp = false,
						copilot_vim = false,
						dap = true,
						dap_ui = true,
						navic = {
							enabled = true,
							custom_bg = "NONE",
						},
						notify = false,
						nvim_surround = false,
						nvimtree = false,
						treesitter_context = true,
						ts_rainbow2 = false,
						ts_rainbow = false,
						ufo = false,
						window_picker = false,
						octo = false,
						overseer = true,
						pounce = false,
						rainbow_delimieters = true,
						snacks = {
							enabled = true,
							indent_scope_color = "lavender",
						},
						symbols_outline = false,
						telekasten = false,
						telescope = {
							enabled = false,
						},
						lsp_trouble = true,
						dadbod_ui = false,
						gitgutter = false,
						illuminate = {
							enabled = true,
							lsp = true,
						},
						sandwich = false,
						signify = false,
						vim_sneak = false,
						vimwiki = false,
						which_key = true,
					},
				})
				vim.cmd.colorscheme("catppuccin")
			end,
		},
	},
})
