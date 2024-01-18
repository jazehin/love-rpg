local debug = true
local mapeditor = true

local state

local xml
local numberOfSaves = 30
local saves = {}
local hasNoSaves
local currentlyPlaying

local misc

function love.load()
    love.filesystem.setRequirePath("require/?.lua")
	misc = require "misc"
	xml = require "xml"
	
    if mapeditor then
		me = require "mapeditor"
		state = "me_menu"
    else
		saves, hasNoSaves = xml.loadSaves(numberOfSaves)
		state = "menu"
	end

    --[[
    local info = love.filesystem.getInfo( "save.dat" )
    if info then
        exists = "true"
    else
        exists = "false"
        love.filesystem.write( "save.dat", "dummy data" )
    end
    ]]
end

function love.update(dt)
    
end

function love.draw()
    if string.sub(state, 1, 2) == "me" then
		me["draw"][string.sub(state, 4)]()
	end
end

function love.mousereleased(x, y, button, istouch, presses)
	if string.sub(state, 1, 2) == "me" then
		local tmpState = me["click"][string.sub(state, 4)](x, y, button, istouch, presses)
		state = tmpState and tmpState or state
	end
end

function love.keypressed(key, scancode, isrepeat)
	if string.sub(state, 1, 2) == "me" then
		me["type"][string.sub(state, 4)](key, scancode, isrepeat)
	end
end