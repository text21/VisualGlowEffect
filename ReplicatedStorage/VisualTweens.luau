-- Made by Akira
---------------------------------------------------------------------------------------
local TweenService = game:GetService("TweenService")
---------------------------------------------------------------------------------------
local VisualTweens = {}
---------------------------------------------------------------------------------------
local function validateUIElement(uiElement)
    if not uiElement or
        not (uiElement:IsA("ImageLabel") or uiElement:IsA("Frame") or uiElement:IsA("TextButton") or
            uiElement:IsA("TextLabel")) or uiElement:IsA("ImageButton") then
        error("VisualEffects module only supports ImageLabels, Frames, TextButtons, and TextLabels", 2)
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
local function createTween(uiElement, tweenInfo, goals)
    return TweenService:Create(uiElement, tweenInfo, goals)
end
---------------------------------------------------------------------------------------
local function processConfiguration(config, defaults)
    config = deepCopyConfig(config)
    for k, v in pairs(defaults) do
        config[k] = config[k] ~= nil and config[k] or v
    end
    return config
end
---------------------------------------------------------------------------------------
-- Glow Effect
function VisualTweens.ApplyGlowEffect(uiElement, config)
    validateUIElement(uiElement)

    local defaults = {
        GrowMultiplier = 1.2,
        GrowTime = 0.6,
        ShrinkTime = 0.6,
        RepeatCount = -1,
        DelayBetween = 0.2,
        GlowColor = Color3.new(1, 1, 1),
        MinTransparency = 0.3,
        MaxTransparency = 1
    }
    config = processConfiguration(config, defaults)

    local originalSize = uiElement.Size
    local originalTransparency = uiElement.BackgroundTransparency or uiElement.ImageTransparency

    local growTween = createTween(uiElement, TweenInfo.new(config.GrowTime), {
        Size = UDim2.new(originalSize.X.Scale * config.GrowMultiplier, originalSize.X.Offset * config.GrowMultiplier,
            originalSize.Y.Scale * config.GrowMultiplier, originalSize.Y.Offset * config.GrowMultiplier),
        BackgroundTransparency = config.MinTransparency
    })

    local shrinkTween = createTween(uiElement, TweenInfo.new(config.ShrinkTime), {
        Size = originalSize,
        BackgroundTransparency = config.MaxTransparency
    })

    task.spawn(function()
        for i = 1, config.RepeatCount > 0 and config.RepeatCount or math.huge do
            growTween:Play()
            growTween.Completed:Wait()
            shrinkTween:Play()
            shrinkTween.Completed:Wait()
            task.wait(config.DelayBetween)
        end
    end)
end
---------------------------------------------------------------------------------------
-- Bounce Effect
function VisualTweens.ApplyBounceEffect(uiElement, config)
    validateUIElement(uiElement)

    config = processConfiguration(config, {
        BounceScale = 1.2,
        BounceTime = 0.15,
        RepeatCount = 1,
        HoverOnly = false
    })

    local originalSize = uiElement.Size
    local function scaleUDim2(udim2, multiplier)
        return UDim2.new(udim2.X.Scale * multiplier, udim2.X.Offset * multiplier, udim2.Y.Scale * multiplier,
            udim2.Y.Offset * multiplier)
    end

    local bounceTweenInfo = TweenInfo.new(config.BounceTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    local bounceUp = TweenService:Create(uiElement, bounceTweenInfo, {
        Size = scaleUDim2(originalSize, config.BounceScale)
    })

    local bounceDown = TweenService:Create(uiElement, bounceTweenInfo, {
        Size = originalSize
    })

    local function runBounce()
        bounceUp:Play()
        bounceUp.Completed:Wait()
        bounceDown:Play()
    end

    if config.HoverOnly then
        uiElement.MouseEnter:Connect(function()
            runBounce()
        end)
    else
        task.spawn(function()
            for i = 1, config.RepeatCount > 0 and config.RepeatCount or math.huge do
                runBounce()
                task.wait(0.1) -- Small delay
            end
        end)
    end
end
---------------------------------------------------------------------------------------
-- Open Menu Effect
function VisualTweens.OpenMenu(uiElement, config)
    validateUIElement(uiElement)

    local defaults = {
        OpenTime = 0.5,
        TargetSize = UDim2.new(1, 0, 1, 0)
    }
    config = processConfiguration(config, defaults)

    uiElement.Size = UDim2.new(0, 0, 0, 0)
    local openTween = createTween(uiElement, TweenInfo.new(config.OpenTime, Enum.EasingStyle.Quad), {
        Size = config.TargetSize
    })

    openTween:Play()
end
---------------------------------------------------------------------------------------
-- Close Menu Effect
function VisualTweens.CloseMenu(uiElement, config)
    validateUIElement(uiElement)

    local defaults = {
        CloseTime = 0.5
    }
    config = processConfiguration(config, defaults)

    local closeTween = createTween(uiElement, TweenInfo.new(config.CloseTime, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 0)
    })

    closeTween:Play()
    closeTween.Completed:Wait()
    uiElement.Visible = false
end
---------------------------------------------------------------------------------------
-- Button Grow
function VisualTweens.ApplyHoverHighlight(uiElement, config)
    validateUIElement(uiElement)

    -- Default configuration
    config = processConfiguration(config, {
        GrowMultiplier = 1.1,
        FadeTransparency = 0.5,
        TransitionTime = 0.2
    })

    local originalSize = uiElement.Size
    local originalTransparency = uiElement.BackgroundTransparency or uiElement.ImageTransparency

    uiElement.MouseEnter:Connect(function()
        local highlightTween = createTween(uiElement, TweenInfo.new(config.TransitionTime), {
            Size = UDim2.new(originalSize.X.Scale * config.GrowMultiplier,
                originalSize.X.Offset * config.GrowMultiplier, originalSize.Y.Scale * config.GrowMultiplier,
                originalSize.Y.Offset * config.GrowMultiplier),
            BackgroundTransparency = config.FadeTransparency
        })
        highlightTween:Play()
    end)

    uiElement.MouseLeave:Connect(function()
        local resetTween = createTween(uiElement, TweenInfo.new(config.TransitionTime), {
            Size = originalSize,
            BackgroundTransparency = originalTransparency
        })
        resetTween:Play()
    end)
end
---------------------------------------------------------------------------------------
-- PulseGlow
function VisualTweens.ApplyHoverPulse(uiElement, config)
    validateUIElement(uiElement)

    -- Default configuration
    config = processConfiguration(config, {
        GlowTime = 0.4,
        MinTransparency = 0.3,
        MaxTransparency = 1
    })

    local originalTransparency = uiElement.BackgroundTransparency or uiElement.ImageTransparency

    uiElement.MouseEnter:Connect(function()
        local pulseTween = createTween(uiElement, TweenInfo.new(config.GlowTime, Enum.EasingStyle.Quad,
            Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = config.MinTransparency
        })
        pulseTween:Play()
    end)

    uiElement.MouseLeave:Connect(function()
        local resetTween = createTween(uiElement, TweenInfo.new(0.2), {
            BackgroundTransparency = originalTransparency
        })
        resetTween:Play()
    end)
end
---------------------------------------------------------------------------------------
-- Shrink on Click
function VisualTweens.ApplyClickShrink(uiElement, config)
    validateUIElement(uiElement)

    -- Default configuration
    config = processConfiguration(config, {
        ShrinkScale = 0.9,
        ShrinkTime = 0.1
    })

    local originalSize = uiElement.Size

    uiElement.MouseButton1Click:Connect(function()
        local shrinkTween = createTween(uiElement, TweenInfo.new(config.ShrinkTime), {
            Size = UDim2.new(originalSize.X.Scale * config.ShrinkScale, originalSize.X.Offset * config.ShrinkScale,
                originalSize.Y.Scale * config.ShrinkScale, originalSize.Y.Offset * config.ShrinkScale)
        })

        local resetTween = createTween(uiElement, TweenInfo.new(config.ShrinkTime), {
            Size = originalSize
        })

        shrinkTween:Play()
        shrinkTween.Completed:Wait()
        resetTween:Play()
    end)
end
---------------------------------------------------------------------------------------
-- Glow on Click
function VisualTweens.ApplyClickGlow(uiElement, config)
    validateUIElement(uiElement)

    -- Default configuration
    config = processConfiguration(config, {
        GlowColor = Color3.new(1, 1, 1),
        GlowTime = 0.2,
        MinTransparency = 0.3
    })

    local originalTransparency = uiElement.BackgroundTransparency or uiElement.ImageTransparency

    uiElement.MouseButton1Click:Connect(function()
        local glowTween = createTween(uiElement, TweenInfo.new(config.GlowTime), {
            BackgroundTransparency = config.MinTransparency
        })

        local resetTween = createTween(uiElement, TweenInfo.new(config.GlowTime), {
            BackgroundTransparency = originalTransparency
        })

        glowTween:Play()
        glowTween.Completed:Wait()
        resetTween:Play()
    end)
end
---------------------------------------------------------------------------------------
return VisualTweens
