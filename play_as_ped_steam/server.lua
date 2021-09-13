local skins = {
    ['default'] = 'mp_m_freemode_01',
    ['steam:11000014526b4b3'] = 'Paolino',
    ['steam:110000147fd9bc4'] = 'dante2'
}


RegisterServerEvent("pap:check")
AddEventHandler('pap:check', function()
    local steamID = nil
    local src = source
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, 5) == "steam" then
            steamID = string.lower(v)
            break
        end
    end
    local skin = nil
    if skins[steamID] ~= nil then
        skin = skins[steamID]
    else
        skin = nil
    end
    if skin then
    TriggerClientEvent("sapcoenvnpae", src, skin)
    end
end)