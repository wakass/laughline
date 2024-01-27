game_scene=scene:extend({
	--[[
	x type of humor each a color
	player selects a color from the GUI
	player moves to a location on the map (level)
	on the map there are multiple entities (cities)
	humor is a circle increasing over time
	if a circle hits a city the city is influenced
	different cities have different properties (sensitifity to a humor type)
	if the city is triggered it creates a humor circle
	moving costs energy
	placing humer costs energy
	triggering a cirt gives energy
	there is a time limit
	you gain energy slowly
	you can increase the lifetime of the circle	
	]]--
	
	init=function(_ENV)
		music(-1, 1000) --fade out any music playing
	
		global.timer=time_limit*30
		-- spawn player
		map=bg()

		-- spawn player
		player=person()

		-- spawn cities
		while #city.pool < n_cities do
			local obj=city({
				x=8+rnd(107),
				y=16+rnd(99),
				humor_type= rnd(n_humor_types),
				humor_level=rnd(10),
				humor_decay=rnd(10)/10,
				humor_sensitivity=rnd(5),
				
				
			})
			
			-- destroy if colliding
			--obj:detect(player,function()
			--	obj:destroy()
			--end)
		end
	end,

	update=function(_ENV)
		entity:each("update")

		-- detect city touched by humor

	
		city:each("detect",function(obj)
			sfx(0)
			global.score+=1
		end
		)
		
		-- check win state
		if #city.pool==0 then
			if level == 9 then
				scene:load(game_win_scene)
			else
				global.level+=1
				scene:load(game_scene)
			end
		end

		-- check game over state
		if timer==0 then
			scene:load(game_over_scene)
		end

		global.timer=max(0,timer-1)
	end,

	draw=function(_ENV)
		add(entity.pool,del(entity.pool,player,map))
		entity:each("draw")	
	end,
})