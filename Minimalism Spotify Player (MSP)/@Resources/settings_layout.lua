-- settings_layout.lua
-- Manages collapsible sections and audio device list

DEVICES = {}
MAX_DEVICES = 8
FONTS_OPEN = true
AUDIO_OPEN = true
SELECTED = ''

-- Y positions
BASE_X = 40
TITLE_Y = 24
SECTION_FONTS_Y = 64

function Initialize()
    SELECTED = SKIN:GetVariable('AudioDevice') or ''
    RefreshDevices()
    Relayout()
end

function Update()
end

-- ── Layout ────────────────────────────────────────────────────────────────
function Relayout()
    local y = SECTION_FONTS_Y

    -- Fonts toggle button
    SetY('BtnToggleFonts', y)
    if FONTS_OPEN then
        SKIN:Bang('!SetOption BtnToggleFonts Text "▼  Text / Fonts"')
    else
        SKIN:Bang('!SetOption BtnToggleFonts Text "▶  Text / Fonts"')
    end
    y = y + 34

    -- Fonts section contents
    if FONTS_OPEN then
        SetY('LabelTrackFont', y); ShowMeter('LabelTrackFont')
        SetY('BtnTrackFont',   y + 20); ShowMeter('BtnTrackFont')
        SetY('LabelTrackSize', y); ShowMeter('LabelTrackSize')
        SetY('BtnTrackSize',   y + 20); ShowMeter('BtnTrackSize')
        y = y + 62

        SetY('LabelTimeFont', y); ShowMeter('LabelTimeFont')
        SetY('BtnTimeFont',   y + 20); ShowMeter('BtnTimeFont')
        SetY('LabelTimeSize', y); ShowMeter('LabelTimeSize')
        SetY('BtnTimeSize',   y + 20); ShowMeter('BtnTimeSize')
        y = y + 62

        SetY('LabelFontHint', y); ShowMeter('LabelFontHint')
        y = y + 36

        SetY('DividerFonts', y); ShowMeter('DividerFonts')
        y = y + 14
    else
        HideMeter('LabelTrackFont')
        HideMeter('BtnTrackFont')
        HideMeter('LabelTrackSize')
        HideMeter('BtnTrackSize')
        HideMeter('LabelTimeFont')
        HideMeter('BtnTimeFont')
        HideMeter('LabelTimeSize')
        HideMeter('BtnTimeSize')
        HideMeter('LabelFontHint')
        HideMeter('DividerFonts')
    end

    -- Audio toggle button
    SetY('BtnToggleAudio', y)
    if AUDIO_OPEN then
        SKIN:Bang('!SetOption BtnToggleAudio Text "▼  Audio Devices"')
    else
        SKIN:Bang('!SetOption BtnToggleAudio Text "▶  Audio Devices"')
    end
    y = y + 34

    -- Audio section contents
    if AUDIO_OPEN then
        SetY('LabelAudioCurrent', y); ShowMeter('LabelAudioCurrent')
        SetY('BtnRefreshDevices', y - 4); ShowMeter('BtnRefreshDevices')
        y = y + 30

        SetY('BtnResetDevice', y); ShowMeter('BtnResetDevice')
        y = y + 36

        for i = 1, MAX_DEVICES do
            local name = DEVICES[i] or ''
            if name ~= '' then
                SetY('DeviceBtn' .. i, y)
                ShowMeter('DeviceBtn' .. i)
                y = y + 36
            else
                HideMeter('DeviceBtn' .. i)
            end
        end

        SetY('DividerAudio', y); ShowMeter('DividerAudio')
        y = y + 14
    else
        HideMeter('LabelAudioCurrent')
        HideMeter('BtnRefreshDevices')
        HideMeter('BtnResetDevice')
        for i = 1, MAX_DEVICES do
            HideMeter('DeviceBtn' .. i)
        end
        HideMeter('DividerAudio')
    end

    -- Close button always at bottom
    SetY('BtnClose', y + 10)

    SKIN:Bang('!UpdateMeter *')
    SKIN:Bang('!Redraw')
end

-- ── Toggle sections ───────────────────────────────────────────────────────
function ToggleFonts()
    FONTS_OPEN = not FONTS_OPEN
    Relayout()
end

function ToggleAudio()
    AUDIO_OPEN = not AUDIO_OPEN
    Relayout()
end

-- ── Audio devices ─────────────────────────────────────────────────────────
function RefreshDevices()
    local tmpFile = SKIN:GetVariable('CURRENTPATH') .. 'audio_devices.txt'

    local cmd = 'powershell -NoProfile -Command "' ..
        '$d = Get-WmiObject Win32_SoundDevice | Select-Object -ExpandProperty Name | Select-Object -Unique; ' ..
        '$d | Out-File -FilePath \'' .. tmpFile .. '\' -Encoding ASCII"'
    os.execute(cmd)

    DEVICES = {}
    local f = io.open(tmpFile, 'r')
    if f then
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

    UpdateDeviceButtons()
    Relayout()
end

function UpdateDeviceButtons()
    SELECTED = SKIN:GetVariable('AudioDevice') or ''

    for i = 1, MAX_DEVICES do
        local name = DEVICES[i] or ''
        if name ~= '' then
            SKIN:Bang('!SetOption DeviceBtn' .. i .. ' Text "' .. name .. '"')
            if name == SELECTED then
                SKIN:Bang('!SetOption DeviceBtn' .. i .. ' SolidColor "80,180,80,220"')
                SKIN:Bang('!SetOption DeviceBtn' .. i .. ' FontColor "255,255,255,255"')
            else
                SKIN:Bang('!SetOption DeviceBtn' .. i .. ' SolidColor "255,255,255,180"')
                SKIN:Bang('!SetOption DeviceBtn' .. i .. ' FontColor "0,0,0,255"')
            end
            SKIN:Bang('!SetOption DeviceBtn' .. i .. ' LeftMouseUpAction ' ..
                '"[!CommandMeasure MeasureLayout \'Select ' .. i .. '\']"')
        end
    end

    if SELECTED == '' then
        SKIN:Bang('!SetOption LabelAudioCurrent Text "Current device: System default"')
    else
        SKIN:Bang('!SetOption LabelAudioCurrent Text "Current device: ' .. SELECTED .. '"')
    end
end

function Select(idx)
    idx = tonumber(idx)
    if not idx or not DEVICES[idx] then return end
    SELECTED = DEVICES[idx]
    local varFile = SKIN:GetVariable('ROOTCONFIGPATH') .. '@Resources\\variables.inc'
    SKIN:Bang('!WriteKeyValue Variables AudioDevice "' .. SELECTED .. '" "' .. varFile .. '"')
    SKIN:Bang('!Refresh "Minimalizm_Spotify_Visualizer" "MinimalSpotifyVisualizer.ini"')
    UpdateDeviceButtons()
    Relayout()
end

function ResetDevice()
    SELECTED = ''
    local varFile = SKIN:GetVariable('ROOTCONFIGPATH') .. '@Resources\\variables.inc'
    SKIN:Bang('!WriteKeyValue Variables AudioDevice "" "' .. varFile .. '"')
    SKIN:Bang('!Refresh "Minimalizm_Spotify_Visualizer" "MinimalSpotifyVisualizer.ini"')
    UpdateDeviceButtons()
    Relayout()
end

-- ── Helpers ───────────────────────────────────────────────────────────────
function SetY(meter, y)
    SKIN:Bang('!SetOption ' .. meter .. ' Y "' .. math.floor(y) .. '"')
end

function ShowMeter(meter)
    SKIN:Bang('!ShowMeter ' .. meter)
end

function HideMeter(meter)
    SKIN:Bang('!HideMeter ' .. meter)
end
