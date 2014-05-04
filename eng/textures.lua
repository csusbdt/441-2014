local textures = {}
setmetatable(textures, { __mode = 'v' })

local texture_mt = {}

texture_mt.__index = texture_mt;

function texture_mt:__gc()
	destroy_texture(self.t)
	textures[self.filename] = nil
end

function texture_mt:draw(x, y, w, h)
	render_texture(self.t, 0, 0, self.w, h or self.h, x or 0, y or 0, self.w, self.h) 
end

local function get(filename)
	if textures[filename] then 
		return textures[filename]
	end
	local o = { filename = filename }
	o.t, o.w, o.h = texture_from_file(filename)
	setmetatable(o, texture_mt)
	textures[filename] = o
	return o
end

return {
	get = get
}

