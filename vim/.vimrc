let maplocalleader = ","
let mapleader = ","


autocmd! bufwritepost *.vim source ~/.vimrc
hi ErrorMsg ctermfg=White ctermbg = Black
hi WarningMsg ctermfg=White ctermbg = Black
" hi MyCustomColor ctermfg=White ctermbg = Black
" hi MatchParen ctermbg=0

" hi ExclamationLine ctermbg=0 guifg = Black ctermfg = White

" source /home/kdog3682/.vim/ftplugin/ToggleMappings.vim
source /home/kdog3682/.vim/ftplugin/vimrc.january2024.vim
" source /home/kdog3682/.vim/ftplugin/typst_refs.vim
" source /home/kdog3682/.vim/ftplugin/typst-data.vim


function! WindowWords()
    let lines = s:getlines('window')
    let text = s:joinlines(lines)
    let words = filter(s:unique(s:get_words(text)), 'len(v:val) > 5')
    return words
endfunction
function! SetGCFW()
    let word = s:choose(WindowWords())
    ec ["word", word]
    let g:current_function_word = word
endfunction
function! InsertFunctionWordExpr()
    let word = g:current_function_word
    " abc(
    if VimTextStateObject().front.is("(")
        return word
    endif
    return word . "()\<LEFT>"
endfunction
let g:execRef2["sgcw"] = "SetGCFW"

function! RunJavascript(file, fnKey, ...)
    let vimState = GetVimState("libraryFile")
    let block = EvaluateFromShell('node', file, fnKey, vimState, a:000)
    return json_decode(block[0])
endfunction
function! LoadLibrary()
    let result = RunJavascript('connect.js', 'LoadLibrary')
    return result.value
    if !exists('b:lib')
        if result.success
            let b:lib = result.value
        else
            return 
        endif
    endif
    return b:lib
endfunction

function! GetLibraryItem2()
    let lib = LoadLibrary()
    if empty(lib)
        ec 'no library'
        return 
    endif
    let item = FuzzyFindDictionary(lib)
    let text = IsString(item) ? item : item.text
    let lines = WrapLines(s:tolines(text))
    call append('$', lines)
endfunction

function FuzzyFindDictionary(ref)
    let ref = a:ref
    let key = s:fuzzy(keys(ref))
    let value = ref[key]
    return value
endfunction
function! GetVimState(...)
    let lineNumber = line('.')
    let file = CurrentFile()
    let filetype = &filetype
    let tail = Tail(file)
    let data = {
        \'file': file,
        \'line': getline(lineNumber),
        \'filename': tail,
        \'name': RemoveExtension(tail),
        \'lineNumber': lineNumber,
        \'lnum': lineNumber,
        \'filetype': filetype,
        \'dir': Head(file),
    \}
    for i in range(a:0)
        let key = a:000[i]
        let value = s:jspy(key)
        if s:exists(value)
            let data[key] = value 
        endif
    endfor
    return data
endfunction

inoreab <buffer>ln lineNumber<C-R>=Eatchar('\s')<CR>
let g:execRef2["gli"] = "GetLibraryItem"
let g:wpsnippets2["python"]["s"] = "s = \"\"\"\n    $c\n\"\"\""
let g:wpsnippets2["python"]["ifname"] = "if __name__ == \"__main__\":"
nnoremap eeu :call OpenBuffer4('/home/kdog3682/PYTHON/utils.py')<CR>
nnoremap eev :call OpenBuffer4('/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim')<CR>
let g:filedict["lu"] = "/home/kdog3682/2023/lezer-utils.js"

nnoremap eelf :call OpenBuffer4('/home/kdog3682/2023/lezer-functions.js')<CR>

" hi Error ctermfg=black guifg=black
" hi Error ctermfg=White ctermbg=Red guifg=White guibg=Red

" #C6C7C811 : cursor color


function Redirect2(s)
    redir => currentMappings
    silent! execute a:s
    redir END
    return currentMappings
endfunction
function! Fooba()
    return AppendBottom(Fuzzy(ToLines(Redirect2('hi'))))
endfunction
function! Colorize()
    " hi MatchParen ctermbg=DarkGray
    " hi MatchParen ctermbg=White
    " asd (asdasd)
endfunction

let g:active_files = []
function! SetActiveFile()
    call add(g:active_files, CurrentFile())
endfunction

function! GoActiveFile()
    let file = GetLast(g:active_files)
    call OpenBuffer3(file)
endfunction
let g:execRef2["gaf"] = "GoActiveFile"

nnoremap ez :call GoActiveFile()<CR>
let g:wpsnippets2["javascript"]["ifnot"] = "if (!$1) {\n    $1 = $2\n}"
let g:linkedBufferGroups["processCallables.js"] = "rewrite.template.js"
let g:linkedBufferGroups["rewrite.template.js"] = "processCallables.js"

let g:linkedBufferGroups["lezer-testing.january.js"] = "l.env.js"
let g:linkedBufferGroups["l.env.js"] = "lezer-testing.january.js"

let g:wpsnippets2["javascript"]["templ"] = "const template = `\n    $c\n`"
let g:wpsnippets2["python"]["inf"] = "inform(\"\"\"\n    $c\n\"\"\")"


function! Seacha()
    execute ":Files <C-r>=expand('%:h')"
endfunction
let g:filedict["eed"] = "/home/kdog3682/2024/dump.txt"


function! LowercaseCurrentWord()
    " Save the current cursor position
    let l:save_cursor = getpos(".")

    " Move to the start of the current word, change it to lowercase, and go back to the end of the word
    normal! b
    let l:word = expand("<cword>")
    execute "normal! ciw" . tolower(l:word)

    " Restore the cursor position
    call setpos('.', l:save_cursor)
endfunction

" Bind the function to a key (e.g., <leader>l)
nnoremap <leader>l :call LowercaseCurrentWord()<CR>

function! Sdfswfwf()
     call ExportToJson('dirdict')
endfunction
let g:filedict["eed"] = "/home/kdog3682/2024/dump.txt"
nnoremap eed :call OpenBuffer4('/home/kdog3682/2024/dump.txt')<CR>
let g:linkedBufferGroups["runEvalFile.js"] = "eval.template.js"
let g:linkedBufferGroups["eval.template.js"] = "runEvalFile.js"

nnoremap etd :call OpenBuffer4('/home/kdog3682/2024/todo.txt')<CR>
nnoremap eef :call OpenBuffer4('/home/kdog3682/2024/functions.txt')<CR>


let g:lezer_functions = ["ExpressionStatement", "getLezerState", "traverse","Environment","traverseJson","findallChildNodes","jsonTraversal","stringBuilder","isContentNode","iterateTree","getChildNodes","findChildNode","viewTree","traverseBlue","getNameNode","getStatef"]
let g:wpsnippets2["javascript"]["ssa"] = "/* deno-fmt-ignore */ import {fooga, exprTemplater, stringifyIfNotPrimitive, panic, stringerf, wrapFunction, regexTemplater, iso8601, strftime, walkChildEntries, getFiletype, matchf, isUrl, looksLikeFunction, toArgument2, notNull, CumulativeStorage2, simpleAssign, findAndMatch, infuseObjectArray, regexGetter, splitArg, isJavascriptComment, runTest, everyOther, splitByRange, get_regex, getImports, isJavascriptFile, isValidDateString, WriteObject, equalityf, group2, splitOnce2, dedent4, isLowerCase, looksLikeRegExpString, isRegExpString, getDependencies, camelSplit, toggle3, countf, isLiteralObject, bindMethodsAndState2, call, mget3, looks_like_object_function, create_functions_from_master, toStringArgumentPretty, codeChunks, smart_map, run_tests, hasStartingCallable, mapTemplate, aliaser, fixSelector, htmlTags, removePythonComments, simpleStringBreaker, colonConfig, operations, error, redColon, so2, group, parseSingleLineJson, Items, findDependencies, tryf, find4, localeString, cssComment, colonConfigf, trimArray, parseCallable, bringToLifeTextFix, localBringToLife, getCaller4, getErrorStack, forEach, getBindings, getExports, matchstr, filter4, allEqual, count, isNativeFunction, repeat, getIndentAndText, StopWatch, stringDictSetter, getFunctionInfo, runRef, toLines, hasCallable, getProseWords, tally, paramify, codeSplit, debugConfig, logConfig, blueColon, toStringArgument3, stringCallable, simpleBinding, dashSplit4, appendBelow, appendAbove, removeLineComments, prependIfNecessary, smartDedent4, blueSandwich, walk4, findLineIndex, parseAB, applyTransform, kebabCase, getExcerpt, sortObject, buildFunction, maybeSort, parseFunction, isTypable, frontMatter, dictEntry, insertAfterIndex, State, bindMethods, cpop, tagRE, toggle2, createFunction2, assignIncrementedIndex, ufa, assignArray, regexFromComment, createParsersFromObject, imatch, globalConsoleDebug, bindMethodsAndState, isQuestion, oxfordComma, isUpperCase, getFunctionIdentifier, filter3, match, getMatch, alternatef, reCombine, assertion2, deepEqual, hasDollar, so, deepAssign, Tally, getFunctionNames, throwError, notEqual, tryString, prettyPrintCodeSnippet, prettyPrintErrorStack, iter, quotify, transformerf, assign, defineBinding, jspy, linebreak, stringCall2, reduce3, getClassParameters, assignOnTop2, isIdentifier, ndy, dashSplit3, runFunctionFromRef, equalf, alphabet, stateGetterFromSchema, mreplace, require, topLineComment, isChinese, replacef, ignoref, codeLibrary, splitLines, addArgumentQuotes, getBindings2, addCaret, mget2, getStartingConfig, incrementalEat, strlen, hr, setOnce, unescapeHtml, oxford, breakerf, runTests, map3, dateSplit, transformDict, walk3, toRegExp, tryAgainf, assertNotNull, getArgumentObject, isArgumentObject, typef, requireArg, keyAndValue, assignf, stateGetter3, objectFromArguments2, assignDefaults, transformValue, assign3, assignFresh3, evaluate3, scopedEvaluator, objectFromArguments, enforce, sub, filterObject, extractStartingJsonLikeConfig, unbrackify, newlineIndent2, deleteLine, both, normalizeIndent, getComment, secondComment, isStringRegExp, dashSplit2, clock, warning, errorStringify, alert, labelCase, bottomComment, stringCompose, getAnyIdentifier, chalkf, getNumbers, partitions, has, addUnit, toCallable, unquote, filter2, warn2, join2, caller2, assignOnce, longShort, shortLong, argPop, caller, assignOnTop, toggle, defineWindow, unescapeNewlines, escapeQuotes, unescapeQuotes, escapeNewlines, setAliases, announceCaller, removeStartingComments, smartBind, assignExisting, isObjectWithKey, eatStart, modularIncrementItem, getRegex, runFunction, isObjectLikeArray, itemGetter2, getAllKeys, prefixSlice, hasQuotes, assertion, diff, toggleState, initState, dunder, objectGetter, superTransform, popFilter, testRunner, assert2, insertAtDollar, popEmptyLine, getOptions, mergeSpecs, sortByKeys, map2, strictMessengerAssert, smartSplit, chalk4, typeLog, getFunctionName, Clock, search3, MyError, fuzzyMatch3, debugDisplay, getCaller3, messengerAssert, camelSlice, setPrototype, assignAliases, display, modifyNumber, toDict, setPush, modularIncrementIndex, longstamp, popIndex, toggleOnOff, locWrap, walk2, typeMatch, prettyStringify, getIdentifiers, CustomError, argMatch, brackify2, smartestDedent, modularIncrementNumber, AbstractMethodError, allUnique, Trie, boundarySplit, numberBoundarySplit, nodeLog, getFirst, defineProperty, supermix, partial, timeLog, timestamp, raise, getIdentifier, conditionalPrefix, conditionalSuffix, QueryList, fuzzyMatch2, buildDict, getTextAndCommand, sprawlFactory, getParameters2, pushf, intersection, union, blue, green, sandwich, getLastSpaces, smartDedent3, red, sort, debounce, checkValue, getCodeChunks, logf, boundary, myError, conditional, isStringFunction, toSpaces, objectf, searchAll, difference, singleQuote, itemGetter, slice2, mergeObjects, once, dashSplit, nchalk, coerceToObject, ArrayState, exporter2, indent2, iterator, removeAllComments, countParams, cumulativeSchemaAssign, argKwargSplit, argParse, removeInlineComments, getFrontMatter, hasHtmlSuffix, lazyArray, isThisFunction, escapeHTML, getKwargs2, search2, toStringArgument, createFuzzyMatch, edit2, splice, zip, merge2, argArgsKwargs, fill2, chalk, vueWrap, splitArray, splitArray2, warn, makeRunner2, searchf2, smartDedent2, dedent2, toArray2, stateGetter2, sortByIndex, IndexedCache, argo, curry2, doUntil2, evaluate2, findall2, findIndex2, findItem2, getCaller2, getErrorStack2, isJson, indexGetter2, insert2, pop2, parseError2, remove2, reduce2, testf2, type2, unshift2, waterfall2, xsplit2, Cache, cumulativeAssign, replaceBefore, topComment, isAsyncFunction, mapSort, getFileURI, getQuotes, isClassObject, isInitialized, getFallback, bindingRE, addObjectOrObjectProperty, forDoubles, isCss, log, iterate, backAndForth, round, iteratorWrapper, toJSON, isFromMap, toString, empty, conditionalString, getConfigArg, hasKey, errorWrap, successWrap, check, toPoints, bind, mixinAliases, isPercentage, isBasicType, reducerStrategy, gather, entries, stateGetter, methodCase, vueCase, push2, smarterIndent, lineSplit, Store, isSingleLetter, prepareText, isSymbol, getShortest, slice, KeyError, deepCopy, argsKwargs, isError, isColor, list, objectEditor, matchall, makeFastRunner, announce, hasLetter, filter, reduce, stringCall, capitalizeName, stop, proseCase, lineDitto, mixinSetters, modularIncrement, distinct, definedSort, groupBy, reWrap2, fuzzyMatch, isPlural, Element, parseError, isPrimitiveArray, callableArgsKwargs, waterfall, defineVariable, info, flat2D, splitThePage, handleError, dedent, TypeAssertion, createFunction, pluralize, remove, Group, PageStorage, Storage, UniqueStorage, Watcher, arrayToDict, addProperty, addQuotes, argWrapFactory, assert, abrev, abf, addExtension, assignFresh, antif, atFirst, atSecond, backspace, bindObject, breaker, blockQuote, brackify, bringToLife, comment, countCaptureGroups, capitalizeTitle, classMixin, callableRE, camelToTitle, curry, createVariable, changeExtension, curryStart, curryEnd, capitalize, copy, camelCase, compose, char2n, camelToDash, deepMerge, datestamp, doublef, dictSetter, dictSetter2, dsearch, doUntil, dashCase, doubleQuote, dict, dictGetter, depluralize, dreplace, dictf, endsWithWord, exporter, edit, exists, evaluate, extend, find, flatMap, fill, fixUrl, functionGetter, findall, fixPath, flat, fparse, findIndex, firstLine, ftest, getKwargs, getFirstName, getBindingName, getParameters, getLastWord, getCodeWords, getCodeWords2, getIndent, getExtension, getLast, getLongest, getChunks, getCaller, getStackTrace, getConstructorName, getFirstWord, getWords, getSpaces, hasComma, hasSpaces, hasHtml, hasBracket, hasNewline, hasCaptureGroup, hasEquals, hasValue, hasCamelCase, hasNumber, hackReplace, insert, indexGetter, incrementf, isCallable, isQuote, isEven, isOdd, isLast, isHTML, isNode, interweave, inferLang, isString, isArray, isObject, isDefined, isFunction, isPrimitive, isNumber, isSet, isNestedArray, indent, isNull, isWord, isBoolean, isRegExp, identity, isObjectLiteral, isJsonParsable, isCapitalized, isNewLine, isObjectArray, isStringArray, isClassFunction, joinSpaces, join, keyArrayToObject, lowerCase, linebreakRE, len, lineGetter, lineCount, lastLine, logConsole, makeRunner, mixin, modularf, matchGetter, merge, mget, map, mergeOnTop, mergeToObject, mapFilter, noop, nestPush, no, newlineIndent, n2char, objectWalk, overlap, objectToString, opposite, pipe, parseTopAttrs, pascalCase, partition, parens, push, pop, parseJSON, rigidSort, removeQuotes, rep, removeComments, range, removeExtension, rescape, reverse, reWrap, reduceToString, repeatUntil, swapKey, sayhi, swap, splitMapJoin, splitCamel, smallify, search, stringify, shared, smartDedent, stringBreaker, sleep, split, snakeCase, stringArgument, sorted, splitOnce, searchf, secondLine, titleCase, textOrJson, toNumber, toArgument, toNestedArray, test, type, tail, transformObject, trim, testf, toArray, templater, totalOverlap, upperCase, unique, uncapitalize, unzip, wrap, walk, wrapf, xsplit, yes, zip2} from \"./utils.js\"\n/* deno-fmt-ignore */ import {componentManager, mdate, WriteFile, LogFile, vimFunctionConnector, tempFile, resolvePath, path2024, write2024, packageManager3, smart_path, createCodeString2, buildBindings2, JavascriptBuilder, ltf, appendVariable3, generateFile, generateImports, getStats, ff, createCodeString, finishConfig, findError2, onConfigStart, packageManager2, getFiles2, colonPackageManager, packageManagerSingletonRunColon, getText, packageManagerSingleton, oneArg, toVimVariable, headAndTail, absdir, getSection, sortByDate, dateTheFile, vimConnector, writeExportFile, pathJoin, jslib, pylib, backupFile, writeAndBackup, superFileGetter, submit, clipOrLog, fileGetter, toTimestamp, appendVariableFile, readParse, incrementalName, rfile, getJuneJson, isRecentFile, unmute, clip2, clip2 as c2, appendVariable2, moduleFunctionFactory, dirGetter, save, getRecentFile, fileOrText, logger, writeFromOptions, appendFileName, backup, getFiles, packageManager, mergeJson, fileFromKey, path, mergeFiles, writeUnitTest, runUnitTest, NodeError, isDir, NodeAssertion, sysArgs, sysArg, mute, abspath, getFile, logAction, head, getDir, dirFromPath, npath, textAndLang, shunt, sysget, append, prepend, currentFile, clip, isFile, normFileDir, normRead, normWrite, normAppend, normPrepend, normRpw, openFile, read, rpw, textGetter, write, getString, appendSelf, appendVariable, argv, exit, request} from \"./node-utils.js\"\n/* deno-fmt-ignore */ import {asciiTable, MatchParserHTML, LineEditor, ScopedEvaluator, MatchParser, csv, pythonic} from \"./next2.js\""

let g:filedict["lt"] = "/home/kdog3682/2023/lezer-getTree.js"
let g:filedict["glt"] = "/home/kdog3682/2023/lezer-getTree.js"


let g:fileRef["tests.js"] = {}
let g:fileRef["tests.js"]["linked6"] = "evaluator.js"
let g:fileRef["tests.js"]["node1"] = {"run":"evaluator.js","argFile":"tests.js"}

let g:execRef2["rp"] = "RunPython"
let g:wpsnippets2["javascript"]["st"] = "setTimeout(() => {\n    $c\n}, $1::100)"
let g:wpsnippets2["markdown"] = {}
let g:wpsnippets2["markdown"]["fm"] = "---\ntitle: $c\ndatetime: $datetime\n---"


function! WriteNotes6(s)
    """ 01-20-2024 
    """ the final iteration of write notes. 
    """ this time we do not edit the input at all.
    """ this time we do not enter the file at all. 
    """ it is a private dot file.
    """ the only thing we do is append timestamp.
    """ this file should never be looked at
    """ in the future, it will be parsed by chatgpt and turned into html
    try
        let value= VT(a:s)
        if empty(value)
            return
        endif
        let s = strftime('%s') . ' ' . value 
        call AppendFile('/home/kdog3682/2024/.notes.txt', s)
    catch
        let error = v:exception
        ec error
    endtry
endfunction
nnoremap <leader>w :call WriteNotes6("")<left><left>

let g:wpsnippets2["vim"]["doc"] = "\"\"\" ${DateStamp()}\n\"\"\" $c\n\"\"\" \n\"\"\" \n\"\"\" \n\"\"\" "
let g:filedict["fp"] = "/home/kdog3682/2023/fixProse.js"
let g:wpsnippets2["javascript"]["md"] = "```markdown\n\n$c\n\n```"
let g:filedict["vdoc"] = "/home/kdog3682/2023/vuetify2.doc.js"

let g:filedict["ft"] = "/home/kdog3682/2024/foo.typ"
function! RunPythonApps()
    " 01-23-2024 
    " let payload = getbufinfo('%')
    " let payload = {'a': 1}
    " let vim = {'file
    let vimState = GetVimState()
    " return vimState
    call NodeTerminalOrShell('run_apps.py', vimState)
endfunction
let g:execRef2["rap"] = "RunPythonApps"
let g:linkedBufferGroups["apps.py"] = "run_apps.py"
let g:linkedBufferGroups["run_apps.py"] = "apps.py"

let g:wpsnippets2["typst"]["cetz"] = "#import \"@preview/cetz:0.2.0\"\n#cetz.canvas({\n  import cetz.draw: *\n  ...\n})"
let g:wpsnippets2["typst"]["cetz"] = "#import \"@preview/cetz:0.2.0\"\n#cetz.canvas({\n  import cetz.draw: *\n  $c\n})"
let g:wpsnippets2["typst"]["auto"] = "#set page(width: 200pt, height: auto)"
let g:wpsnippets2["typst"]["imp"] = "import \"base-utils.typ\": *"
let g:wpsnippets2["typst"]["pan"] = "#panic($1)"
let g:filedict["bu"] = "/home/kdog3682/2024-typst/src/base-utils.typ"
let g:filedict["tt"] = "/home/kdog3682/2024-typst/src/template.typ"
let g:filedict["ut"] = "/home/kdog3682/PYTHON/utils.py"
let g:linkedBufferGroups["mmgg-morning-walk.typ"] = "jieba_script.py"
let g:linkedBufferGroups["jieba_script.py"] = "mmgg-morning-walk.typ"

let g:wpsnippets2["typst"]["measure"] = "style(styles => {\n    let measurement = measure($1, styles)\n    $c\n})"
let g:filedict["cj"] = "/home/kdog3682/2024/clip.json"


function! ChangeDirectoryBasedOnFilePath()
    " Get the full path of the current file
    let fullPath = expand('%:p')

    let dirs = []

    " Check if path starts with '~/'
    let homeShortcut = '~/'
    let homeDir = $HOME . '/'
    if fullPath[:len(homeShortcut) - 1] == homeShortcut
        let fullPath = substitute(fullPath, homeShortcut, homeDir, '')
    endif

    " Iterate through the path and construct the directory list
    while fullPath != '/' && fullPath != homeDir
        " Add the directory to the list
        let dirs = [fullPath] + dirs

        " Move up one directory
        let fullPath = fnamemodify(fullPath, ':h')
    endwhile

    " Show the list to the user and get the selection
    let idx = Choose(dirs)
    if idx > 0 && idx <= len(dirs)
        " Change the directory
        execute 'cd ' . dirs[idx - 1]
    endif
endfunction

" Map the function to the key '7' in normal mode
" nnoremap 7 :call ChangeDirectoryBasedOnFilePath()<CR>

let g:vimCurrentTestFunction = "InsertOW"
let g:linkedBufferGroups["manifest.json"] = "background.js"
let g:linkedBufferGroups["background.js"] = "manifest.json"

let g:linkedBufferGroups["world.js"] = "art.js"
let g:linkedBufferGroups["art.js"] = "world.js"


function! VimGrep()
    let dir = "/home/kdog3682/PYTHON/"
    let dir = "/home/kdog3682/2024-python/"
    let query = "timedelta"
    let cmd = printf('grep -r "%s" %s > grep.txt', query, dir)
    let value = systemlist(cmd)
    ec value
    " call AppendBelow('.', value)
endfunction


function! ZipDirectory(dirPath, zipLocation)
    let dirPath = a:dirPath
    let zipLocation = a:zipLocation 
    let cmd = 'rtar -czf ' . zipLocation . ' ' . dirPath
    " ec cmd
    " return
    let result = system(cmd)
    ec result
    if v:shell_error == 0
        echo "Directory zipped successfully to " . zipLoc
    else
        echoerr "Failed to zip the directory"
    endif
endfunction

" let file = '/home/kdog3682/2024-chrome-extensions/web-nanny/0.0.1/'
" let out = '/home/kdog3682/2024-chrome-extensions/web-nanny/0.0.1/package./'
" call ZipDirectory(file, out)



function! Sdfsdfjk()
    call GitPushDirectory('/home/kdog3682/2024-writing/')
endfunction

function! ResetGit()
    call GitCommand('git rm -r --cached .')
endfunction
let g:execRef2["rgi"] = "ResetGit"
let g:linkedBufferGroups["mathDialogueTransformer.js"] = "percent-more-percent-less.txt"
let g:linkedBufferGroups["percent-more-percent-less.txt"] = "mathDialogueTransformer.js"

let g:execRef2["temp"] = "SetVimSpeaker"


let g:execRef2["ivs"] = "InitializeVimSpeakers"
let g:execRef2["cds"] = "CreateDialogueSection"
nnoremap edt :call OpenBuffer4('/home/kdog3682/2024/dump.txt')<CR>
let g:filedict["lop2"] = "/home/kdog3682/2023/lazyObjectParser2.js"
let g:system_exec_ref = {}
let g:system_exec_ref["gs"] = "git status"
let g:system_exec_ref["gs"] = "GetGitFiles"
let g:execRef2["fs"] = "FindSnippet"
let g:execRef2["fah"] = "FindAnythingHandler"
let g:system_exec_ref["gca"] = "git commit -a -m \"$prompt\""
let g:execRef2["gitdiff"] = "GitDiff"
let g:execRef2["fgd"] = "FullGitDiff"
let g:execRef2["ga"] = "GitAddCurrentFile"
let g:filedict["tj"] = "/home/kdog3682/2024/tests.json"
let g:execRef2["gpcd"] = "GitPushCurrentDirectoryBasedOnMainFile"
let g:execRef2["fvf"] = "FVF"
let g:execRef2["glt"] = "GitLoremTest"
let g:execRef2["gpt"] = "GitProductionTest"
let g:execRef2["gpcf"] = "GitPushCurrentFile"
let g:filedict["ft"] = "/home/kdog3682/2024/file-table.txt"
let g:filedict["rt"] = "/home/kdog3682/2024-typst/src/render.typ"
let g:execRef2["cd"] = "CD"
let g:filedict["jv"] = "/home/kdog3682/.vim/ftplugin/javascript.vim"


" function RegexGetter()
    " return 1
" endfunction
function! VimTextStateObject(...)
    let number = line('.')
    let s = a:0 >= 1 ? a:1 : getline(number)
    let pos = col('.') - 1

    let back_ch = s[pos - 3]
    let current_ch = s[pos - 2]
    let next_ch = s[pos - 1]
    " call input(json_encode({"number": number, "s": s, "pos": pos, "back_ch": back_ch, "current_ch": current_ch, "next_ch": next_ch}))

    let front =  strpart(s, pos)
    let back = strpart(s, 0, pos)
    let trimmed = trim(s)
    let trimmedBack = trim(back)
    let trimmedFront = trim(front)
    let spaces = Match(s, '^ *')
    let ind = len(spaces)
    " @bookmark 1709331717 vto
    let data = {
        \"getset": {Fn -> setline(number, Fn(data))},
        \"match": {k -> Match(s, RegexGetter(k))},
        \"sub": {r, Fn -> Substitute(s, r, Fn)},
        \"replace_line": {payload -> ReplaceBlock(number, payload, 1)},
        \"set_line": {payload -> setline(number, Test(payload, '^ +') ? payload : spaces . payload)},
        \"replace": {x,y -> setline(number, Substitute(s, x, y))},
        \"empty": len(trimmed) == 0,
        \"line": {
         \   'text': s, 
         \   'trimmed': trimmed, 
         \   'spaces': Match(s, '^ *'), 
          \  'number': number, 
          \  'lnum': number, 
           \ 'length': len(s),
           \ 'has': {x -> Test(s, x)},
        \}, 
       \ 'char': {
        \    "pos": pos, 
         \   "prev": back_ch, 
          \  "current": current_ch, 
           \ "next": next_ch
        \},
        \'front': {
         \ 'empty': empty(trimmedFront),
         \ 'text': front,
         \ 'word': { -> Match(trimmedFront, '^[a-z]\w+$') },
         \ 'isword': { -> Test(trimmedFront, '^[a-z]\w+')},
         \'has': {x -> len(x) == 1 ? x == next_ch : Test(trimmedFront, x)},
         \ 'trimmed': trimmedFront, 
          \'test': {x -> Test(trimmedFront, x)},
          \'is': {x -> x == trimmedFront },
        \},
        \'back': {
         \ 'empty': empty(trimmedBack),
         \ 'isword': { -> Test(trimmedBack, '^[a-z]\w+$')},
         \ 'text': back,
         \ 'word': { -> Match(trimmedBack, '[a-z]\w+$') },
         \ 'trimmed': trimmedBack,
          \'test': {x -> Test(trimmedBack, x)},
          \'has': {x -> len(x) == 1 ? x == prev_ch : Test(trimmedBack, x)},
          \'is': {x -> x == trimmedBack },
        \},
        \'ind': ind,
        \'endswith': {x -> Test(s, x . '$')},
        \'startswith': {x -> Test(s, '^ *' . x)},
        \'has': {x -> Test(s, EscapeRegexEqual(x))},
        \'test': {x -> Test(s, x)},
        \'sosall': { -> Sosall(s)},
        \'gcw': { -> expand('<cword>')},
        \'first': { -> Match(s, '^\W*\zs\w+')},
        \'last': { -> Match(s, '\w+\ze\W*$')},
        \'deleteEndingSpaces': { -> BackspaceExpr(Match(back, '\S\zs *$'))}
    \}
    return data
endfunction


function! TypstMathSmartEqual()
" @bookmark 1707418745 TypstMathSmartEqual
    let state = VimTextStateObject()
    " ec state

    if state.endswith('[?<>!=] *')
        return state.deleteEndingSpaces() . "= "
    endif

    " if state.ind == 0
        " return g:keyboard.reset . '#let ' . state.line.text . g:keyboard.equals
    " endif

    return state.deleteEndingSpaces() . " = "
    return " = "
/home/kdog3682/2024/td.q15.math
    
endfunction
" @bookmark 1707418745 TypstMathSmartEqual
let g:wpsnippets2["javascript"]["fm"] = "---\n$c\n---"
let g:filedict["tclip"] = "/home/kdog3682/2024-typst/src/clip.typ"
let g:execRef2["cob"] = "CloseOldBuffers"

function! SmartEqual()

    " let o = "if (mode == 'debug' || mode) {"
    let state = VimTextStateObject()
    " return state

    " call input(string(state))
    " if state.endswith('[?<>!=] *')
        " if state.startswith('const')
            " return g:keyboard.delete_first_word . state.deleteEndingSpaces() . ' '
        " endif
        " return state.deleteEndingSpaces() . "= "
    " endif

    let prefix = JP('prefix')
    " ec input(state.startswith('if'))

    " @bookmark 1709331717 vto
    if state.startswith('(const|var|let|if|else|for|while|do)>')
        " call input(string(state.back.endswith('=')))
        " if state.back.test('\= *$')
            return state.deleteEndingSpaces() . "= "
        " endif
        return state.deleteEndingSpaces() . " == "
    elseif state.front.empty
   " call input(string(state.front.empty))
        let equal_dictionary_ref = JP('equal_dictionary')
        if has_key(equal_dictionary_ref, state.back.trimmed)
            let [before, after] = equal_dictionary_ref[state.back.trimmed]
            return g:keyboard.reset . prefix . before . ' = ' . after
        elseif state.startswith('(let)')
            return state.deleteEndingSpaces() . " = "
        elseif state.startswith('(const|var|let|if|else|for|while|do)>')
           " throw 's'
            " call input(string(state.back.endswith('=')))
            if state.back.endswith('=')
                return state.deleteEndingSpaces() . "= "
            endif
            return state.deleteEndingSpaces() . " == "
        elseif state.startswith('%([a-z]\w*$|[\[\{])') && !state.back.has(prefix)
            return "\<C-O>I" . prefix . "\<C-O>A = "
        else
            return ' = '
        endif
    elseif state.back.isword() && state.back.trimmed != prefix
        return g:keyboard.reset . prefix . state.back.trimmed . ' = ' . state.front.trimmed
    elseif state.endswith('[<>?=]')
        return state.deleteEndingSpaces() . "= "
    else
        return ' = '
    endif
endfunction

let g:keyboard.delete_first_word = "\<C-O>I " . g:keyboard.esc . 'v/ ' . g:keyboard.left . g:keyboard.enter . "d " . "\<C-O>A"



function! Substitute(s, r, replacement, ...)
    let flags = a:0 >= 1 ? a:1 : 'g'
    return substitute(a:s, '\v' . a:r, a:replacement, flags)
endfunction
function! EscapeRegexEqual(s)
    "test: ' = '
    let s = a:s
	return Substitute(s, '[={]', {x -> '\\' . x[0]})
endfunction

function! FindGetCommentsTextWithGrep()
endfunction


let g:denops_server_addr = '127.0.0.1:32123'
let g:denops#deno = '/home/kdog3682/.deno/bin/deno'
call plug#begin()
    Plug 'junegunn/vim-easy-align'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'https://github.com/AndrewRadev/simple_bookmarks.vim'
    " needs a higher vim version to use these
    " Plug 'vim-denops/denops.vim'
    " Plug 'vim-denops/denops-helloworld.vim'

    " Plug 'jayli/vim-easycomplete'
    " Plug 'SirVer/ultisnips'
    " Plug 'https://github.com/msanders/snipmate.vim'
    " Plug 'https://github.com/drmingdrmer/xptemplate'
    " Plug 'https://github.com/tpope/vim-surround'
    " <plug>(fzf-maps-n)
    " Plug 'lifepillar/vim-mucomplete'
call plug#end()
syntax off




function! Goyo()
    Goyo
endfunction

function! WriteOldFiles()
    call WriteFile('/home/kdog3682/2024/oldfiles.txt', v:oldfiles)
endfunction
function! _AppendFileName(file, extra)
    let file = a:file
    let extra = a:extra
    return Head(file) . '/' . RemoveExtension(Tail(file)) . extra . '.' . GetExtension2(file)
endfunction

function! CopyFile(a, b)
     call system(printf('cp %s %s', a:a, a:b))
     return a:b
endfunction
function! VimFileStateObject()
    let payload = {}
    let filepath = expand('%')
    let dir = fnamemodify(filepath, ':h') . '/'
    let ext = fnamemodify(filepath, ':e')
    let tail = fnamemodify(filepath, ':t')
    let root = fnamemodify(filepath, ':r')
    let name = RemoveExtension(tail)
    if Empty(name)
        let name = tail
    endif
    function! Get_name_version(name)
        let name = a:name
        if Test(name, 'v\d')
            return 'v3'
        endif
        return 'v2'
    endfunction
    let payload['append_file_name'] = {x -> dir . root . x . Exists(ext) ? '.' . ext : ''}
    let payload['next_ver'] = { -> dir . name . '-' . Get_name_version(root) . (Exists(ext) ? '.' . ext : '')}
    let payload['dup'] = {x -> CopyFile(filepath, x)}
    let payload['open'] = {x -> OpenBuffer(x) }
    let payload['dir'] = dir
    let payload['ext'] = ext
    let payload['tail'] = tail
    let payload['path'] = filepath
    return payload
endfunction

let g:javascript_equal_dictionary = {
    \'ggg': ['ccc', 'aaa'],
    \'xy': ['[x, y]', ''],
    \'wh': ['[w, h]', ''],
    \'sto': ['storage', 'new Storage()'],
    \'tally': ['tally', 'new Tally()'],
    \'cache': ['cache', 'new Cache()'],
    \'store': ['store', '[]'],
    \'gggg': ['[a,b]', 'aaa'],
    \'ab': ['[a, b]', ''],
    \'abc': ['[a, b, c]', ''],
    \'so': ['[first, rest]', "splitOnce()\<LEFT>"],
\}
let g:vim_equal_dictionary = {
    \'to': ['to', 'VimTextStateObject()'],
\}

let g:typst_equal_dictionary = {
    \'store': ['store', '()'],
\}
function! DupTheFile()
    let f = VimFileStateObject()
    return f.open(f.dup(f.next_ver()))
endfunction
let g:execRef2["dup"] = "DupTheFile"

let g:linkedBufferGroups["functions.typ"] = "typst-math-assignment-parser-v2.js"
let g:linkedBufferGroups["typst-math-assignment-parser-v2.js"] = "functions.typ"

let g:execRef2["ct"] = "CompileTypstFromJavascript"
let g:wpsnippets2["math"] = {}
let g:wpsnippets2["math"]["fm"] = "---\n$c\n---"


function! FTEF_Typst_Five()
    let state = VimTextStateObject()
    if state.char.prev == '5'
        return g:keyboard.bs . '%'
    endif
    return '5'
endfunction
let g:linkedBufferGroups["td.q15.math"] = "functions.typ"
let g:linkedBufferGroups["functions.typ"] = "td.q15.math"

let g:wpsnippets2["typst"]["ta"] = "let table-attrs = (\n    align: auto,\n    column-gutter: auto,\n    row-gutter: auto,\n    columns: 2,\n    fill: auto,\n    stroke: (\n        top: none,\n        left: none,\n        right: none,\n        bottom: none,\n    ),\n    rows: auto,\n)"

let g:wpsnippets2["typst"]["ba"] = "let box-attrs = (\n    inset: 3pt,\n    outset: 0pt,\n    fill: none,\n    radius: 0pt,\n    stroke: black,\n)"


let g:execRef2["tt"] = "ToggleTypst"


function! TypstColorWrap()
    let state = VimTextStateObject()
    return state
    let back = state.back.trimmed
    call input('back: ' . back)
    return 
    asdf
endfunction



function! WrapCurrentCharWithBlue()
    if ToggleColor()
        return 
    endif
  let cursorPos = getpos(".")
  let char = getline('.')[cursorPos[2] - 1]
  let replacement = '#xblue(' . char . ')'
  call setline('.', substitute(getline('.'), '\%' . cursorPos[2] . 'c.', replacement, ''))
  call setpos('.', cursorPos)
  " adfadsfasdfadsf a#orange(b)c
endfunction

function! ToggleColor()
  " Define an array of colors to cycle through
  let colors = ['red', 'green', 'blue', 'yellow', 'purple', 'orange']
  let colors = ['blue', 'green', 'blue']

  " Get the current word under the cursor
  let currentWord = expand('<cword>')

  " Find the index of the current word in the colors array
  let currentIndex = index(colors, currentWord)

  " If the current word is a color, toggle to the next color
  if currentIndex != -1
    " Calculate the index of the next color
    let nextIndex = (currentIndex + 1) % len(colors)

    " Get the next color
    let nextColor = colors[nextIndex]

    " Replace the current word with the next color
    " We use the '\<...\>' regex to match the whole word exactly
    let line = getline('.')
    let line = substitute(line, '\<'.currentWord.'\>', nextColor, '')
    call setline('.', line)
    return 1
  endif
endfunction

let g:execRef2["wb"] = "WrapCurrentCharWithBlue"



function TypstCreateFunctionBlock()
    let s = VimTextStateObject()
    let t = "let %s(%s) = {\<CR>}\<CR>\<ESC>?{\<CR>o    "
    let before = "\<ESC>O"
    if s.front.test('^\w*\)')
        let ref = {}
        let raw_arg_string = Prompt('args?', 'x')
        let arg_string = get(ref, raw_arg_string, raw_arg_string)
        let value = printf(before . t, s.gcw(), arg_string)
        return value
    endif
    let [a, b] = s.sosall()
    return printf(g:keyboard.reset . g:keyboard.hash . t, a, join(b, ', '))
endfunction
let g:keyboard.hash = '#'

function! s:string(s)
    let s = a:s
    return json_encode(s)
endfunction
function! TypstNormalCreateFunctionWrapping()
    let to = VimTextStateObject()
    let key = to.match('callable')
    let style_object = g:typst_style_ref[key]

    let name = key . '-attrs'
    let insert_str = '..' . name . ', '
    let a = trim(to.sub(key . '\(\zs', insert_str))
    let b = BuildExprObjectString(name, style_object)
    let args = [b, a]
    call KeyboardTemplater('delete_to_start $1 go_down $2', args, 1)

endfunction
function! TypstCreateFunctionWrapping()
    """ 02-13-2024
    """ input: return columns(2, ..column-attrs, enumGroup)
    """ becomes:
    """ return block(..attrs, columns(2, ..column-attrs, enumGroup))
    """ type: expr

    let to = VimTextStateObject()
    let key = to.back.word()
    call input(json_encode([key, to.back.text]))
    let attr_name = key . '-attrs'
    let attr_str = '..' . attr_name . ', '
    let style_object = g:typst_styles_ref[key]
    " call input(json_encode(style_object))
    let attr_object = BuildExprObjectString(attr_name, style_object)
    let args = [attr_str, attr_object]
    let a = KeyboardTemplater('lp $1 go_to_end rp insert_above $2', args)
    return a
endfunction
function! BuildExprObjectString(name, obj)
    """ 02-13-2024
    """ builds a typst object
    """ 
    """ 
    """ 
    """ 
    let name = a:name
    let obj = a:obj
    let s = printf('let %s = ', name)
    function! s:inner(obj)
        " let final_enter = "\<CR>\<BS>"
        let initial_enter = "\<c-o>o\t"
        let obj = a:obj
        let s = ''
        let s .= '('
        let s .= initial_enter
        for [k,v] in items(obj)
            let s .= k . ': '
            if IsString(v)
                let s .= printf("%s", TypstAddQuotes(v))
            elseif IsNumber(v)
                let s .= printf("%s", v)
            elseif IsObject(v)
                let s .= s:inner(v)
            endif
            let s .= ',' . "\<c-o>o"
        endfor
        let s .= "\<BS>"
        let s .= ')'
        return s
    endfunction

    let s .= s:inner(obj)
    return s
    "let block-attrs = (\<ESC>o\tabc: \"hi\",\<CR>\<BS>)"}
endfunction
let g:typst_styles_ref = {'block': {'gg': 'xx', 'abc': '3pt', 'dd': {'aa': 11}}}

let g:jspyref3["vim"]["equal_dictionary"] = g:vim_equal_dictionary
let g:jspyref3["typst"]["equal_dictionary"] = g:typst_equal_dictionary
let g:jspyref3["python"]["equal_dictionary"] = {}
let g:jspyref3["javascript"]["equal_dictionary"] = g:javascript_equal_dictionary
function! KeyboardTemplater(s, ref = [1,2], executeIt = 0)
    "test: lp $1 go_to_end rp insert_above $2
    let executeIt = a:executeIt
    let s = a:s
    let ref = a:ref
    let t = 'has_key(g:keyboard, v:val) ? g:keyboard[v:val] : ref[v:val[1:] - 1]'
    let value = join(map(Split(s, ' +'), t), '')
    if executeIt
        execute 'normal! ' . value
    else
        return value
    endif
endfunction
let g:keyboard.lp = '('
let g:keyboard.rp = ')'
let g:keyboard.delete_to_start = '^Da'
let g:keyboard.go_down = "\<C-O>o"
let g:keyboard.insert_above = "\<ESC>O"
let g:keyboard.go_to_end = "\<C-O>$"
function! TypstAddQuotes(v)
    let v = a:v
    let r = '%(pt|em|\%|px|none|auto|left|top|bottom|right|black|blue|green|red)$'
    return Test(v, r) ? v : DoubleQuote(v)
endfunction

function! RunDictFunc(ref, key, ...)
    let ref = a:ref
    let key = a:key
    return call(function(ref[key]), a:000)
endfunction
function! TypstSmartEnter2()
    return
    let state = VimTextStateObject()

    let [PosteriorRef, AnteriorRef] = g:typst_enter_refs
    let first = state.first()
    if first in PosteriorRef 
        let items = state.sosall()[1]
        return RunDictFunc(PosteriorRef, first, state, items)
    endif

    let last = state.last()
    if last in AnteriorRef
        let items = state.sosall_reverse()[1]
        return RunDictFunc(AnteriorRef, last, state, items)
    endif

endfunction


function! LocateSnippet(key)
    let key = a:key
    
endfunction
function! LocateMapKey(key)
    "test: w,
    "test: <leader>d
    let key = a:key
    return maparg('w,', 'i', 0, 1)
endfunction
function! LocateDictKey(key)
    "test: tsa
    let key = a:key
    let refs = [
        \g:execRef2,
        \g:execRef,
    \]
    for item in refs
        if has_key(item, key)
            return item[key]
        endif
    endfor
endfunction

function! LocateDictFunction(key)
    "test: tsa
    let key = a:key
    let fnKey = LocateDictKey(key)
    call FindVimFunctionInVimFiles(fnKey)
endfunction
let g:linkedBufferGroups["td.q16.math"] = "mathDialogueTransformer.js"
let g:linkedBufferGroups["mathDialogueTransformer.js"] = "td.q16.math"

let g:linkedBufferGroups["td.q16.math.compiled"] = "td.q16.math"
let g:linkedBufferGroups["td.q16.math"] = "td.q16.math.compiled"

let g:filedict["lgt"] = "/home/kdog3682/2023/lezer-getTree.js"

function! CutLineAtCursorAndSetValueOnTop()
    let to = VimTextStateObject()
    let s:_name = Prompt('choose a name for this value', 'value')
    let s:_match = ''

    function! s:inner(x)
        let s = a:x
        let s:_match = s[0]
        return s:_name
    endfunction
    let r = printf('\(\zs%s.{-}\ze\) *$', to.gcw())
    let val = to.sub(r, function('s:inner'))
    let var = printf('let %s = %s', s:_name, s:_match)
    let payload = [var, trim(val)]
    return to.replace_line(payload)
endfunction
call add(g:lineEditCommands, "CutLineAtCursorAndSetValueOnTop")


let g:execRef2["wof"] = "WriteOldFiles"


function! RegexGetter(key)
    let dict = {
        \'': '^ *$',   
        \'callable': '[a-z]\w+\ze\(',   
    \}
    return get(dict, a:key, a:key)
endfunction

function! TypstNormalToggle()
    let to = VimTextStateObject()
    let [a,b] = SplitOnce(to.line.trimmed, ':')
    if Exists(b)
        return to.replace(b, ' ' . 'howdy')
    endif
          'asdfasdfadsf: howdy

endfunction
let g:wpsnippets2["typst"]["lo"] = "let $1 = kwargs.at(\"$1\", default: none)"

function! GetToplevelBlockIndexes()
    let f = CreateFLI()
    call f.up('^\w')
    call input('f: ' . s:string(f))
    call f.down('empty')
    let value = f.value()
    return value
endfunction
nnoremap dg :call DeleteBlock(GetToplevelBlockIndexes())<CR>


function! CreateFLI()
    let s:a = 0
    let s:b = 0

    function! s:get(k)
        let k = a:k
        let ref = {
            \"empty": {
                \"regex": '^\S+',
                \"backtrack": '\S+',
            \},
        \}
        return IsWord(k) ? ref[k] : {'regex': k}
    endfunction
    function! s:down(k)
        let k = s:get(a:k)
        let ind = FliDown(k.regex)
        call input('ind: ' . s:string(ind))
        let s = getline(ind)
        if s == "}"
            let s:b = ind
            return ind
        endif

        if has_key(k, 'backtrack')
            let ind = FliUp(k.backtrack, ind)
        endif
        let s:b = ind
        return ind
    endfunction

    function! s:up(k)
        let k = s:get(a:k)
        let ind = FliUp(k.regex)
        let s:a = ind
        return ind
    endfunction

    function! s:value()
        return [s:a, s:b]
    endfunction

    return { 'up': function('s:up'), 'down': function('s:down'), 'value': function('s:value'), }
endfunction


let g:wpsnippets2["javascript"]["cs"] = "console.s = `\n$c\n`\nconsole.test2($1)"
let g:wpsnippets2["typst"]["forkv"] = "for (k, v) in $1 {\n    $c\n}"

let g:filedict["v3"] = "/home/kdog3682/2023/typst-math-assignment-parser-v3.js"
nnoremap ev3 :call OpenBuffer4('/home/kdog3682/2023/typst-math-assignment-parser-v3.js')<CR>
nnoremap ect :call OpenBuffer4('/home/kdog3682/2024-typst/src/clip.typ')<CR>
let g:filedict["git3"] = "/home/kdog3682/2024-python/GithubController.py"
let g:filedict["sc3"] = "/home/kdog3682/2023/StateContext3.js"
nnoremap ewp :call OpenBuffer4('/home/kdog3682/PYTHON/workspace.py')<CR>
nnoremap edp :call OpenBuffer4('/home/kdog3682/PYTHON/dirs.py')<CR>
nnoremap epu :call OpenBuffer4('/home/kdog3682/PYTHON/utils.py')<CR>
nnoremap ewp :call OpenBuffer4('/home/kdog3682/PYTHON/workspace.py')<CR>


function! OpenBuffer(buffer)
    let buffer = a:buffer
    let prefix = bufexists(buffer) ? 'buffer! ' : 'edit! '
    let cmd = prefix . buffer
    execute cmd
endfunction
function! ResetNode7()
    ec "resetting node7"
    unlet g:node7files
endfunction
function! Node7()
    if exists('g:node7files') && Exists(g:node7files)
        let g:node7file = ModularIncrement2(g:node7files, g:node7file, 1)
    else
        let dir = '/home/kdog3682/2024-javascript'
        let dires = Globber(dir, 'IsDir')
        let dir = Choose100(dires)
        if empty(dir)
            return 
        endif
        let g:node7files = Globber(dir, 'IsFile')
        let g:node7file = g:node7files[0]
    endif

    ec g:node7file
    return OpenBuffer(g:node7file)
endfunction

function! Yes(...)
    return 1
endfunction
function! Globber(dir, fnkey= "IsFile", regex = 'node_modules')
    let dir = Substitute(a:dir, '/$', '')
    let files = split(glob(dir . '/*'), '\n')
    return filter(files, a:fnkey . '(v:val) && !Test(v:val, a:regex)')
endfunction
nnoremap <buffer> 7 :call Node7()<CR>
nnoremap 7 :call Node7()<CR>
inoreab <buffer>cf CurrentFile()<LEFT><C-R>=Eatchar('\s')<CR>
let g:execRef2["n7"] = "Node7"
let g:execRef2["rn7"] = "ResetNode7"
let g:execRef2["fa"] = "FindAnythingHandler"
let g:execRef2["ls"] = "LSDirectory"


silent call SimpleHighlighting()

    " let font = color == "bold" ? "cterm" : "ctermfg"
    " let cmd = printf('highlight %s %s=%s', name, font, color)
    " call s:highlight_syntax("simple_comment", "^ *//.*", "gray")
let g:linkedBufferGroups["lexer.js"] = "parser.js"
let g:linkedBufferGroups["parser.js"] = "lexer.js"

let g:linkedBufferGroups["handlers.js"] = "lexer.js"
let g:linkedBufferGroups["lexer.js"] = "handlers.js"

set smartindent
let g:execRef2["uso"] = "Uso"


function! JSS_tr()
    let t = GetSnippet("tr")
endfunction
let g:wpsnippets2["javascript"]["tr"] = "import { testRunnerMultiple } from \"./testRunner.js\"\ntestRunnerMultiple({\n    inputs: $str,\n    fn: $fn,\n    name: $file,\n})"






function! CompileMathToRaw()
    
endfunction
function! CompileMathToProduction()
    
endfunction

function! SetupPackageManagerFunctionCaller()
    """ 02-19-2024
    """ this will initialize a certain file 
    """ as the source for function calls
    """ 
    """ trigger: pm

    let file = GetOrSetGVariable('package_manager_file', "$file")
endfunction


function! TildaPath(x)
    let x = a:x
    return Substitute(x, '/home/kdog3682', '~')
endfunction
function! Map(items, ...)
    let s = 'v:val'
    for item in a:000
        let s = item . '(' . s . ')'
    endfor
    return map(a:items, s)
endfunction
function! BufferString(s)
    let buffers = GetActiveBuffers()
    let buffers = map(Map(buffers, 'expand'), "Substitute(v:val, '^/home/kdog3682', '~')")
    let buffers = filter(buffers, "v:val[0]== '~'")
    return join(sort(buffers), "\n")
endfunction
let g:filedict["todo"] = "/home/kdog3682/2024/todo.txt"
let g:wpsnippets2["text"] = {}
let g:wpsnippets2["text"]["buffers"] = "BufferString"

let g:filedict["gloss"] = "/home/kdog3682/2024/glossary.txt"
let g:filedict[".gloss"] = "/home/kdog3682/2024/.glossary.txt"
let g:filedict[".notes"] = "/home/kdog3682/2024/.notes.txt"
let g:filedict[".g"] = "/home/kdog3682/2024/.glossary.txt"
let g:filedict[".n"] = "/home/kdog3682/2024/.notes.txt"
function! Save()
    call WriteNotes6('!important $file')
endfunction
let g:execRef2["save"] = "Save"
nnoremap ejw :call OpenBuffer4('/home/kdog3682/2023/workspace.js')<CR>
let g:filedict["ffr"] = "/home/kdog3682/2024/ffr-simple.json"
let g:execRef2["asc"] = "AppendSpellcheckJSON"

function! TtpAutocomplete()
  let l:matches = ['ttpla', 'ttplb']
  call complete(col('.'), l:matches)
  return ''
endfunction


function! Fooo()
    execute 'inoremap <expr> ttp TtpAutocomplete("ttp", [1,2,3])'
endfunction
function! TTPAutocomplete(trigger, choices)
    let trigger = a:trigger
    let choices = a:choices
  call feedkeys(BackspaceExpr(trigger), 'n')
  let displayedChoices = map(copy(choices), {i,s -> (i + 1) . '. ' . s})
  let choiceIndex = inputlist(displayedChoices)
  call feedkeys(choices[choiceIndex - 1], 'n')
  return ''
endfunction

function! GetLastModifiedDate()
    " Get the current file name
    let l:filename = expand('%')

    " Construct and execute the Git command
    " git log -1 --format=%cd -- <file_path>
    " %cd is the committer date
    " You might need to customize the date format based on your preferences
    let l:command = 'git log -1 --format="%cd" -- ' . l:filename
    let l:lastModifiedDate = system(l:command)

    " Check for errors or empty result
    if v:shell_error || l:lastModifiedDate == ""
        echo "Unable to find the last modified date."
    else
        " Trim the result to remove any trailing newline
        let l:lastModifiedDate = substitute(l:lastModifiedDate, '\n\+$', '', '')
        echo "Last Modified Date: " . l:lastModifiedDate
    endif
endfunction


let g:execRef2["lmd"] = "GetLastModifiedDate"

let g:execRef2["fma"] = "FindMapArg"
nnoremap 0 :w<CR> :call Node0()<CR>
let g:wpsnippets2["typst"]["imp"] = "#import \"base-utils.typ\": *"
let g:wpsnippets2["typst"]["i"] = "ImportTypst"
let g:execRef2["sof"] = "SetOverrideFile"
let g:execRef2["compile"] = "CompileTypstFromStartToFinish"
let g:execRef2["mvo"] = "MoveOut"
let g:filedict["vbu"] = "/home/kdog3682/2024-typst/src/very-base-utils.typ"
let g:execRef2["ac"] = "AppController"
let g:wpsnippets2["typst"]["p1"] = "panic(1)"
let g:execRef2["gtc"] = "GitTempCheckout"
let g:execRef2["eb"] = "ExtractBlock"
let g:execRef2["jsi"] = "JSImport2024"
let g:wpsnippets2["javascript"]["dirs"] = "[ \"top\", \"right\", \"left\", \"bottom\", \"x\", \"y\"]"
let g:execRef2["tbu"] = "TempBackup"
let g:filedict["cabmap"] = "/home/kdog3682/2023/cabmap.js"
let g:vimFunctionAliases["vs"] = "GetVimState"
let g:vimFunctionAliases["word"] = "GetCurrentWord"
let g:vimFunctionAliases["strftime"] = "TimeStamp"
let g:execRef2["noc"] = "Node0Controller"

function! GoDotFile(file)
    let file = "/home/kdog3682/2024/." . a:file
    call OpenBuffer3(file)
endfunction

function! GoWorkspaceFile()
    return OpenBuffer('/home/kdog3682/2024-javascript/staging/workspace.js')
endfunction

nnoremap e.n :call GoDotFile("notes.txt")<CR> 
nnoremap e.fn :call GoDotFile(&filetype . "-function-notes.txt")<CR> 
"go to the general note file
nnoremap <leader>n :call FunctionNote("")<LEFT><LEFT>
nnoremap <leader>ng :call GlossaryNote("")<LEFT><LEFT>

function! FunctionNote(message)
    "test: asdf
    let message = trim(a:message)
    let length = len(message)
    if length < 3
        ec printf('A FunctionNoteEntry need to have a length of 10 or more for the message. The length of this message "%s" was only %s characters.', message, length)
        return 
    endif

    let s = VT('$strftime [$word]: $1', message)
    call AppendFile(GetLangNoteFile(), s)
endfunction

function! GetLangNoteFile()
    let outpath = VT('$dir2024/.$filetype-function-notes.txt')
    return outpath
endfunction
let g:gfgfdict['ob'] = ['/home/kdog3682/2024-typst/src/mmgg-morning-walk.typ', '', 0]
let g:gfgfdict['ob'] = ['/home/kdog3682/2024-typst/src/mmgg-morning-walk.typ', '', 0]
let g:execRef2["ic"] = "InsertAtCursorFuzzyFoundFile"
let g:execRef2["ita"] = "InsertTextAtCursor"
let g:wpsnippets2["javascript"]["s"] = "JSTestString"

function! JSTestString(...)
    let template = "const s = `\n$cursor\n`\nconsole.log($chooseFunc(s))"
    return VT(template)
endfunction
let g:execRef2["H"] = "CapitalHelpNotes"
let g:execRef2["gsr"] = "SetGConfigRawFile"
function! CreateEvalEnvTestFileForJavascript()
    let s = "import * as main from \"/home/kdog3682/2024-javascript/$1/main.js\"\nimport evalenv from \"/home/kdog3682/2024-javascript/evalenv/main.js\"\nevalenv({modules: main})"
    let importPath = VT('$head/main.js')
    call AssertFile(importPath)

    let h = Head()
    let name = GetLastWord(h)
    let value = VT(s, name)
    let outpath = h . '/test.js'
    call WriteFile(outpath, value)
endfunction
let g:execRef2["cenv"] = "CreateEvalEnvTestFileForJavascript"
function! AssertMatch(s, r, anti = 0)
    let s = a:s
    let r = a:r
    let anti = a:anti
    let m = Test(s, r)
    if anti
        if m
            throw VT('AssertionMatchError: "$1" is not allowed to match "$2"', r, s)
        endif
    else
        if !m
            throw VT('AssertionMatchError: "$1" does not match "$2"', r, s)
        endif
    endif
endfunction
function! AssertFile(file)
    let file = a:file
    if !IsFile(file)
        throw VT('AssertFileError: "$1" is not a file.', file)
    endif
endfunction

function! FzfDir2(directory)
    call fzf#run(fzf#wrap({'dir': a:directory, 'source': 'ls'}))
endfunction

function! FzfDir(directory)
    call fzf#vim#files(a:directory)
endfunction

function! AddSlash(s)
    let s = a:s
    return Test(s, '/$') ? '' : s . '/'
endfunction
function! Sinker(s)
    "test: foo
    throw 'hi'
    return AddSlash(s:dir) . Sub(a:s, '^./', '')
endfunction
function! FzfSimple(dir = 0)
    let dir = Exists(a:dir) ? a:dir : g:active_dir
    let h = FzfHelper(dir)
    call fzf#run(h)
endfunction
let g:execRef2["fzf"] = "FzfDir"
nnoremap <leader>f :call FzfDirectoryManager()<CR>
nnoremap <leader>i :call JSImport2024()<CR>
nnoremap <leader>s :call FzfSimple()<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:wpsnippets2["javascript"]["hi"] = "console.log('hi'); throw getCaller()"

function! SetIndentExpr()
    execute 'set indentexpr='
    ec 'fixing indent expr'
endfunction
let g:execRef2["sie"] = "SetIndentExpr"
let g:linkedBufferGroups["vueBlocks.js"]      = "/home/kdog3682/2024-javascript/vuekit/ComponentState.js"
let g:linkedBufferGroups["ComponentState.js"] = "/home/kdog3682/2024-javascript/txflow/vueBlocks.js"

let g:execRef2["sh"] = "SimpleShunt"

function! JuneGunnEasyAlign()
    :EasyAlign[=]
endfunction
let g:execRef2["eza"] = "JuneGunnEasyAlign"

" Mapping selecting mappings
" nmap <leader><tab> <plug>(fzf-maps-n)
" imap <c-x><c-f> <plug>(fzf-complete-path)

" Path completion with custom source command
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
function! FzfHelper(source, Sink = "e")
    let source = a:source
    let Sink = a:Sink

    let payload = {'window': {'width': 0.88, 'height': 0.8}, 'left': '50%'}
    if IsArray(source)
        let payload['source']  = source
    else
        let payload['source'] = 'find $(pwd) -regextype posix-extended -type f | grep -vE ''(fonts|\.git/|node_modules|\.log$|temp|pycache)'''
        let payload['dir'] = source
    endif
    if Exists(Sink)
        let payload["sink"]= Sink
    endif
    return payload
endfunction
inoremap <expr> ,f fzf#vim#complete(FzfHelper('/home/kdog3682/2024-javascript/'))


function! Fooga()
    ec "hi"
endfunction

nnoremap \\ :call Fooga()<CR>

function! SeeVimVersion()
    call GitCommandWrapper('vim --version')
endfunction


nnoremap ` :call FzfDir("/home/kdog3682/2024-javascript/")<CR>
nnoremap eb :call OpenBuffer4('/home/kdog3682/2024-javascript/txflow/vueBlocks.js')<CR>

function! SmartEqual2()

    let state = VimTextStateObject()

    if state.endswith('[?<>!=] *')
        return state.deleteEndingSpaces() . "= "
    endif

    if state.front.empty
        if state.startswith('^ *(const|var|let|if|else|for|while|do) ')
            if state.char.prev == "="
                return state.deleteEndingSpaces() . "= "
            endif
            return state.deleteEndingSpaces() . " == "
        else
            return ' = '
        endif
    elseif state.back.isword() && state.back.trimmed != prefix
        return g:keyboard.reset . prefix . state.back.trimmed . ' = ' . state.front.trimmed
    elseif state.back.test('[<>?=]')
        return state.deleteEndingSpaces() . "= "
    else
        return ' = '
    endif
endfunction

function! VueEnter()
    let state = VimTextStateObject()
    if state.empty
        return g:keyboard.enter
    elseif state.endswith(':')
        return g:keyboard.enter . state.line.spaces . '    '
    endif
    return g:keyboard.enter . state.line.spaces
endfunction

function! VueBrace()
    let state = VimTextStateObject()
    if state.endswith('[')
        return g:keyboard.bs . '{}' . g:keyboard.left
    endif
    return '['
endfunction
call add(g:lineEditCommands, "QuoteTheLine")
function! VueBrace()
    let state = VimTextStateObject()
    if state.endswith('[')
        return g:keyboard.bs . '{}' . g:keyboard.left
    endif
    return '['
endfunction
let g:filedict["vv"] = "/home/kdog3682/.vim/ftplugin/vue.vim"
let g:filedict["gmail"] = "https://gmail.com"
let g:filedict["web"] = "https://google.com"

function! VueFunction()
    
endfunction


" set completeopt+=menuone,noselect
" let g:mucomplete#user_mappings = { 'sqla' : "\<c-c>a" }
" let g:mucomplete#chains = { 'sql' : ['file', 'sqla', 'keyn'] }

" mut

function! Mut()
    MUcompleteAutoToggle
endfunction
let g:execRef2["mut"] = "Mut"


function! MyCustomComplete()
    return ['AbstractMethodError', 'bbb']
endfunction
	let g:mucomplete#user_mappings = {
	    \ 'sqla' : "\<c-c>a",
	    \ 'xyz'  : "\<c-r>=MyCustomComplete()\<cr>"
	    \ }

" let g:mucomplete#chains = { 'default': ['user', 'keyp'] }
" let g:mucomplete#enable_auto_at_startup = 0
" let g:mucomplete#minimum_prefix_length = 1

function! GoTestingFile()
    let h = GetLastWord(Head())
    let item = get(g:dirRef, h, 0)
    if Exists(item)
        call OpenBuffer3(item)
    endif
endfunction
let g:dirRef= {}
" let g:dirRef['txflow']=
nnoremap gtf :call GoTestingFile()<CR>


function! GetFileInfo()
    ec VT("getting file info for current file: $cf")

endfunction
let g:execRef2["info"] = "GetFileInfo"

function! Me()
    let keys = [
                \"woke",
                \"wake",
                \"dinner",
                \"idle",
                \"idle",
    \]

endfunction
let g:execRef2["me"] = "Me"

let g:linkedBufferGroups["components.txt.js"] = "vuetify.js"
let g:linkedBufferGroups["vuetify.js"] = "components.txt.js"

let g:execRef2["sjs"] = "SetFileTypeJavascript"
function! GetBufferNames()
	return GetActiveBuffers()
endfunction
let g:gfgfdict['ob'] = ['/home/kdog3682/2024-javascript/txflow/vueBlocks.js', 'someDepth', 0]
augroup css_autocmd
    autocmd!
    autocmd BufEnter *.css :call CssAutoEnter()
    autocmd BufWritePost  *.css call CssAutoEnter()
augroup END

function! ChooseFileAndThenDoSomething()
    
endfunction

function! _GetFZF(name)
    let g:fzf_sink= name
endfunction
function! IsCssFile(s)
    let s = a:s
    return GetExtension(s) == 'css'
endfunction
function! GetFZF(names)
    let names = a:names
    call fzf#run(FzfHelper(names, 'EchoArgument'))
    return g:fzf_sink
endfunction
function RunCommandViaFZF(arg)
    let arg = a:arg
    call function(arg)()
endfunction

function! EchoArgument(arg)
    let g:fzf_sink= a:arg
endfunction

command! -nargs=1 EchoArgument call EchoArgument(<f-args>)
command! -nargs=1 RunCommandViaFZF call RunCommandViaFZF(<f-args>)

nnoremap ebc :call OpenBuffer4('/home/kdog3682/2024-javascript/vuekit/base-components.js')<CR>
let g:wpsnippets2["javascript"]["vt"] = "const ${Pascal($1)} = {\n    name: '${DashCase($1)}',\n    render(h) {\n         $c\n        return h('div', {class: \"${DashCase($1)}\"}, value)\n    },\n    props: ['value'],\n}"
let g:wpsnippets2["javascript"]["vh"] = "const ${Pascal($1)} = {\n    name: '${DashCase($1)}',\n    render(h) {\n         $c\n        return h('div', {class: \"${DashCase($1)}\"}, value)\n    },\n    props: ['value'],\n}"
" let g:wpsnippets2["javascript"]["vr"] = "const ${Pascal($1)} = {\n    name: 'r-${DashCase($1)}',\n    raw: q`\n\n\n`
let g:execRef2["sd"] = "SwapDashes"
let g:wpsnippets2["vim"]["nb"] = "nnoremap <buffer> $1 :call $2()<CR>"
let g:execRef2["sad"] = "SetActiveDir"
let g:execRef2["booga"] = "Booga"


nnoremap <leader>d :call fzf#run(FzfHelper(GetBufferNames(), "e"))<CR>
nnoremap <leader>c :call FzfFunctionHandler()<CR>
nnoremap <buffer> <leader>d :call FOOO()<CR>

function! FOOO()
	ec 'hi'
endfunction
let g:execRef2["g"] = "GoGfgf"
let g:gfgfdict['ob'] = ['/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim', 'OpenBuffer4', 0]
let g:wpsnippets2["vim"]["map"] = "map($1, '$2(v:val)')"
let g:wpsnippets2["vim"]["filter"] = "filter($1, '$2(v:val)')"
let g:gfgfdict['v3'] = ['/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim', 'VAction3', 0]

let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/tests/vuemd.a.js"] = "/home/kdog3682/2024-javascript/txflow/vuemdBlocks.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/vuemdBlocks.js"] = "/home/kdog3682/2024-javascript/txflow/tests/vuemd.a.js"

function! SmartEqual3()
    "javascript

    let state = VimTextObject()

    if g:config.txflow_equal_sign
        return state.deleteEndingSpaces() . ' = '

    elseif state.left.endswith('[?<>!=] *')
        return state.deleteEndingSpaces() . "= "

    elseif state.test('^ *[a-z]\w* *$')

        let word = state.match('[a-z]\w*')
        let equal_dictionary_ref = JP('equal_dictionary')

        if has_key(equal_dictionary_ref, word)
            let prefix = JP('prefix')
            let [before, after] = equal_dictionary_ref[word]
            return g:keyboard.reset . prefix . before . ' = ' . after

            " existing
        elseif Exists(state.find_above(word . '(\)| *\= *)|[!(] *' . word))
            return state.deleteEndingSpaces() . " = "
        else
            let prefix = JP('prefix')
            return "\<C-O>I" . prefix . "\<C-O>A = "
            " return g:keyboard.reset . prefix . state.left.trimmed . ' = '
        endif
    elseif state.left.test('^ *\w+ *$')
        let prefix = JP('prefix')
        return g:keyboard.reset . prefix . state.left.trimmed . ' = ' . state.right.trimmed
    else
        return ' = '
    endif
endfunction
function! VimTextObject()
    let number = line('.')
    let s = getline(number)
    let pos = col('.') - 1
    let left_ch = s[pos - 3]
    let current_ch = s[pos - 2]
    let next_ch = s[pos - 1]
    let right =  strpart(s, pos)
    let left = strpart(s, 0, pos)
    " return [left, right]

    let trimmed = trim(s)
    let trimmedLeft = trim(left)
    let trimmedRight = trim(right)
    let spaces = Match(s, '^ *')
    let ind = len(spaces)
    " @bookmark 1709331717 vto
    let data = {
        \"getset": {Fn -> setline(number, Fn(data))},
        \"match": {k -> Match(s, RegexGetter(k))},
        \"find_above": {r -> Fli(r, number, -1, 5)},
        \"find_below": {r -> Fli(r, number, 1, 5)},
        \"sub": {r, Fn -> Substitute(s, r, Fn)},
        \"replace_line": {payload -> ReplaceBlock(number, payload, 1)},
        \"set_line": {payload -> setline(number, Test(payload, '^ +') ? payload : spaces . payload)},
        \"replace": {x,y -> setline(number, Substitute(s, x, y))},
        \"empty": len(trimmed) == 0,
         \   'text': s,
         \   'trimmed': trimmed,
         \   'spaces': Match(s, '^ *'),
          \  'number': number,
          \  'lnum': number,
           \ 'length': len(s),
        \    "pos": pos,
         \   "prev_ch": left_ch,
          \  "ch": current_ch,
           \ "next_ch": next_ch,
        \'left': {
         \ 'endswith': {x -> Test(left, x . '$')},
         \ 'test': {x -> Test(left, x)},
         \ 'startswith': {x -> Test(trimmedLeft, '^' . x)},
         \ 'trimmed': trimmedLeft,
        \},
        \'right': {
         \ 'endswith': {x -> Test(right, x . '$')},
         \ 'test': {x -> Test(right, x)},
         \ 'startswith': {x -> Test(trimmedRight, '^' . x)},
         \ 'trimmed': trimmedRight,
        \},
        \'ind': ind,
        \'endswith': {x -> Test(s, x . '$')},
        \'startswith': {x -> Test(s, '^ *' . x)},
        \'has': {x -> Test(s, EscapeRegexEqual(x))},
        \'test': {x -> Test(s, x)},
        \'sosall': { -> Sosall(s)},
        \'gcw': { -> expand('<cword>')},
        \'first': { -> Match(s, '^\W*\zs\w+')},
        \'last': { -> Match(s, '\w+\ze\W*$')},
        \'deleteEndingSpaces': { -> BackspaceExpr(Match(left, '\S\zs *$'))}
    \}
    return data
endfunction
let g:vimCurrentTestFunction = "SmartEqual3"
let g:execRef2["tgc"] = "ToggleGConfig"

function! GlossaryNote(message)
    "test: asdf
    let message = trim(a:message)
    let s = VT('$strftime [$word]: ' . message)
    call AppendFile(g:glossaryfile, s)
endfunction
let g:glossaryfile = "/home/kdog3682/2024/.glossary.txt"

call add(g:lineEditCommands2, "ExtractVarAndMoveUp")
function! FzfDirectoryManager()
    let dir= "/home/kdog3682/2024-javascript/"
    if &filetype== "typst"
        let dir = "/home/kdog3682/2024-typst/src"
    elseif &filetype== "python"
        let dir = "/home/kdog3682/PYTHON"
    endif
    call fzf#vim#files(dir)
endfunction
let g:wpsnippets2["css"]["com"] = "/****\n    $c\n****/"

let g:fzf_function_items = [
    \'GenerateAdvancedComponentFile',
\]

function! Foo()
    ec 'hii'
endfunction
let g:alphabet= ['aaaa', 'bbbbbbbb', 'ccccccccc']
function! FzfFunctionHandler()
    call fzf#run(fzf#wrap({'source': g:fzf_function_items, 'sink': 'RunCommandViaFZF'}))
endfunction
nnoremap evc :call OpenBuffer4('/home/kdog3682/2024-javascript/vuekit/vuetify.css')<CR>

function! WritePackageJson()
    let file = '/home/kdog3682/2024-javascript/package.json'
    call WriteFile(file, json_encode({"type": "module"}))
endfunction
nnoremap eps :call OpenBuffer4('/home/kdog3682/2024-javascript/vuekit/ps105.css')<CR>
let g:execRef2["goyo"] = "Goyo"


function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=5
  set wrap
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  set nowrap
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


let g:fzf_css_completions= ['shadow 1', 'shadow 2']
inoremap <expr> ,d fzf#vim#complete(FzfHelper(g:css_local_phrases))
nnoremap ecd :call OpenBuffer4('/home/kdog3682/.vim/ftplugin/css-data.vim')<CR>
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/specialComponentWrapper.js"] = "/home/kdog3682/2024-javascript/txflow/vueBlocks.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/vueBlocks.js"] = "/home/kdog3682/2024-javascript/txflow/specialComponentWrapper.js"

nnoremap ecs :call OpenBuffer4('/home/kdog3682/2024-javascript/vuekit/simple.css')<CR>

function! FzfHis()
    History
endfunction
let g:execRef2["his"] = "FzfHis"


let g:gfgfdict['n'] = ['/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim', 'Node1', 0]

" set runtimepath+=/home/kdog3682/.vim/xptemplate




inoremap <silent> <expr> <Tab> QQQ()

" inoremap <silent> <buffer> <Tab> <C-R>=CleverTab()<CR>
" old and deprecated
let g:gfgfdict['vfs'] = ['/home/kdog3682/.vimrc', 'VimFileStateObject', 0]

" /home/kdog3682/.config/nvm/versions/node/v21.7.1/lib/node_modules
" /home/kdog3682/2023/node_modules



let g:execRef2["aed"] = "AddEntryToDirDict"
let g:dirdict["cetz-package"] = "/home/kdog3682/.cache/typst/packages/preview/cetz/0.2.0/"
let g:wpsnippets2["vim"]["jsp"] = "let g:jspyref3[\"vim\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"python\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"javascript\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"typst\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"html\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"css\"][\"$1\"] = \"$2\""


let g:wpsnippets2["vim"]["jsp"] = "let g:jspyref3[\"vim\"][\"$1\"] = \"\"\nlet g:jspyref3[\"python\"][\"$1\"] = \"\"\nlet g:jspyref3[\"javascript\"][\"$1\"] = \"\"\nlet g:jspyref3[\"typst\"][\"$1\"] = \"\"\nlet g:jspyref3[\"html\"][\"$1\"] = \"\"\nlet g:jspyref3[\"css\"][\"$1\"] = \"\""


let g:execRef2["dfr"] = "DenoFileRunner"
let g:execRef2["export"] = "ExportToJson"

let g:execRef2["gf"] = "GoGfgf"
let g:execRef2["ve"] = "VimExecRef2Runner"
let g:execRef2["fmt"] = "DenoFormat"

nnoremap <leader>ba :BookmarkAdd<space>
nnoremap <leader>bg :BookmarkGo<space>
nnoremap <leader>bd :BookmarkDel<space>
nnoremap <leader>bq :BookmarkQf<cr>
function! GetVimState2()
    let override = a:0 >= 1 && Exists(a:1)
    let file = override ? a:1 : CurrentFile()
    let lineNumber = override ? getbufinfo(file)[0].lnum : line('.')
    let filetype = GetFiletype(file)
    let tail = Tail(file)
    let state= 
    let data = {
        \'file': file,
        \'filename': tail,
        \'name': RemoveExtension(tail),
        \'lineNumber': lineNumber,
        \'lnum': lineNumber,
        \'filetype': filetype,
        \'dir': Head(file),
        \'state': state,
    \}
    return data
endfunction

function BuildPattern(line)
  return '^\s*\V' . escape(a:line, '\') . '\m\s*$'
endfunction

source /home/kdog3682/.vim/ftplugin/simpleBookmarks.vim




function! DenoCreateFile(filename)
    " first fzf the directory ... then create the file
    let s:filename = a:filename
    let dirs= GetPublicDirectoriesRecursively('/home/kdog3682/2024-javascript/', 'd')
    function! Sink(dir)
        let dir = a:dir
        let path = PathJoin(dir, s:filename)
        call OpenBuffer(path)
        call Magical(path)
    endfunction
    call fzf#run(fzf#wrap({'source': dirs, 'sink': function('Sink')}))
endfunction

function! GetPublicDirectoriesRecursively(...)

    let dir= a:0 >= 1 ? a:1 : '$(pwd)'
    let type= a:0 >= 2 && a:2== 'dir' || a:2== 'd'? 'd' : 'f'
    let ignore= '(fonts|\.git|node_modules|\.log$|temp|package)'
    let source = printf('find %s -regextype posix-extended -type %s | grep -vE ''%s''', dir, type, ignore)
    let result = systemlist(source)
    return result
endfunction


function! _FzfObjectCallback(obj, Callback)
    let s:obj= a:obj
    let s:Callback = function(a:Callback)

    let display= keys(s:obj)
    function! Sink(name)
        return s:Callback(s:obj[a:name])
    endfunction
    call fzf#run(fzf#wrap({'source': display, 'sink': function('Sink')}))

endfunction
function! FzfCallback(items, Callback = "Callback", Display = "Display", Access = "Access")
    let items = IsString(a:items) ? ReadJson(a:items) : a:items
    " ec items
    " return
    let Display = a:Display
    let Callback = a:Callback
    let Access = a:Access
    if empty(items)
        ec "no items to fzf"
        return 
    elseif IsObject(items)
        return _FzfObjectCallback(items, Callback)
    else
        return _FzfArrayCallback(items, Callback, Display, Access)
    endif
    
endfunction
function! _FzfArrayCallback(items, Callback, Display, Access)
    let s:items = a:items
    let s:Display = function(a:Display)
    let s:Callback = function(a:Callback)
    if len(a:items)== 1
        return s:Callback(a:items[0])
    endif

    function! SimpleSink(item)
        return s:Callback(a:item)
    endfunction

    function! Sink(match)
        let item = Find(s:items, {x -> s:Display(x)== a:match})
        return s:Callback(item)
    endfunction

    if IsString(a:items[0])
        return fzf#run(fzf#wrap({'source': a:items, 'sink': function('SimpleSink')}))
    endif

    let display= SimpleMap(a:items, a:Display)
    call fzf#run(fzf#wrap({'source': display, 'sink': function('Sink')}))
endfunction

function! SimpleMap(items, fnKey)
    let items = a:items
    let fnKey = a:fnKey
    return map(copy(items), fnKey . '(v:val)')
endfunction

let g:execRef2["dcf"] = "DenoCreateFile"
function! Magical(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
    if Test(file, 'apps/\w+(\.\w+)+$')
        let name = Match2(file, '/apps/(\w+)')
        call SnippeteerHandler('maj', name)
    endif
endfunction
let g:execRef2["magic"] = "Magical"
let g:wpsnippets2["javascript"]["maj"] = "export default $1 \n\nfunction $1(s) {\n\n}"

function! SnippeteerHandler(...)
    return Snippeteer(join(a:000, ' '))
endfunction
function! InputPrompt(a, b)
    let a = a:a
    let b = a:b
    ec a
    ec b
    call input('')
endfunction
let g:execRef2["dj"] = "DenoJavascriptAppRunner"
" let g:wpsnippets2["text"]["insert"] = "Inserter"
" function! Inserter(s)
    " let s = a:s
" endfunction
let g:wpsnippets2["javascript"]["edm"] = "export default main"
let g:execRef2["ff"] = "FZF_FindExecRefFunction"

let g:jspyref3['javascript']['lp'] = 'pause("pausing @ $1", $1)'

function! GoTempError()
    let json = ReadVimJSON('temp-error')
    call OpenBuffer(json.file)
    call cursor(json.line, 1000)
endfunction
nnoremap gte :call GoTempError()<CR>
let g:wpsnippets2["javascript"]["sl"] = "switch($1.length) {\n    case 0:\n    case 1:\n        $c\n    case 2:\n    case 3:\n}"

let g:wpsnippets2["javascript"]["p"] = "pause('pausing at $1', $1)"
let g:execRef2["typf"] = "TypstFormat"
let g:filedict["foo"] = "/home/kdog3682/2024-typst/src/foo.typ"
nnoremap ey :call OpenBuffer4('/home/kdog3682/2024-javascript/nodekit/deno.js')<CR>

function! Sdfjksdhf()
	throw "hi"
endfunction
" nnoremap <leader>v :call FzfSimple("/home/kdog3682/.vim/ftplugin")<CR>
let g:s_fzf_dir="/home/kdog3682/.local/share/typst/packages/local/stdlib/0.1.0/src"
nnoremap <leader>s :call FzfDir2(g:s_fzf_dir)<CR>
" nnoremap <leader>s :call FzfSimple("/home/kdog3682/GITHUB/nvimbackup")<CR>
nnoremap <leader>a :call FzfSimple("/home/kdog3682/.config/nvim")<CR>
nnoremap <leader>j :call FzfSimple("/home/kdog3682/2023")<CR>
nnoremap <leader>t :call FzfSimple("/home/kdog3682/2024-typst/src")<CR>
nnoremap <leader>c :call FzfSimple(SmartHead())<CR>
nnoremap <leader>1 :call FzfSimple(GetBuffers2024())<CR>
nnoremap <leader>2 :call FzfSimple("/home/kdog3682/@bkl")<CR>


function! SmartHead()
    let h = Head()
    let m = Match(h, '\@\zs(\w+)')
    if Exists(m)
        return '/home/kdog3682/@' . m
    endif
    return h
endfunction
let g:cetz_package_dir= "/home/kdog3682/GITHUB/typst-packages/packages/preview/cetz/0.2.0/src"
nnoremap  <leader><leader>c :call fzf#run(fzf#wrap({'dir': g:cetz_package_dir}))<CR>
" fzf#run(FzfHelper(dir))
function! GetBuffers2024()
    let f = "!Test(v:val.name, '\.(vim|log|vimrc)$')"
    let g = "v:val.name"
    let buffers = filter(getbufinfo(), f)
    call sort(buffers, function('CompareByLastUsed'))
    return map(buffers, g)
endfunction
let g:vimCurrentTestFunction = "ConstantlyCallJavascript"
let g:jspyref3["lua"] = {}
let g:jspyref3["lua"]["commentPrefix"] = "--"

inoremap <expr> ,a fzf#vim#complete(FzfHelper('~/.config/nvim/lua/kdog3682'))
let g:execRef2["--1"] = "GetDateOfLastFileTouch"
let g:filedict["lf"] = "/home/kdog3682/2024-javascript/stdlib/lezer/functions.js"

function! Zap()
	call AppendFile('/home/kdog3682/.temp.txt', getline('.'))
endfunction
let g:execRef2["zap"] = "Zap"
let g:filedict["tt"] = "/home/kdog3682/.temp.txt"
let g:wpsnippets2["javascript"]["ar"] = "------------------------------------------------------------\n\ndatetime: $datetime\nsubreddit: $c\ntitle: \nbody:"
let g:wpsnippets2["javascript"]["extf"] = "------------------------------------------------------------\n\ndatetime: $datetime\nexternal_file: $c\nbody:"
let g:execRef2["tus"] = "ToggleUnderscore"
let g:wpsnippets2["text"]["fm"] = "---\n$c\n---"



let g:execRef2["pvj"] = "PreviewVueJS"
let g:wpsnippets2["html"] = {}
let g:wpsnippets2["html"]["div"] = "<div id=''>\n</div>"

let g:wpsnippets2["html"]["script"] = "<script type= 'module'>\n    \n</script>"
let g:filedict["cmn1"] = "/home/kdog3682/2023/cm-next.js"
let g:filedict["cm3"] = "/home/kdog3682/2023/cm3.js"
let g:execRef2["grep"] = "GREP"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/JavascriptVisitors.js"] = "/home/kdog3682/2024-javascript/staging/lezer-workspace.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/lezer-workspace.js"] = "/home/kdog3682/2024-javascript/staging/JavascriptVisitors.js"

let g:wpsnippets2["javascript"]["vc"] = "const [a, b] = visitChildren(this, ast, env)"
let g:wpsnippets2["javascript"]["vcabc"] = "const [a, b, c] = visitChildren(this, ast, env)"
let g:wpsnippets2["javascript"]["vcc"] = "const children = visitChildren(this, ast, env)"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/NameCheckerVisitors.js"] = "/home/kdog3682/2024-javascript/staging/lezer-workspace.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/lezer-workspace.js"] = "/home/kdog3682/2024-javascript/staging/NameCheckerVisitors.js"

let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/addMissingDependencyVisitors.js"] = "/home/kdog3682/2024-javascript/staging/lezer-workspace.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/lezer-workspace.js"] = "/home/kdog3682/2024-javascript/staging/addMissingDependencyVisitors.js"

let g:wpsnippets2["javascript"]["ptc"] = "pause(this.children)"
let g:wpsnippets2["javascript"]["ifmk"] = "if (!$1) {\n    $1 = $2\n}"

let g:filedict["tb"] = "/home/kdog3682/2024-javascript/txflow/typstBlocks.js"
let g:filedict["typ"] = "https://typst.app/project/pmNCqtXTIGrMxEOd0913Ik"
nnoremap etb :call OpenBuffer4('/home/kdog3682/2024-javascript/txflow/typstBlocks.js')<CR>
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/tests/typst.a.js"] = "/home/kdog3682/bkl/math/slope/0.1.0/raw.txf"
let g:linkedBufferGroups["/home/kdog3682/bkl/math/slope/0.1.0/raw.txf"] = "/home/kdog3682/2024-javascript/txflow/tests/typst.a.js"

let g:filedict["slope"] = "/home/kdog3682/bkl/math/slope/0.1.0/raw.txf"
let g:wpsnippets2["text"]["exp"] = "JSVExpand"
let g:wpsnippets2["global"]["buffers"] = "B"

function! JSVExpand()
    let line = CurrentLine()
    let file= ""

    let module_file = "/home/kdog3682/2024-javascript/nodekit/apps/expand.js"
    let s = json_encode({'text': line})
    " ec s
    let state= ShellEscape(s)
    " return
    " ec state
    " return
    let res= systemlist('deno run --allow-all ' . g:deno_file . ' ' . module_file . ' ' . state)
    ec res
    " ec res
    return
    let base = res[0]
    ec base
    return 
    " let base= Sub(base, '\\\\', '\\')
    " ec base
    " return
    let s = json_decode(base)
    ec s.value
    return 
    " let res = SystemExec(g:deno_file, module_file, R)
    " ec res
    return 
endfunction
let g:execRef2["jsv"] = "JSVExpand"

function! NodeBooga(state) abort
   let state = a:state
   let module_file = '/home/kdog3682/2024-javascript/nodekit/apps/' . AddExtension(state.module, 'js')
   let state.redirect = v:true
   let state.state= {}
   let state = json_encode(state)
   let state= ShellEscape(state)
   " call append('$', state)
   " return
   " ec state
   " return
   let cmd = 'deno run --allow-all ' . g:deno_file . ' ' . module_file . ' ' . state
   " ec cmd
   " return
   let base= ''
   let result= ''
    try
        let base= systemlist(cmd)
        if empty(base)
            return '  --EMPTY--'
        endif
       let res = trim(base[1])
       let value = json_decode(res)
       let result = value.value
    catch
        let error = v:exception
        return '  --ERROR: ' . error
    endtry
   if IsObject(result)
        if has_key(result, 'open')
            call OpenBuffer(result.open)
        elseif has_key(result, 'template')
            return g:keyboard.reset . BackslashReplacer(result.template)
        elseif has_key(result, 'replacement')
             if has_key(result, 'backspaces')
                 return repeat(g:keyboard.bs, result.backspaces) . result.replacement
             endif
             " call input(string(result.replacement))
            return Sub(result.replacement, '\t', "    ")
        else
            ec result
        endif
   endif
endfunction

function! RunJavascriptModuleForCurrentLine(module)
    let state = {"arg": CurrentLine(), 'module': a:module}
    return NodeBooga(state)
endfunction

function! RunJavascriptModuleWithArg(module, arg)
    let module = a:module
    let arg = trim(a:arg)
    let state = {"module": module, "arg": trim(arg)}
    return NodeBooga(state)
endfunction

let g:execRef2["rjm"] = "RunJavascriptModuleWithArg"
let g:execRef2["dlgit"] = "RunJavascriptModuleWithArg('github', '$1')"
function! TypstOmniExpand()
    return RunJavascriptModuleForCurrentLine('typstOmniExpand')
endfunction
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/nodekit/apps/typstOmniExpand.js"] = "/home/kdog3682/bkl/math/slope/0.1.0/slope-triangle.typ"
let g:linkedBufferGroups["/home/kdog3682/bkl/math/slope/0.1.0/slope-triangle.typ"] = "/home/kdog3682/2024-javascript/nodekit/apps/typstOmniExpand.js"

function! Fooo()
    return TypstOmniExpand()
    let t = "let %s(%s) = {\<CR>}\<CR>\<ESC>?{\<CR>oabc"
    return g:keyboard.reset . t
endfunction


function! BackslashReplacer(s)
    let s = a:s
    let k= "\<CR>\<ESC>?{\<CR>o"
    let cr = "\<CR>"
    let s = substitute(s, '\v\n\t\n(.*)', {x -> cr . x[1] . k}, '')
    return s



    let s = Sub(s, 'dooga', "{\<CR>}\<CR>\<ESC>?{\<CR>o    ")
    let s = 
    " call input(s)
    " let s =  Sub(s, '\\\<CR\>', "\<CR>")
    " let s = Sub(s, '\\\<ESC\>', "\<ESC>")
    " let s =  Sub(s, '\\\<CR\>', "\<CR>")
    return s
endfunction
inoremap <silent> <expr> qt Fooo()

let g:linkedBufferGroups["/home/kdog3682/.config/nvim/lua/local-plugins/nvim-grey/colors/grey.lua"] = "/home/kdog3682/.config/nvim/lua/plugins/lsp.lua"
let g:linkedBufferGroups["/home/kdog3682/.config/nvim/lua/plugins/lsp.lua"] = "/home/kdog3682/.config/nvim/lua/local-plugins/nvim-grey/colors/grey.lua"

let g:linkedBufferGroups["/home/kdog3682/bkl/math/slope/0.2.0/base-triangle.typ"] = "/home/kdog3682/bkl/math/slope/0.2.0/slope-triangle.typ"
let g:linkedBufferGroups["/home/kdog3682/bkl/math/slope/0.2.0/slope-triangle.typ"] = "/home/kdog3682/bkl/math/slope/0.2.0/base-triangle.typ"

let g:wpsnippets2["typst"]["c2"] = "#import \"@preview/cetz:0.2.2\""
let g:filedict["sty"] = "/home/kdog3682/.local/share/typst/packages/local/stdlib/0.1.0/src/styles.typ"
let g:wpsnippets2["typst"]["stroke"] = "stroke: (\n    paint: $1,\n    thickness: $2,\n    dash: \"dotted\"\n)"
let g:wpsnippets2["typst"]["stdlib"] = "#import \"@local/stdlib:0.1.0\" as stdlib: *"
let g:wpsnippets2["typst"]["cetz"] = "#import \"@preview/cetz:0.2.2\"\n#import cetz.draw: *"
let g:execRef2["sfm"] = "SetFrontMatterMode"
let g:filedict["ls"] = "/home/kdog3682/2024-javascript/txflow/LineScanner.js"
let g:linkedBufferGroups["/home/kdog3682/2023/serveVite.js"] = "/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim"
let g:linkedBufferGroups["/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim"] = "/home/kdog3682/2023/serveVite.js"

let g:execRef2["gpa"] = "GitPushAlan"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/vuekit/staging/trigtips.vue.js"] = "/home/kdog3682/2024-javascript/vuekit/fzf.css"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/vuekit/fzf.css"] = "/home/kdog3682/2024-javascript/vuekit/staging/trigtips.vue.js"

nnoremap <leader>3 :call Node3()<CR>
function! RunJavascript(...)
    execute '!clear; node ' . join(a:000, " ")
endfunction
function! Vite(...)
    let file = CurrentFile()
    call RunJavascript("/home/kdog3682/2023/serveVite.js", 'serve', file)
endfunction
function! Roll(...)
    let file = CurrentFile()
    call RunJavascript("/home/kdog3682/2023/rollup2.js", 'serve', file)
    " /home/kdog3682/NOTES/2024-04-12.txt
endfunction
let g:execRef2["vite"] = "Vite"
let g:execRef2["roll"] = "Roll"
let g:filedict["git3"] = "/home/kdog3682/PYTHON/GithubController.py"
let g:execRef2["bda"] = "ClearBufs"
let g:filedict["vcj"] = "/home/kdog3682/my-vitesse-app/vite.config.ts"
function! SetJavascript()
    :setlocal filetype=javascript
endfunction
let g:execRef2["sj"] = "SetJavascript"

function! SetFiletypeText()
    :setlocal filetype=text
endfunction

let g:execRef2["gcf"] = "Gcf"
let g:execRef2["gcs"] = "Gcs"
let g:linkedBufferGroups["/home/kdog3682/@bkl/frontend/src/views/Dashboard.vue"] = "/home/kdog3682/@bkl/frontend/src/router/index.js"
let g:linkedBufferGroups["/home/kdog3682/@bkl/frontend/src/router/index.js"] = "/home/kdog3682/@bkl/frontend/src/views/Dashboard.vue"

let g:execRef2["st"] = "SetFiletypeText"
let g:wpsnippets2["vue"] = {}
let g:wpsnippets2["vue"]["script"] = "<script setup>\n    $c\n</script>\n\n\n<template>\n\n</template>"

let g:filedict["hkbfscesiv"] = "/home/kdog3682/@bkl/frontend/src/components/examples/SimpleIcons.vue"
let g:filedict['doc']=  "https://docs.google.com/document/d/1ZkQHnrNZDkfGveGmETJ2lXqGvR_jsC3HCw3BVM-00uk/edit"
let g:filedict['docweb']=  "https://docs.google.com/document/d/e/2PACX-1vR0Sc75Wkd8jGmw7j6Paas4Vz93pQIMySoDmq7jz1JS-wW8ZvvXQxD1vWxB7Y9sJdqMBO-tv5GhZ29p/pub"


function! PythonConnector(s)
    let state = GetVimState()
    let [key, arg]= SplitOnce(a:s)
    let state['arg'] = arg
    call SystemExec('/home/kdog3682/PYTHON/vim_package_manager.py', key, state)
endfunction
nnoremap <c-z> :ec ("'c-z' was pressed")<CR>
let g:execRef2["pc"] = "PythonConnector"
let g:temp_file = "/home/kdog3682/2024/temp.txt"
function! Go_temp_file()
    call OpenBuffer3(g:temp_file)
endfunction
nnoremap et :call Go_temp_file()<CR>
nnoremap evp :call OpenBuffer4('/home/kdog3682/PYTHON/vim_package_manager.py')<CR>
let g:linkedBufferGroups["/home/kdog3682/@bkl/packages/frontend/package.json"] = "/home/kdog3682/@bkl/package.json"
let g:linkedBufferGroups["/home/kdog3682/@bkl/package.json"] = "/home/kdog3682/@bkl/packages/frontend/package.json"

nnoremap eflb :call OpenBuffer4('/home/kdog3682/.cache/kdog3682/bkl_files.json')<CR>
let g:linkedBufferGroups["/home/kdog3682/@bkl/frontend/brooklynlearning/package.json"] = "/home/kdog3682/@bkl/frontend/package.json"
let g:linkedBufferGroups["/home/kdog3682/@bkl/frontend/package.json"] = "/home/kdog3682/@bkl/frontend/brooklynlearning/package.json"

function! Foobar()
    ec 'hooooooo'
    return 'asd'
endfunction
inoremap <expr> qh fzf#vim#complete(FzfHelper('~/@bkl', function('Foobar')))

" ExplorerViaFzf
nnoremap eftb :call OpenBuffer4('/home/kdog3682/.cache/kdog3682/bkl.directory_tree.txt')<CR>

let g:python_plugin_file= '/home/kdog3682/PYTHON/vim_package_manager.py'

function! TildaParse(s)
    return trim(Match2(a:s, '\~\~\~(.{-})\~\~\~'))
endfunction
function! Fooo()
    ec TildaParse("~~~hi\nbye~~~i")
endfunction
function! PlugPython(key, ...)
    let state = GetVimState()
    let state['command'] = a:key
    let state['args'] = a:000
    let cmd = SetupShellCommandArgs('python3', g:python_plugin_file, state)
    let res = system(cmd)
    let result = json_decode(TildaParse(system(cmd)))
    if result.success
        call call(function(result.command), result.args)
    else
        ec result
    endif
endfunction
function! GoFile2()
    call PlugPython("GoFile")
endfunction
let g:execRef2["gf2"] = "GoFile2"

let g:python_plugin_ref = {}
let g:python_plugin_ref["gf"] = "aa"

function! Abcde(path)
    let filename= input('choose a filename')
    call PlugPython('smart_create_new_file', a:path, filename)
endfunction
function! FzfDirectories(source)
    let payload = {'window': {'width': 0.88, 'height': 0.8}, 'left': '50%'}
    let payload['source'] = 'find $(pwd) -regextype posix-extended -type d | grep -vE ''(fonts|\.git/|node_modules|\.log$|temp|pycache)'''
    let payload['dir'] = a:source
    let payload['dir'] = a:source
    let payload['sink'] = function('Abcde')

    call fzf#run(payload)
endfunction
nnoremap <leader>3 :call FzfDirectories('~/@bkl')<CR>
nnoremap <leader>4 :call FzfSimple('~/@bkl/apps/examples/Repl')<CR>
let g:linkedBufferGroups["/home/kdog3682/PYTHON/vim_package_manager.py"] = "/home/kdog3682/PYTHON/api.py"
let g:linkedBufferGroups["/home/kdog3682/PYTHON/api.py"] = "/home/kdog3682/PYTHON/vim_package_manager.py"

let g:filedict["fish"] = "/home/kdog3682/.config/fish/config.fish"
let g:wpsnippets2["json"] = {}
let g:wpsnippets2["json"]["pm"] = "\"packageManager\": \"pnpm@9.0.6\","

inoremap <expr> ,,2 fzf#vim#complete(FzfHelper("~/@bkl"))
let g:execRef2["sh"] = "VShunt4"
let g:wpsnippets2["javascript"]["i"] = "import {$1} from \"./shared/getTree.js\""

let g:wpsnippets2["javascript"]["clip"] = "import { clip, appendVariable } from \"/home/kdog3682/2023/node-utils.js\""
let g:wpsnippets2["python"]["w1"] = "while True:\n    $c"
nnoremap eff :call OpenBuffer4('/home/kdog3682/.config/fish/config.fish')<CR>

let g:wpsnippets2["fish"] = {}
let g:wpsnippets2["fish"]["fun"] = "function $1\n    $c\nend"

let g:filedict["viml"] = "/home/kdog3682/2024-javascript/stdlib/vim/parser.js"
