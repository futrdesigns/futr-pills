futr-pills
A customizable FiveM resource for creating harvestable items with various effects.

Installation
Download the resource and place it in your resources directory

Add ensure futr-pills to your server.cfg

Make sure you have the following dependencies:

ox_lib

ox_inventory (or your preferred inventory system)

Configuration
Adding Harvest Locations
Edit config.lua and add locations to Config.HarvestLocations:

lua
{
    name = "pills_harvest",
    coords = vec3(-1536.43, 868.49, 180.13),
    heading = 226.1295,
    radius = 2.5,
    item = "pills",
    itemAmount = 1,
    duration = 5000,
    animation = {
        dict = 'amb@world_human_gardener_plant@male@idle_a',
        clip = 'idle_a'
    },
    marker = {
        type = 1,
        size = vec3(2.0, 2.0, 1.0),
        color = {0, 255, 0, 150}
    }
}
Adding New Items
Add item effects in config.lua:

lua
Config.ItemEffects = {
    your_item_name = {
        notify = {
            title = 'Item Name',
            description = 'Effect description',
            type = 'inform' -- success, error, warning, inform
        },
        effectType = 1, -- Choose from 1-6 in EffectTypes
        animationType = 1, -- Choose from 1-6 in AnimationTypes
    }
}
Add inventory item (ox_inventory example):

lua
['your_item_name'] = {
    label = 'Your Item',
    weight = 100,
    stack = true,
    close = true,
    description = 'Item description',
    client = {
        export = 'pill_system.useItem'
    }
}
Available Effect Types
1: Basic stimulant (energy boost, speed increase)

2: Health restoration (healing)

3: Strong stimulant (speed, armor)

4: Hallucinogenic (visual effects, slowed movement)

5: Pain killer (health and armor)

6: Energy boost (speed and swimming)

Available Animation Types
1: Smoking animation

2: Pill swallowing

3: Drinking animation

4: Injecting

5: Eating

6: Chemical sniffing

Usage
Players approach harvest locations marked with green markers

Press E to harvest items

Use items from inventory to activate effects

Effects automatically wear off after their duration

Commands
/testitem <item_name> - Test item effects (debug mode only)

Dependencies
ox_lib

ox_inventory (recommended)
