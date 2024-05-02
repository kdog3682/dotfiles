# Completion for the "mycommand" command
complete -c mycommand -x -a "(__fish_mycommand_completions)"

# The function that generates the completions
function __fish_mycommand_completions
    # Here, we define the possible completions
    set -l completions "option1" "option2" "option3"

    # If the commandline contains the string "opt", we want to complete options
    if string match -rq 'opt' (commandline -ct)
        set completions $completions "option4" "option5"
    end

    # Return the list of completions
    printf "%s
" $completions
end