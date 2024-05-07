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
let g:filedict["lws"] = "/home/kdog3682/2024-javascript/staging/lezer-workspace.js"


function! FzfVueProject(dir, regex)
    let dir = a:dir
    let regex = a:regex
    let payload = {'window': {'width': 0.88, 'height': 0.8}, 'left': '50%'}
    let payload['dir'] = dir 
    let payload['source'] = printf("find $(pwd) -regextype posix-extended -type f | grep -vE '%s'", regex)
    let payload["sink"]= 'e'
    call fzf#run(payload)
endfunction
inoremap <expr> ,f fzf#vim#complete(FzfHelper('/home/kdog3682/2024-javascript/'))


let regex= '(fonts|\.git/|node_modules|\.log$|temp|pycache|env|README|gitignore|(svg|html)$|dist|.github|alanmath)'

nnoremap <leader>4 :call FzfVueProject('~/projects/foxscribe', regex)<CR>
nnoremap <leader>5 :call FzfVueProject('~/projects/', regex)<CR>
let g:wpsnippets2["javascript"]["am"] = "onMounted(async () => {\\n    $c\\n}"
let g:linkedBufferGroups["/home/kdog3682/projects/foxscribe/src/App.vue"] = "/home/kdog3682/projects/foxscribe/src/composables/helpers.js"
let g:linkedBufferGroups["/home/kdog3682/projects/foxscribe/src/composables/helpers.js"] = "/home/kdog3682/projects/foxscribe/src/App.vue"

nnoremap <silent>efh :call OpenBuffer4('/home/kdog3682/projects/foxscribe/src/composables/helpers.js')<CR>

function! Comp(name)
    let path = printf('/home/kdog3682/projects/foxscribe/src/components/%s.vue', a:name)
    call OpenBuffer3(path)
endfunction
let g:execRef2["comp"] = "Comp"
let g:wpsnippets2["javascript"]["template"] = "<template>\\n    $c\\n</template>"
let g:wpsnippets2["javascript"]["nu"] = "import { appendVariableFile, writeUnitTest, read, clip2, appendVariable2, clip, appendVariable, write, rpw, isFile, sysget, } from \\\"/home/kdog3682/2023/node-utils.js\\\""


