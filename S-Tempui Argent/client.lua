local ESX = nil
local stage = 1
local micmuted = false

local Keys = {

    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,

    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,

    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,

    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,

    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,

    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,

    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,

    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,

    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118

}
local voicelevel = 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('esx:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)

StartShowHudThread()
print("test")
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	for k, v in pairs(accounts) do
		local account = v
		if account.name == "black_money" then
			if account.money > 0 then
			SendNUIMessage({action = "setBlackMoney", black = account.money})
			else
			SendNUIMessage({action = "hideBlackMoney"})
			end
		end
	end
	SendNUIMessage({action = "setVoiceLevel", level = 1})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "money" then

	SendNUIMessage({action = "setMoney", money = account.money})
	end
	if account.name == "black_money" then
		if account.money > 0 then
		SendNUIMessage({action = "setBlackMoney", black = account.money})
		SendNUIMessage({action = "muted", muted = micmuted})
		else
		SendNUIMessage({action = "hideBlackMoney"})
		end
	end
end)


AddEventHandler('SaltyChat_MicStateChanged', function(isMicrophoneMuted)
	micmuted = isMicrophoneMuted

	if micmuted == false then
		SendNUIMessage({action = "nomuted"})
		SendNUIMessage({action = "setVoiceLevel", level = voicelevel})
	end
end)

function StartShowHudThread()
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		
		SendNUIMessage({action = "setMoney", money = ESX.GetPlayerData().money})
		SendNUIMessage({action = "muted", muted = micmuted})
	end
end)
end


RegisterNetEvent("adminon")
AddEventHandler('adminon', function()
    SendNUIMessage({action = "adminon"})
end)

RegisterNetEvent("adminoff")
AddEventHandler('adminoff', function()
    SendNUIMessage({action = "adminoff"})
end)

RegisterNetEvent('hud:range')
AddEventHandler('hud:range', function(voiceRange)
	print(voiceRange)
	if micmuted == false then
	if voiceRange == 3 then
	SendNUIMessage({action = "setVoiceLevel", level = 1})
	--ESX.ShowNotification("Sprachreichweite betraegt nun 3 Meter")
	TriggerEvent('tilly_notify', '#005ca8', "SaltyChat", 'Sprachreichweite: 3M')

	voicelevel = 1

	end
	if voiceRange == 8 then
	SendNUIMessage({action = "setVoiceLevel", level = 2})
	--ESX.ShowNotification("Sprachreichweite betraegt nun 8 Meter")
	TriggerEvent('tilly_notify', '#005ca8', "SaltyChat", 'Sprachreichweite: 8M')
	voicelevel = 2

	end
	if voiceRange == 15 then
	SendNUIMessage({action = "setVoiceLevel", level = 3})
	--ESX.ShowNotification("Sprachreichweite betraegt nun 15 Meter")
	TriggerEvent('tilly_notify', '#005ca8', "SaltyChat", 'Sprachreichweite: 15M')
	voicelevel = 3

	end
	-- if voiceRange == 32 then
	-- SendNUIMessage({action = "setVoiceLevel", level = 4})
	-- --ESX.ShowNotification("Sprachreichweite betraegt nun 32 Meter")
	-- TriggerEvent('tilly_notify', -1, "SaltyChat", 'Sprachreichweite: 32M', 800)
	-- voicelevel = 4

	-- end

end
end)

RegisterNetEvent('esx:activateMoney')
AddEventHandler('esx:activateMoney', function(e)
	SendNUIMessage({action = "setMoney", money = e})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local data = exports.saltychat:GetRadioChannel(true)

		if  data == nil or data == '' then
			SendNUIMessage({action = "hide"})
		else
			SendNUIMessage({action = "show"})
		end

	  end
  end)
  


-- Hud développer par ImLew#1337 

-- Simple Hud 

-- Version 2.0 Comming Soon Here :

-- https://discord.gg/yg93HpMhrw