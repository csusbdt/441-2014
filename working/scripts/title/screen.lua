_ENV = {
	_G             = _G,
	require        = require,
	quit           = quit,
	collectgarbage = collectgarbage,
	package        = package,
read_file = read_file
}

Button = require('app.Button')
waves  = require('res.waves')

function on_draw()
	b1:draw()
	b2:draw()
	b3:draw()
	b4:draw()
end

function on_touch(x, y) 
	if b1:contains(x, y) then 
		hide()
		require('story.screen').show()
	elseif b2:contains(x, y) then
		hide()
		require('tic.screen').show()
	elseif b3:contains(x, y) then
		if package.loaded['story.screen'] then
			package.loaded['story.screen'] = nil
		end
	elseif b4:contains(x, y) then
		hide()
		quit()
	end
end

function show()
	b1 = Button.create_from_text('Story', 100, 100)
	b2 = Button.create_from_text('Tic Tac Toe', b1.x, b1.y + 32)
	b3 = Button.create_from_text('Reload story.screen module.', b2.x, b2.y + 32)
	b4 = Button.create_from_text('Exit', b3.x, b3.y + 32)
	music = waves.get('music/Overworld.wav'):loop()
	_G.on_draw  = on_draw
	_G.on_touch = on_touch
end

function hide()
	music:stop() 
	music = nil
	b1 = nil
	b2 = nil
	b3 = nil
	b4 = nil
	_G.on_draw  = nil
	_G.on_touch = nil
	collectgarbage()
end

return {
	show  = show
}

