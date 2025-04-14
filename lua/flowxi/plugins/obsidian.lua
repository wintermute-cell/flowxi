--- Flowxi for Obsidian(epwalsh)
--- https://github.com/epwalsh/obsidian.nvim
---
--- @usage
--- local highlights = require("flowxi.plugins.obsidian")
--- require("obsidian").setup({ ui = {hl_groups = highlights} })

local p = require("flowxi.palette")

return {
	ObsidianBullet = { fg = p.muted },
	ObsidianRefText = { underline = true, fg = p.purple_two },
	ObsidianDone = { bold = true, fg = p.cyan_two },
}
