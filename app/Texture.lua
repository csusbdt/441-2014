local loaded_textures = {}
setmetatable(loaded_textures, { __mode = 'v' })

local mt = {}

mt.__index = mt;

function mt.__gc(self)
	destroy_texture(self.t)
	loaded_textures[self.filename] = nil
end

function mt.draw(self, x, y, w, h)
	render_texture(self.t, 0, 0, self.w, h or self.h, x or 0, y or 0, self.w, self.h) 
end

local function load(filename)
	if loaded_textures[filename] then 
		return loaded_textures[filename]
	end
	local o = { filename = filename }
	o.t, o.w, o.h = texture_from_file(filename)
	setmetatable(o, mt)
	loaded_textures[filename] = o
	return o
end

return {
	load = load
}

