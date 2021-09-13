RegisterNetEvent('sapcoenvnpae')
AddEventHandler('sapcoenvnpae', function(skin)
    Citizen.CreateThread(function()
        print(steamID)
        local model = GetHashKey(skin)
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
    end)
end)

AddEventHandler('playerSpawned', function()
    local src = source
    TriggerServerEvent("pap:check", source)
end)