--local Button = require('app.Button')
--local quit_btn = Button.create_from_texture('assets/textures/mybutton.bmp', 100, 60)

function on_draw()
	--quit_btn:draw()
end

function on_touch(x, y) 
	msgbox("x = " .. x .. "   y = " .. y)
end


