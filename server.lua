local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("radio", function(source)
    TriggerClientEvent('qb-radio:use', source)
end)

for channel, config in pairs(Config.RestrictedChannels) do
    exports['pma-voice']:addChannelCheck(channel, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        return config[Player.PlayerData.job.name] and Player.PlayerData.job.onduty
    end)
end

if Config.CheckForUpdates then
    local function VersionLog(_type, log)
        local color = _type == 'success' and '^2' or '^1'
        print(('^8[J0M1D4R]%s %s^7'):format(color, log))
    end

    local function UpdateLog(log)
        print(('^8[J0M1D4R]^3 [Update Log] %s^7'):format(log))
    end

    local function FetchUpdateLog()
        PerformHttpRequest('https://raw.githubusercontent.com/Haaasib/updates/main/radio-up-log.txt', function(err, text, headers)
            if not text then
                UpdateLog('Currently unable to fetch the update log.')
                return
            end
            UpdateLog(':\n' .. text)
        end)
    end

    local function CheckMenuVersion()
        PerformHttpRequest('https://raw.githubusercontent.com/Haaasib/updates/main/radio.txt', function(err, text, headers)
            local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
            if not text then
                VersionLog('error', 'Currently unable to run a version check.')
                return
            end
            VersionLog('success', ('Current Version: %s'):format(currentVersion))
            VersionLog('success', ('Latest Version: %s'):format(text))
            if text:gsub("%s+", "") == currentVersion:gsub("%s+", "") then
                VersionLog('success', 'You are running the latest version.')
            else
                VersionLog('error', ('You are currently running an outdated version, please update to version %s'):format(text))
                FetchUpdateLog()
            end
        end)
    end

    CheckMenuVersion()
end