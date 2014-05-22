_ENV = {
	read_file  = read_file,
	write_file = write_file,
	string = string,
	pairs = pairs,
	_G = _G
}

function load()
	t = {}
	local data = read_file('history')
	if not data then return end
	for k, v in string.gmatch(data, "([%-_%w]+)=([%/%-_%w]+)") do
		t[k] = v
	end
end

function save()
	local data
	for k, v in pairs(t) do
		data = data and data .. ','
		data = data or ''
		data = data .. k .. '=' .. v
	end
	write_file('history', data)
end

function clear()
	write_file('history', nil)
end

function get(k)
	return t[k]
end

function set(k, v)
	t[k] = v
	save()
end

load()

return {
	clear = clear ,
	get   = get   ,
	set   = set
}

