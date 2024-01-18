local misc = {}

--from an answer on https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console by JCH2k
function misc.tprint (tbl, indent) 
	if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            misc.tprint(v, indent+1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))      
        elseif type(v) ~= 'userdata' then
            print(formatting .. v)
        else
            print(formatting .. type(v))
        end
	end
end

function misc.formatNumber(num)
    if num < 10 then
        return string.format("0%d", num)
    else
        return string.format("%d",  num)
    end
end

return misc