--[[
  @ CW KEYCULTIST/PLEAT/608B PLEASE CREDIT WHEN USED!
  @ D 12/16/23
]]

---- Service definitions
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

---- Replicated Asset definitions
local ReplicatedAssets = ReplicatedStorage:WaitForChild("ReplicatedAssets")
local SharedAssets = ReplicatedAssets:WaitForChild("SharedAssets")
local ClientAssets = ReplicatedAssets:WaitForChild("ClientAssets")

--- Server Asset definitions
local ServerAssets = ServerStorage:WaitForChild("ServerAssets")
local ServerResources = ServerAssets:WaitForChild("Resources")
local ServerUtilities = ServerResources:WaitForChild("Utilities")

---- Event definitions
local RemoteEvents = SharedAssets:WaitForChild("RemoteEvents")
local RemoteReplication = RemoteEvents:WaitForChild("RemoteReplication")
local RemoteInput = RemoteEvents:WaitForChild("RemoteInput")

--- Module definitions
local DetectionUtility = require(ServerUtilities:WaitForChild("DetectionUtility"))
local RagdollUtility = require(ServerUtilities:WaitForChild("RagdollUtility"))
local Timer = require(script:WaitForChild("TimeKeeper"))

--- Globals
local Module = script

---- Array definitions
local Weather = { }
Weather.Types = {
	"ThunderStorm",
	"Snow",
	"Rain",
	"Hail",
	"Acid",
}

--[[
  Start Function; Starts a weather effect at a certain position/region
]]
function Weather:Start(WeatherType : string, TargetRegion : Part, Duration : number)
	if not WeatherType then
		warn("No weather type provided.")
		return
	end

	if not TargetRegion then
		warn("No region provided.")
		return
	end

	local Filter = { TargetRegion, workspace.Effects, workspace.Effects.Hitboxing, workspace.Effects.Weather, workspace.Effects.Weather.Rain, workspace.Effects.Weather.Snow, workspace.Effects.Weather.ThunderBolts }
	local Params = RaycastParams.new()
	Params.CollisionGroup = "Hitbox"
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = Filter

	if TargetRegion.Weather.Value ~= WeatherType then
		TargetRegion.Weather.Value = WeatherType

		if WeatherType == "Snow" then
			local TimeKeep = Timer.new(Duration)

			while TimeKeep:GetRemaining() > 0 do
				local SnowPart = Instance.new("Part")
				SnowPart.Parent = workspace.Effects.Weather.Snow
				SnowPart.Name = "SnowInstance"..TargetRegion.Name
				SnowPart.Anchored = true
				SnowPart.BrickColor = BrickColor.White()
				SnowPart.Material = Enum.Material.Snow
				SnowPart.CastShadow = false
				SnowPart.CanCollide = false
				SnowPart.CastShadow = false
				SnowPart.CollisionGroup = "Hitbox"
				SnowPart.Size = Vector3.new(0.3, 35, 0.3)
				SnowPart.Position = (TargetRegion.CFrame * CFrame.new(
					(math.random() - 0.5) * TargetRegion.Size.X,
					500,
					(math.random() - 0.5) * TargetRegion.Size.Z
					)).Position

				local RayCast = workspace:Raycast(SnowPart.Position,-Vector3.new(0, 10000, 0), Params)
				local EndPos = RayCast.Position 

				task.wait()

				local Tween = TweenService:Create(SnowPart, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = EndPos, Size = Vector3.new(0.2, 0.2, 0.2)})
				Tween:Play()

				Tween.Completed:Connect(function()
					local Splatter = Instance.new("Part")
					Splatter.Parent = workspace.Effects.Weather.Snow
					Splatter.Name = "SnowInstance"..TargetRegion.Name
					Splatter.Anchored = true
					Splatter.CastShadow = false
					Splatter.CanCollide = false
					Splatter.BrickColor = BrickColor.White()
					Splatter.Material = Enum.Material.Snow
					Splatter.Size = Vector3.new(0.1, 0.1, 0.1)
					Splatter.CollisionGroup = "Hitbox"
					Splatter.Position = EndPos

					local SplatterTween2 = TweenService:Create(Splatter,TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {Transparency = 1})

					local SplatterTween = TweenService:Create(Splatter,TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {Size = Vector3.new(3, 0.1, 3)})
					SplatterTween:Play()

					task.delay(0.6, function()
						SplatterTween2:Play()
					end)

					Debris:AddItem(Splatter, 1)

					if RayCast.Instance.Name == "SnowPuddle" then
						if RayCast.Instance.Size.X <= 5 then
							RayCast.Instance.Size += Vector3.new(0.5, 0.01, 0.5)
						end
					end
				end)

				Debris:AddItem(SnowPart, 5.1)
				task.wait(0.15)
			end
		end

		if WeatherType == "Rain" then
			local TimeKeep = Timer.new(Duration)

			while TimeKeep:GetRemaining() > 0 do
				local RainPart = Instance.new("Part")
				RainPart.Parent = workspace.Effects.Weather.Rain
				RainPart.Name = "RainDrop"..TargetRegion.Name
				RainPart.Anchored = true
				RainPart.BrickColor = BrickColor.new(43)
				RainPart.CanCollide = false
				RainPart.CollisionGroup = "Hitbox"
				RainPart.Material = Enum.Material.Glass
				RainPart.CastShadow = false
				RainPart.Size = Vector3.new(0.3, 35, 0.3)
				RainPart.Position = (TargetRegion.CFrame * CFrame.new(
					(math.random() - 0.5) * TargetRegion.Size.X,
					500,
					(math.random() - 0.5) * TargetRegion.Size.Z
					)).Position


				local RayCast = workspace:Raycast(RainPart.Position,-Vector3.new(0, 10000, 0), Params)
				local EndPos = RayCast.Position 

				task.wait()

				local Tween = TweenService:Create(RainPart, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = EndPos, Size = Vector3.new(0.2, 0.2, 0.2)})
				Tween:Play()

				Tween.Completed:Connect(function()
					local Splatter = Instance.new("Part")
					Splatter.Parent = workspace.Effects
					Splatter.Name = "RainSplatter"..TargetRegion.Name
					Splatter.Anchored = true
					Splatter.BrickColor = BrickColor.new(43)
					Splatter.Material = Enum.Material.Glass
					Splatter.Transparency = 0.5
					Splatter.CanCollide = false
					Splatter.CollisionGroup = "Hitbox"
					Splatter.Size = Vector3.new(0.1, 0.1, 0.1)
					Splatter.Position = EndPos

					local SplatterTween2 = TweenService:Create(Splatter,TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {Transparency = 1})
					local SplatterTween = TweenService:Create(Splatter,TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {Size = Vector3.new(2, 0.05, 2)})
					SplatterTween:Play()

					task.delay(0.6, function()
						SplatterTween2:Play()
					end)

					Debris:AddItem(Splatter, 1)
					
					if RayCast.Instance.Name == "GlassPuddle" then
						if RayCast.Instance.Size.X <= 5 then
							RayCast.Instance.Size += Vector3.new(0.5, 0.01, 0.5)
						end
					end
				end)

				Debris:AddItem(RainPart, 5)
				task.wait(0.15)
			end
		end

		if WeatherType == "ThunderStorm" then
			local TimeKeep = Timer.new(Duration)

			task.spawn(function()
				while TimeKeep:GetRemaining() > 0 do
					local RainPart = Instance.new("Part")
					RainPart.Parent = workspace.Effects.Weather.Rain
					RainPart.Name = "RainDrop"..TargetRegion.Name
					RainPart.Anchored = true
					RainPart.BrickColor = BrickColor.new(43)
					RainPart.Material = Enum.Material.Glass
					RainPart.CanCollide = false
					RainPart.CastShadow = false
					RainPart.Size = Vector3.new(0.3, 35, 0.3)
					RainPart.CollisionGroup = "Hitbox"
					RainPart.Position = (TargetRegion.CFrame * CFrame.new(
						(math.random() - 0.5) * TargetRegion.Size.X,
						500,
						(math.random() - 0.5) * TargetRegion.Size.Z
						)).Position


					local RayCast = workspace:Raycast(RainPart.Position,-Vector3.new(0, 10000, 0), Params)
					local EndPos = RayCast.Position 

					local Tween = TweenService:Create(RainPart, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = EndPos, Size = Vector3.new(0.2, 0.2, 0.2)})
					Tween:Play()

					Tween.Completed:Connect(function()
						RainPart.Transparency = 1
						local Splatter = Instance.new("Part")
						Splatter.Parent = workspace.Effects.Weather.Rain
						Splatter.Name = "RainSplatter"..TargetRegion.Name
						Splatter.Anchored = true
						Splatter.CastShadow = false
						Splatter.BrickColor = BrickColor.new(43)
						Splatter.CanCollide = false
						Splatter.Material = Enum.Material.Glass
						Splatter.Transparency = 0.5
						Splatter.CollisionGroup = "Hitbox"
						Splatter.Size = Vector3.new(0.1, 0.1, 0.1)
						Splatter.Position = EndPos

						local SplatterTween2 = TweenService:Create(Splatter,TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {Transparency = 1})

						local SplatterTween = TweenService:Create(Splatter,TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {Size = Vector3.new(2, 0.05, 2)})
						SplatterTween:Play()

						task.delay(0.6, function()
							SplatterTween2:Play()
						end)
						
						Debris:AddItem(RainPart, 5)

						Debris:AddItem(Splatter, 1)
						if RayCast.Instance.Name == "RainPuddle" then
							if RayCast.Instance.Size.X <= 5 then
								RayCast.Instance.Size += Vector3.new(0.5, 0.01, 0.5)
							end
						end
					end)
					task.wait(0.1 / 1000000000)
				end
			end)

			task.spawn(function()
				while TimeKeep:GetRemaining() > 0 do
					local PreferredMaterial = "Metal"
					local OriginPoint = (TargetRegion.CFrame * CFrame.new(
						(math.random() - 0.5) * TargetRegion.Size.X,
						900,
						(math.random() - 0.5) * TargetRegion.Size.Z
						)).Position

					local ThunderOrigin = Instance.new("Part", workspace.Effects.Weather.ThunderBolts)
					ThunderOrigin.Size = Vector3.new(2, 2, 2)
					ThunderOrigin.Anchored = true
					ThunderOrigin.Name = "ThunderOrigin"
					ThunderOrigin.Material = Enum.Material.Neon
					ThunderOrigin.Position = OriginPoint
					ThunderOrigin.CollisionGroup = "Hitbox"
					ThunderOrigin.CanCollide = false
					ThunderOrigin.CastShadow = false


					local RayCast = workspace:Raycast(ThunderOrigin.Position, -Vector3.new(0, 10000, 0), Params)
					local EndPos = RayCast.Position 

					local EndPart = Instance.new("Part")
					EndPart.CanCollide = false
					EndPart.CastShadow = false
					EndPart.Anchored = true 
					EndPart.Size = ThunderOrigin.Size
					EndPart.CollisionGroup = "Hitbox"
					EndPart.Name = "ThunderEndOrigin"		
					EndPart.Transparency = 1
					EndPart.CFrame = CFrame.new(EndPos.X, EndPos.Y, EndPos.Z)

					local Distance = OriginPoint.Y - EndPos.Y
					local TotalPoints = math.round(Distance / 25)

					local ParentPosition = OriginPoint

					local PreviousPart = ThunderOrigin

					for Index: Number = 1, TotalPoints do
						local DesiredPosition = ParentPosition + Vector3.new(math.random(-10, 10), -(Distance / 25) / 2.35, math.random(-10, 10))

						if Index == TotalPoints then
							DesiredPosition = EndPos

							local Hitbox = DetectionUtility:CreateHitBox(EndPart, Vector3.new(35, 35, 35), 1, false)
							local GetArray = Hitbox:GetArray({ })

							for Index: Number, Target: Model in pairs(GetArray) do
								local TargetHumanoid = Target:WaitForChild("Humanoid")
								
								local Victim = TargetHumanoid.Parent:FindFirstChild("HumanoidRootPart")
								
								local BodyVelocity = Instance.new("BodyVelocity")
								BodyVelocity.Parent = Victim
								BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								BodyVelocity.Velocity = -(EndPart.Position - Victim.Position).Unit * 50
								
								RagdollUtility.SetRagdoll(Victim.Parent,2)

								game.Debris:AddItem(BodyVelocity,0.5)
								
								TargetHumanoid:TakeDamage(15)
							end
						end

						local PointPart = Instance.new("Part", workspace.Effects.Weather.ThunderBolts)
						PointPart.Name = "PointPart"..Index
						PointPart.Size = ThunderOrigin.Size
						PointPart.Material = ThunderOrigin.Material
						PointPart.Anchored = true
						PointPart.Position = DesiredPosition
						PointPart.Transparency = 1
						PointPart.CanCollide = false
						PointPart.CollisionGroup = "Hitbox"
						PointPart.CastShadow = false

						local ConnectDist = (PreviousPart.Position - PointPart.Position).Magnitude
						local MidPos = (PreviousPart.Position + PointPart.Position) / 2
						local Up = Vector3.new(0,1,0)

						local ConnectingPart = Instance.new("Part", workspace.Effects.Weather.ThunderBolts)
						ConnectingPart.Name = "ConnectingPart"..Index
						ConnectingPart.CFrame = CFrame.lookAt(MidPos,PointPart.Position,Up)
						ConnectingPart.Size = Vector3.new(0,0,ConnectDist)
						ConnectingPart.Anchored = true
						ConnectingPart.Material = ThunderOrigin.Material
						ConnectingPart.Transparency = 0
						ConnectingPart.CanCollide = false
						ConnectingPart.CastShadow = false

						TweenService:Create(ConnectingPart,TweenInfo.new(0.25,Enum.EasingStyle.Sine),{Transparency = 0, Size = Vector3.new(ThunderOrigin.Size.X,ThunderOrigin.Size.Y,ConnectDist)}):Play()

						ParentPosition = DesiredPosition
						PreviousPart = PointPart

						Debris:AddItem(PointPart, 2)
						Debris:AddItem(ConnectingPart, 2)

						task.delay(1,function()
							TweenService:Create(ConnectingPart,TweenInfo.new(0.25,Enum.EasingStyle.Sine),{Transparency = 1, Size = Vector3.new(0,0,ConnectingPart.Size.Z)}):Play()
						end)

						task.wait(0.000001)
					end

					ParentPosition = OriginPoint 

					Debris:AddItem(ThunderOrigin, 2)
					task.wait()
				end
			end)
		end
	end

	task.delay(Duration, function()
		TargetRegion:FindFirstChild("Weather").Value = "Sunny"
	end)
end

--[[
  Random Function; Creates a random weather effect.
]]
function Weather:Random(Position)
	local Types = Weather.Types

	local Chosen = Types[math.random(1,#Types)]

	return Chosen
end

--- Returning array for referencing
return Weather
