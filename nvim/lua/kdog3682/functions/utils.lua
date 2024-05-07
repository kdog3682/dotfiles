local serpent = require("kdog3682.lib.serpent")

local function print_table_contents(t)
    print(111)
    -- print(serpent.dump(t))
end
local function to_array(t)
    if not t then return {}
    elseif vim.tbl_islist(t) then
        return t
    end
    return { t }
end

local function noremap(key, expr, opts)
	if not opts then
		opts = {}
	end
	if opts.save then
		expr = vim.fn.printf(":w<cr><cmd>lua %s()<cr>", expr)
	elseif opts.args then
		local argstr = join(map(to_array(opts.args), to_string_argument), ", ")
		expr = vim.fn.printf("<cmd>lua %s(%s)<cr>", expr, argstr)
    elseif opts.lua then
		expr = vim.fn.printf("<cmd>lua %s()<cr>", expr)
    end
	vim.keymap.set("n", key, expr, { noremap = true, silent = true })
end

local function tail(file)
	-- https://github.com/hrsh7th/cmp-calc
	local bufname = file or vim.api.nvim_buf_get_name(0)
	return vim.fn.fnamemodify(bufname, ":p")
end

local function head(file)
	local bufname = file or vim.api.nvim_buf_get_name(0)
	return vim.fn.fnamemodify(bufname, ":h")
end

local function lua_bufwrite_callback()
	local bufname = vim.api.nvim_buf_get_name(0)
	print("howdy", bufname)
	pause(bufname)
	local dir = tail(head())
	if dir == "snippets" then
		print(bufname)
	end
	execute("source", bufname)
end


local function is_object(x)
	if not is_table(x) then
		return false
	end
	if x[1] == nil then
		return true
	else
		return false
	end
end

local function is_array(x)
	if not is_table(x) then
		return false
	end
	if x[1] == nil then
		return false
	else
		return true
	end
end

local function select_item(items)
	local selected_index = vim.ui.select(items)
	print(selected_index)
end

local function foo()
    local my_query = [[
        ((function_definition
        name: (identifier) @function)
        (#set! "type" "$name"))
    ]]
    vim.treesitter.query.add_query('lua', 'my-query', my_query)

    local node = get_root_node()
    for _, match in ipairs(node) do
        print(get_node_text(match))
    end
end

local function getline()
	return vim.fn.getline(vim.fn.line("."))
end

local function reload_vim()
	vim.cmd("source ~/.config/nvim/init.lua")
	print("Reload")
end

local function ToggleComment()
	local line = vim.api.nvim_get_current_line()
	local comment_string = vim.api.nvim_buf_get_option(0, "commentstring")
	vim.ui.input("cs", comment_string)

	-- Check if the line is already commented
	if string.find(line, "^%s*" .. comment_string) then
		-- Remove comment
		local uncommented_line = string.gsub(line, "^%s*" .. comment_string, "")
		vim.api.nvim_set_current_line(uncommented_line)
	else
		-- Add comment
		local commented_line = comment_string .. line
		vim.api.nvim_set_current_line(commented_line)
	end
end

local function ExportTreeAsJSON2()
	local root = get_root_node()
	-- append_file(vim.g.temp_file, root)

	local function convertNode(node)
		local t = {
			type = node:type(),
			range = { node:range() },
		}

		local childNodes = {}
		for childNode in node:iter_children() do
			table.insert(childNodes, convertNode(childNode))
		end

		if #childNodes > 0 then
			t.children = childNodes
		end

		return t
	end
	append_file(vim.g.temp_file, convertNode(root))
end

local function ls_root_files()
	local output = vim.fn.system("ls", "/")
	print(output)
end

local function toggler()
	vim.cmd("Lazy reload " .. vim.g.plugin)
end

local function get_filetype(file)
	if not file then
		return vim.bo.filetype
	else
		local fileTypes = {
			txt = "text",
			pdf = "pdf",
			typ = "typst",
			lua = "lua",
			js = "javascript",
			css = "css",
			py = "python",
			vim = "vim",
			-- Add more extensions and types as needed
		}
		local extension = string.match(file, "%.(%a+)$")
		return fileTypes[extension]
	end
end

local function join(a, delimiter)
	return table.concat(a, delimiter or " ")
end

local function command(...)
	local s = join({ ... })
	print("command", s)
	vim.cmd(s)
end

local function reloader()
	command("Lazy reload " .. vim.g.plugin)
end

local function get_line()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	row = row - 1
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
	return line
end

local function omni_toggle()
	local w = vim.fn.expand("<cword>")
	print(w)
	replace_word_under_cursor()
end

local function replace_word_under_cursor()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	local s = vim.api.nvim_get_current_line()
	local a = s
	local new_line_text = line_text:sub(1, col - #word_start) .. "foobar" .. line_text:sub(col + #word_end + 1)
	vim.api.nvim_set_current_line(new_line_text)
end

local function pause(arg)
	vim.fn.input(stringify(arg))
end

local function motion_qw()
	-- local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local a = vim.fn.getline(".")
	local col = vim.fn.col(".")
	local s1 = a[col]

	if true then
		return "123555"
	end
	if s1 == "," then
		return "<RIGHT>"
	else
		return "<RIGHT>, "
	end
end

local function help()
	local w = vim.fn.expand("<cword>")
	print(w)
	-- vim.fn
end

local function see(access)
	temp(keys(access), "a")
end

local function anything_handler(s)
	local handlers = {
		gft = get_filetype,
		help = help,
        e = "e!",
	}

	local key = ""
	local parts = split(s, " ")

	if #parts == 0 then
		if vim.g.state.anything_handler_key == nil then
			print("no vim.g.state.anything_handler_key ... early return")
			return
		else
			key = vim.g.state.anything_handler_key
		end
	else
		key = table.remove(parts, 1)
		vim.g.state.anything_handler_key = key
	end
	if is_number(key) then
		return vim.api.nvim_win_set_cursor(0, { tonumber(key - 1), 100 })
	end
	local func = handlers[key]

	if func then
        if is_string(func) then
            vim.cmd(func)
        else
            local success, result = pcall(func, unpack(parts))
            if success then
                print(result)
            end
        end
	else
		run_lua_function(key)
	end
end

local function statusline()
	local current_mode = vim.api.nvim_get_mode().mode
	return filepath() .. "     " .. (current_mode == "i" and "-- INSERT --" or "")
end

local function open(file_path)
	vim.api.nvim_command("edit! " .. file_path)
end

local function open_buffer(file_path)
	local file_path = file_path or "~/abc.typ"
	open(file_path)
end

local function open_prev_buffer()
	local file_path = "#"
	open(file_path)
end

local function trim(s)
	return s:gsub("^%s*(.-)%s*$", "%1")
end

local function is_filetype(s)
	return s == get_filetype()
end

local function smart_dash()
	if is_filetype("lua") and everything_before_cursor_is_spaces() then
		return "-- "
	else
		return "_"
	end
end

local function fzf(input)
	if not is_array(input) then
		input = vim.g.state.fzf[2]
	end
	local function default(selected)
		local a = vim.fn.expand(selected[1])
		nvim_tree(a)
	end
	require("fzf-lua").fzf_exec(input, { actions = { default = default } })
end

local function execute(cmd)
	print("CMD:", cmd)
	vim.api.nvim_command(cmd)
end

local function resourcer()
	execute("source", vim.g.source_file)
end

local function edit_dated_note_file()
	local file = string.format("~/NOTES/%s.txt", iso8601())
	open_buffer(file)
end

local function inoremap(key, expr)
	vim.keymap.set("i", key, expr, { expr = true, noremap = true, silent = true })
end

local function get_current_buffer(file)
	return file or vim.fn.expand("%")
end

local function get_prev_buffer()
	return vim.fn.expand("#")
end

local function get_current_buffer_directory()
	return head()
end

local function get_prev_buffer_directory()
	return vim.fn.fnamemodify(vim.fn.expand("%"), ":h")
end

local function qg_input()
	local a = vim.input("query")
	return a .. a .. a
end

local function prompt_for_input()
	prompt = "prompting for input"
	function callback(answer)
		return answer
	end
	local input = vim.ui.input({ prompt = prompt }, callback)
end

local function eval(s)
	return vim.fn.eval(s)
end

local function is_file(x)
	return vim.fn.filereadable(x) == 1
end

local function chdir(dir)
	vim.cmd.cd(dir)
end

local function git_push_directory()
	bash([[
        cd ~/.config/nvim
        git add .
        git commit -m "pushing"
        git push
        echo pushed!
    ]])
end

local function doublequote(s)
	return vim.fn.printf('"%s"', s)
end

local function maybe_print(s)
    if s then
        if type(s) == "userdata" then
            local a = s:type()
            if a then
                print(stringify(get_node_info(s)))
            end
        else
            print(s)
        end
    end
end

local function run_lua_function(key, arg)
	local argstr = ""
    if arg then argstr = doublequote(arg) end
	local cmd = vim.fn.printf(":lua maybe_print(%s(%s))", key, argstr)
	vim.cmd(cmd)
end

local function run_python_function(key, arg)
	vim.fn.system({ "python3", "~/PYTHON/run.py", key, arg })
end

local function open_file(file)
	local file = file or vim.fn.expand("%")
	print(file)
	run_python_function("ofile", file)
end

local function test(s, r)
	if not s then
		return false
	end
	return s:find(r)
end

local function is_number(x)
	return type(x) == "number" or test(x, "^%d")
end

local function is_string(x)
	return type(x) == "string"
end

local function find_parent_node(node, check)
	local checkpoint = check
	if is_string(check) then
		checkpoint = function(node)
			return node:type() == check
		end
	end

	local current = node
	while current ~= nil do
		if checkpoint(current) then
			return current
		end

		current = current:parent()
	end

	return false
end

local function get_function_node()
	local node = get_cursor_node(node)
	return find_parent_node(node, "function_declaration")
end

local function is_boolean(x)
	return type(x) == "boolean"
end

local function find_child_node(node, kind)
	local function callback(node)
		return node:type() == kind
	end

	local function traverse_nodes(node)
        print_node(node)
		local current = node
		while current ~= nil do
			if callback(current) then
				return current
			end
			if current:child_count() > 0 then
				local child = current:child(i)
				local result = traverse_nodes(child)
				if result ~= nil then
					return result
				end
			end
			current = current:next_sibling()
		end
	end
	return traverse_nodes(node)
end

local function get_identifier_node(node)
	local child = find_child_node(node, "identifier")
	return child
end

local function simple_comment()
	local bufnr = vim.api.nvim_get_current_buf()
	local comment = vim.bo[bufnr].comments
end

local function get_set_node(node, callback)
	local start_row, start_col, end_row, end_col = node:range()
	local new_text = callback(node)
	vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { new_text })
end

local function match(s, regex)
	local m = vim.fn.matchstr(s, vim.regex(regex))
	if m == nil then
		m = ""
	end
	return m
end

local function len(x)
	return x and #x
end

local function to_lines(x)
	if is_array(x) then
		return x
	else
		return vim.fn.split(x, "\n")
	end
end

local function repeatstr(str, count)
	local result = ""
	for i = 1, count do
		result = result .. str
	end
	return result
end

local function indent(payload, ind)
	ind = ind or 0
	local function indenter(s)
		local spaces = repeatstr(" ", ind)
		return spaces .. s
	end
	payload = map(to_lines(payload), indenter)
	return payload
end

local function get_set_line(line_number, fn)
	local prev = vim.fn.getline(line_number)
	local text = vim.fn.trim(prev)
	local ind = len(match(text, "^%s*"))
	local payload = indent(fn(text, ind), ind)
	replace_lines(line_number - 1, line_number, payload)
end

local function keys(iterable)
	local store = {}
	for key, _ in pairs(iterable) do
		table.insert(store, key)
	end
	return store
end

local function is_table(x)
	return type(x) == "table"
end

local function clip(s)
	write(vim.g.clip_file, s)
end

local function tern(a, b, c)
	if a then
		return b
	else
		return c
	end
end

local function append_file(a, b)
	local content = to_line_content(b)
	vim.fn.writefile(content, a, "a")
end

local function temp(data, mode)
	local fn = tern(mode == "a", append_file, write)
	fn(vim.g.temp_file, data)
end

local function prettier()
	local file = get_current_buffer()
	local ft = get_filetype(file)
	local deno = "deno fmt --indent-width=4 --no-semicolons --line width=65"
	local stylua = "/mnt/chromeos/MyFiles/Downloads/stylua"

	local ref = {
		lua = stylua, -- works
		vue = "eslint --fix", -- not working
		javascript = deno, -- dunno
		typescript = deno,
	}
	local cmd = ref[ft] .. " " .. file
	pause(cmd)
	os.execute(cmd)
	vim.cmd("silent! e!")
end

local function opposite(s)
	local ref = {
		["1"] = 0,
		["0"] = 1,
		["false"] = true,
		["true"] = false,
	}
	return ref[tostring(s)]
end

local function toggle()
	local val = opposite(vim.g.state.debug)
	print("new value @ toggle", val)
	vim.g.state.debug = val
end

local function execute_command(...)
	local command = table.concat({ ... }, " ")
	local result = vim.fn.system("clear;" .. command)
	print(result)
end

local function get_buffers()
	local buffers = vim.api.nvim_list_bufs()
	return buffers
end

local function print_factory(fn)
	local function printed(...)
		local success, result = pcall(fn)
		print(result)
		print_table_contents(result)
	end
	return printed
end

local function find_line(r)
	local pattern = vim.regex(r)
	local lines = vim.fn.getline(1, "$")

	for i, line in ipairs(lines) do
		if pattern:match_line(line) then
			print("Match found on line " .. i .. ": " .. line)
		end
	end
end

local function clone(url, to)
	local s = string.format("git clone %s %s", url, to)
	vim.fn.system(s)
end

local function exists(x)
	return not empty(x)
end

local function get_child_nodes(node)
	local store = {}
	local stop = node:child_count()
	for i = 1, stop do
		local child = node:child(i - 1)
		table.insert(store, child)
	end
	return store
end

local function map(items, fn)
	local store = {}
	for i, item in pairs(items) do
		table.insert(store, fn(item))
	end
	return store
end

local function get_page_text()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	return table.concat(lines, "\n")
end

local function get_node_text(node)
	local bufnr = vim.api.nvim_get_current_buf()
    return vim.treesitter.get_node_text(node, bufnr)
end

local function find_node(items, kind)
	local function checkpoint(node)
		return node:type() == kind
	end
	for i, item in pairs(items) do
		if checkpoint(item) then
			return item
		end
	end
end

local function get_top_nodes()
	local a = 12
	return 123
end

local function asdf()
	return
end

local function caller(fn)
    success, result = pcall(fn)
    if success then
        maybe_print(result)
    else
        print("failed @ caller for fn", fn)
    end
end

local function one()
	local node = get_function_node()
	local a = get_identifier_node(node)
	local identifier = get_node_text(a)
	local cmd = vim.fn.printf(":lua caller(%s)", identifier)
    vim.cmd(cmd)
end

local function lua_function_caller()
	-- howdy
	local node = get_function_node()

	if node == false then
		print("error for some reason ... no node was found ...")
		return
	end

	local a = get_identifier_node(node)
	local identifier = get_node_text(a)
	local b = find_child_node(node, "block")
	local children = get_child_nodes(node)
	local comment = find_node(children, "comment")
	store = {}
	store.identifier = identifier
	store.arg = ""
	if comment then
		arg = get_node_text(comment)
		store.arg = arg
	end
    maybe_debug(store)
	if identifier == "lua_function_caller" then
		return
	end

	run_lua_function(identifier, arg)
end

local function maybe_debug(x)
    vim.g.state.debug = true
    if vim.g.state.debug == true then
        pause(stringify(store))
    end
end

local function to_line_content(data)
	if type(data) == "table" then
		if is_array(data) then
			return data
		end
		return { vim.fn.json_encode(data) }
	else
		return { data }
	end
end

local function stringify(data)
	if type(data) == "table" then
		return vim.fn.json_encode(data)
	else
		return data
	end
end

local function bash(s)
	os.execute(s)
end

local function bash_smth()
	bash([[
 sudo unzip /mnt/chromeos/Myfiles/Downloads/Hack.zip -d /usr/.local/share/fonts;
 sudo fc-cache -f -v;
 ]])
end

local function sub(s, r, regex, flags)
	if not flags then
		flags = ""
	end
	return vim.fn.substitute(s, r, vim.regex(regex), flags)
end

local function nvim_tree(path)
	local api = require("nvim-tree.api")
	api.tree.open({ path = path })
end

local function get_root_node()
	return vim.treesitter.get_parser():parse()[1]:root()
end

local function get_cursor_node()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }
	local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
	return node
end

local function fuzzyfind(dir)
	if not dir then
		dir = vim.g.state.directories[1]
	end
end

local function nvim_tree_toggle()
	local tree = require("nvim-tree.api").tree
	if tree.is_visible() then
		tree.toggle()
	end
end

local function arrow_right()
	local tree = require("nvim-tree.api").tree
	if tree.is_visible() then
		tree.toggle()
	end
end

local function arrow_left()
	local tree = require("nvim-tree.api").tree
	if tree.is_visible() then
		tree.toggle()
	end
end

local function omni_copy()
	local w = vim.fn.expand("<cword>")
	print(w)
end

local function choose(items, opt)
	local select = vim.ui.select
	if opt.multiple then
		select = vim.ui.select_mult
	end
	local label = opt.label or "item"
	local prompt = vim.fn.printf("please choose a %s", label)

	select(options, {
		prompt = prompt,
	}, opt.callback)
end

local function upper(s)
	return s:upper()
end

local function append(s, i)
	if not i then
		i = vim.fn.line(".")
	end
	vim.api.nvim_buf_set_lines(0, i, i, false, to_lines(s))
end

local function jspy(key, filetype)
	filetype = get_filetype(filetype)
	ref = jspyref[filetype]
	return ref and ref[key]
end

local function vimeval(s)
	-- timestamp
	local aliases = {
		timestamp = "tostring(os.time())",
	}
	local code = aliases[s] or s
	return load(code)
end

local function vt(s, o)
	local function callback(capture)
		local m = jspy(capture)
		if exists(m) then
			return m
		end
		m = vimeval(capture)
		if exists(m) then
			return m
		end
		m = o and o[capture]
		if exists(m) then
			return m
		end
	end
	local r = "%$(%w+)"
	return string.gsub(s, r, callback)
end

local function set_bookmark()
	local choices = { "fix", "todo", "problem" }
	local function callback(label)
		label = upper(label)
		message = vt("$comment_delimiter$timestamp $label: ")
		append(message)
	end
	local a = choose(choices, { label = "bookmark type", callback = callback })
end

local function implicit_anything_handler(arg)
	local items = {
		{
			match = "github",
			callback = clone,
		},
		{
			match = "githubb",
		},
	}
	local opts = imatch(arg, items)
	local params = count_params(v.callback) - 1
	local args = {}
	local function callback(input)
		push(args, input)
	end

	for i = 1, #params do
		local m = vim.fn.printf("requesting arg %s", i)
		prompt(m, callback)
	end

	args = map(args, to_string_argument)
	pause(args)
	status, result = pcall(opts.callback, unpack(args))
	if status then
		print(result)
	end
end

local function to_string_argument(s)
	if is_number(s) then
		return tonumber(s)
	end
	return doublequote(tostring(s))
end

local function to_argument(s)
	if is_number(s) then
		return tonumber(s)
	end
	return tostring(s)
end

local function imatch(arg, items)
	for i, v in pairs(items) do
		if test(arg, v.match) then
			return v
		end
	end
end

local function foobarasd(sadsad) end
local function prompt(message, callback)
	vim.ui.input({ prompt = message }, function(input)
		callback(input)
	end)
end

local function push(base, item)
	if empty(item) then
		return
	end
	table.insert(base, item)
end

local function fzf_query_directory(s)
	local q =
		[[find $(pwd) -regextype posix-extended -type f | grep -vE '(fonts|.git|node_modules|.log$|temp|package)']]
	local actions = {
		["default"] = require("fzf-lua").actions.file_edit,
	}
	require("fzf-lua").fzf_exec(q, { cwd = s, actions = actions })
end

local function abc()
	local a = vim.fn.system('ls ~/LOREMDIR')
    a = prepare_text_input(a)
    print(a)
end

local function four()
	local ids = collect_top_level_identifiers()
	select(ids, regex_find_function)
end

local function formatter(name, template, nodes)
	return s(name, fmta(template, nodes))
end

local function wrapf2(fn)
    local function lambda(...)
        return pcall(fn, unpack({...}))[2]
    end
    return lambda
end

local function booga(s)
    return "a"
end

local function get_identifier_nodes_above_cursor()
    local nodes = {}
    local node = get_cursor_node()
    pause(node:type())
    local s = get_node_text(node)
    pause(s)
    return s
end

local function get_node_info(root)
    return {range = root:range(), text = get_node_text(root), type = root:type()}
end

local function go_file_or_function()
    local a = go_file()
    if a then return end
    if go_function() then return end
    print("no file and no function")
end

local function go_file()
	local a = vim.fn.getline(".")
    local pattern = "%b''"
    local match = string.match(a, pattern)

    if not match or len(match) < 5 then
        pattern = '%b""'
        match = string.match(a, pattern)
    end
    if not match or len(match) < 5 then
        return false
    end
    if match then
        match = string.sub(match, 2, -2)
        pause(match)
        if is_file(match) then
            open_buffer(match)
            return true
        end
    end
    print('no file found in a string')

end

local function go_function()
	local w = vim.fn.expand("<cword>")
	local a = vim.fn.getline(".")
    if test(a, w .. "%(") then
        regex_find_function(w)
        return true
    end
end

local function generate_random_id(length)
    local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    local id = ''
    local random = math.random

    for i = 1, length or 10 do
        id = id .. chars:sub(random(1, #chars), 1)
    end

    return id
end

local function visual_handler()
    fooo()
   -- gccasdf
end

local function get_root_node2()
    local ts_utils = require("nvim-treesitter.ts_utils") 
    local root = ts_utils.get_node_at_cursor()
    return root
end

local function get_visual_selection_lines()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line = start_pos[2]
  local end_line = end_pos[2]

  return {start_line, end_line}
end

local function get_lines(a, b)
    return vim.api.nvim_buf_get_lines(0, a, b, false)
end

local function fooo()
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")
    local line_start = vstart[2] 
    local line_end = vend[2]
    local p = vim.fn.getline(line_start, line_end)
    if true then return print(stringify(p)) end

-- or use api.nvim_buf_get_lines local lines = vim.fn.getline(line_start,line_end)


    local a, b = unpack(get_visual_selection_lines())
    local lines = get_lines(a, b + 1)
    append_file(vim.g.temp_file, lines)

    if true then return end
    local root = get_cursor_node()
        --local next = root:prev_sibling
    print(stringify(get_node_info(root)))


    if true then
        return end
    while root:parent() do
        root = root:parent()
    end
    -- DFS through the tree and find all nodes that have the given type
    local stack = { root }
    local nodes, selections_list = {}, {}
    while #stack > 0 do
        local cur = stack[#stack]
        -- If the current node's type matches the target type, process it
        if is_any_of(cur:type(), node_types) then
            -- Add the current node to the stack
            nodes[#nodes + 1] = cur
            -- Compute the node's selection and add it to the list
            local range = { ts_utils.get_vim_range({ cur:range() }) }
            selections_list[#selections_list + 1] = {
                left = {
                    first_pos = { range[1], range[2] },
                },
                right = {
                    last_pos = { range[3], range[4] },
                },
            }
        end
        -- Pop off of the stack
        stack[#stack] = nil
        -- Add the current node's children to the stack
        for child in cur:iter_children() do
            stack[#stack + 1] = child
        end
    end
end

local function vnoremap(k, v)
    vim.keymap.set('v', k, vim.fn.printf(":'<,'> lua %s()<CR>", v))
end

local function get_decl_node()
    local start = get_far_left_node()
    return start
end

local function get_indent()
    local s = vim.fn.line('.')
    local indent_level = vim.fn.indent(s)
    return indent_level
end

local function create_snippet(s)
    return snippet
end

local function getvis()
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")
    return {start, vend}
end

local function uncomment(s)
    
end

local function add_snippet()
    local s = uncomment(vim.fn.line('.'))
    local key = vim.fn.input("snippet key?")
    local ls = require("luasnip")
    local snippet = ls.parser.parse_snippet(key, expr)
    local ft = get_filetype()
    ls.add_snippets(ft, {
        snippet
    })
end

local function print_node(node)
    pause(stringify(get_node_info(node)))
end

local function get_far_right_node()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local left_of_cursor_range = { cursor[1] - 1, start }
	local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
	return node
end

local function get_far_left_node()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local left_of_cursor_range = { cursor[1] - 1, get_indent() + 1 }
	local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
	return node
end

local function foo_asdfads_bar()
   local aaaa = 1
   return 123
end

local function get_cmd_history()
  local cmd_history = vim.split(vim.cmdline, '\n')
  return cmd_history
end

local function clear_cmd_history()
    vim.opt.cmdline = ""
end

local function parse_query(s)
    return vim.treesitter.query.parse_query("lua", s)
end

local function do_query(query, node)
    local query = parse_query(query)
    for _, matches, _ in ipairs(query:iter_matches(node), 0) do
        local return_type = vim.treesitter.query.get_node_text(matches[1], 0)
        local name = vim.treesitter.query.get_node_text(matches[2], 0)
        local param_node = matches[3]
        local param_info = {}

        for param in param_node:iter_children() do
            if param:type() == "formal_parameter" then
                table.insert(param_info, {
                    type = vim.treesitter.query.get_node_text(param:field("type")[1], 0),
                    name = vim.treesitter.query.get_node_text(param:field("name")[1], 0),
                })
            end
        end

        return {
            return_type = return_type,
            name = name,
            param_info = param_info,
            start_line = method_node:start(),
        }
    end
end

local function get_identifier_node_left_of_cursor()
	local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1
    local col = get_indent()
    pause("hI")

    local c = 0
    while c < 10 do
        c = c + 1
        local node = vim.treesitter.get_node({ pos = {row, col} })
        if node:type() == "block" then
            col = col + 1
        else
            local cccc = 0
            print_node(node)
            return pause(find_child_node(node, "identifier"))
        end
    end
    return 'error: no node found'
end

local function prepare_text_input(s)
    return sub(s, "\n", "\\n")
end

local function get_identifier()
    return fli("^function (%w+)")
end

local function run_lua_function_with_identifier()
    local arg = get_identifier()
    run_lua_function(arg)
end

local function redirector(cmd)
    -- Redirect the output of `:highlight` to the temporary file
    local tmp_file = "/home/kdog3682/del.txt"
    vim.cmd("redir! > " .. tmp_file)
    vim.cmd("silent " .. cmd)
    vim.cmd("redir END")
end

local function remove_items(sources, targets)
    for i = #sources, 1, -1 do
        if contains(targets, sources[i]) then
            table.remove(sources, i)
        end
    end
    return sources
end

local M = {}

M.ExportTreeAsJSON2 = ExportTreeAsJSON2
M.ToggleComment = ToggleComment
M.abc = abc
M.add_snippet = add_snippet
M.anything_handler = anything_handler
M.append = append
M.append_file = append_file
M.arrow_left = arrow_left
M.arrow_right = arrow_right
M.asdf = asdf
M.bash = bash
M.bash_smth = bash_smth
M.booga = booga
M.caller = caller
M.chdir = chdir
M.choose = choose
M.clear_cmd_history = clear_cmd_history
M.clip = clip
M.clone = clone
M.command = command
M.create_snippet = create_snippet
M.do_query = do_query
M.doublequote = doublequote
M.edit_dated_note_file = edit_dated_note_file
M.eval = eval
M.execute = execute
M.execute_command = execute_command
M.exists = exists
M.find_child_node = find_child_node
M.find_line = find_line
M.find_node = find_node
M.find_parent_node = find_parent_node
M.foo = foo
M.foo_asdfads_bar = foo_asdfads_bar
M.foobarasd = foobarasd
M.fooo = fooo
M.formatter = formatter
M.four = four
M.fuzzyfind = fuzzyfind
M.fzf = fzf
M.fzf_query_directory = fzf_query_directory
M.generate_random_id = generate_random_id
M.get_buffers = get_buffers
M.get_child_nodes = get_child_nodes
M.get_cmd_history = get_cmd_history
M.get_current_buffer = get_current_buffer
M.get_current_buffer_directory = get_current_buffer_directory
M.get_cursor_node = get_cursor_node
M.get_decl_node = get_decl_node
M.get_far_left_node = get_far_left_node
M.get_far_right_node = get_far_right_node
M.get_filetype = get_filetype
M.get_function_node = get_function_node
M.get_identifier = get_identifier
M.get_identifier_node = get_identifier_node
M.get_identifier_node_left_of_cursor = get_identifier_node_left_of_cursor
M.get_identifier_nodes_above_cursor = get_identifier_nodes_above_cursor
M.get_indent = get_indent
M.get_line = get_line
M.get_lines = get_lines
M.get_node_info = get_node_info
M.get_node_text = get_node_text
M.get_page_text = get_page_text
M.get_prev_buffer = get_prev_buffer
M.get_prev_buffer_directory = get_prev_buffer_directory
M.get_root_node = get_root_node
M.get_root_node2 = get_root_node2
M.get_set_line = get_set_line
M.get_set_node = get_set_node
M.get_top_nodes = get_top_nodes
M.get_visual_selection_lines = get_visual_selection_lines
M.getline = getline
M.getvis = getvis
M.git_push_directory = git_push_directory
M.go_file = go_file
M.go_file_or_function = go_file_or_function
M.go_function = go_function
M.head = head
M.help = help
M.imatch = imatch
M.implicit_anything_handler = implicit_anything_handler
M.indent = indent
M.inoremap = inoremap
M.is_array = is_array
M.is_boolean = is_boolean
M.is_file = is_file
M.is_filetype = is_filetype
M.is_number = is_number
M.is_object = is_object
M.is_string = is_string
M.is_table = is_table
M.join = join
M.jspy = jspy
M.keys = keys
M.len = len
M.ls_root_files = ls_root_files
M.lua_bufwrite_callback = lua_bufwrite_callback
M.lua_function_caller = lua_function_caller
M.map = map
M.match = match
M.maybe_debug = maybe_debug
M.maybe_print = maybe_print
M.motion_qw = motion_qw
M.noremap = noremap
M.nvim_tree = nvim_tree
M.nvim_tree_toggle = nvim_tree_toggle
M.omni_copy = omni_copy
M.omni_toggle = omni_toggle
M.one = one
M.open = open
M.open_buffer = open_buffer
M.open_file = open_file
M.open_prev_buffer = open_prev_buffer
M.opposite = opposite
M.parse_query = parse_query
M.pause = pause
M.prepare_text_input = prepare_text_input
M.prettier = prettier
M.print_factory = print_factory
M.print_node = print_node
M.prompt_for_input = prompt_for_input
M.push = push
M.qg_input = qg_input
M.redirector = redirector
M.reload_vim = reload_vim
M.reloader = reloader
M.remove_items = remove_items
M.repeatstr = repeatstr
M.replace_word_under_cursor = replace_word_under_cursor
M.resourcer = resourcer
M.run_lua_function = run_lua_function
M.run_lua_function_with_identifier = run_lua_function_with_identifier
M.run_python_function = run_python_function
M.see = see
M.select_item = select_item
M.set_bookmark = set_bookmark
M.simple_comment = simple_comment
M.smart_dash = smart_dash
M.statusline = statusline
M.stringify = stringify
M.sub = sub
M.tail = tail
M.temp = temp
M.tern = tern
M.test = test
M.to_argument = to_argument
M.to_array = to_array
M.to_line_content = to_line_content
M.to_lines = to_lines
M.to_string_argument = to_string_argument
M.toggle = toggle
M.toggler = toggler
M.trim = trim
M.uncomment = uncomment
M.upper = upper
M.vimeval = vimeval
M.visual_handler = visual_handler
M.vnoremap = vnoremap
M.vt = vt
M.wrapf2 = wrapf2
M.print_table_contents = print_table_contents

return M
