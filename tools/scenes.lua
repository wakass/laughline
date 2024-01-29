-- scenes
-- global=_ENV

scene=class:extend({
	current=nil,

	update=noop,
	draw=noop,
	start_time=nil,

	destroy=function(_ENV)
		entity:each("destroy")
	end,

	load=function(_ENV,scn)
		start_time = t()
		if current != scn then
			if (current) current:destroy()
			current=scn()
		end
	end
})