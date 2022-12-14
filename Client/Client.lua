
local ESX = exports["es_extended"]:getSharedObject()

--[[ Player ]]--
local Player = {}
Player.ID = 0
Player.ServerID = 0
--[[ Player ]]--

local open = false
-- RegisterCommand('PauseMenu', function()
--     OpenPauseMenu()
-- end)

RegisterKeyMapping('PauseMenu', 'Open Pause Menu', 'keyboard', 'ESCAPE')

function OpenPauseMenu()
    if not open and not IsPauseMenuActive() then
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = 'show',
        })
        open = true
        CounterPlayer()
        PlayerName()
        PlayerID()
    end
end

function CounterPlayer()
    ESX.TriggerServerCallback("PauseMenu:Getserverdata", function(max, total) 
        SendNUIMessage({action = 'updatePlayers', max = max, total = total})
	end)
end

function PlayerName()
    SendNUIMessage({action = 'updatePlayersname', name = Player.Name})
end

function PlayerID()
        SendNUIMessage({action = 'updatePlayersID', id = Player.ServerID})
end

CreateThread(function()
    while true do 
        SetPauseMenuActive(false) 
        Wait(1)
    end
end)

RegisterNUICallback('exit', function(data, cb)
  SetNuiFocus(false, false)
  open = false
end)

RegisterNUICallback('SendAction', function(data, cb)
    if data.action == 'settings' then 
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'),0,-1) 
        SetNuiFocus(false, false)
    elseif data.action == 'map' then 
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'),0,-1)
        SetNuiFocus(false, false)
    elseif data.action == 'touche' then 
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_KEYMAPPING_MENU'),0,-1) 
        SetNuiFocus(false, false)
    elseif data.action == 'leavegamelua' then
        ESX.TriggerServerCallback("PauseMenu:Leave")
    end
end)

Citizen.CreateThread(function()
    Player.Name = 'undefined'
    Player.ID = PlayerId()
    Player.ServerID = GetPlayerServerId(Player.ID)
    Player.Name = GetPlayerName(Player.ID)
end)
