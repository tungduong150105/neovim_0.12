local M = {}

-- Constants
local SOLID_LEFT_ARROW = ""
local SOLID_RIGHT_ARROW = ""
local MAX_NAME_LENGTH = 20
local TRUNCATE_TO = 17

---Apply tabline highlight groups from the solarized.nvim palette
local function set_highlights()
	local ok, utils = pcall(require, "solarized.utils")
	if not ok then
		vim.notify("tabline: solarized.nvim not found", vim.log.levels.WARN)
		return
	end
	-- Palette for the current 'background' (light: base3 = editor bg, base2 = subtle bg)
	local colors = utils.get_colors()

	-- Active tab: yellow background, editor-bg text
	vim.api.nvim_set_hl(0, "TabLineActive", {
		fg = colors.base3,
		bg = colors.yellow,
		bold = true,
	})

	-- Inactive tab: base2 background, base01 text
	vim.api.nvim_set_hl(0, "TabLineInactive", {
		fg = colors.base01,
		bg = colors.base2,
	})

	-- Separator for active tab (yellow foreground, editor background)
	vim.api.nvim_set_hl(0, "TabLineSepActive", {
		fg = colors.yellow,
		bg = "NONE",
	})

	-- Separator for inactive tab (base2 foreground, editor background)
	vim.api.nvim_set_hl(0, "TabLineSepInactive", {
		fg = colors.base2,
		bg = "NONE",
	})

	-- Fill area (editor background)
	vim.api.nvim_set_hl(0, "TabLineFill", {
		bg = "NONE",
	})
end

---Setup highlight groups for the tabline.
---Re-applied on ColorScheme, since `:colorscheme` clears custom groups.
function M.setup()
	set_highlights()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("UserTabline", { clear = true }),
		callback = set_highlights,
	})
end

---Get file icon using mini.icons with fallback
---@param filename string
---@return string icon, string hl
local function get_icon(filename)
	local ok, icons = pcall(require, "mini.icons")
	if ok then
		return icons.get("file", filename)
	end
	return "", "Normal"
end

---Get display name for a buffer
---@param bufnr number
---@return string name, string icon
local function get_buf_info(bufnr)
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local buftype = vim.bo[bufnr].buftype
	local filetype = vim.bo[bufnr].filetype

	-- Handle special buffer types
	if buftype == "terminal" then
		return "[Terminal]", ""
	end

	if filetype == "oil" then
		local dir = bufname:gsub("^oil://", "")
		dir = vim.fn.fnamemodify(dir, ":~")
		if #dir > MAX_NAME_LENGTH then
			dir = "…" .. dir:sub(-TRUNCATE_TO)
		end
		return dir, ""
	end

	if bufname == "" then
		return "[No Name]", ""
	end

	local filename = vim.fn.fnamemodify(bufname, ":t")
	local icon = get_icon(filename)

	-- Truncate long filenames
	if #filename > MAX_NAME_LENGTH then
		filename = filename:sub(1, TRUNCATE_TO) .. "…"
	end

	return filename, icon
end

---Render a single tab
---@param tabnr number
---@param is_active boolean
---@return string
local function render_tab(tabnr, is_active)
	local buflist = vim.fn.tabpagebuflist(tabnr)
	local winnr = vim.fn.tabpagewinnr(tabnr)
	local bufnr = buflist[winnr]

	if not bufnr then
		return ""
	end

	local filename, icon = get_buf_info(bufnr)
	local modified = vim.bo[bufnr].modified

	-- Build the tab content
	local title = "   " .. icon .. " " .. filename
	if modified then
		title = "   [+] " .. icon .. " " .. filename
	end
	title = title .. "   "

	-- Select highlight groups based on active state
	local tab_hl = is_active and "%#TabLineActive#" or "%#TabLineInactive#"
	local sep_hl = is_active and "%#TabLineSepActive#" or "%#TabLineSepInactive#"

	-- Build clickable tab with separators
	return string.format(
		"%%%dT%s%s%s%s%s%s%%T",
		tabnr,
		sep_hl,
		SOLID_LEFT_ARROW,
		tab_hl,
		title,
		sep_hl,
		SOLID_RIGHT_ARROW
	)
end

---Render the complete tabline
---@return string
function M.render()
	local ok, result = pcall(function()
		local parts = {}
		local current_tab = vim.fn.tabpagenr()
		local tab_count = vim.fn.tabpagenr("$")

		for tabnr = 1, tab_count do
			local is_active = tabnr == current_tab
			parts[#parts + 1] = render_tab(tabnr, is_active)
		end

		return table.concat(parts) .. "%#TabLineFill#"
	end)

	if not ok then
		return "%#TabLineFill#"
	end
	return result
end

return M
