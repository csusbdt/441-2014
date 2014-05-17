_ENV = {
	_G		= _G,
	require 	= require,
	loadfile        = loadfile,
	pcall           = pcall,
	collectgarbage	= collectgarbage
}

Button = require('app.Button')
textures = require('res.textures')
dialog_font = require('res.fonts').get('dialog')
waves  = require('res.waves')

function on_draw()
	if s1       then s1:draw(100, 50) end
	if s2       then s2:draw(100, 80) end
	if p        then p:draw(300, 300) end
	if a1       then a1:draw() end
	if a2       then a2:draw() end
	if exit_btn then exit_btn:draw() end
end

function on_touch(x, y) 
	if exit_btn:contains(x, y) then 
		hide()
		require('title.screen').show()
		return
	end
	if a1:contains(x, y) then 
		node(r1)
	end
end

function show()
	exit_btn = Button.create_from_text('Exit', 350, 330)
	--music = waves.get('music/MushroomForest.wav'):loop()
	_G.on_draw  = on_draw
	_G.on_touch = on_touch
end

function hide()
	s1 = nil
	s2 = nil
	a1 = nil
	a2 = nil
	r1 = nil
	r2 = nil
	music = nil
	_G.on_draw  = nil
	_G.on_touch = nil
	collectgarbage()
end

function node(node)
	s1 = nil
	s2 = nil
	a1 = nil
	a2 = nil
	r1 = nil
	r2 = nil
	local env = {}
	local n = loadfile('nodes/' .. node .. '.lua', 't', env)
	n()
	if env.s1 then s1 = textures.text(env.s1, dialog_font) end
	if env.s2 then s2 = textures.text(env.s2, dialog_font) end
	if env.a1 then 
		a1 = Button.create_from_text(env.a1, 50, 200) 
		r1 = env.r1
	end
end

node('start')

return {
	show = show
}

