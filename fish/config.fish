if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -U fish_color_autosuggestion 'none'
set -U fish_syntaxhighlighting 'none'

function goto-git-root
    set -l root_dir (git rev-parse --show-toplevel)
    if test -n "$root_dir"
        cd $root_dir
        echo "Moved to Git root: $root_dir"
    else
        echo "Not inside a Git repository."
    end
end



function fish_user_key_bindings
    bind \; complete-and-execute
end

function complete-and-execute
    commandline -f accept-autosuggestion
    commandline -i ";"
end

function mkdir-and-enter
    mkdir $argv
    cd $argv
end 

function git-commit
    if test (count $argv) -eq 0
        echo "Please provide a commit message."
    else
        git commit -m "$argv"
    end
end

function git-commit-all 
    git add .
    if test (count $argv) -eq 0
        git commit
    else
        git commit -m "$argv"
    end
end


function gc
    git commit
end


function s
    source /home/kdog3682/.config/fish/config.fish
    echo sourced config.fish
end



function gs
    git status
end



function gacp
    git add .
    if test (count $argv) -eq 0
        git commit
    else
        git commit -m "$argv"
    end
    git push
end


function gwf
    git add .
    if test (count $argv) -eq 0
        git commit -m "Attempt fix github workflow"
    else
        git commit -m "Attempt fix github workflow: $argv"
    end
    git push
end

function wip 
    if test (count $argv) -eq 0
        echo "WIP requires a message"
        return
    else
        git add .
        git commit -m "WIP: $argv"
    end
end


function run_python_function
    python3 ~/PYTHON/fish.py $PWD
end

abbr cvi 'cat vite.config.js'
abbr cvt 'cat vitest.config.js'
abbr cpj 'cat package.json'
abbr cdbkl 'cd ~/@bkl/frontend/brooklynlearning/'
abbr cdnm 'cd node_modules'
abbr prb 'pnpm run build'
abbr prd 'pnpm run dev'
abbr prt 'pnpm run test'
abbr nrb 'pnpm run build'
abbr nrd 'pnpm run dev'
abbr nrt 'pnpm run test'
abbr pa 'pnpm add'
abbr pb 'pnpm build'
abbr pi 'pnpm install'
abbr pr 'pnpm remove'
abbr vvi 'vim vite.config.js'
abbr vvt 'vim vitest.config.js'
abbr vpj 'vim package.json'
abbr lsr 'ls -R'
abbr c 'clear'
abbr gsr 'git -C ~/@bkl status'
abbr root 'cd ~/@bkl'
abbr gca 'git-commit-all'
abbr root 'goto-git-root'

abbr stash 'git stash push -m "temp-stash"'
abbr pop 'git stash pop'
abbr rebase 'git rebase -i' # needs an additional arg

abbr mk 'mkdir-and-enter'
abbr kdog 'cd ~/@kdog3682'
abbr bkl 'cd ~/@bkl'
abbr cdg 'cd ~/GITHUB'
abbr up 'cd ..'
abbr cbh 'cat ~/.bash_history'
abbr xxx 'ls ~/.cache/kdog3682'
abbr cdnvim 'cd ~/.config/nvim'
abbr pyproject 'cat ~/projects/pyvimkit/pyproject.toml'

function nvi
    if test (count $argv) -eq 0
        set argv "~/.config/nvim/init.lua"
    end

    /mnt/chromeos/MyFiles/Downloads/nvim-linux64/bin/nvim $argv
end
