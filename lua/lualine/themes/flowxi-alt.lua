local p = require("flowxi.palette")

return {
	normal = {
		a = { bg = p.surface, fg = p.magenta_two, gui = "bold" },
		b = { bg = p.surface, fg = p.text },
		c = { bg = p.surface, fg = p.subtle, gui = "italic" },
	},
	insert = {
		a = { bg = p.surface, fg = p.cyan_two, gui = "bold" },
	},
	visual = {
		a = { bg = p.surface, fg = p.purple_two, gui = "bold" },
	},
	replace = {
		a = { bg = p.surface, fg = p.blue_two, gui = "bold" },
	},
	command = {
		a = { bg = p.surface, fg = p.red_two, gui = "bold" },
	},
	inactive = {
		a = { bg = p.base, fg = p.subtle, gui = "bold" },
		b = { bg = p.base, fg = p.subtle },
		c = { bg = p.base, fg = p.subtle, gui = "italic" },
	},
}
