
" silent nunmap <buffer> []
" silent nunmap <buffer> ][
" silent nunmap <buffer> ]]
" silent nunmap <buffer> [[
" silent nunmap <buffer> [{
" silent nunmap <buffer> ]}
" silent nunmap <buffer> ]"
" silent nunmap <buffer> ["
" silent nunmap <buffer> <left>"
" 
" let color = 'blue'
" let regex = '^ *//.*'
" execute printf('hi MyCustomBlueColor guifg=%s', color)
" call matchadd('MyCustomBlueColor', '\v' . regex)
" 

try
    silent nunmap <buffer> []
catch
endtry

try
    silent nunmap <buffer> ][
catch
endtry

try
    silent nunmap <buffer> ]]
catch
endtry

try
    silent nunmap <buffer> [[
catch
endtry

try
    silent nunmap <buffer> [{
catch
endtry

try
    silent nunmap <buffer> ]}
catch
endtry

try
    silent nunmap <buffer> ]"
catch
endtry

try
    silent nunmap <buffer> ["
catch
endtry

try
    silent nunmap <buffer> <left>
catch
endtry


try
    silent nunmap <buffer> <right>
catch
endtry


try
    silent nunmap <left>
catch
endtry


try
    silent nunmap <right>
catch
endtry

