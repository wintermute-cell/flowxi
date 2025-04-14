local p = require("flowxi.palette")

return {
	normal = {
		a = { bg = p.blue_two, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.blue_two },
		c = { bg = p.base, fg = p.text },
	},
	insert = {
		a = { bg = p.yellow_two, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.yellow_two },
		c = { bg = p.base, fg = p.text },
	},
	visual = {
		a = { bg = p.purple_two, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.purple_two },
		c = { bg = p.base, fg = p.text },
	},
	replace = {
		a = { bg = p.red_two, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.red_two },
		c = { bg = p.base, fg = p.text },
	},
	command = {
		a = { bg = p.orange_two, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.orange_two },
		c = { bg = p.base, fg = p.text },
	},
	inactive = {
		a = { bg = p.base, fg = p.muted, gui = "bold" },
		b = { bg = p.base, fg = p.muted },
		c = { bg = p.base, fg = p.muted },
	},
}
