-- Made by Akira
---------------------------------------------------------------------------------------
local VisualTweens = require(game.ReplicatedStorage.VisualTweens)
---------------------------------------------------------------------------------------
local myFrame = script.Parent.MYFrame
local ImageLabel = script.Parent.ImageLabel
local button = script.Parent.TextButton
---------------------------------------------------------------------------------------
VisualTweens.ApplyGlowEffect(myFrame, {
    GrowMultiplier = 1.5,
    GrowTime = 1,
    ShrinkTime = 0.3,
    RepeatCount = -1,
    DelayBetween = 1
})
---------------------------------------------------------------------------------------
VisualTweens.ApplyBounceEffect(button, {
    BounceScale = 1.2,
    BounceTime = 0.15,
    HoverOnly = true
})
---------------------------------------------------------------------------------------
VisualTweens.ApplyGlowEffect(ImageLabel, {
    GrowMultiplier = 1.2,
    GrowTime = 1,
    ShrinkTime = 0.3,
    RepeatCount = -1,
    DelayBetween = 1
})
---------------------------------------------------------------------------------------
