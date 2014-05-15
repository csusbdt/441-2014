_ENV = {
	_G		= _G,
	require 	= require,
	collectgarbage	= collectgarbage,
	dx		= app.dialog_x,
	dy		= app.dialog_y
}

Button = require('app.Button')
textures = require('res.textures')
dialog_font = require('res.fonts').get('dialog')
waves  = require('res.waves')

function on_draw()
	b1:draw()
	ima:draw()
	if dialog then dialog:draw(dx, dy) end
end

function on_touch(x, y) 
	if b1:contains(x, y) then 
		hide()
		require('title.screen').show()
	elseif ima:contains(x, y) then 
		dialog = textures.text('You clicked me.', dialog_font)
	end
end

function show()
	b1 = Button.create_from_text('Back to Title', 50, 30)
	ima = Button.create_from_file('textures/ima.bmp', 300, 260)
	music = waves.get('music/MushroomForest.wav'):loop()
	_G.on_draw  = on_draw
	_G.on_touch = on_touch
end

function hide()
	music:stop() 
	music = nil
	b1 = nil
	ima = nil
	dialog = nil
	_G.on_draw  = nil
	_G.on_touch = nil
	collectgarbage()
end

return {
	show = show,
	exit = exit
}

