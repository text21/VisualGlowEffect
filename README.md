# GlowEffectModule

A flexible, easy-to-use Lua module for creating glowing and pulsing effects on `Frame` and `ImageLabel` UI elements in Roblox. This module enables you to apply a visually appealing glow effect that grows and fades over time, with customizable settings such as color, transparency, and number of repetitions.

## Features

- **Supports Frames and ImageLabels**: The module works seamlessly with both `Frame` and `ImageLabel` UI elements.
- **Customizable Glow**: Adjust the color, transparency, and size of the glow effect.
- **Looping Support**: Control the number of times the effect should repeat, or loop infinitely.
- **Flexible**: Easily reusable in any UI, and can be applied to multiple elements with just a single line of code.
- **Disappearing Effect**: The UI element disappears after each cycle, and then reappears to continue the effect.

## Installation

To use this module, you can simply add it to `ReplicatedStorage` or any other service where you prefer storing modules in your Roblox game. 

Once added, you can easily require the module in your scripts like so:

```lua
local GlowEffect = require(game.ReplicatedStorage.GlowEffectModule)
```

## Usage
You can apply the glow effect to any Frame or ImageLabel UI element using the ApplyGlowEffect function. Here's how:
```lua
local GlowEffect = require(game.ReplicatedStorage.GlowEffectModule)
local myFrame = script.Parent.MYFrame
local ImageLabel = script.Parent.ImageLabel

-- Apply the effect to a Frame
GlowEffect.ApplyGlowEffect(myFrame, {
    GrowMultiplier = 1.5,  -- Size multiplier for the glow effect
    GrowTime = 0.3,        -- Duration for the growing animation
    ShrinkTime = 0.3,      -- Duration for the shrinking animation
    RepeatCount = 3,       -- How many times the effect should repeat
    DelayBetween = 0.2,    -- Delay time between each cycle
    GlowColor = Color3.new(1, 1, 1), -- Glow color (white by default)
    MinTransparency = 0.2, -- Minimum transparency for the glow effect
    MaxTransparency = 0.7 -- Maximum transparency during fading
})

-- Apply the effect to an ImageLabel
GlowEffect.ApplyGlowEffect(myImageLabel, {
    GrowMultiplier = 1.3,
    GrowTime = 0.4,
    ShrinkTime = 0.4,
    RepeatCount = 5, 
    DelayBetween = 0.3,
    GlowColor = Color3.new(1, 1, 1),
    MinTransparency = 0.3,
    MaxTransparency = 1
})
```
## Configuration Options

Here are the available configuration options you can modify when applying the glow effect:
```lua
- *GrowMultiplier* (default: 1.2): Controls how much the element should grow during the effect. The higher the value, the more it will grow.
- *GrowTime* (default: 0.6): Duration of the growing phase.
- *ShrinkTime* (default: 0.6): Duration of the shrinking phase.
- *RepeatCount* (default: -1): How many times the effect should repeat. Use -1 for infinite repetition.
- *DelayBetween* (default: 0.2): Time to wait between each cycle.
- *GlowColor* (default: Color3.new(1, 1, 1)): Color of the glow effect. Default is white.
- *MinTransparency* (default: 0.3): The minimum transparency of the element during the glow effect.
- *MaxTransparency *(default: 1): The maximum transparency during the fading part of the effect.
```
## Example Use Case
If you want a Frame to pulse with a white glow that grows larger, fades out, disappears, and then comes back for a total of 5 cycles, you would use:
```lua
GlowEffect.ApplyGlowEffect(myFrame, {
    GrowMultiplier = 1.5,
    GrowTime = 0.3,
    ShrinkTime = 0.3,
    RepeatCount = 5,
    DelayBetween = 0.2,
    GlowColor = Color3.new(1, 1, 1),
    MinTransparency = 0.2,
    MaxTransparency = 0.7
})
```

## Notes
- The glow effect will automatically reset the element's original properties (size, transparency, color) after each cycle.
- The `RepeatCount` parameter allows you to control how many times the effect will loop. If set to `-1`, the effect will loop indefinitely.
- If you have multiple elements that need the effect, you can easily reuse the ApplyGlowEffect function for each element.
- If you have multiple elements that need the effect, you can easily reuse the `ApplyGlowEffect` function for each element.

## Contribution
Feel free to fork this project and submit issues or pull requests if you'd like to contribute to the module. If you have any suggestions or find any bugs, please let me know!

## License
This project is open-source and available for free use in any Roblox game. You can modify and distribute it under the MIT License.
