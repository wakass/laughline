-- heart
heart=entity:extend({
	w=5,
	h=5,
	pool={},

	draw=function(_ENV)
		print("♥",x,y,8)
	end,

	create_spark=function(_ENV)
		spark({
			x=x-2+rnd(9),
			y=y-2+rnd(4),
			frames=4+rnd(4),
		})
	end
})