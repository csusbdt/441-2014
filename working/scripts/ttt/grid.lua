_ENV = {
	_G             = _G,
	require        = require,
	set_draw_color = set_draw_color,
	draw_line      = draw_line,
	setmetatable   = setmetatable,
	math           = math
,print = print
}

Button = require('app.Button')

x1 = 100
x2 = 200
x3 = 300
x4 = 400

y1 = 100
y2 = 200
y3 = 300
y4 = 400

grid_pos_x = 100
grid_pos_y = 100
cell_size = 100

function draw_x(x, y)
	draw_line(x + 30, y + 30, x + 70, y + 70)
	draw_line(x + 70, y + 30, x + 30, y + 70)
end

-- Define metatable for grid cells.
mt = {}
mt.__index = mt
function mt:draw()
	if     self.p == 'x' then draw_x(self.x, self.y)
	elseif self.p == 'o' then draw_o(self.x, self.y)
	end
end

-- Create the grid cells.
c = {}

function draw()
	set_draw_color(255, 255, 255, 255)
	draw_line(x1, y2, x4, y2)
	draw_line(x1, y3, x4, y3)
	draw_line(x2, y1, x2, y4)
	draw_line(x3, y1, x3, y4)
	for i = 1, 3 do
		for j = 1, 3 do
			c[i][j]:draw()
		end
	end
end

function on_touch(x, y) 
	if x < grid_pos_x or x > grid_pos_x + 3 * cell_size then return end
	if y < grid_pos_y or y > grid_pos_y + 3 * cell_size then return end
	local i = math.floor((x - 100) / 100) + 1
	local j = math.floor((y - 100) / 100) + 1
	if c[i][j].p then return end
	c[i][j].p = 'x'
end

function init()
	for i = 1, 3 do
		c[i] = {}
		for j = 1, 3 do
			c[i][j] = { 
				x = grid_pos_x + cell_size * (i - 1), 
				y = grid_pos_y + cell_size * (j - 1)
			}
			--c[i][j].i = i
			--c[i][j].j = j
			setmetatable(c[i][j], mt)
		end
	end
end


return {
	init     = init,
	draw     = draw,
	on_touch = on_touch
}

