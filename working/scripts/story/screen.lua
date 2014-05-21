_ENV = {
	_G		= _G,
	require 	= require,
	load            = load,
	pcall           = pcall,
	msgbox          = msgbox,
	collectgarbage	= collectgarbage,
	package         = package,
	load_chunk      = load_chunk,
	read_file       = read_file,
	write_file      = write_file
}

Button      = require('app.Button')
textures    = require('res.textures')
dialog_font = require('res.fonts').get('dialog')
waves       = require('res.waves')
history     = require('app.history')

if not history.get('current_node') then
	history.set('current_node', 'start')
end

function on_draw()
	if p        then  p:draw(400, 100) end
	if a1       then a1:draw(100,  50) end
	if a2       then a2:draw(100,  80) end
	if b1       then b1:draw()         end
	if b2       then b2:draw()         end
	if exit_btn then exit_btn:draw()   end
end

-- On R key down, reload the story screen.
function on_keydown_r()
	hide()
	package.loaded['story.screen'] = nil
	require('story.screen').show()
end

function hide()
	mi               = nil
	p                = nil
        a1               = nil
        a2               = nil
        b1               = nil
        b2               = nil
        c1               = nil
        c2               = nil
	_G.on_draw       = nil
	_G.on_touch      = nil
	_G.on_keydown_r  = nil
	collectgarbage()
end

function on_touch(x, y) 
	if exit_btn:contains(x, y) then 
		hide()
		require('title.screen').show()
	elseif b1 and b1:contains(x, y) then 
		goto_node(c1)
	elseif b2 and b2:contains(x, y) then 
		goto_node(c2) 
	end
end

function show()
	exit_btn        = Button.create_from_text('Exit', 40, 400)
	_G.on_draw      = on_draw
	_G.on_touch     = on_touch
	_G.on_keydown_r = on_keydown_r
	goto_node(history.get('current_node'))
end

function end_story()
	history.clear()
	history.set('current_node', 'start')
	hide()
	require('title.screen').show()
end

function goto_node(node)
	if not node then 
		end_story() 
		return
	end
	local chunk = load_chunk('nodes/' .. node .. '.lua')
	if not chunk then
		msgbox(file .. ' not found.') 
		return 
	end
	local env = { history = history }
	local n, msg = load(chunk, nil, 't', env)
	if not n then 
		msgbox(msg)
		goto_node(history.get('current_node'))
		return 
	end
	local status, msg = pcall(n)
	if not status then 
		msgbox(msg)
		goto_node(history.get('current_node'))
		return 
	end

	p  = env.p  and textures.image('portraits/' .. env.p .. '.bmp')

	a1 = env.a1 and textures.text(env.a1, dialog_font)
	a2 = env.a2 and textures.text(env.a2, dialog_font)

	b1 = env.b1 and Button.create_from_text('a) ' .. env.b1, 50, 300)
	b2 = env.b2 and Button.create_from_text('b) ' .. env.b2, 50, 340)

	c1 = b1 and env.c1 
	c2 = b2 and env.c2 

	if not env.m then 
		m  = nil
		mi = nil
	elseif m ~= env.m then
		m  = env.m
		mi = waves.get('music/' .. music .. '.wav')
		if mi then
			mi:loop()
		else
			msgbox('Unknown music: ' .. m)
			m = nil
		end
	end

	history.set('current_node', node)
end

return {
	show = show
}

