lua << EOF

-- package.path = package.path .. ";/home/kdog3682/.config/nvim/lua"
-- require('kdog3682')

EOF

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source /home/kdog3682/.vim/ftplugin/vimrc.january2024.vim
source /home/kdog3682/.vim/ftplugin/generated.vim
autocmd! bufwritepost *.vim source ~/.config/nvim/init.vim
filetype indent off


let g:python3_host_prog = '/usr/bin/python3'

function! Foo()
    :py3file /home/kdog3682/PYTHON/chatgpt_vim_python_executor.py
endfunction

let g:execRef2["foo"] = "Foo"

function! OmniSave()
    let file = CurrentFile()
    if file== '/home/kdog3682/PYTHON/execute_neovim_lua.lua' 
        try
            :luafile /home/kdog3682/PYTHON/execute_neovim_lua.lua
        catch
            let error = v:exception
            ec error
        endtry
    elseif file== '/home/kdog3682/PYTHON/chatgpt_vim_python_executor.py' 
        try
            :py3file /home/kdog3682/PYTHON/chatgpt_vim_python_executor.py
        catch
            let error = v:exception
            if Test(error, "Interrupt")
                return 
            endif
            ec error
        endtry
    else
        ec 'saved!'
    endif
endfunction

nnoremap qq :wa<CR>:q<CR>
nnoremap s :update<CR>:call OmniSave()<CR>
nnoremap <leader>v :e /home/kdog3682/dotfiles/nvim/init.vim<CR>




" /home/kdog3682/PYTHON/chatgpt_vim_python_executor.py
" /home/kdog3682/PYTHON/execute_neovim_lua.lua

function! RunPythonStartup()
python3 << EOF
    
sys.path.append('/home/kdog3682/PYTHON/')
import chatgpt_vim_python_executor as mod
mod.unsetup()
print("removing certain keymaps")
    
EOF
endfunction

autocmd VimEnter * call RunPythonStartup()



function! PyTest()
python3 << EOF

import sys
sys.path.append('/home/kdog3682/PYTHON/')
import utils
print(utils.sayhi('am'))
print(utils.is_string('a'))
print('a')

EOF
endfunction

function! PyTest2()
python3 << EOF

import sys
sys.path.append('/home/kdog3682/PYTHON/')
import utils
print(utils.sayhi('am'))
print(utils.is_string('a'))
print('a')

EOF
endfunction
let g:execRef2["pt"]="PyTest"
let g:execRef2["pt2"]="PyTest2"

hi MoreMsg ctermfg=White ctermbg = Black
hi SpecialKey ctermfg=White ctermbg = Black
hi EndOfBuffer ctermfg=None ctermbg = None 
hi Directory ctermfg=White ctermbg = Black
hi MatchParen ctermfg=White ctermbg = Black
hi NonText ctermfg=White ctermbg = Black
hi Question ctermfg=White ctermbg = Black
hi WildMenu ctermfg=White ctermbg = Black
hi Search ctermfg=White ctermbg = Black
hi LineNr ctermfg=White




function! PyTest3()
python3 << EOF

import sys
sys.path.append('/home/kdog3682/PYTHON/')
import test23
print(test23)
EOF
endfunction
let g:execRef["pt3"]="PyTest3"
