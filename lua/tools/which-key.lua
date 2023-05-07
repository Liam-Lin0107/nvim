return function()
	local which_key = require("which-key")

	which_key.setup({
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "  ", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		operators = { gc = "Comments" },
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			-- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 5,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = false, -- show help message on the command line when the popup is visible
		show_keys = false, -- show the currently pressed key and its label as a message in the command line
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			i = { "j", "k" },
			v = { "j", "k" },
		},

		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})

	-- normal mode
	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = false, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}
	local mappings = {
		["w"] = { "<cmd>silent! w!<CR>", "Save" }, -- Format command is from lsp/handler
		["W"] = { "<cmd>silent! wa!<CR>", "Save all" },
		["q"] = { "<cmd>confirm q<CR>", "Quit" },
		-- ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
		["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
		["f"] = {
			function()
				require("telescope.builtin").find_files(
					require("telescope.themes").get_dropdown({ previewer = false, hidden = true })
				)
			end,
			"Find File",
		},
		["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
		["e"] = { "<cmd>Neotree toggle<CR>", "Explorer" },
		-- ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
		[";"] = { ":e $MYVIMRC<CR>", "configuration" },
		["m"] = { "<Plug>MarkdownPreviewToggle", "Markdown Preview" },
		["v"] = { "<cmd>vsplit<CR>", "Split" },
		b = {
			name = "Browser show",
			m = { "<Plug>MarkdownPreviewToggle", "Markdown Preview" },
			l = { "<Cmd>LiveServer<CR>" },
		},
		d = {
			name = "Debug",
			k = { "<Cmd>lua require('dapui').eval()<CR>", "Evaluate Expression" },
			t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			l = { "<cmd>:Telescope dap list_breakpoints<cr>", "List Breakpoints" },
			b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			C = { "<cmd>:Telescope dap configurations<cr>", "Run To Cursor" },
			q = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
			g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
			i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			s = { "<cmd>lua require'dap'.continue()<CR>", "Start" },
			U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
		},
		p = {
			name = "Plugins",
			i = { "<cmd>Lazy install<cr>", "Install" },
			s = { "<cmd>Lazy sync<cr>", "Sync" },
			S = { "<cmd>Lazy clear<cr>", "Status" },
			c = { "<cmd>Lazy clean<cr>", "Clean" },
			u = { "<cmd>Lazy update<cr>", "Update" },
			p = { "<cmd>Lazy profile<cr>", "Profile" },
			l = { "<cmd>Lazy log<cr>", "Log" },
			d = { "<cmd>Lazy debug<cr>", "Debug" },
		},
		g = {
			name = "Git",
			g = { "<cmd>lua require('telescope').extensions.lazygit.lazygit()<CR>", "Lazygit Chooser" },
			j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
			l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			-- p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			-- R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			-- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			-- u = {
			-- 	"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			-- 	"Undo Stage Hunk",
			-- },
			d = {
				"<cmd>DiffviewOpen<cr>",
				"Git Diff Open",
			},

			q = {
				"<cmd>tabclose<cr>",
				"Git Diff Close",
			},
			c = { name = "Choose" },
		},
		l = {
			name = "LSP",
			f = { "<cmd>Lspsaga Lspsaga lsp_finder<CR>", "Finder" },
			a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
			p = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definition" },
			b = { "<cmd>Lspsaga show_buf_diagnostics<cr>", "Buffer Diagnostics" },
			-- w = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Workspace Diagnostics" },
			R = { "<cmd>LspRestart<Cr>", "Lsp Restart" },
			j = {
				"<cmd>Lspsaga diagnostic_jump_next<cr>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>Lspsaga diagnostic_jump_prev<cr>",
				"Prev Diagnostic",
			},
			J = {
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
				"Next Error",
			},
			K = {
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
				"Prev Error",
			},
			w = { "<cmd>Troble<CR>", "Workspace Diagnostics" },
			-- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
			-- q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
			r = { "<cmd>Lspsaga rename ++project<cr>", "Rename" },
			-- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			-- S = {
			-- 	"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			-- 	"Workspace Symbols",
			-- },

			e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
			o = { "<cmd>Lspsaga outline<CR>", "Outline" },
		},
		s = {
			name = "Search",
			b = { "<cmd>Telescope buffers<cr>", "Checkout branch" },
			B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			n = { "<cmd>Telescope notify<cr>", "Notify History" },
			h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
			H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			t = { "<cmd>Telescope live_grep<cr>", "Text" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
			l = { "<cmd>Telescope resume<cr>", "Resume last search" },
			m = { "<cmd>Telescope media_files<CR>", "Media" },
			p = {
				"<cmd>Telescope project<cr>",
				"Projects",
			},
		},
		t = {
			name = "Toggle Term",
			g = { "<cmd>LazyGit<CR>", "Lazygit" },
			q = { "<cmd>1 ToggleTerm<CR>", "terminal 1" },
			w = { "<cmd>2 ToggleTerm<CR>", "terminal 2" },
			e = { "<cmd>3 ToggleTerm<CR>", "terminal 3" },
			r = { "<cmd>4 ToggleTerm<CR>", "terminal 4" },
			t = { "<cmd>5 ToggleTerm direction=tab<CR>", "tab terminal" },
			b = { "<cmd>6 ToggleTerm direction=horizontal<CR>", "bottom terminal" },
		},
	}

	-- visual mode
	local vopts = {
		mode = "v", -- VISUAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}
	local vmappings = {
		-- ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
	}

	which_key.register(mappings, opts)
	which_key.register(vmappings, vopts)
end
