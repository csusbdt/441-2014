local textures    = require('eng.textures')
local button_font = require('eng.fonts').get('button')

local button_mt = {}

button_mt.__index = button_mt;

function button_mt.draw(self)
	self.t:draw(self.x, self.y) 
end

function button_mt.contains(self, x, y)
	return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
end

local function create_from_file(filename, x, y, w, h)
	local t = textures.image(filename)
	local o = { t = t, x = x or 0, y = y or 0, w = w or t.w, h = h or t.h }
	setmetatable(o, button_mt)
	return o
end

local function create_from_text(text, x, y, font)
	local t = textures.text(text, font or button_font)
	local o = { t = t, x = x or 0, y = y or 0, w = t.w, h = t.h }
	setmetatable(o, button_mt)
	return o
end

return {
	create_from_file = create_from_file,
	create_from_text = create_from_text
}

