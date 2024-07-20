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

function big-commit
    git add .
    if test (count $argv) -eq 0
        git commit -m "big-commit"
    else
        git commit -m "$argv"
    end
    git push
end

function git-commit-all 
    git add .
    if test (count $argv) -eq 0
        git commit -m "commit-all"
    else
        git commit -m "$argv"
    end
end


function t
    set file $argv[1]
    set -e argv[1]
    set message (string join " " $argv)
    echo ["$file"] ["$message"]
end


function gc 
    if test (count $argv) -eq 0
        git commit
    else
        set message (string join " " $argv)
        git commit -m "$message"
    end
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
abbr v 'vim ~/.vimrc'
abbr cdfox 'cd ~/projects/foxscribe/'
abbr pi 'pnpm install'
abbr run 'pnpm run dev'
abbr test 'pnpm run test'
abbr e2e 'pnpm run e2e'
abbr pyproject 'cat ~/projects/pyvimkit/pyproject.toml'

function nvi
    if test (count $argv) -eq 0
        set argv "~/.config/nvim/init.vim"
    end

    /mnt/chromeos/MyFiles/Downloads/nvim-linux64/bin/nvim $argv
end

abbr bfg '/mnt/chromeos/MyFiles/Downloads/bfg-1.14.0.jar'


function cd_and_save
    if test -n "$argv"
        set dir $argv[1]
        if test -d $dir
            set alias (basename $dir)
            echo "abbr $alias 'cd $dir' >> ~/dotfiles/fish/config.fish"
            cd $dir
            echo "Created alias '$alias' for '$dir'"
        else
            echo "'$dir' is not a valid directory"
        end
    else
        echo "Usage: cdandsave [dir]"
    end
end

function save_current_dir
    if test -n "$argv"
        set alias $argv[1]
        set dir (pwd)
        echo "abbr $alias 'cd $dir'" >> ~/.config/fish/config.fish
        echo "Created alias '$alias' for '$dir'"
    else
        echo "Usage: save_current_dir <alias>"
    end
end
abbr scd 'save_current_dir'
abbr greenleaf 'cd /home/kdog3682/projects/greenleaf'

abbr pdf 'node ~/2023/fs-watch.js'
abbr ga 'git add'
abbr gl 'git log'
abbr dev 'pnpm run dev'



function checkout
    if test (count $argv) -eq 0
        echo "Usage Error (missing <branch-name): checkout <branch-name>"
        return 1
    end

    set branch_name $argv[1]
    git checkout -b $branch_name
end

# Function to push current branch upstream and revert to main (if not on main)
function push-branch
    # Check if on main branch
    if test (git rev-parse --abbrev-ref HEAD) = "main"
        echo "Already on main branch. Nothing to do."
        echo "this operation is only for feature branches"
        return 1
    end

    # Check if on a branch
    if not test (git rev-parse --abbrev-ref HEAD)
        echo "Not on any branch."
        return 1
    end

    set current_branch (git rev-parse --abbrev-ref HEAD)

    # Push current branch to set upstream
    git push --set-upstream origin $current_branch

    # Revert back to main
    git checkout main
end



function fc
    # Define a dictionary with key-directory pairs
    set -l dir_map \
        m ~/projects/typst/mathematical \
        mva /home/kdog3682/projects/my-vitesse-app \
        foxscribe /home/kdog3682/projects/foxscribe \
        greenleaf /home/kdog3682/projects/greenleaf \
        pearbook /home/kdog3682/projects/pearbook \
        vue-starter /home/kdog3682/projects/vue-starter \
        tk /home/kdog3682/projects/typkit \
        hm /home/kdog3682/projects/hammymath \
        ttt /home/kdog3682/2024-javascript \

    # Prompt the user for a key
    # read -P "Enter directory key: " key
    set key $argv[1]

    # Find the directory corresponding to the key
    for i in (seq 1 2 (count $dir_map))
        if test $dir_map[$i] = $key
            set dir $dir_map[(math $i + 1)]
            break
        end
    end

    # Check if directory was found and change to it
    if test -n "$dir"
        cd $dir
    else
        echo "Invalid key: $key"
    end
end





# eat: a


abbr reset 'git reset HEAD'
abbr diff 'git diff HEAD'


function gae 
    git add .
    for arg in $argv
        git reset HEAD $arg
    end
end



function soft
    if test (count $argv) -eq 0
        echo "Usage: requires a <file>"
        return 1
    end
    set file $argv[1]
    git show HEAD:$file > $file
    echo "Restored $file to its state from the previous commit."
end

function push
    git push --set-upstream origin dev
end


abbr p 'vim ~/projects/maelstrom/__main__.py'

abbr nvi '/mnt/chromeos/MyFiles/Downloads/nvim-linux64/bin/nvim /home/kdog3682/dotfiles/nvim/init.vim'
