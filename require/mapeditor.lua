local me = { 
    draw = {},
    click = {},
    type = {}
}
local firstPrint = true
local btnTexts =       {"New tileset", "Delete tileset", "New map", "Edit map", "Delete map"}
local btnReturnTexts = {"new_tileset", "delete_tileset", "new_map", "edit_map", "delete_map"}
local width, height = love.graphics.getDimensions()

local isTextboxActive = false
local textbox = {
    x = 0,
    y = 0,
    text = ""
}

me["draw"]["menu"] = function () 
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

me["draw"]["new_tileset_1"] = function ()
    local font = love.graphics.getFont()
    local text = love.graphics.newText(font, "New tileset name: " .. textbox.text)
    local twidth, theight = text:getDimensions()
    love.graphics.draw(text, 10, 10)

end

me["click"]["menu"] = function (x, y)
    if y > height / 2 then
        return "me_" .. btnReturnTexts[math.ceil(x / (width / #btnTexts))] .. "_1"
    end
end

me["click"]["new_tileset_1"] = function (x, y)

end

me["type"]["menu"] = function () end

me["type"]["new_tileset_1"] = function (key)
    if not isTextboxActive then return end
    local letters = "abcdefghijklmnopqrstuvwxyz0123456789"
    local i = 1
    while i <= string.len(letters) and string.sub(letters, i, i) ~= key do i = i + 1 end
    local isAlphanumeic = i <= string.len(letters)

    if isAlphanumeic then
        textbox.text = textbox.text .. key
    elseif key == "space" then
        textbox.text = textbox.text .. " "
    elseif key == "backspace" then
        textbox.text = string.sub(textbox.text, 1, #textbox.text - 1)
    end
end

return me