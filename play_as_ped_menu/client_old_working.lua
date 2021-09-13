ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ESX:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('ESX:playerLoaded')
AddEventHandler('ESX:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('ESX:setJob')
AddEventHandler('ESX:setJob', function(job)
  PlayerData.job = job
end)

local isMenuOpen = false

local options = {
	{label = '1Lay Down', value = 'Lay Down'},
	{label = '2Bark', value = 'Bark'},
	{label = '3Sit', value = 'Sit'},
	{label = '4Itch', value = 'Itch'},
	{label = '5Draw Attention', value = 'Draw Attention'},
	{label = '6Attack', value = 'Attack'},
	{label = '7Taunt', value = 'Taunt'},
	{label = '8Swim', value = 'Swim'},
	{label = '9Chiudi', value = 'exit'},

}

local animations = {
	{ dictionary = "creatures@rottweiler@amb@sleep_in_kennel@", animation = "sleep_in_kennel", name = "Lay Down", },
	{ dictionary = "creatures@rottweiler@amb@world_dog_barking@idle_a", animation = "idle_a", name = "Bark", },
	{ dictionary = "creatures@rottweiler@amb@world_dog_sitting@base", animation = "base", name = "Sit", },
	{ dictionary = "creatures@rottweiler@amb@world_dog_sitting@idle_a", animation = "idle_a", name = "Itch", },
	{ dictionary = "creatures@rottweiler@indication@", animation = "indicate_high", name = "Draw Attention", },
	{ dictionary = "creatures@rottweiler@melee@", animation = "dog_takedown_from_back", name = "Attack", },
	{ dictionary = "creatures@rottweiler@melee@streamed_taunts@", animation = "taunt_02", name = "Taunt", },
	{ dictionary = "creatures@rottweiler@swim@", animation = "swim", name = "Swim", },
}

local dogModels = {
	"a_c_shepherd", "a_c_rottweiler", "a_c_husky", "a_c_poodle", "a_c_pug", "a_c_westy", "a_c_retriever"
}

local emotePlaying = false

function isDog()
	local playerModel = GetEntityModel(GetPlayerPed(-1))
	for i=1, #dogModels, 1 do
		if GetHashKey(dogModels[i]) == playerModel then
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
function OpenMenu()
	isMenuOpen = True
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dog_menu', {
		title 	 = 'Dog Menu',
		align 	 = 'left',
		elements = options
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
    function(data, manu) -- Closing The Menu
        menu.close()
    end)
end

-- OK
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not isMenuOpen and IsControlJustReleased(0, 46) and isDog() then
			OpenMenu()
		end		
		if emotePlaying then
            if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
                cancelEmote()
            end
        end
	end
end)
-- OK