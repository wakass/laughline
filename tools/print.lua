-- print title
function print_title(str,y,clr)
	poke(0x5f58,0x81)
	local x=64-(#str*8)/2
	print(str,x,y+2,13)
	print(str,x,y,clr)
	poke(0x5f58,0x01)
end

-- print centered
function printc(str,y,clr)
	local x=64-(#str*4)/2
	print(str,x,y,clr)
end

-- print shadow
function prints(str,x,y,clr)
	print(str,x+1,y+1,0)
	print(str,x,y,clr)
end

-- left pad
function pad(str,len,char)
	str=tostr(str)
	char=char or "0"
	if (#str==len) return str
	return char..pad(str, len-1)
end

function draw_foo(x, y, size, color, bgcolor)
		local size = size or 2
		local color = color or 7
		local bgcolor = bgcolor or 1
	
		circ(x+(size*2),y+(size*11),size,color)
		rectfill(x+size, y+(size*10), x+(size*3), y+(size*11), bgcolor)		
		circ(x+size,y+(size*10),size,color)
		
		circ(x+(size*4),y+size,size,color)
		rectfill(x+(size*3), y+(size), x+(size*5), y+(size*2), bgcolor)	
		circ(x+(size*5),y+(size*2),size,color)
		
		line(x+(size*3),y+(size*11), x+(size*3), y+(size),color)
		line(x+(size*2),y+(size*6)-1, x+(size*4), y+(size*6)-1, color)
		line(x+(size*2),y+(size*6)+1, x+(size*4), y+(size*6)+1, color)
end

function draw_sickhouse(x,y)
	palt(0,false)
	palt(7,true)
	sspr(88,0,40,40,x,y)
	palt()
end

function draw_rectfill(x,y,w,h,color)
	rectfill(x,y,x+w,y+h,color)	
end

function draw_ll7(x,y,size,color)
	circfill(x,y,size,color)
	circfill(x+(size*5),y,size,color)
	draw_rectfill(x-(size),y+(size*4),size*7,size,color)
	draw_rectfill(x-(size*2),y+(size*3),size,size,color)
	draw_rectfill(x+(size*6),y+(size*3),size,size,color)
	
	draw_rectfill(x-(size*2),y+(size*7),size*9,size,color)
	
	draw_rectfill(x-(size*3),y+(size*10),size*11,size,color)

end

