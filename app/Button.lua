local Texture = require('app.Texture')

local mt = {}

mt.__index = mt;

function mt.draw(self)
	self.t:draw(self.x, self.y) 
end

function mt.contains(self, x, y)
	return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
end

local function create_from_file(filename, x, y, w, h)
	local t = Texture.load(filename)
	local o = { t = t, x = x or 0, y = y or 0, w = w or t.w, h = h or t.h }
	setmetatable(o, mt)
	return o
end

return {
	create_from_file = create_from_file
}

