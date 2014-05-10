_ENV = {
	_G      = _G,
	require = require,
	quit    = quit,
	collectgarbage = collectgarbage
}

Button = require('app.Button')
waves  = require('res.waves')

function on_draw()
	b1:draw()
	b2:draw()
	b3:draw()
end

function on_touch(x, y) 
	if b1:contains(x, y) then 
		quit() 
	elseif b2:contains(x, y) then
		exit()
		require('ttt.screen').show()
	elseif b3:contains(x, y) then
		collectgarbage()
	end
end

function show()
	b1 = Button.create_from_text('Exit', 100, 100)
	b2 = Button.create_from_text('Play Tic Tac Toe', b1.x, b1.y + 32)
	b3 = Button.create_from_text('Run Garbage Collector', b2.x, b2.y + 32)
	music = waves.get('music/Overworld.wav'):loop()
	_G.on_draw  = on_draw
	_G.on_touch = on_touch
end

function exit()
	music:stop() 
	music = nil
	b1 = nil
	b2 = nil
	_G.on_draw  = nil
	_G.on_touch = nil
	collectgarbage()
end

return {
	show  = show,
	exit  = exit
}

