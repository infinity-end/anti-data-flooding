--[[

 █████╗ ███╗   ██╗████████╗██╗    ██████╗  █████╗ ████████╗ █████╗     ███████╗██╗      ██████╗  ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗
██╔══██╗████╗  ██║╚══██╔══╝██║    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗    ██╔════╝██║     ██╔═══██╗██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝
███████║██╔██╗ ██║   ██║   ██║    ██║  ██║███████║   ██║   ███████║    █████╗  ██║     ██║   ██║██║   ██║██║  ██║██║██╔██╗ ██║██║  ███╗
██╔══██║██║╚██╗██║   ██║   ██║    ██║  ██║██╔══██║   ██║   ██╔══██║    ██╔══╝  ██║     ██║   ██║██║   ██║██║  ██║██║██║╚██╗██║██║   ██║
██║  ██║██║ ╚████║   ██║   ██║    ██████╔╝██║  ██║   ██║   ██║  ██║    ██║     ███████╗╚██████╔╝╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝
╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝    ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝

]]

-- Anti Data Flooding
-- GitHub: https://github.com/infinity-end/anti-data-flooding

--- Configuration table for the Anti Data Flooding system.
-- This table defines all settings for controlling data change limits, bans, and kicks.
local CONFIG = {
    ANTI_DATA_FLOODING = {
        --- Enables or disables the entire anti-data-flooding system.
        -- @type boolean
        -- @default true
        ENABLED = true,

        --- Maximum allowed size for data values (in bytes) passed to setElementData.
        -- Prevents oversized data from causing server lag or crashes.
        -- @type number
        -- @default 1024
        DATA_SIZE_LIMIT = 1024,

        --- Regular expression pattern for valid data keys in setElementData.
        -- Only keys matching this pattern are allowed (e.g., alphanumeric, underscore, dot, colon).
        -- @type string
        -- @default [a-zA-Z0-9_.:]
        KEY_PATTERN = "[a-zA-Z0-9_.:]",

        --- Configuration for different element types (vehicle, player, ped, object).
        -- Each type has its own settings for data change limits and penalties.
        -- @type table
        ALLOWED_TYPES = {
            vehicle = {
                --- Enables data flood protection for vehicles.
                -- @type boolean
                -- @default true
                enabled = true,

                --- Maximum number of data changes allowed within the interval.
                -- @type number
                -- @default 10
                maxChanges = 10,

                --- Time window (in milliseconds) for tracking data changes.
                -- Changes older than this are ignored.
                -- @type number
                -- @default 3000
                interval = 3000,

                --- If true, players exceeding limits are kicked instead of banned.
                -- @type boolean
                -- @default false
                kick = false,

                --- If true, players exceeding limits are banned.
                -- @type boolean
                -- @default true
                ban = true,

                --- Duration of the ban ("perm" for permanent or a number in seconds).
                -- Use 0 for a temporary ban with no duration (server-dependent).
                -- @type string|number
                -- @default "perm"
                banDuration = "perm",

                --- Message shown to players when banned for flooding vehicle data.
                -- @type string
                -- @default "Data flood detected on vehicle"
                banMessage = "Data flood detected on vehicle",

                --- Message shown to players when kicked for flooding vehicle data.
                -- @type string
                -- @default "Excessive data changes on vehicle"
                kickMessage = "Excessive data changes on vehicle"
            },
            player = {
                --- Enables data flood protection for players.
                -- @type boolean
                -- @default true
                enabled = true,

                --- Maximum number of data changes allowed within the interval.
                -- Higher than vehicles due to frequent player interactions.
                -- @type number
                -- @default 150
                maxChanges = 150,

                --- Time window (in milliseconds) for tracking data changes.
                -- @type number
                -- @default 3000
                interval = 3000,

                --- If true, players exceeding limits are kicked instead of banned.
                -- @type boolean
                -- @default false
                kick = false,

                --- If true, players exceeding limits are banned.
                -- @type boolean
                -- @default true
                ban = true,

                --- Duration of the ban ("perm" for permanent or a number in seconds).
                -- 0 means a temporary ban (server-dependent behavior).
                -- @type string|number
                -- @default 0
                banDuration = 0,

                --- Message shown to players when banned for flooding player data.
                -- @type string
                -- @default "Data flood detected on player"
                banMessage = "Data flood detected on player",

                --- Message shown to players when kicked for flooding player data.
                -- @type string
                -- @default "Excessive data changes on player"
                kickMessage = "Excessive data changes on player"
            },
            ped = {
                --- Enables data flood protection for peds (non-player characters).
                -- @type boolean
                -- @default true
                enabled = true,

                --- Maximum number of data changes allowed within the interval.
                -- @type number
                -- @default 10
                maxChanges = 10,

                --- Time window (in milliseconds) for tracking data changes.
                -- @type number
                -- @default 3000
                interval = 3000,

                --- If true, players exceeding limits are kicked instead of banned.
                -- @type boolean
                -- @default false
                kick = false,

                --- If true, players exceeding limits are banned.
                -- @type boolean
                -- @default true
                ban = true,

                --- Duration of the ban ("perm" for permanent or a number in seconds).
                -- @type string|number
                -- @default "perm"
                banDuration = "perm",

                --- Message shown to players when banned for flooding ped data.
                -- @type string
                -- @default "Data flood detected on ped"
                banMessage = "Data flood detected on ped",

                --- Message shown to players when kicked for flooding ped data.
                -- @type string
                -- @default "Excessive data changes on ped"
                kickMessage = "Excessive data changes on ped"
            },
            object = {
                --- Enables data flood protection for objects.
                -- @type boolean
                -- @default true
                enabled = true,

                --- Maximum number of data changes allowed within the interval.
                -- @type number
                -- @default 10
                maxChanges = 10,

                --- Time window (in milliseconds) for tracking data changes.
                -- @type number
                -- @default 3000
                interval = 3000,

                --- If true, players exceeding limits are kicked instead of banned.
                -- @type boolean
                -- @default false
                kick = false,

                --- If true, players exceeding limits are banned.
                -- @type boolean
                -- @default true
                ban = true,

                --- Duration of the ban ("perm" for permanent or a number in seconds).
                -- @type string|number
                -- @default "perm"
                banDuration = "perm",

                --- Message shown to players when banned for flooding object data.
                -- @type string
                -- @default "Data flood detected on object"
                banMessage = "Data flood detected on object",

                --- Message shown to players when kicked for flooding object data.
                -- @type string
                -- @default "Excessive data changes on object"
                kickMessage = "Excessive data changes on object"
            }
        },

        --- Settings for ban behavior when a player exceeds data limits.
        -- @type table
        BAN = {
            --- If true, bans the player's IP address.
            -- @type boolean
            -- @default true
            IP = true,

            --- If true, bans the player's serial (unique hardware ID).
            -- @type boolean
            -- @default true
            SERIAL = true,

            --- If true, bans the player's account (if logged in).
            -- @type boolean
            -- @default true
            ACCOUNT = true
        }
    }
}

for elementType, settings in pairs(CONFIG.ANTI_DATA_FLOODING.ALLOWED_TYPES) do
    if settings.enabled then
        assert(settings.interval > 0, ("Invalid interval for %s: must be positive"):format(elementType))
        assert(settings.maxChanges > 0, ("Invalid maxChanges for %s: must be positive"):format(elementType))
    end
end

local dataTracker = {}

local function isAllowedElement(element)
    local elementType = getElementType(element)
    return CONFIG.ANTI_DATA_FLOODING.ALLOWED_TYPES[elementType] and CONFIG.ANTI_DATA_FLOODING.ALLOWED_TYPES[elementType].enabled
end

local function getElementConfig(element)
    local elementType = getElementType(element)
    return CONFIG.ANTI_DATA_FLOODING.ALLOWED_TYPES[elementType]
end

local function recordActivity(serial, timestamp)
    dataTracker[serial] = dataTracker[serial] or {}
    table.insert(dataTracker[serial], timestamp)
end

local function purgeExpired(serial, now, element)
    local records = dataTracker[serial]
    if not records then return end

    local elementConfig = getElementConfig(element)
    if not elementConfig then return end

    while records[1] and (now - records[1] > elementConfig.interval) do
        table.remove(records, 1)
    end
end

local function isOverLimit(serial, elementConfig)
    return dataTracker[serial] and #dataTracker[serial] > elementConfig.maxChanges
end

local function handleBanOrKick(client, elementConfig, reason)
    local playerName = getPlayerName(client) or "Unknown"
    local logMessage = ("Action on %s: %s"):format(playerName, reason or elementConfig.banMessage)

    if elementConfig.ban then
        local banDuration = elementConfig.banDuration
        if banDuration == "perm" then
            banPlayer(client, CONFIG.ANTI_DATA_FLOODING.BAN.IP, CONFIG.ANTI_DATA_FLOODING.BAN.SERIAL, CONFIG.ANTI_DATA_FLOODING.BAN.ACCOUNT, nil, reason or elementConfig.banMessage)
            outputServerLog(logMessage .. " (Permanent ban)")
        elseif tonumber(banDuration) then
            banPlayer(client, CONFIG.ANTI_DATA_FLOODING.BAN.IP, CONFIG.ANTI_DATA_FLOODING.BAN.SERIAL, CONFIG.ANTI_DATA_FLOODING.BAN.ACCOUNT, tonumber(banDuration), reason or elementConfig.banMessage)
            outputServerLog(logMessage .. (" (%s seconds ban)"):format(banDuration))
        else
            kickPlayer(client, reason or elementConfig.kickMessage)
            outputServerLog(("Invalid banDuration for %s: %s, kicked instead"):format(playerName, tostring(banDuration)))
        end
    elseif elementConfig.kick then
        kickPlayer(client, reason or elementConfig.kickMessage)
        outputServerLog(logMessage .. " (Kicked)")
    end
end

addEventHandler("onElementDataChange", root, function(key, oldValue, newValue)
    if not CONFIG.ANTI_DATA_FLOODING.ENABLED or not client then return end

    local playerName = getPlayerName(client) or "Unknown"
    local elementType = getElementType(source) or "unknown"

    if not string.match(key, CONFIG.ANTI_DATA_FLOODING.KEY_PATTERN) then
        local reason = ("Invalid data key: %s"):format(tostring(key))
        outputServerLog(("%s attempted invalid key on %s: %s"):format(playerName, elementType, tostring(key)))
        kickPlayer(client, reason)
        outputServerLog(("Kicked %s for %s on %s"):format(playerName, reason, elementType))
        return
    end

    local dataSize = string.len(tostring(newValue))
    if dataSize > CONFIG.ANTI_DATA_FLOODING.DATA_SIZE_LIMIT then
        local reason = ("Oversized data: %s bytes"):format(dataSize)
        outputServerLog(("%s attempted oversized data on %s: %s bytes"):format(playerName, elementType, dataSize))
        kickPlayer(client, reason)
        outputServerLog(("Kicked %s for %s on %s"):format(playerName, reason, elementType))
        return
    end

    if not isAllowedElement(source) then return end
    local elementConfig = getElementConfig(source)
    if not elementConfig then return end

    local serial = getPlayerSerial(client)
    if not serial then return end

    local now = getTickCount()
    recordActivity(serial, now)
    purgeExpired(serial, now, source)

    if isOverLimit(serial, elementConfig) then
        handleBanOrKick(client, elementConfig, ("Data flood detected on %s"):format(elementType))
        dataTracker[serial] = nil
        outputServerLog(("%s triggered flood detection on %s"):format(playerName, elementType))
    end
end)

addEventHandler("onPlayerQuit", root, function()
    local serial = getPlayerSerial(source)
    if serial then
        dataTracker[serial] = nil
    end
end)
