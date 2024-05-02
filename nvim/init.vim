set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source /home/kdog3682/.vim/ftplugin/vimrc.january2024.vim
autocmd! bufwritepost *.vim source ~/.config/nvim/init.vim
nnoremap <leader>v :e /home/kdog3682/dotfiles/nvim/init.vim<CR>


let g:python3_host_prog = '/usr/bin/python3'

function! Foo()
    :py3file /home/kdog3682/PYTHON/chatgpt_vim_python_executor.py
endfunction

let g:execRef2["foo"] = "Foo"

" python3 << EOF
" import sys
" sys.path.append('/home/kdog3682/PYTHON/')
" import chatgpt_vim_python_executor
" EOF

function! OmniSave()
    let file = CurrentFile()
    if file== '/home/kdog3682/PYTHON/chatgpt_vim_python_executor.py'
        :py3file /home/kdog3682/PYTHON/chatgpt_vim_python_executor.py
    else
        ec 'saved!'
    endif
endfunction
nnoremap qq :wa<CR>:q<CR>
nnoremap s :update<CR>:call OmniSave()<CR>
" command! PrintKeyMaps :py3 print_keymaps(123)
" command! VimKeymapViewer :py3 chatgpt_vim_python_executor.foobar1(123111)
