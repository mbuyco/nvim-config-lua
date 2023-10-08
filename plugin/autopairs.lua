local status_ok, autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
	return
end

autopairs.setup {
  map_cr = true
}
