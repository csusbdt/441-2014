local waves = {}
setmetatable(waves, { __mode = 'v' })

local mt = {}

mt.__index = mt;

function mt.__gc(self)
	destroy_wave(self.w)
	waves[self.filename] = nil
end

function mt.play(self)
	play_wave(self.w) 
end

function mt.loop(self)
	return loop_wave(self.w) 
end

local function get(filename)
	if waves[filename] then 
		return waves[filename]
	end
	local o = { filename = filename }
	o.w = wave_from_file(filename)
	setmetatable(o, mt)
	waves[filename] = o
	return o
end

return {
	get = get
}

