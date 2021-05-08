function lazyload()
	print("I am lazy")
	vim.cmd([[syntax on]])
	-- vim.cmd([[packadd aurora]])
	-- vim.cmd([[colorscheme aurora]])
	vim.cmd([[packadd gitsigns.nvim]])
	require('modules.tools.config').gitsigns()
	vim.cmd([[packadd nvim-treesitter]])
	require('modules.lang.treesitter').treesitter()
	vim.cmd([[packadd nvim-lspconfig]])

    vim.cmd([[packadd guihua.lua]])
	vim.cmd([[packadd navigator.lua]])
	require('modules.lang.config').navigator()

	vim.cmd([[packadd indent-blankline.nvim]])
	require('modules.ui.config').blankline()

	-- require('modules.ui.config').nvim_bufferline()

	require('vscripts.cursorhold')

end

vim.cmd([[autocmd User LoadLazyPlugin lua lazyload()]])

-- require "core.timer".add(
--     function()
--     	print('timer')
--     	vim.cmd([[doautocmd User LoadLazyPlugin]])
--         return 100 
--     end
-- )

vim.defer_fn(function ()
	vim.cmd([[doautocmd User LoadLazyPlugin]])
end, 80)      

