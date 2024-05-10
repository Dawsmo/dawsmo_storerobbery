lib.locale()
Config = {}

Config.General = {
    TimeBeforeReset = 15, -- minutes
    PoliceJobsName = {"police", "fib", "bcso"},
    PoliceCountToRob = 1,
    ChanceNpc = {
        Surrender = 70, -- %
        Run = 60, -- %
        Fight = 40, -- %
    },
}

Config.Shopkeepers = {
    ["grocery"] = "mp_m_shopkeep_01",
    ["barber"] = "s_f_m_fembarber",
    ["tattoo"] = "s_m_m_tattoo_01",
    ["clothes"] = "s_f_y_shop_low",
}

Config.RobData = {
    ["CashRegister"] = {
        Message = locale("Config_CashRegister_Message"),
        BreakRegister = { -- Step 1 : Break the register
            Message = locale("Config_BreakRegister_Message"),
            TimeForBreak = 3500, -- milliseconds
        },
        RobRegister = { -- Step 2 : Rob the register
            Message = locale("Config_RobRegister_Message"),
            TimeForRob = 16500, -- milliseconds
        },
        Rewards = {
            ["black_money"] = {min = 1000, max = 1250, label = "Argent sale"}
        },
    },
    ["StoreShelves"] = {
        Message = locale("Config_StoreShelves_Message"),
        Description = locale("Config_StoreShelves_Description"),
        TimeForRob = 15000, -- milliseconds
        Rewards = {
            ["clothes"] = {
                ["black_money"] = {min = 400, max = 500, label = "Argent sale"}
            },
            ["tattoo"] = {
                ["black_money"] = {min = 400, max = 500, label = "Argent sale"}
            },
            ["barber"] = {
                ["black_money"] = {min = 400, max = 500, label = "Argent sale"}
            },
            ["grocery"] = {
                ["black_money"] = {min = 400, max = 500, label = "Argent sale"}
            }
        },
    },
    ["Safe"] = {
        Message = locale("Config_Safe_Message"),
        Description = locale("Config_Safe_Grab"),
        TimeForGrabMoney = 10000, -- milliseconds
        SafeTextUI = {
            icon = 'vault',
            style = {
                borderRadius = 0,
                backgroundColor = '#c40000',
                color = 'white'
            }
        },
        ForcePin = {
            Message = locale("Config_Safe_ForcePin"),
            Item = "hook_metal",
        },
        ForceSafe = {
            Message = locale("Config_Safe_ForceSafe"),
            TimeForForce = 35000, -- milliseconds
            Item = "blowtorch",
        },
        Rewards = {
            ["black_money"] = {min = 2000, max = 2500, label = "Argent sale"}
        },
    }
}
