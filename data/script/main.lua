

log "this is for the console."

test()
log "Hi from lua!"
path = PathForData "script/main.lua"
if path then
  log(path:to_s())
else
  log("path not found")
end
path = nil
collectgarbage()

mainmenu_image = Image("image/background/eruta_mainmenu.png")
if mainmenu_image then
  local w = mainmenu_image:w()
  local h = mainmenu_image:h()
  log("Image dimensions:" .. w .. "," .. h)
end

font_tuffy = Font("Tuffy.ttf", 16, 0)
if font_tuffy then
  local w = font_tuffy:w("M")
  local h = font_tuffy:h()
  log("Font:" .. w .. "," .. h)
end



function on_start(s)
  -- log("Start! " .. s)
end

function on_draw()
  log("Draw!")
--  io.write("Draw!\n")  
end


function on_update()
--  io.write("Update!\n")
end








