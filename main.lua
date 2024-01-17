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
    if state == "me_menu" then
		me.drawMenu()
	end
end

function love.mousereleased(x, y, button, istouch, presses)
	if state == "me_menu" then
		local btnPressed = me.getClickedButton(x, y)
		if btnPressed ~= "none" then
			state = "me_" .. btnPressed .. "_1"
			if state == "me_new_tileset_1" then
				xml.loadTilesets()
			end
		end
	end
end