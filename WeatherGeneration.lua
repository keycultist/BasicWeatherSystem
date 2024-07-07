--[[
  @ CW TAKT 
  @ D 12/16/23
]]

---- Service definitions
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

---- Replicated Asset definitions
local ReplicatedAssets = ReplicatedStorage:WaitForChild("ReplicatedAssets")
local SharedAssets = ReplicatedAssets:WaitForChild("SharedAssets")
local ClientAssets = ReplicatedAssets:WaitForChild("ClientAssets")

---- Event definitions
local RemoteEvents = SharedAssets:WaitForChild("RemoteEvents")
local RemoteReplication = RemoteEvents:WaitForChild("RemoteReplication")
local RemoteInput = RemoteEvents:WaitForChild("RemoteInput")

--- Module definitions
local Timer = require(script.Parent.TimeKeeper)

---- Array definitions
local WeatherGeneration = { }

function WeatherGeneration:Snow(Region : Part, Duration : number)
	local TimeKeep = Timer.new(Duration)

	repeat task.wait() until TimeKeep:OnFinished(function() do
			local SnowPart = Instance.new("Part")
			SnowPart.Parent = workspace.Effects
			SnowPart.Name = "SnowInstance"..Region.Name
			SnowPart.Anchored = true
			SnowPart.Size = Vector3.new(0.2,2,0.2)
			SnowPart.Position = (Region.CFrame * CFrame.new(
				(math.random() - 0.5) * Region.Size.X,
				1000,
				(math.random() - 0.5) * Region.Size.Z
				)).Position

			local RayCast = workspace:Raycast(SnowPart.Position,-Vector3.new(0, 10000, 0))
			local EndPos = RayCast.Position 

			TweenService:Create(SnowPart,TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = EndPos})
			Debris:AddItem(SnowPart,5)

			task.wait(0.5)
		end
	end)
end

--- Returning array for referencing
return WeatherGeneration
