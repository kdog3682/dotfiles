source /home/kdog3682/.vim/ftplugin/vimrc.january2024.vim
autocmd! bufwritepost *.vim source ~/.vimrc
let g:wpsnippets2["python"]["refa"] = "ref = [\\n    $c\\n]"
let g:filedict["abc"] = "/home/kdog3682/@bkl/apps/examples/ClipboardCollector/README.md"



    " console.log('hi')
" execute('grep -r "autocommands" ~/.config/nvim > /home/kdog3682/scratch/grep.txt')


let g:linkedBufferGroups["/home/kdog3682/PYTHON/chatgpt_vim_python_executor.py"] = "/home/kdog3682/PYTHON/vim_package_manager.py"
let g:linkedBufferGroups["/home/kdog3682/PYTHON/vim_package_manager.py"] = "/home/kdog3682/PYTHON/chatgpt_vim_python_executor.py"

nnoremap zel :call OpenBuffer4('/home/kdog3682/PYTHON/execute_neovim_lua.lua')<CR>
let g:execRef2["pt"] = "PyTest"
let g:execRef2["pt3"] = "PyTest3"
