let color = 'blue'
let regex = '^ *//.*'
execute printf('hi MyCustomBlueColor guifg=%s', color)
call matchadd('MyCustomBlueColor', '\v' . regex)
