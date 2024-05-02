# hopt -s histappend 
# PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
# Default stty is "^S"
stty stop "^Q"
# causes a stop to happen

alias d="rm ./.vimrc.swp"
alias la="ls -a"
alias listen="sudo netstat -tulpn | grep LISTEN"
alias packagemodule="touch package.json > {"type": "module"}"
alias pip="pip3"
alias removemodule="rm package.json"
alias rmuswap="rm ./.utils.js.swp"
alias rmvswap="rm ./.vimrc.swp"
alias s="source ~/.bashrc"
alias sv="source .vimrc"
alias p="source .profile"
alias n="node index.js"
alias socket="git clone https://github.com/socketio/chat-example.git"
alias n="nodemon index.js"

alias base="vim /home/kdog3682/2023/base.css"
alias gac="vim /home/kdog3682/2023/googleAppConnector.js"
alias m2="vim /home/kdog3682/2023/math.txt"
alias comp="vim /home/kdog3682/2023/compiled.js"
alias chl="vim /home/kdog3682/2023/changelog.md"
alias v="vim /home/kdog3682/.vimrc"
alias tod="vim /home/kdog3682/2023/today.js"

alias 2023="cd /home/kdog3682/2023"
alias js="cd /home/kdog3682/2023/"
alias css="cd /home/kdog3682/CWF/public/"
alias pdf="cd /home/kdog3682/PDFS/"
alias txt="cd /home/kdog3682/TEXTS/"
alias json="cd /home/kdog3682/JSONS/"
alias math="cd /home/kdog3682/MATH/"
alias jpg="cd /home/kdog3682/PICS/"
alias jpeg="cd /home/kdog3682/PICS/"
alias png="cd /home/kdog3682/PICS/"
alias svg="cd /home/kdog3682/PICS/"
alias log="cd /home/kdog3682/LOGS/"
alias py="cd /home/kdog3682/PYTHON/"
alias dir2023="cd /home/kdog3682/2023"
alias v='vim /home/kdog3682/.vimrc'
alias dev='npm run dev'
alias dev='npm --prefix ./home/kdog3682/2023/vite1 run dev'
alias c="clear"

print_dict() {
    declare -n dict_ref=$1  # Create a reference to the passed dictionary
    for key in "${!dict_ref[@]}"; do
        echo "Key: $key, Value: ${dict_ref[$key]}"
    done
}

check_vim_and_npm() {
    cd ~/@bkl
  if [[ $(pgrep -c vim) -eq 1 ]]; then
      fish
      # cd /home/kdog3682/2023/
     #  echo humzles viting time
     #  echo press "pdf" to run the pdf-typst server via fs-watch
      # echo press "vite $1 (fallback is vuetify.html) to run vite server" 
      # read_todo
  else
      # cd /home/kdog3682/my-vitesse-app/
      echo welcome!
  fi
}


alias x="vim /home/kdog3682/mycurrentfile"
alias san="vim /home/kdog3682/2023/lazyObjectParser.js"
alias 2024="cd /home/kdog3682/2024"
alias dl="cd /mnt/chromeos/MyFiles/Downloads/"

alias pdf="node fs-watch.js"
# specifically watches the file /home/kdog3682/2023/test.pdf
# when this file changes, server is updated

alias vite='serveVite'
alias path="echo $PATH"

function read_todo() {
    print_dict componentRefAliases
}

gapi() {
    cd ~/2024-python
    source gapi/bin/activate
    which python3
}


serveVite() {
    local arg=${1:-vuetify.html}
    local dir=${2:-2023}

    # Append '.html' if not present
    if [[ $arg != *.html ]]; then
        arg="$arg.html"
    fi

    # Prepend directory if provided to normalize to 
    # /home/kdog3682/2024/ or /home/kdog3682/2023/
    if [[ -n $dir ]]; then
        arg="/home/kdog3682/$dir/$arg"
    fi

    node serveVite.js serve "$arg"
}

declare -A componentRefAliases=(
    ["1"]="/home/kdog3682/2024-javascript/vuekit/vuetify.html"
    ["2"]="/home/kdog3682/2024-javascript/vuekit/standalone.html"
    ["3"]="/home/kdog3682/2024-javascript/vuekit/simple.html"
    ["cm"]="/home/kdog3682/2024-javascript/vuekit/cm.html"
    ["vanilla"]="/home/kdog3682/2024-javascript/vuekit/vanilla.html"
    ["mr"]="/home/kdog3682/2024-javascript/vuekit/multiple-raw.html"
    ["onec"]="/home/kdog3682/2024-javascript/vuekit/one-component.html"
    ["mdt"]="/home/kdog3682/2024-javascript/my-daily-tracker-website/index.html"
    ["alias3"]="realname3.html"
    ["alias$$$"]="realname3.html"
    ["ichigo"]="/home/kdog3682/scratch/ichigo.html"
)

gitSubtreePush() {
    git subtree push --prefix dist origin gh-pages
}
serveVite() {
    local arg=${1:-vuetify.html}
    local dir=${2:-2023}

    if [[ -n ${componentRefAliases[$arg]} ]]; then
        arg=${componentRefAliases[$arg]}
    fi

    if [[ $arg != *.html ]]; then
        arg="$arg.html"
    fi

    # Prepend directory if arg does not start with '/' and a directory is provided
    if [[ $arg != /* && -n $dir ]]; then
        arg="/home/kdog3682/$dir/$arg"
    fi

    # Check if the file exists and is a regular file
    if [[ ! -f $arg ]]; then
        echo "The file $arg does not exist or is not a regular file."
        return 1 # Return from the function with an error status
    fi

    node serveVite.js serve "$arg"
}


alias vi="serveVite"
alias watch="typst watch /home/kdog3682/2024-typst/src/foo.typ /home/kdog3682/2023/test.pdf"
alias cdnv="cd ~/.config/nvim/"
alias cdg="cd ~/GITHUB"
alias root="cd ~/"
alias bkl="cd ~/@bkl"
alias bklf="cd ~/@bkl/packages/frontend"
alias nvimplugin="cd ~/.config/nvim/rplugin/python3"
alias cdgm="cd ~/GITHUB/codemirror-quickstart"
alias nvi="/mnt/chromeos/MyFiles/Downloads/nvim-linux64/bin/nvim ~/.config/nvim/init.lua"

check_vim_and_npm


# Define the function
fzf_select() {
    # Check if the file exists
    if [[ -f ~/.bash_commands ]]; then
        # Read from the file, use fzf to select a command, and eval it
        local selected_command=$(cat ~/.bash_commands | fzf --prompt "Select a command: ")
        eval "$selected_command"
    else
        echo "The file ~/.bash_commands does not exist."
    fi
}


fzf_completer() {
  _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
    echo very
    echo wow
    echo such
    echo doge
  )
}

# Create an alias 'f' for the function
alias f="fzf_select"
alias pj="vim package.json"
alias prt="pnpm run test"
alias unitest="pnpm run test:unit"
alias npm="pnpm"

