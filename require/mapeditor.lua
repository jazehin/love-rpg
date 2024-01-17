local me = {}
local firstPrint = true
local btnTexts =       {"New tileset", "Delete tileset", "New map", "Edit map", "Delete map"}
local btnReturnTexts = {"new_tileset", "delete_tileset", "new_map", "edit_map", "delete_map"}
local width, height = love.graphics.getDimensions()

function me.drawMenu() 
    local x, y = love.mouse.getPosition()

    local font = love.graphics.getFont()
    local text = love.graphics.newText(font, "Map Editor")
    local twidth, theight = text:getDimensions()
    love.graphics.draw(text, math.floor(width / 2 - twidth / 2), math.floor(height / 4 - theight / 2))

    local bwidth, bheight = width / #btnTexts, height / 2
    for i, btext in ipairs(btnTexts) do
        love.graphics.rectangle("line", (i-1) * bwidth, bheight, bwidth, bheight)
        local bttext = love.graphics.newText(font, btext)
        local btwidth, btheight = text:getDimensions()
        love.graphics.draw(bttext, math.floor((i-1) * bwidth + bwidth / 2 - btwidth / 2), math.floor(bheight + bheight / 2 - btheight / 2))
    end

    firstPrint = false
end

function me.getClickedButton(x, y)
    if y < height / 2 then
        return "none"
    else
        return btnReturnTexts[math.ceil(x / (width / #btnTexts))]
    end
end

return me