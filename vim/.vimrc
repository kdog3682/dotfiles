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


let regex= '(hanzi|toml|assets|fonts|\.git/|node_modules|\.log$|<temp>|pycache|env|README|gitignore|(svg|html)$|dist|.github|alanmath)'
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


let g:linkedBufferGroups["/home/kdog3682/projects/foxscribe/src/components/fzf-entry.vue"] = "/home/kdog3682/projects/foxscribe/src/components/fzf.vue"
let g:linkedBufferGroups["/home/kdog3682/projects/foxscribe/src/components/fzf.vue"] = "/home/kdog3682/projects/foxscribe/src/components/fzf-entry.vue"

let g:wpsnippets2["vue"]["computed"] = "const $1 = computed(() => {\n    $c\n})"


let g:filedict["hkpfscmsfv"] = "/home/kdog3682/projects/foxscribe/src/components/multi-step-form.vue"
" let g:filedict["a"] = "/home/kdog3682/projects/src/components
let g:linkedBufferGroups["/home/kdog3682/projects/pearbook/src/router.js"] = "/home/kdog3682/PYTHON/vim_package_manager.py"

let g:linkedBufferGroups["/home/kdog3682/PYTHON/vim_package_manager.py"] = "/home/kdog3682/projects/pearbook/src/router.js"
let g:wpsnippets2["vue"]["utils"] = "import * as utils from \\\"/home/kdog3682/2023/utils.js\\\""
let g:wpsnippets2["javascript"]["utils"] = "import * as utils from \\\"/home/kdog3682/2023/utils.js\\\""
let g:wpsnippets2["javascript"]["template"] = "<template lang=\\\"pug\\\">\\n\\n\\n</template>\\n\\n<script setup>\\n\\n\\n</script>\\n\\n\\n<style lang=\\\"stylus\\\">\\n\\n</style>"
let g:wpsnippets2["python"]["prop"] = "@property\\ndef $1(self):\\n    $c"


let g:fzf_ignore_re= regex
let g:execRef2['vitesse']=  ":call FzfVueProject('~/pr', g:fzf_ignore_re)"
let g:linkedBufferGroups["/home/kdog3682/projects/pearbook/tests/1.js"] = "/home/kdog3682/.vimrc"
let g:linkedBufferGroups["/home/kdog3682/.vimrc"] = "/home/kdog3682/projects/pearbook/tests/1.js"

let g:linkedBufferGroups["/home/kdog3682/projects/pearbook/tests/2.js"] = "/home/kdog3682/projects/pearbook/tests/1.js"
let g:linkedBufferGroups["/home/kdog3682/projects/pearbook/tests/1.js"] = "/home/kdog3682/projects/pearbook/tests/2.js"

nnoremap <silent> epb :call OpenBuffer4('/home/kdog3682/projects/pearbook/src/components/Pearbook.vue')<CR>
let g:wpsnippets2["text"]["sing"] = "singleton {\n    $c\n}"
nnoremap  <silent> epr :call OpenBuffer4('/home/kdog3682/projects/pearbook/src/router.js')<CR>
nnoremap  <silent> ect :call OpenBuffer4('/home/kdog3682/2024/claude.txt')<CR>
nnoremap  <silent> eps :call OpenBuffer4('/home/kdog3682/projects/pearbook/src/routes.js')<CR>
nnoremap evc :edit /home/kdog3682/projects/pearbook/src/views/.vue<left><left><left><left>
nnoremap evb :edit /home/kdog3682/projects/pearbook/src/composables/use.js<left><left><left>
nnoremap  <silent> epg :call OpenBuffer4('/home/kdog3682/projects/pearbook/src/createNavigationGuards.js')<CR>
let g:wpsnippets2["javascript"]["vomp"] = "const $1 = computed(() => {\\n    $c\\n})"
let g:wpsnippets2["javascript"]["comp"] = "const $1 = computed(() => {\\n    $c\\n})"
let g:linkedBufferGroups["/home/kdog3682/PYTHON/lop2.py"] = "/home/kdog3682/PYTHON/lazy_object_parser.py"
let g:linkedBufferGroups["/home/kdog3682/PYTHON/lazy_object_parser.py"] = "/home/kdog3682/PYTHON/lop2.py"

nnoremap elw :call OpenBuffer4('/home/kdog3682/2024-javascript/staging/lezer-workspace.js')<CR>
nnoremap egi :call OpenBuffer4('/home/kdog3682/2024-javascript/staging/getImpliedVisitorRef.js')<CR>



nnoremap <leader>4 :call FzfVueProject('~/projects/pearbook', regex)<CR>
nnoremap <leader>5 :call FzfVueProject('~/projects/', regex)<CR>
nnoremap <leader>6 :call FzfVueProject('~/projects/greenleaf', regex)<CR>
nnoremap <leader>0 :call FzfVueProject('~/projects/typkit', regex)<CR>
nnoremap <leader>9 :call FzfVueProject('~/projects/typst', regex)<CR>
nnoremap <leader>8 :call FzfVueProject('~/projects/hammymath', regex)<CR>
nnoremap <silent> ecf :call OpenBuffer4('/home/kdog3682/projects/greenleaf/src/javascript/buildAST.js')<CR>
nnoremap <silent> ecd :call OpenBuffer4('/home/kdog3682/2023/clip.d.js')<CR>
nnoremap <silent> ett :call OpenBuffer4('/home/kdog3682/2023/temp.txt')<CR>
nnoremap <silent> ecn :call OpenBuffer4('/home/kdog3682/2024/code_notes.txt')<CR>
let g:linkedBufferGroups["/home/kdog3682/projects/greenleaf/src/javascript/classes.js"] = "/home/kdog3682/projects/greenleaf/src/javascript/buildAST.js"
let g:linkedBufferGroups["/home/kdog3682/projects/greenleaf/src/javascript/buildAST.js"] = "/home/kdog3682/projects/greenleaf/src/javascript/classes.js"

let g:wpsnippets2["javascript"]["cbn"] = "const callback = (node) => {\n    $c\n}"
let g:wpsnippets2["javascript"]["doc"] = "/**************************************\n    $c\n**************************************/"
let g:linkedBufferGroups["/home/kdog3682/projects/hammymath/dialogues/counting/temp.txt"] = "/home/kdog3682/projects/hammymath/dialogues/counting/assets.typ"
let g:linkedBufferGroups["/home/kdog3682/projects/hammymath/dialogues/counting/assets.typ"] = "/home/kdog3682/projects/hammymath/dialogues/counting/temp.txt"

let g:linkedBufferGroups["/home/kdog3682/projects/hammymath/dialogues/exponents/raw.txt"] = "/home/kdog3682/projects/hammymath/dialogues/exponents/assets.typ"
let g:linkedBufferGroups["/home/kdog3682/projects/hammymath/dialogues/exponents/assets.typ"] = "/home/kdog3682/projects/hammymath/dialogues/exponents/raw.txt"

let g:linkedBufferGroups["/home/kdog3682/2024-javascript/prosy/sentenceFix.js"] = "/home/kdog3682/2024-javascript/dialogue/dialogueStrategy.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/dialogue/dialogueStrategy.js"] = "/home/kdog3682/2024-javascript/prosy/sentenceFix.js"

function! InsertLinebreak()
    call append('.', '')
    call append('.', Repeat('-', 60))
endfunction
function! Fooga()
    nnoremap <buffer> <silent> <space> :call SetVimSpeaker()<CR>
    nnoremap <buffer> <silent> zl :call InsertLinebreak()<CR>
    ec 'initialiing vim_dialogue ZL and SPACE'
endfunction

function! ExploreTypstPackages()
    execute "Explore /home/kdog3682/.cache/typst/packages/preview"
endfunction

function! ExploreNotes()
    execute "Explore /home/kdog3682/documents/notes"
endfunction

function! ExploreTypst()
    execute "Explore /home/kdog3682/projects/hammymath/dialogues/"
endfunction
let g:execRef2["temp"] = "Fooga"
let g:filedict["cpy"] = "/home/kdog3682/PYTHON/current.py"
let g:wpsnippets2["typst"]["typ"] = "#import \"@local/typkit:0.1.0\": *"
let g:filedict["dia"] = "/home/kdog3682/PYTHON/dialogue.py"
let g:filedict["ta"] = "/home/kdog3682/2024-javascript/txflow/tests/typst.a.js"
let g:filedict["ta"] = "/home/kdog3682/2024-javascript/txflow/tests/typst.a.js"
let g:filedict["cf"] = "/home/kdog3682/projects/hammymath/dialogues/counting/drafts/ii-factorials.typ"
let g:filedict["tb"] = "/home/kdog3682/2024-javascript/txflow/typstBlocks.js"
let g:filedict["pd"] = "/home/kdog3682/2024-javascript/dialogue/pureDialogue.js"
let g:execRef2["et"] = "ExploreTypst"

function! FzfDirectoryManager()
    let dir= "/home/kdog3682/2024-javascript/"
    if &filetype== "python"
        let dir = "/home/kdog3682/PYTHON"
    elseif &filetype== "python"
        let dir = "/home/kdog3682/PYTHON"
    endif
    call FzfVueProject(dir, g:fzf_ignore_re)
endfunction

function! GoFileAndMakeDir()
    let file = GetFileFromLine2(getline("."))
    call EnsureDirExists(file)
    call OpenBuffer(file)
endfunction

function! ExploreHammyMath()
    execute 'Explore /home/kdog3682/projects/hammymath'
endfunction
nnoremap gx :call GoFileAndMakeDir()<CR>
let g:wpsnippets2["typst"]["fm"] = "---\ntitle: \nsubtitle: \nspeakers: \n---"
let g:execRef2["etp"] = "ExploreTypstPackages"
let g:execRef2["ehm"] = "ExploreHammyMath"
let g:wpsnippets2["typst"]["hmc"] = "And so concluded, was the first of Hammy Math Class."
let g:filedict["hkptmslt"] = "/home/kdog3682/projects/typst/mathematical/0.1.0/src/lightning.typ"
let g:wpsnippets2["typst"]["lb"] = "---------------------------------------------------"
let g:wpsnippets2["javascript"]["lb"] = "---------------------------------------------------"
let g:wpsnippets2["text"]["lb"] = "---------------------------------------------------"


let g:wpsnippets2["typst"]["cc"] = "cetz.canvas({\n    $c\n})" 
let g:wpsnippets2["typst"]["fore"] = "for (${Depluralize($1)}-index, ${Depluralize($1)}) in $1.enumerate() {\n    $c\n}" 
let g:wpsnippets2["typst"]["fori"] = "for i in range($1) {\n    $c\n}" 
let g:wpsnippets2["typst"]["for"] = "for ${Depluralize($1)} in $1 {\n    $c\n}" 
let g:wpsnippets2["typst"]["cb"] = "let callback($1) = {\n    $c\n}" 
let g:wpsnippets2["typst"]["ift"] = "if $1 == true {\n    $c\n}" 
let g:wpsnippets2["typst"]["imp"] = "#import \"$1.typ\"" 
let g:wpsnippets2["typst"]["impx"] = "#import \"$1.typ\": $1" 
let g:wpsnippets2["typst"]["imps"] = "#import \"$1.typ\": *" 
let g:wpsnippets2["typst"]["demo"] = "#import \"demos/$1.typ\": $1" 
let g:wpsnippets2["typst"]["a"] = "let attrs = (\n    $c\n)"
let g:wpsnippets2["typst"]["args"] = "let args = sinks.pos()"
nnoremap <leader>s :call FzfVueProject('~/projects/hammymath/singletons', regex)<CR>
nnoremap <buffer> <leader>s :call FzfVueProject('~/projects/hammymath/singletons', regex)<CR>
nnoremap <leader>p :call FzfVueProject('~/PYTHON', regex)<CR>
let g:filedict["foot"] = "/home/kdog3682/projects/typkit/0.1.0/src/foo.typ"
let g:filedict["yr"] = "/home/kdog3682/projects/hammymath/singletons/drafts/yarn-and-ribbon.typ"
let g:wpsnippets2["typst"]["args"] = "let args = sink.pos()"
let g:wpsnippets2["typst"]["kw"] = "let kwargs = sink.named()"
let g:filedict["hkpjtrj"] = "/home/kdog3682/projects/javascript/ttt/run.js"
let g:wpsnippets2["text"]["td"] = "```"


let g:filedict["hkpfscmsfv"] = "/home/kdog3682/projects/foxscribe/src/components/multi-step-form.vue"
let g:filedict["foot"] = "/home/kdog3682/scratch/bar.typ"

nnoremap <leader>` :call FzfVueProject2('~/projects/foxscribe')<CR>

function! FzfVueProject2(dir)
    if empty(a:dir)
        return 
    endif
    let regex= '(assets|fonts|\.git/|node_modules)'
    let payload = {'window': {'width': 0.88, 'height': 0.8}, 'left': '50%'}
    let payload['dir'] = a:dir 
    let payload['source'] = printf("find $(pwd) -regextype posix-extended -type f | grep -vE '%s'", regex)
    let payload["sink"]= 'e'
    call fzf#run(payload)
endfunction


let g:wpsnippets2["global"]["eat"] = "inoreab <buffer> $1 $2 <C-R>=Eatchar('\\s')<CR>"
let g:wpsnippets2["global"]["eat"] = "inoreab <buffer> $1 $2<C-R>=Eatchar('\\s')<CR>"

" inoreab <buffer> foox boar<C-R>=Eatchar('s')<CR>
inoreab <buffer> foo bar<C-R>=Eatchar('\s')<CR>
let g:wpsnippets2["typst"]["a1"] = "let placeholder = if args.len() == 1 { args.first() } else { $1 }"
let g:wpsnippets2["typst"]["math"] = "#import \"@local/mathematical:0.1.0\": *"
let g:wpsnippets2["typst"]["ab"] = "$1: $1,"

nnoremap e0 :call OpenBuffer4(g:activeFileLogFile)<CR>
nnoremap <nowait> et :call OpenBuffer4('~/2024-javascript/testsuite/index.js')<CR>
nnoremap <buffer> e0 :call OpenBuffer4(g:activeFileLogFile)<CR>
let g:wpsnippets2["fish"]["a"] = "abbr $1 '$2'"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/ttt/visit.js"] = "/home/kdog3682/2024-javascript/ttt/doFrontmatter.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/ttt/doFrontmatter.js"] = "/home/kdog3682/2024-javascript/ttt/visit.js"

let g:wpsnippets2["javascript"]["forc"] = "const children = node.children\nfor (let i = 0; i < children.length; i++) {\n    const child = children[i]\n    $c    \n}"
let g:wpsnippets2["global"] = {}
let g:wpsnippets2["global"]["td"] = "```\n$c\n```"

iunabbrev <buffer> is
iunabbrev <buffer> be
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/ttt/textToTypst.js"] = "/home/kdog3682/2024-javascript/ttt/typstFunctions.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/ttt/typstFunctions.js"] = "/home/kdog3682/2024-javascript/ttt/textToTypst.js"

nunmap <leader>gt
nnoremap <nowait> <leader>g :call FzfVueProject2(GetGitDirPath())<CR>
nnoremap <nowait> <leader>x :call FzfVueProject2("~/projects/greenleaf/")<CR>
let g:wpsnippets2["javascript"]["u"] = "import { $1 } from \"/home/kdog3682/2023/utils.js\""
let g:wpsnippets2["python"]["ab"] = "\"$1\": $1,"
