local Button = require('app.Button')
local waves = require('eng.waves')
local fonts = require('eng.fonts')

local b1 = Button.create_from_text('Exit', 100, 60)
local b2 = Button.create_from_text('Play door sound', 100, 260)
local b3 = Button.create_from_text('Stop music', 300, 60)
local b4 = Button.create_from_file('textures/ima.bmp', 300, 260)

local door = waves.get('waves/door.wav')
local musicloop = waves.get('music/menu.wav'):loop()

function on_draw()
	b1:draw()
	b2:draw()
	b3:draw()
	b4:draw()
end

function on_touch(x, y) 
	if b1:contains(x, y) then quit() end
	if b2:contains(x, y) then door:play() end
	if b3:contains(x, y) then musicloop:stop() end
end

