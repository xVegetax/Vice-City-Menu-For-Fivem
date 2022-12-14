ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback("PauseMenu:Getserverdata", function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local MaxPlayers = GetConvarInt('sv_maxclients', Config.PlayerCounter)
    local TotalPlayers = GetNumPlayerIndices()
    cb(MaxPlayers, TotalPlayers)
end)
