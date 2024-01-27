-- particles

particle=entity:extend({
	frame=0,
	frames=10,
	radius=1,
	color=5,
	sx=0,
	sy=0,
	
	update=function(_ENV)
		x+=sx
		y+=sy
		frame+=1
		
		if frame>=frames then
			destroy(_ENV)
		end
	end,

	draw=function(_ENV)
		local r=(1-frame/frames)*radius
		circfill(x,y,r,color)
	end
})

dust=particle:extend({
	radius=3,
	sy=-.25
})

spark=particle:extend({
	color=10,
	sy=-.5,
})
