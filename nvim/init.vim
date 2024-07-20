luafile ~/.config/nvim/lua/kdog3682/init.lua
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source /home/kdog3682/.vim/ftplugin/vimrc.january2024.vim
" source /home/kdog3682/.vim/ftplugin/generated.vim
autocmd! bufwritepost *.vim source ~/.config/nvim/init.vim
filetype indent off


let g:python3_host_prog = '/usr/bin/python3'

function! Foo()
    :py3file /home/kdog3682/PYTHON/chatgpt_vim_python_executor.py
endfunction

let g:execRef2["foo"] = "Foo"

function! OmniSave()
    let file = CurrentFile()
    " execute '!python3 ~/PYTHON/foo.py'
    " return 
    if file== '/home/kdog3682/PYTHON/execute_neovim_lua1.lua' 
        try
            :luafile /home/kdog3682/PYTHON/execute_neovim_lua1.lua
        catch
            let error = v:exception
            ec error
        endtry

    elseif Test(file, "\.js")
        execute "!clear; node --no-warnings " . file

    elseif file== '/home/kdog3682/PYTHON/execute_neovim_lua.lua' 
        try
            :luafile /home/kdog3682/PYTHON/execute_neovim_lua.lua
        catch
            let error = v:exception
            ec error
        endtry
    elseif file== '/home/kdog3682/PYTHON/pyvim2.py' 
        try
            " :py3file /home/kdog3682/PYTHON/pyvim2.py
            :python3 reload_module("pyvim2")
            :python3 reload_module("native")
        catch
            let error = v:exception
            if Test(error, "Interrupt")
                return 
            endif
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

nnoremap \\ :wa<CR>:q<CR>
nnoremap s :update<CR>:call OmniSave()<CR>
nnoremap <leader>v :e /home/kdog3682/dotfiles/nvim/init.vim<CR>G

hi MoreMsg ctermfg=White ctermbg = Black
hi SpecialKey ctermfg=White ctermbg = Black
hi EndOfBuffer ctermfg=None ctermbg = None 
hi Directory ctermfg=White ctermbg = Black
hi MatchParen ctermfg=White ctermbg = Black
hi NonText ctermfg=White ctermbg = Black
hi Question ctermfg=White ctermbg = Black
hi WildMenu ctermfg=White ctermbg = Black
hi Search ctermfg=White ctermbg = Black
hi Comment ctermfg=White ctermbg = None
hi Constant ctermfg=None ctermbg = None 
hi Identifier ctermfg=None ctermbg = None gui = None cterm = None
hi Statement ctermfg=None ctermbg = None 
hi Type ctermfg=None ctermbg = None 
hi DiagnosticError ctermfg=None ctermbg = None 
hi DiagnosticWarn ctermfg=None ctermbg = None 
hi DiagnosticInfo ctermfg=None ctermbg = None 
hi DiagnosticHint ctermfg=None ctermbg = None 
hi Title ctermfg=None ctermbg = None 
hi Delimiter ctermfg=None ctermbg = None 
hi Define ctermfg=None ctermbg = None 
hi String ctermfg=None ctermbg = None 
hi Float ctermfg=None ctermbg = None 
hi Boolean ctermfg=None ctermbg = None 
hi Conditional ctermfg=None ctermbg = None 
hi Operator ctermfg=None ctermbg = None 
hi Exception ctermfg=None ctermbg = None 
hi Special ctermfg=None ctermbg = None 
hi NonText ctermfg=None ctermbg = None 
hi VimHighlight ctermfg=None ctermbg = None 
hi VimOption ctermfg=None ctermbg = None 
hi VimCommand ctermfg=None ctermbg = None 
hi VimCondHL ctermfg=None ctermbg = None 
hi Folded ctermfg=None ctermbg = None 
hi Special ctermfg=None ctermbg = None 
hi PreProc ctermfg=None ctermbg = None 
hi VimSpecFile ctermfg=None ctermbg = None 
hi Normal ctermfg=None ctermbg = None 
hi SpecialChar ctermfg=None ctermbg = None 
hi LineNr ctermfg=White




function! RunPythonStartup()
python3 << EOF
    
import sys
sys.path.append('/home/kdog3682/PYTHON/')
sys.path.append('/home/kdog3682/maelstrom/')

import utils
import chatgpt_vim_python_executor as mod
mod.unsetup()
# mod.unhighlight()
print("RunPythonStartup @ init.vim: initializing python & maelstrom")
print("removing certain keymaps ... importing utils")
    
EOF
endfunction

autocmd VimEnter * call RunPythonStartup()


function! PyTest()
python3 << EOF
# this stuff works
print(get_var('g:abc'))
print(utils.findall('amaaaaaaa', 'a'))
set_var('g:abc', 1233333)
EOF
endfunction

let g:execRef2["pt"]="PyTest"
let g:execRef2["pt2"]="PyTest2"


" asdfasdfasdf
"
"
function! SeeHighlights()
    redir! > /home/kdog3682/scratch/highlight.txt
    hi
    redir END
endfunction

"nnoremap c :python3 mod.toggle_block_comments()<CR>
nnoremap <silent> c :python3 mod.toggle_line_comments()<CR><DOWN>
nnoremap <c-\> :wq<CR>
nnoremap <silent> g0 :python3 mod.go_file_from_line()<CR>
nnoremap zx :w<cr>:python3 mod.reload_chatgpt_module()<CR>
nnoremap za :w<cr>:python3 mod.reload_all()<CR>
nnoremap ` :python3 mod.colon_handler('')<LEFT><LEFT>


inoremap <nowait> <silent> <expr> <CR> py3eval("mod.omni_enter_wrapper()") 
vnoremap <nowait> <cr>   :<c-u>call py3eval("mod.visual_handler()")<CR>
nnoremap e0 :call OpenBuffer4(g:activeFileLogFile)<CR>


" /home/kdog3682/PYTHON/execute_neovim_lua.lua
" /home/kdog3682/PYTHON/chatgpt_vim_python_executor.py
