local sendVimKey = require("myFunctions").sendVimKey

vim.api.nvim_create_user_command("OpenGithubPlug", function()
	sendVimKey([[^"wyi":!start "" https://github.com/<C-r>w<CR>]])
end, {
	desc = "Open a github plugin page.",
})

vim.api.nvim_create_user_command("SetSvgReactProps", function()
	sendVimKey(
		[[<ESC>/\v("|')#[a-fA-F0-9]+("|')<CR>v/\v("|')<CR>"pyvafo<ESC>ci){ color = <C-R>p, ...props }<ESC>/><CR>i<CR><UP><TAB>{...props}<ESC>:%s/\v("|')#[a-fA-F0-9]+("|')(,)@!/{color}/g<CR>]]
	)
end, {
	desc = "Set svg react props.",
})

vim.api.nvim_create_user_command("CloseAllExceptThisWindow", function()
	sendVimKey([[:%bd|e#|bd#<CR>]])
end, {
	desc = "Set svg react props.",
})
