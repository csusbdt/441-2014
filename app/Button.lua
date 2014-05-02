local mt = {}

mt.__index = mt;

function mt.__gc(self)
	destroy_texture(self.t)
end

function mt.draw(self)
	render_texture(self.t, self.x, self.y) 
end

function mt.contains(self, x, y)
	return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
end

local function create_from_texture(filename, x, y)
	local b = { x = x or 0, y = y or 0 }
	b.t, b.w, b.h = texture_from_file(filename)
	setmetatable(b, mt)
	return b
end

return {
	create_from_texture = create_from_texture
}

