local fontspecs = { 
	dialog: { filename = 'fonts/DroidSansMono.ttf', size = 16 },
	title: { filename = 'fonts/DroidSansMono.ttf', size = 20 },
}

local fonts = {}
setmetatable(fonts, { __mode = 'v' })

local font_mt = {}

font_mt.__index = font_mt;

function font_mt:__gc()
	close_font(self.ud)
	fonts[self.name] = nil
end

local function get(name)
	if fonts[name] then return fonts[name] end
	for n, s in pairs(fontspecs) do
		if n == name then
			local o = { name = name }
			o.ud = open_font(spec.filename, spec.size)
			setmetatable(o, font_mt)
			fonts[name] = o
			return o
		end
	end
	return nil
end

return {
	get = get
}

