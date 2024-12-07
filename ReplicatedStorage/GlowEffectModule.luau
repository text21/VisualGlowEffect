-- Made by Akira
---------------------------------------------------------------------------------------
local TweenService = game:GetService("TweenService")
---------------------------------------------------------------------------------------
local GlowEffectModule = {}
---------------------------------------------------------------------------------------
local function validateUIElement(uiElement)
	if not uiElement or not (uiElement:IsA("ImageLabel") or uiElement:IsA("Frame")) then
		error("GlowEffectModule only supports ImageLabels and Frames", 2)
	end
end
---------------------------------------------------------------------------------------
local function getElementProperties(uiElement)
	if uiElement:IsA("ImageLabel") then
		return {
			colorProperty = "ImageColor3",
			transparencyProperty = "ImageTransparency"
		}
	else
		return {
			colorProperty = "BackgroundColor3", 
			transparencyProperty = "BackgroundTransparency"
		}
	end
end
---------------------------------------------------------------------------------------
local function deepCopyConfig(config)
	local copy = {}
	for k, v in pairs(config or {}) do
		copy[k] = v
	end
	return copy
end
---------------------------------------------------------------------------------------
local function processConfiguration(config)
	config = deepCopyConfig(config)
	
	config.GrowMultiplier = type(config.GrowMultiplier) == "number" and config.GrowMultiplier or 1.2
	config.GrowTime = type(config.GrowTime) == "number" and config.GrowTime or 0.6
	config.ShrinkTime = type(config.ShrinkTime) == "number" and config.ShrinkTime or 0.6
	config.RepeatCount = type(config.RepeatCount) == "number" and config.RepeatCount or -1
	config.DelayBetween = type(config.DelayBetween) == "number" and config.DelayBetween or 0.2

	config.GlowColor = config.GlowColor or Color3.new(1, 1, 1)
	config.MinTransparency = type(config.MinTransparency) == "number" and 
		math.clamp(config.MinTransparency, 0, 1) or 0.3
	config.MaxTransparency = type(config.MaxTransparency) == "number" and 
		math.clamp(config.MaxTransparency, 0, 1) or 1

	return config
end
---------------------------------------------------------------------------------------
function GlowEffectModule.ApplyGlowEffect(uiElement, config)
	validateUIElement(uiElement)
	config = processConfiguration(config)

	local props = getElementProperties(uiElement)

	local originalSize = uiElement.Size
	local originalColor = uiElement[props.colorProperty]
	local originalTransparency = uiElement[props.transparencyProperty]

	local growTweenInfo = TweenInfo.new(
		config.GrowTime, 
		Enum.EasingStyle.Sine, 
		Enum.EasingDirection.Out, 
		-1,
		true
	)

	local fadeTweenInfo = TweenInfo.new(
		config.GrowTime, 
		Enum.EasingStyle.Sine, 
		Enum.EasingDirection.Out, 
		-1,
		true
	)

	local growGoals = {
		Size = UDim2.new(
			originalSize.X.Scale * config.GrowMultiplier,
			originalSize.X.Offset * config.GrowMultiplier,
			originalSize.Y.Scale * config.GrowMultiplier,
			originalSize.Y.Offset * config.GrowMultiplier
		),
		[props.colorProperty] = config.GlowColor,
		[props.transparencyProperty] = config.MinTransparency
	}

	local fadeGoals = {
		[props.transparencyProperty] = config.MaxTransparency
	}

	local function runEffect()
		local growTween = TweenService:Create(uiElement, growTweenInfo, growGoals)
		local fadeTween = TweenService:Create(uiElement, fadeTweenInfo, fadeGoals)

		growTween:Play()
		fadeTween:Play()

		growTween.Completed:Wait()
		fadeTween.Completed:Wait()
	end

	task.spawn(function()
		local count = 0
		while config.RepeatCount == -1 or count < config.RepeatCount do
			runEffect()

			uiElement[props.transparencyProperty] = 1
			uiElement.Size = UDim2.new(0, 0, 0, 0)

			task.wait(config.DelayBetween)

			uiElement[props.colorProperty] = originalColor
			uiElement[props.transparencyProperty] = originalTransparency
			uiElement.Size = originalSize

			count += 1
		end
	end)
end
---------------------------------------------------------------------------------------
return GlowEffectModule
---------------------------------------------------------------------------------------