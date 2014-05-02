local Button = require('app.Button')
local btn = Button.create_from_texture('textures/ima.bmp', 100, 60)

function on_draw()
	btn:draw()
end

function on_touch(x, y) 
	if btn:contains(x, y) then quit() end
end


