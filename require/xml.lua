local xml = {}

function xml.loadSaves(numberOfSaves)
    local saves = {}
    local numberOfSaves = 0

    for i = 1, numberOfSaves do 
        saves[i] = {
            variables = {},
            flags = {}
        }

        local filename = string.format("save%s.xml", misc.formatNumber(i))
        local info = love.filesystem.getInfo(filename)
        if info then
            local control = 0
            --[[
                x -> <?xml version="1.0" encoding="UTF-8"?>
                x -> <state>
                x ->    <variables>
                1 ->        reading variables
                2 ->    </variables>
                x ->    <flags>
                3 ->        reading flags
                4 ->    </flags>
                x -> </state> => done
            ]]

            for line in love.filesystem.lines(filename) do
                if line == "    <variables>" then
                    control = 1
                elseif line == "    </variables>" then
                    control = 2
                elseif line == "    <flags>" then
                    control = 3
                elseif line == "    </flags>" then
                    control = 4
                elseif control == 1 then
                    --reading variables
                    words = {}
                    for word in string.gmatch(line, "(\".-\")") do
                        table.insert(words, string.sub(word, 2, #word - 1))
                    end

                    if words[1] == "string" then
                        saves[i]["variables"][words[2]] = words[3]
                    elseif words[1] == "number" then
                        saves[i]["variables"][words[2]] = tonumber(words[3])
                    --elseif words[1] == "bool" then
                    --    saves[i]["variables"][words[2]] = words[3] == true
                    end
                elseif control == 3 then
                    --reading flags(/bools)
                    words = {}
                    for word in string.gmatch(line, "(\".-\")") do
                        table.insert(words, string.sub(word, 2, #word - 1))
                    end

                    saves[i]["flags"][words[1]] = words[2] == "true"
                end
            end

            numberOfSaves = numberOfSaves + 1
        end
    end

    return saves, (numberOfSaves == 0)
end

function xml.loadTilesets()
    local dir = "res/"
    local filename = dir .. "maps/tilesets.xml"
    local tilesets = {}

    for line in love.filesystem.lines(filename) do
        local ts = {}
        local tsName
        local tsSource
        local tsSize
        local control = 0
        --[[
            x -> <?xml version="1.0" encoding="UTF-8"?>
            x -> <tilesets>
            1 ->    reading tilesets
            2 -> </tilesets> => done
        ]]

        for line in love.filesystem.lines(filename) do
            if line == "<tilesets>" then
                control = 1
            elseif line == "</tilesets>" then
                control = 2
            elseif control == 1 then
                words = {}
                for word in string.gmatch(line, "(\".-\")") do
                    table.insert(words, string.sub(word, 2, #word - 1))
                end

                tsName = words[1]
                tsSource = dir .. words[2]
                tsSize = tonumber(words[3])

                local img = love.graphics.newImage(tsSource)
                local imgWidth, imgHeight = img:getDimensions()

                assert(imgWidth % tsSize == 0 and imgHeight % tsSize == 0, string.format("Invalid image as spritesheet in \"%s\": %s is %dx%d and thus cannot be divided into %dx%d indices!", tsName, tsSource, imgWidth, imgHeight, tsSize, tsSize))

                
            end
        end
    end
end

function xml.loadMaps()

end

return xml