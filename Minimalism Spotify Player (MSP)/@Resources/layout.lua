function Initialize() Update() end
function Update() end

local function vars()
    local pos  = tonumber(SKIN:GetVariable('CoverPosition')) or 0
    local w    = tonumber(SKIN:GetVariable('Width'))         or 372
    local h    = tonumber(SKIN:GetVariable('Height'))        or 125
    local sz   = tonumber(SKIN:GetVariable('CoverSize'))     or 64
    local pad  = tonumber(SKIN:GetVariable('CoverPadding'))  or 8
    return pos, w, h, sz, pad
end

function CoverX()
    local pos, w, h, sz, pad = vars()
    if pos == 0 then return pad
    elseif pos == 1 then return math.floor((w - sz) / 2)
    else return w - sz - pad
    end
end

function CoverY()
    local pos, w, h, sz, pad = vars()
    return math.floor((h - sz) / 2)
end

function TextCenterX()
    local pos, w, h, sz, pad = vars()
    if pos == 0 then
        local start = sz + pad * 2
        return start + math.floor((w - start) / 2)
    elseif pos == 2 then
        return math.floor((w - sz - pad * 2) / 2)
    else
        return math.floor(w / 2)
    end
end

function TextW()
    local pos, w, h, sz, pad = vars()
    if pos == 0 or pos == 2 then
        return w - sz - pad * 3
    else
        return w - pad * 2
    end
end

function TextY()
    return 10
end

function BarStartX()
    local pos, w, h, sz, pad = vars()
    if pos == 0 then
        return sz + pad * 2
    else
        return 10
    end
end

function ProgressX()
    return BarStartX()
end

function BtnPrevX()
    return TextCenterX() - 40
end

function BtnPlayX()
    return TextCenterX()
end

function BtnNextX()
    return TextCenterX() + 40
end
