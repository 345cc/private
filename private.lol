-- important var

local controller = game.Players["Enity_4x4"]
local Players = game:GetService("Players")
local bot = Players.LocalPlayer
local char = bot.Character or bot.CharacterAdded:Wait()
local controllerchar = controller.Character or controller.CharacterAdded:Wait()
local RNG = Random.new(tick())
local MainEvent = game:GetService('ReplicatedStorage'):WaitForChild("MainEvent")
local TweenService = game:GetService("TweenService")
local input = loadstring(game:HttpGet('https://pastebin.com/raw/dYzQv3d8'))()



-- cfgs

local prefix = "!"
local Protect

-- function



local ok = {}
local function getplayer(Name)
	Name = Name:lower():gsub(" ","")
	for _,x in next, Players:GetPlayers() do
		if x ~= bot then
			if x.Name:lower():match("^"..Name) then
				return x
			elseif x.DisplayName:lower():match("^"..Name) then
				return x
			elseif Name == "me" then
				return controller
			end
		end
	end
end

local preds = {
	1,
	1.25,
	1.5,
	1.75,
	2,
	2.25
}
function fling(target)
	local TRootPart = target.Character:FindFirstChildOfClass("Humanoid").RootPart
	local THumanoid = target.Character:FindFirstChildOfClass("Humanoid")
	local Humanoid = char and char:FindFirstChildOfClass("Humanoid")
	local THead = target.Character.Head

	--
	workspace.FallenPartsDestroyHeight = 0/0
	local RootPart = Humanoid and Humanoid.RootPart

	local FPos = function(BasePart, Pos, Ang)
		char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
		char:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
		char:FindFirstChildOfClass("Humanoid").RootPart.Velocity = Vector3.new(0,-2^14,0)
		char:FindFirstChildOfClass("Humanoid").RootPart.RotVelocity = Vector3.new(0,-2^14,0)
	end

	local SFBasePart = function(BasePart)
		local TimeToWait = 4
		local Time = tick()
		local angle = 0
		local Pred = -20

		repeat
			if target.Character:FindFirstChildOfClass("Highlight") then
				repeat wait() until not target.Character:FindFirstChildOfClass("Highlight")
			else

			end
			for i,v in pairs(preds) do
				if RootPart and THumanoid then
					angle = angle + 1
					FPos(BasePart, CFrame.new(0, 0, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / v, CFrame.Angles(math.rad(90),0 ,math.rad(target.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame.Rotation.Z)))
					game:GetService("RunService").Heartbeat:Wait()
				else
					break
				end
				game:GetService("RunService").Heartbeat:Wait()
			end
		until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= target.Character or target.Parent ~= Players or not target.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
	end
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

	if TRootPart and THead then
		if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
		else
			SFBasePart(TRootPart)
		end
	elseif TRootPart and not THead then
		SFBasePart(THead)
	else
		return print("Target is losing all body bro")
	end
end

function rand180()
	return math.random(-180, 180)
end



local part = Instance.new("Part", workspace)
part.Position = Vector3.new(9999,9999,9999)
part.Size = Vector3.new(25,1,25)
part.Transparency = 0.2
part.Anchored = true

bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = part.CFrame * CFrame.new(0,2,0)
-- control
controller.Chatted:Connect(function(msg)
	msg = msg:lower()
	if string.sub(msg,1,3) == "/e " then
		msg = string.sub(msg,4)
	end
	if string.sub(msg,1,1) == prefix then
		local cmd
		local space = string.find(msg," ")
		if space then
			cmd = string.sub(msg,2,space-1)
		else
			cmd = string.sub(msg,2)
		end
		if cmd == "test" then
			print("test")
		end
		if cmd == "fixposition" then
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = part.CFrame * CFrame.new(0,2,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.RotVelocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)


		end

		if cmd == "bringme" then
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = controller.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame
		end
		if cmd == "fling" then
			local oldpos = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame
			local Time = os.clock()
			local var = string.sub(msg,space+1)
			local target = getplayer(var)
			if target == nil then return end
			local TRootPart = target.Character:FindFirstChildOfClass("Humanoid").RootPart
			local THumanoid = target.Character:FindFirstChildOfClass("Humanoid")
			local THead = target.Character:FindFirstChild("Head")

			local Humanoid = char and char:FindFirstChildOfClass("Humanoid")
			--
			fling(target)

			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			workspace.CurrentCamera.CameraSubject = Humanoid

			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos * CFrame.new(0,2,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.RotVelocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
		end
		if cmd == "rejoin" then
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, bot)
		end
		if cmd == "checkplayer" then
			local oldpos = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame
			local Time = os.clock()
			local var = string.sub(msg,space+1)
			local target = getplayer(var)
			if target == nil then 
				game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(target.Name.. " is logged.", "All")
			end
			game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(target.Name.. " is on the server.", "All")
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = controller.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame
			wait(2)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
		end
		if cmd == "bring" then
			local var = string.sub(msg,space+1)
			local target = getplayer(var)
			local Humanoid = char:WaitForChild("Humanoid")
			if target == nil then end
			local TimeToWait = 10
			local Time = tick()
			local oldpos = char:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
			local FPos = function(BasePart, Pos)
				char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(BasePart.Position) * Pos
				char:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos )
			end
			for i = 1,5 do
				if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
					bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
					break
				else

				end
				if target.Character:FindFirstChildOfClass("Highlight") then
					repeat wait() until not target.Character:FindFirstChildOfClass("Highlight")
				else

				end
				bot.Character:FindFirstChildOfClass("Humanoid"):EquipTool(bot.Backpack["[Knife]"])
				local oldpos = bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
				wait(0.3)
				bot.Character["[Knife]"]:Activate()
				wait(1.4)
				for i = 1,15 do
					if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
						break
					end
					if target.Character:FindFirstChildOfClass("Highlight") then repeat wait() until not target.Character:FindFirstChildOfClass("Highlight") else end
					FPos(target.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame, CFrame.new(0, -2, 0) + target.Character:FindFirstChildOfClass("Humanoid").MoveDirection * target.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / 13)
					task.wait()
				end
				bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
				bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
				wait(0.4)
			end
			if target.Character:FindFirstChildOfClass("Humanoid").Health >= 15 then print("failed to bring player (health error)") else end 
			repeat
				char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(target.Character.Head.CFrame.Position) * CFrame.new(0,3,0)
				local args = {
					[1] = "Grabbing",
					[2] = false
				}
				game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
				wait(.1)
			until target.Character:FindFirstChild("GRABBING_CONSTRAINT") or tick() > Time + TimeToWait or target.Character:FindFirstChildOfClass("Humanoid").Health >= 15
			bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = controller.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame
			wait(0.9)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = controller.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame
			local args = {
				[1] = "Grabbing",
				[2] = false
			}
			game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
			wait(0.4)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos * CFrame.new(0,2,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.RotVelocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
		end
		if cmd == "hurt" then
			local var = string.sub(msg,space+1)
			local target = getplayer(var)
			local Humanoid = char:WaitForChild("Humanoid")
			if target == nil then end
			local TimeToWait = 5
			local Time = tick()
			local oldpos = char:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
			local FPos = function(BasePart, Pos)
				char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(BasePart.Position) * Pos
				char:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos )
			end
			for i = 1,5 do
				bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
				if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
					bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
					break
				else

				end
				bot.Character:FindFirstChildOfClass("Humanoid"):EquipTool(bot.Backpack["[Knife]"])
				local oldpos = bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
				MainEvent:FireServer("ChargeButton")
				wait(1.4)
				for i = 1,15 do
					if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
						break
					end
					if target.Character:FindFirstChildOfClass("Highlight") then repeat wait() until not target.Character:FindFirstChildOfClass("Highlight") else end

					FPos(target.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame, CFrame.new(0, -2, 0) + target.Character:FindFirstChildOfClass("Humanoid").MoveDirection * target.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / 13)
					task.wait()
				end
				bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
				bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
				wait(0.2)
			end
			bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos * CFrame.new(0,2,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.RotVelocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
		end
		if cmd == "kill" then
			local var = string.sub(msg,space+1)
			local target = getplayer(var)
			local Humanoid = char:WaitForChild("Humanoid")
			if target == nil then end
			local TimeToWait = 10
			local Time = tick()
			local oldpos = char:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
			local FPos = function(BasePart, Pos)
				char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(BasePart.Position) * Pos
				char:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos )
			end
			for i = 1,5 do
				if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
					bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
					break
				else

				end
				wait(0.2)
				bot.Character:FindFirstChildOfClass("Humanoid"):EquipTool(bot.Backpack["[Knife]"])
				local oldpos = bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
				MainEvent:FireServer("ChargeButton")

				wait(1.4)
				for i = 1,20 do
					if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
						break
					end
					if target.Character:FindFirstChildOfClass("Highlight") then repeat wait() until not target.Character:FindFirstChildOfClass("Highlight") else end
					FPos(target.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame, CFrame.new(0, RNG:NextNumber(-2,2), 0) + target.Character:FindFirstChildOfClass("Humanoid").MoveDirection * target.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / 13)
					task.wait()
				end
				bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
				bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
				wait(0.3)
			end
			if target.Character:FindFirstChildOfClass("Humanoid").Health >= 15 then print("failed to kill player (health error)") else end 
			repeat
				char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(target.Character.Head.CFrame.Position) * CFrame.new(0,3,0)
				local args = {
					[1] = "Grabbing",
					[2] = false
				}
				game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
				game:GetService("RunService").Heartbeat:Wait()
			until target.Character:FindFirstChild("GRABBING_CONSTRAINT") or tick() > Time + TimeToWait or target.Character:FindFirstChildOfClass("Humanoid").Health >= 15
			bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(999999999999,0,999999999999)
			wait(0.8)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(999999999999,0,999999999999)
			local args = {
				[1] = "Grabbing",
				[2] = false
			}
			game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
			wait(.1)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos * CFrame.new(0,2,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.RotVelocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
		end
		if cmd == "void" then
			local var = string.sub(msg,space+1)
			local target = getplayer(var)
			local Humanoid = char:WaitForChild("Humanoid")
			if target == nil then end
			local TimeToWait = 10
			local Time = tick()
			local oldpos = char:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
			local FPos = function(BasePart, Pos)
				char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(BasePart.Position) * Pos
				char:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos )
			end
			for i = 1,5 do
				if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
					bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
					break
				else

				end
				wait(0.2)
				bot.Character:FindFirstChildOfClass("Humanoid"):EquipTool(bot.Backpack["[Knife]"])
				local oldpos = bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
				MainEvent:FireServer("ChargeButton")
				wait(1.4)
				for i = 1,20 do
					if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
						break
					end
					if target.Character:FindFirstChildOfClass("Highlight") then repeat wait() until not target.Character:FindFirstChildOfClass("Highlight") else end
					FPos(target.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame, CFrame.new(0, RNG:NextNumber(-2,2), 0) + target.Character:FindFirstChildOfClass("Humanoid").MoveDirection * target.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / 13)
					task.wait()
				end
				bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
				bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
				wait(0.3)
			end
			if target.Character:FindFirstChildOfClass("Humanoid").Health >= 15 then print("failed to kill player (health error)") else end 
			repeat
				char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(target.Character.Head.CFrame.Position) * CFrame.new(0,3,0)
				local args = {
					[1] = "Grabbing",
					[2] = false
				}
				game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))

				game:GetService("RunService").Heartbeat:Wait()
			until target.Character:FindFirstChild("GRABBING_CONSTRAINT") or tick() > Time + TimeToWait or target.Character:FindFirstChildOfClass("Humanoid").Health >= 15
			bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(999999999999,999999999999,999999999999)
			wait(0.8)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(999999999999,999999999999,999999999999)
			local args = {
				[1] = "Grabbing",
				[2] = false
			}
			game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
			wait(0.2)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos * CFrame.new(0,2,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.RotVelocity = Vector3.new(0,0,0)
			bot.Character:FindFirstChildOfClass("Humanoid").RootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
		end
		if cmd == "stomp" then
			local var = string.sub(msg,space+1)
			local target = getplayer(var)
			local Humanoid = char:WaitForChild("Humanoid")
			if target == nil then end
			local TimeToWait = 10
			local Time = tick()
			local oldpos = char:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
			local FPos = function(BasePart, Pos)
				char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = CFrame.new(BasePart.Position) * Pos
				char:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos )
			end
			for i = 1,5 do
				if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
					bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
					break
				else

				end
				wait(0.2)
				bot.Character:FindFirstChildOfClass("Humanoid"):EquipTool(bot.Backpack["[Knife]"])
				local oldpos = bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame 
				MainEvent:FireServer("ChargeButton")
				wait(1.4)
				for i = 1,20 do
					if target.Character:FindFirstChildOfClass("Humanoid").Health <= 5 then
						break
					end
					if target.Character:FindFirstChildOfClass("Highlight") then repeat wait() until not target.Character:FindFirstChildOfClass("Highlight") else end
					FPos(target.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame, CFrame.new(0, RNG:NextNumber(-2,2), 0) + target.Character:FindFirstChildOfClass("Humanoid").MoveDirection * target.Character:FindFirstChildOfClass("Humanoid").RootPart.Velocity.Magnitude / 13)
					task.wait()
				end
				bot.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
				bot.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
				wait(0.3)
			end
			if target.Character:FindFirstChildOfClass("Humanoid").Health >= 15 then print("failed to kill player (health error)") return else end 

			for i = 1,20 do
				if target.Character then
					char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(target.Character.Head.CFrame.Position) * CFrame.new(0,3,0)
				end
				input.press(Enum.KeyCode.E)
				game:GetService("RunService").Heartbeat:Wait()
			end
			char:FindFirstChildOfClass("Humanoid").RootPart.CFrame = oldpos
		end

	end
end)

