Config = {}

Config.Debug = false

-- Available Effects (just reference by number)
Config.EffectTypes = {
    [1] = { -- Basic stimulant
        timecycle = "DrugsDrivingOut",
        runMultiplier = 1.25,
        staminaRestore = 1.0,
        duration = 30000
    },
    [2] = { -- Health restoration
        timecycle = "PPFilter",
        healthRestore = 50,
        duration = 15000
    },
    [3] = { -- Strong stimulant
        timecycle = "ArenaEMP",
        runMultiplier = 1.5,
        staminaRestore = 1.0,
        armorRestore = 25,
        duration = 45000
    },
    [4] = { -- Hallucinogenic
        timecycle = "BikerFilter",
        runMultiplier = 0.8,
        duration = 60000
    },
    [5] = { -- Pain killer
        timecycle = "PlayerSwitchPulse",
        healthRestore = 25,
        armorRestore = 10,
        duration = 25000
    },
    [6] = { -- Energy boost
        timecycle = "CAMERA_secuirity",
        runMultiplier = 1.3,
        swimMultiplier = 1.2,
        staminaRestore = 1.0,
        duration = 20000
    }
}

-- Available Animations (just reference by number)
Config.AnimationTypes = {
    [1] = { -- Smoking animation
        dict = "amb@world_human_smoking_pot@male@base",
        clip = "base",
        duration = 5000
    },
    [2] = { -- Pill swallowing
        dict = "mp_suicide",
        clip = "pill",
        duration = 3000
    },
    [3] = { -- Drinking animation
        dict = "amb@world_human_drinking@beer@male@idle_a",
        clip = "idle_a",
        duration = 4000
    },
    [4] = { -- Injecting
        dict = "mp_suicide",
        clip = "pill",
        duration = 4000
    },
    [5] = { -- Eating
        dict = "mp_player_inteat@burger",
        clip = "mp_player_int_eat_burger",
        duration = 3000
    },
    [6] = { -- Chemical sniffing
        dict = "switch@trevor@trev_smoking_wait",
        clip = "trev_smoking_wait_loop",
        duration = 4000
    }
}

-- Harvest locations configuration
Config.HarvestLocations = {
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
    },
    -- Add more locations like this:
    -- {
    --     name = "medicine_harvest",
    --     coords = vec3(100.0, 200.0, 300.0),
    --     heading = 180.0,
    --     radius = 2.5,
    --     item = "medicine",
    --     itemAmount = 2,
    --     duration = 7000,
    --     animation = {
    --         dict = 'amb@world_human_gardener_plant@male@base',
    --         clip = 'base'
    --     },
    --     marker = {
    --         type = 1,
    --         size = vec3(2.0, 2.0, 1.0),
    --         color = {0, 0, 255, 150}
    --     }
    -- }
}

-- Item effects configuration
Config.ItemEffects = {
    -- Pills effect
    pills = {
        notify = {
            title = 'Pills',
            description = 'You feel a sudden burst of energy!',
            type = 'inform'
        },
        effectType = 1, -- References Config.EffectTypes[1]
        animationType = 2, -- References Config.AnimationTypes[2]
    },
    -- Medicine effect
    medicine = {
        notify = {
            title = 'Medicine',
            description = 'You feel your wounds healing...',
            type = 'success'
        },
        effectType = 2, -- References Config.EffectTypes[2]
        animationType = 2, -- References Config.AnimationTypes[2]
    },
    -- Add more items easily:
    -- stimulant = {
    --     notify = {
    --         title = 'Stimulant',
    --         description = 'Your senses are heightened!',
    --         type = 'warning'
    --     },
    --     effectType = 3, -- Strong stimulant
    --     animationType = 4, -- Injecting animation
    -- },
    -- energy_drink = {
    --     notify = {
    --         title = 'Energy Drink',
    --         description = 'You feel energized!',
    --         type = 'inform'
    --     },
    --     effectType = 6, -- Energy boost
    --     animationType = 3, -- Drinking animation
    -- },
    -- hallucinogen = {
    --     notify = {
    --         title = 'Strange Substance',
    --         description = 'Reality seems to warp around you...',
    --         type = 'error'
    --     },
    --     effectType = 4, -- Hallucinogenic
    --     animationType = 6, -- Chemical sniffing
    -- }
}