local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	vim.notify("failed to load mason")
	return
end

require("mason").setup()
