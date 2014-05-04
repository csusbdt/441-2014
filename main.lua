local Button = require('app.Button')
local waves = require('app.waves')
local b1 = Button.create_from_file('textures/ima.bmp', 100, 60)
local b2 = Button.create_from_file('textures/ima.bmp', 100, 260)
local door = waves.get('waves/door.wav')
local music = waves.get('music/menu.wav')

-- TODO: need to return something here and enable stopping

local loop = music:loop()

function on_draw()
	b1:draw()
	b2:draw()
end

function on_touch(x, y) 
	if b1:contains(x, y) then quit() end
	if b2:contains(x, y) then door:play() end
	if loop then loop:stop() end
end


