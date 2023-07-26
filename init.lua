--[[
    Created by scottricity

    Credit/Sources;
    - https://stackoverflow.com/a/24213274
]]

local util = {}

function util.clamp(component)
    return math.min(math.max(component, 0), 255)
end

function util.getLuminance(color3: Color3|{R: number, G: number, B: number}, method: string|"Relative"|"Contrast"|"HSP"?)
    local default = method or "Relative"
    local sets = {
        ["Relative"] = function(c)
            return (0.2126 * c.R + 0.7152 * c.G + 0.0722 * c.B)
        end;
        ["Contrast"] = function(c)
            return (0.299 * c.R + 0.587 * c.G + 0.114 * c.B)
        end;
        ["HSP"] = function(c)
            return math.sqrt(0.299 * c.R^2 + 0.587 * c.G^2 + 0.114 * c.B^2)            
        end
    }
    return sets[default](color3)
end

function util.HexToRGB(hexDecimal: number)
    local r = util.clamp(math.floor(hexDecimal / 0x10000))
    local g = util.clamp(math.floor(hexDecimal / 0x100) % 0x100)
    local b = util.clamp(hexDecimal % 0x100)
    return {R = r, G = g, B = b}
end

function util.LightenDarkenColor(col, amt: number)
	local num = tonumber(col, 16)
	local r = math.floor(num / 0x10000) + amt
	local g = (math.floor(num / 0x100) % 0x100) + amt
	local b = (num % 0x100) + amt
	return string.format("0x%d", util.clamp(r) * 0x10000 + util.clamp(g) * 0x100 + util.clamp(b))
  end

return util