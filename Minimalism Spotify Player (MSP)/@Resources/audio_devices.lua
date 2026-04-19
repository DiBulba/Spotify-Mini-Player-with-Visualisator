-- audio_devices.lua
-- Enumerates audio output devices via PowerShell and populates device buttons

DEVICES = {}
MAX_DEVICES = 8

function Initialize()
    RefreshDevices()
end

function Update()
end

function RefreshDevices()
    local tmpFile = SKIN:GetVariable('CURRENTPATH') .. 'audio_devices.txt'
    
    -- Run PowerShell to get output devices
    local cmd = 'powershell -NoProfile -Command "Get-WmiObject Win32_SoundDevice | Select-Object -ExpandProperty Name | Out-File -FilePath \'' .. tmpFile .. '\' -Encoding UTF8"'
    os.execute(cmd)
    
    -- Read the file
    DEVICES = {}
    local f = io.open(tmpFile, 'r')
    if f then
        -- Skip BOM if present
        local content = f:read('*all')
        f:close()
        content = content:gsub('^\xEF\xBB\xBF', '')
        for line in content:gmatch('[^\r\n]+') do
            line = line:match('^%s*(.-)%s*$')
            if line ~= '' and #DEVICES < MAX_DEVICES then
                table.insert(DEVICES, line)
            end
        end
    end
    
    -- Update all device buttons
    for i = 1, MAX_DEVICES do
        local name = DEVICES[i] or ''
        local hidden = (name == '') and '1' or '0'
        SKIN:Bang('!SetOption DeviceBtn' .. i .. ' Text "' .. name .. '"')
        SKIN:Bang('!SetOption DeviceBtn' .. i .. ' Hidden "' .. hidden .. '"')
        if name ~= '' then
            SKIN:Bang('!SetOption DeviceBtn' .. i .. ' LeftMouseUpAction "[!CommandMeasure MeasureDevices \'Select ' .. i .. '\']"')
        end
    end
    SKIN:Bang('!UpdateMeter *')
    SKIN:Bang('!Redraw')
end

function Select(idx)
    idx = tonumber(idx)
    if DEVICES[idx] then
        local varFile = SKIN:GetVariable('ROOTCONFIGPATH') .. '@Resources\\variables.inc'
        SKIN:Bang('!WriteKeyValue Variables AudioDevice "' .. DEVICES[idx] .. '" "' .. varFile .. '"')
        SKIN:Bang('!Refresh "Minimalizm_Spotify_Visualizer" "MinimalSpotifyVisualizer.ini"')
        SKIN:Bang('!Refresh')
    end
end
