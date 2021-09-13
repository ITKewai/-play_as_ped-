ESX              = nil
local PlayerData = {}
-- https://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShVqSSeRvraredObjVqSSeRvrect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local isMenuOpen = false

local options_big = {
	{label = 'Cuccia', value = 'Lay Down'},
	{label = 'Abbaia', value = 'Bark'},
	{label = 'Siediti', value = 'Sit'},
	{label = 'Grattati', value = 'Itch'},
	{label = 'Richiama Attenzione', value = 'Draw Attention'},
	{label = 'Attacco continuo', value = 'Attack'},
	{label = 'Richiama Attenzione2', value = 'Taunt'},
	{label = 'Nuota', value = 'Swim'},
	{label = 'Chiudi', value = 'exit'},

}

local options_small = {
	{label = 'Grattati', value = 'Itch'},
	{label = 'Siediti', value = 'Sit'},
	{label = 'Cuccia', value = 'Lay Down'},
	{label = 'Leva zecche / Asciugati', value = 'Shake'},
	{label = 'Abbaia', value = 'Bark'},
	{label = 'Balla', value = 'Dance'},
	{label = 'Dormi 1', value = 'Sleep/Death 1'},
	{label = 'Dormi 2', value = 'Sleep/Death 2'},
	{label = 'Chiudi', value = 'exit'},
}

local bigDogModels = {
	"a_c_shepherd", "a_c_rottweiler", "a_c_husky", "a_c_retriever", "a_c_chop"
}

local smallDogModels = {
	"a_c_poodle", "a_c_pug", "a_c_westy"
}

local emotePlaying = false

function isBigDog()
	local playerModel = GetEntityModel(GetPlayerPed(-1))
	for i=1, #bigDogModels, 1 do
		if GetHashKey(bigDogModels[i]) == playerModel then
			return true
		end
	end
	return false
end

function isSmallDog()
	local playerModel = GetEntityModel(GetPlayerPed(-1))
	for i=1, #smallDogModels, 1 do
		if GetHashKey(smallDogModels[i]) == playerModel then
			return true
		end
	end
	return false
end

function cancelEmote()
	ClearPedTasksImmediately(GetPlayerPed(-1))
	emotePlaying = false
end

function playAnimation(dictionary, animation)
	if emotePlaying then
		cancelEmote()
	end
	RequestAnimDict(dictionary)
	while not HasAnimDictLoaded(dictionary) do
		Wait(1)
	end
	TaskPlayAnim(GetPlayerPed(-1), dictionary, animation, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	emotePlaying = true
end

-- OK
function OpenMenuBig()
	isMenuOpen = True
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dog_menu', {
		title 	 = 'Dog Menu by IT | Kewai#9029',
		align 	 = 'right',
		elements = options_big
	}, function(data, menu)
		if data.current.value == 'Lay Down' then
			playAnimation("creatures@rottweiler@amb@sleep_in_kennel@", "sleep_in_kennel")
		end
		if data.current.value == 'Bark' then
			playAnimation("creatures@rottweiler@amb@world_dog_barking@idle_a", "idle_a")
		end
		if data.current.value == 'Sit' then
			playAnimation("creatures@rottweiler@amb@world_dog_sitting@base", "base")
		end
		if data.current.value == 'Itch' then
			playAnimation("creatures@rottweiler@amb@world_dog_sitting@idle_a", "idle_a")
		end
		if data.current.value == 'Draw Attention' then
			playAnimation("creatures@rottweiler@indication@", "indicate_high")
		end
		if data.current.value == 'Attack' then
			playAnimation("creatures@rottweiler@melee@", "dog_takedown_from_back")
		end
		if data.current.value == 'Taunt' then
			playAnimation("creatures@rottweiler@melee@streamed_taunts@", "taunt_02")
		end
		if data.current.value == 'Swim' then
			playAnimation("creatures@rottweiler@swim@", "swim")
		end
		if data.current.value == 'exit' then
			isMenuOpen = false
			menu.close()
        end
    end,
    function(data, menu) -- Closing The Menu
        menu.close()
    end)
end



function OpenMenuSmall()
	isMenuOpen = True
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dog_menu_small', {
		title 	 = 'Dog Menu by IT | Kewai#9029',
		align 	 = 'left',
		elements = options_small
	}, function(data, menu)
		if data.current.value == 'Itch' then
			playAnimation("creatures@pug@amb@world_dog_sitting@idle_a", "idle_a")
		end
		if data.current.value == 'Sit' then
			playAnimation("creatures@pug@amb@world_dog_sitting@idle_a", "idle_b")
		end
		if data.current.value == 'Lay Down' then
			playAnimation("creatures@pug@amb@world_dog_sitting@idle_a", "idle_c")
		end
		if data.current.value == 'Shake' then
			playAnimation("creatures@pug@amb@world_dog_barking@idle_a", "idle_c")
		end
		if data.current.value == 'Bark' then
			playAnimation("creatures@pug@amb@world_dog_barking@idle_a", "idle_a")
		end
		if data.current.value == 'Dance' then
			playAnimation("creatures@pug@move", "idle_turn_0")
		end
		if data.current.value == 'Sleep/Death 1' then
			playAnimation("creatures@pug@move", "dead_right")
		end
		if data.current.value == 'Sleep/Death 2' then
			playAnimation("creatures@pug@move", "dead_left")
		end
		if data.current.value == 'exit' then
			isMenuOpen = false
			menu.close()
        end
--    end,
--    function(data, manu) -- Closing The Menu
--        menu.close()
    end)
end


-- OK
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not isMenuOpen and IsControlJustReleased(0, 46) and isBigDog() then
			OpenMenuBig()
		end		
		if not isMenuOpen and IsControlJustReleased(0, 46) and isSmallDog() then
			OpenMenuSmall()
		end		
		if emotePlaying then
            if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35) or IsControlPressed(0, 77) or IsControlPressed(0, 21)) then
                cancelEmote()
            end
        end
	end
end)
-- OK