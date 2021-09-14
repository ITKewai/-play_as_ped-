ESX = nil
stamina_loop = nil
sono_un_ped = false

Citizen.CreateThread(function()
    while ESX == nil do
        --TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        TriggerEvent('esx:getShVqSSeRvraredObjVqSSeRvrect', function(obj) ESX = obj end)

        Citizen.Wait(0)
    end
end)


Citizen.CreateThread( function()
    while true do
        Citizen.Wait(1)
        if stamina_loop and Config.Staff_unlimited_stamina then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
    end
end)

function MenuUtente()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MenuUtente',
            {
                title    = 'Menu Utente',
                align    = 'right',
                elements = Config.MenuUtente
            }, function(data, menu)
                for i=1, #Config.MenuUtente do
                    if data.current.value == i then
                        if data.current.ped == "human" then
                            if not sono_un_ped then
                                break
                            end
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0

                                if isMale then
                                    RequestModel("mp_m_freemode_01")

                                    while not HasModelLoaded("mp_m_freemode_01") do
                                        Citizen.Wait(0)
                                    end

                                    SetPlayerModel(PlayerId(), GetHashKey("mp_m_freemode_01"))
                                else
                                    RequestModel("mp_f_freemode_01")

                                    while not HasModelLoaded("mp_f_freemode_01") do
                                        Citizen.Wait(0)
                                    end

                                    SetPlayerModel(PlayerId(), GetHashKey("mp_f_freemode_01"))
                                end

                                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                                end)

                                sono_un_ped = false
                            end)
                        else
                            for b=1, #Config.User_peds do
                                if Config.User_peds[b].identifier == lce then
                                    if sono_un_ped then
                                        break
                                    end
                                    print(Config.User_peds[b].ped)
                                    RequestModel(Config.User_peds[b].ped)
                                    local cnt
                                    cnt = 0
                                    while not HasModelLoaded(Config.User_peds[b].ped) do
                                        cnt = cnt + 1
                                        if cnt <= 10 then
                                            print("Caricamento : " .. cnt)
                                            Citizen.Wait(500)
                                        else
                                            print("Esito : Negativo")
                                            return
                                        end
                                    end

                                    print("Esito : Positivo")
                                    SetPlayerModel(PlayerId(), GetHashKey(Config.User_peds[b].ped))

                                    local ped = PlayerPedId()
                                    SetPedDefaultComponentVariation(ped)
                                    ClearAllPedProps(ped)
                                    ClearPedDecorations(ped)
                                    ClearPedFacialDecorations(ped)

                                    SetPedComponentVariation(ped, 0, 0, 0, 0)
                                    Wait(200)
                                    --SetPedComponentVariation(ped, 0, 0, 1, 0)
                                    --Wait(200)
                                    SetModelAsNoLongerNeeded(Config.User_peds[b].ped)
                                    sono_un_ped = true
                                    break
                                end
                            end
                        end
                    end
                end
            end,
            function(data, menu)
                menu.close()
            end)
end

function MenuAnimali()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MenuAnimali',
            {
                title    = 'Menu Animali',
                align    = 'right',
                elements = Config.Animali
            }, function(data, menu)
                for i=1, #Config.Animali do
                    if data.current.value == i then
                        if data.current.ped == "human" then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0

                                if isMale then
                                    RequestModel("mp_m_freemode_01")

                                    while not HasModelLoaded("mp_m_freemode_01") do
                                        Citizen.Wait(0)
                                    end

                                    SetPlayerModel(PlayerId(), GetHashKey("mp_m_freemode_01"))
                                else
                                    RequestModel("mp_f_freemode_01")

                                    while not HasModelLoaded("mp_f_freemode_01") do
                                        Citizen.Wait(0)
                                    end

                                    SetPlayerModel(PlayerId(), GetHashKey("mp_f_freemode_01"))
                                end

                                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                                end)

                                SetEntityInvincible(ped, false)
                                stamina_loop = false
                            end)
                        else
                            RequestModel(data.current.ped)
                            local cnt
                            cnt = 0
                            while not HasModelLoaded(data.current.ped) do
                                cnt = cnt + 1
                                if cnt <= 10 then
                                    print("Caricamento : " .. cnt)
                                    Citizen.Wait(500)
                                else
                                    print("Esito : Negativo")
                                    return
                                end
                            end

                            print("Esito : Positivo")
                            SetPlayerModel(PlayerId(), GetHashKey(data.current.ped))

                            local ped = PlayerPedId()
                            SetPedDefaultComponentVariation(ped)
                            ClearAllPedProps(ped)
                            ClearPedDecorations(ped)
                            ClearPedFacialDecorations(ped)

                            SetPedComponentVariation(ped, 0, 0, 0, 0)
                            Wait(200)
                            --SetPedComponentVariation(ped, 0, 0, 1, 0)
                            --Wait(200)

                            SetModelAsNoLongerNeeded(data.current.ped)
                            SetEntityInvincible(ped, Config.Staff_god_mode)
                            stamina_loop = true
                            break
                        end
                    end
                end
            end,
            function(data, menu)
                menu.close() -- handles backspace
            end)
end

function GruppoPedNormali()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'GruppoPedNormali',
            {
                title    = 'Gruppo Ped Normali',
                align    = 'right',
                elements = Config.GruppoPedNormali
            }, function(data, menu)
                for i=1, #Config.GruppoPedNormali do
                    if data.current.value == i then
                        if data.current.ped == "human" then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0

                                if isMale then
                                    RequestModel("mp_m_freemode_01")

                                    while not HasModelLoaded("mp_m_freemode_01") do
                                        Citizen.Wait(0)
                                    end

                                    SetPlayerModel(PlayerId(), GetHashKey("mp_m_freemode_01"))
                                else
                                    RequestModel("mp_f_freemode_01")

                                    while not HasModelLoaded("mp_f_freemode_01") do
                                        Citizen.Wait(0)
                                    end

                                    SetPlayerModel(PlayerId(), GetHashKey("mp_f_freemode_01"))
                                end

                                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                                end)

                                SetEntityInvincible(ped, false)
                                stamina_loop = false
                            end)
                        else
                            RequestModel(data.current.ped)
                            local cnt
                            cnt = 0
                            while not HasModelLoaded(data.current.ped) do
                                cnt = cnt + 1
                                if cnt <= 10 then
                                    print("Caricamento : " .. cnt)
                                    Citizen.Wait(500)
                                else
                                    print("Esito : Negativo")
                                    return
                                end
                            end

                            print("Esito : Positivo")
                            SetPlayerModel(PlayerId(), GetHashKey(data.current.ped))

                            local ped = PlayerPedId()
                            SetPedDefaultComponentVariation(ped)
                            ClearAllPedProps(ped)
                            ClearPedDecorations(ped)
                            ClearPedFacialDecorations(ped)

                            SetPedComponentVariation(ped, 0, 0, 0, 0)
                            Wait(200)
                            --SetPedComponentVariation(ped, 0, 0, 1, 0)
                            --Wait(200)

                            SetModelAsNoLongerNeeded(data.current.ped)
                            SetEntityInvincible(ped, Config.Staff_god_mode)
                            stamina_loop = true
                            break
                        end
                    end
                end
            end,
            function(data, menu)
                menu.close() -- handles backspace
            end)
end

function GruppoPedModificati()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'GruppoPedModificati',
            {
                title    = 'Gruppo Ped Modificati',
                align    = 'right',
                elements = Config.GruppoPedModificati
            }, function(data, menu)
                for i=1, #Config.GruppoPedModificati do
                    if data.current.value == i then
                        if data.current.ped == "human" then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0

                                if isMale then
                                    RequestModel("mp_m_freemode_01")

                                    while not HasModelLoaded("mp_m_freemode_01") do
                                        Citizen.Wait(0)
                                    end

                                    SetPlayerModel(PlayerId(), GetHashKey("mp_m_freemode_01"))
                                else
                                    RequestModel("mp_f_freemode_01")

                                    while not HasModelLoaded("mp_f_freemode_01") do
                                        Citizen.Wait(0)
                                    end

                                    SetPlayerModel(PlayerId(), GetHashKey("mp_f_freemode_01"))
                                end

                                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                                end)

                                SetEntityInvincible(ped, false)
                                stamina_loop = false
                            end)
                        else
                            RequestModel(data.current.ped)
                            local cnt
                            cnt = 0
                            while not HasModelLoaded(data.current.ped) do
                                cnt = cnt + 1
                                if cnt <= 10 then
                                    print("Caricamento : " .. cnt)
                                    Citizen.Wait(500)
                                else
                                    print("Esito : Negativo")
                                    return
                                end
                            end

                            print("Esito : Positivo")
                            SetPlayerModel(PlayerId(), GetHashKey(data.current.ped))

                            local ped = PlayerPedId()
                            SetPedDefaultComponentVariation(ped)
                            ClearAllPedProps(ped)
                            ClearPedDecorations(ped)
                            ClearPedFacialDecorations(ped)

                            SetPedComponentVariation(ped, 0, 0, 0, 0)
                            Wait(200)
                            --SetPedComponentVariation(ped, 0, 0, 1, 0)
                            --Wait(200)

                            SetModelAsNoLongerNeeded(data.current.ped)
                            SetEntityInvincible(ped, Config.Staff_god_mode)
                            stamina_loop = true
                            break
                        end
                    end
                end
            end,
            function(data, menu)
                menu.close() -- handles backspace
            end)
end

function MenuSupremi()
    local menu_options = {
        {label = 'Animali'},
        {label = 'GruppoPedNormali'},
        {label = 'GruppoPedModificati'},
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MenuSupremi',
            {
                title    = 'Menu Supremi IT|Kewai',
                align    = 'right',
                elements = menu_options
            }, function(data, menu)
                if data.current.label == 'Animali' then
                    MenuAnimali()
                elseif data.current.label == 'GruppoPedNormali' then
                    GruppoPedNormali()
                elseif data.current.label == 'GruppoPedModificati' then
                    GruppoPedModificati()
                end
            end,
            function(data, menu)
                menu.close()
            end)
end

function MainMenu(lce)
    local menu_options = {
        {label = 'Utente'},
        {label = 'Staff'},
    }
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MainMenu',
            {
                title    = 'Menu Ped',
                align    = 'right',
                elements = menu_options
            }, function(data, menu)
                if data.current.label == 'Utente' then
                    MenuUtente(lce)
                else
                    for i=1, #Config.Staff_identifier do
                        if Config.Staff_identifier[i] == lce then
                            MenuSupremi(lce)
                        end
                        end

                end

            end,
            function(data, menu)
                menu.close()
            end)
end

RegisterCommand('pap', function()
    ESX.TriggerServerCallback('play_as_ped:getData', function(data)
        local lce = data.identifier
        print(lce)
        MainMenu(lce)
    end)
end)