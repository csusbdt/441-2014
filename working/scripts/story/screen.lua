_ENV = {
	_G		= _G,
	require 	= require,
	loadfile        = loadfile,
	pcall           = pcall,
	msgbox          = msgbox,
	collectgarbage	= collectgarbage,
	package         = package
}

Button = require('app.Button')
textures = require('res.textures')
dialog_font = require('res.fonts').get('dialog')
waves  = require('res.waves')

function on_draw()
	if p        then p:draw(400, 100) end
	if a1       then a1:draw(100, 50) end
	if a2       then a2:draw(100, 80) end
	if b1       then b1:draw()        end
	if b2       then b2:draw()        end
	if exit_btn then exit_btn:draw()  end
end

function hide()
	p = nil
	a1 = nil
	a2 = nil
	b1 = nil
	b2 = nil
	c1 = nil
	c2 = nil
	music = nil
	_G.on_draw  = nil
	_G.on_touch = nil
	_G.on_keydown_r = nil
	collectgarbage()
end

function return_to_title()
	hide()
	require('title.screen').show()
end

function on_keydown_r()
	hide()
	package.loaded['story.screen'] = nil
	local m = require('story.screen')
	m.show()
	--goto_node(current_node)
end

function on_touch(x, y) 
	if     exit_btn:contains(x, y)  then return_to_title()
	elseif b1 and b1:contains(x, y) then goto_node(c1)
	elseif b2 and b2:contains(x, y) then goto_node(c2) 
	end
end

function show()
	exit_btn = Button.create_from_text('Exit', 40, 400)
	_G.on_draw  = on_draw
	_G.on_touch = on_touch
	_G.on_keydown_r = on_keydown_r
	goto_node('start')
end

function goto_node(node)
	if not node then return_to_title(); return end
	current_node = node
	local file = 'nodes/' .. node .. '.lua'
	local env = {}
	local nodefile, msg = loadfile(file, 't', env)
	if not nodefile then msgbox(msg); return end

	local result, msg = pcall(nodefile)
	if not result then msgbox(msg) return end

	p = nil
	a1 = nil
	a2 = nil
	b1 = nil
	b2 = nil
	c1 = nil
	c2 = nil

	if env.p then p = textures.image('portraits/' .. env.p .. '.bmp') end
	if env.a1 then a1 = textures.text(env.a1, dialog_font) end
	if env.a2 then a2 = textures.text(env.a2, dialog_font) end
	if env.b1 then 
		b1 = Button.create_from_text('a) ' .. env.b1, 50, 300) 
		if env.c1 then c1 = env.c1 end
	end
	if env.b2 then 
		b2 = Button.create_from_text('b) ' .. env.b2, 50, 340) 
		if env.c2 then c2 = env.c2 end
	end
	--music = waves.get('music/MushroomForest.wav'):loop()
end

return {
	show = show
}

