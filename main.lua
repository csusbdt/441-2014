local Button = require('app.Button')
local waves = require('eng.waves')

local b1 = Button.create_from_file('textures/ima.bmp', 100, 60)
local b2 = Button.create_from_file('textures/ima.bmp', 100, 260)
local b3 = Button.create_from_file('textures/ima.bmp', 300, 60)

collectgarbage()

local door = waves.get('waves/door.wav')

local loop = waves.get('music/menu.wav'):loop()

collectgarbage()

function on_draw()
	b1:draw()
	b2:draw()
	b3:draw()
end

function on_touch(x, y) 
	if b1:contains(x, y) then quit() end
	if b2:contains(x, y) then door:play() end
	if b3:contains(x, y) then loop:stop() end
end


