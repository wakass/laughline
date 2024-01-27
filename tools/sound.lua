function make_note(pitch, instr, vol, effect)
  return { pitch + 64*(instr%4) , 16*effect + 2*vol + flr(instr/4) } -- flr may be redundant when this is poke'd into memory
end

function get_note(sfx, time)
  local addr = 0x3200 + 68*sfx + 2*time
  return { peek(addr) , peek(addr + 1) }
end

function set_note(sfx, time, note)
  local addr = 0x3200 + 68*sfx + 2*time
  poke(addr, note[1])
  poke(addr+1, note[2])
end

function get_speed(sfx)
  return peek(0x3200 + 68*sfx + 65)
end

function set_speed(sfx, speed)
  poke(0x3200 + 68*sfx + 65, speed)
end

function get_loop_start(sfx)
  return peek(0x3200 + 68*sfx + 66)
end

function get_loop_end(sfx)
  return peek(0x3200 + 68*sfx + 67)
end

function set_loop(sfx, start, stop)
  local addr = 0x3200 + 68*sfx
  poke(addr + 66, start)
  poke(addr + 67, stop)
end