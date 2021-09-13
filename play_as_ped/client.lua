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

RegisterCommand('pap', function()
    ESX.TriggerServerCallback('play_as_ped:getData', function(data)
        local lce = data.identifier
        print(lce)
        if data.group ~= "admin" and lce ~= "steam:1100001183c1e41" then -- Only mod, admin, superadmin
        --if data.group == "admin" and lce ~= "steam:1100001183c1e41"  then -- test kappa
            --[[local elements = {
                {label = 'Human',            value = 1,  ped = "human"},
                {label = 'Cat',              value = 2,  ped = "a_c_cat_01"},
                {label = 'Pug',              value = 3,  ped = "a_c_pug"},
                {label = 'Poodle',           value = 4,  ped = "a_c_poodle"},
                {label = 'Westy',            value = 5,  ped = "a_c_westy"},
                {label = 'Bird',             value = 6,  ped = "a_c_chickenhawk"},
                {label = 'Cow',              value = 7,  ped = "a_c_cow"},
                {label = 'Pig',              value = 8, ped = "a_c_pig"},
                {label = 'Pigeon',           value = 9, ped = "a_c_pigeon"},
                {label = 'Husky',            value = 10, ped = "a_c_husky"},
                {label = 'Retriver',         value = 11, ped = "a_c_retriever"},
                {label = 'Poddle',           value = 12, ped = "a_c_poodle"},
                {label = 'Rottweiler',       value = 13, ped = "a_c_rottweiler"},
                {label = 'Shepherd',         value = 14, ped = "a_c_shepherd"},
            }]]
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_menu',
                    {
                        title    = 'Ped Menu User',
                        align    = 'right',
                        elements = Config.Public_elements
                    }, function(data, menu)
                        for i=1, #Config.Public_elements do
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
                        menu.close() -- handles backspace
                    end)
        else
            for i=1, #Config.Staff_identifier do
                if Config.Staff_identifier[i] == data.identifier then
                    ESX.UI.Menu.CloseAll()
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_menu',
                            {
                                title    = 'Ped Menu  Admin',
                                align    = 'right',
                                elements = Config.Staff_elements
                            }, function(data, menu)
                                for i=1, #Config.Staff_elements do
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
                                            SetEntityInvincible(ped, god_mode)
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
            end
        end
    end)
end)