-- Made by Akira
---------------------------------------------------------------------------------------
local GlowEffect = require(game.ReplicatedStorage.GlowEffectModule)
---------------------------------------------------------------------------------------
local myFrame = script.Parent.MYFrame
local ImageLabel = script.Parent.ImageLabel
---------------------------------------------------------------------------------------
GlowEffect.ApplyGlowEffect(myFrame, {
    GrowMultiplier = 1.5,
    GrowTime = 1,
    ShrinkTime = 0.3,
    RepeatCount = 3,
    DelayBetween = 1
})
---------------------------------------------------------------------------------------
GlowEffect.ApplyGlowEffect(ImageLabel, {
    GrowMultiplier = 1.2,
    GrowTime = 1,
    ShrinkTime = 0.3,
    RepeatCount = -1, -- Grows and shrinks 5 times
    DelayBetween = 1
})
---------------------------------------------------------------------------------------
