lib.locale()
Config = {}

Config.General = {
    TimeBeforeReset = 15, -- minutes
    PoliceJobsName = {"police", "fib", "bcso"},
    PoliceCountToRob = 2,
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
            ["black_money"] = {min = 1, max = 100, label = "Argent sale"}
        },
    },
    ["StoreShelves"] = {
        Message = locale("Config_StoreShelves_Message"),
        Description = locale("Config_StoreShelves_Description"),
        TimeForRob = 15000, -- milliseconds
        Rewards = {
            ["clothes"] = {
                ["black_money"] = {min = 1, max = 100, label = "Argent sale"}
            },
            ["tattoo"] = {
                ["black_money"] = {min = 1, max = 100, label = "Argent sale"}
            },
            ["barber"] = {
                ["black_money"] = {min = 1, max = 100, label = "Argent sale"}
            },
            ["grocery"] = {
                ["black_money"] = {min = 1, max = 100, label = "Argent sale"},
                ["money"] = {min = 1, max = 100, label = "Argent"},
                ["cigare"] = {min = 1, max = 100, label = "Cigare"}
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
            Item = "stethoscope",
        },
        ForceSafe = {
            Message = locale("Config_Safe_ForceSafe"),
            TimeForForce = 35000, -- milliseconds
            Item = "blowtorch",
        },
        Rewards = {
            ["black_money"] = {min = 1, max = 100, label = "Argent sale"}
        },
    }
}

Config.Stores = {
    [1] = {
        Coords = vec3(24.8778, -1346.7985, 28.4970),
        Heading = 268.9660,
        Type = "grocery",
        PositionNPC = {Coords = vec3(26.3499, -1342.7832, 29.4969), Heading = 191.6737},
        Loots = {
            CashRegister = {
                {Coords = vec3(24.8881, -1345.7323, 29.4970)},
                {Coords = vec3(24.8901, -1347.9144, 29.4970)}
            },
            StoreShelves = {
                {Coords = vec3(28.8435, -1342.3337, 29.4969)},
                {Coords = vec3(29.6959, -1345.1266, 29.4969)}
            },
            Safe = {
                {Coords = vec3(31.1874, -1339.2880, 29.4970)}}
        }
    },
    [2] = {
        Coords = vec3(-46.3478, -1757.3995, 28.4210),
        Heading = 51.1140,
        Type = "grocery",
        PositionNPC = {Coords = vec3(-43.8559, -1755.6353, 28.4210), Heading = 50.7693},
        Loots = {
            CashRegister = {
                {Coords = vec3(-47.8860, -1759.3416, 29.4210)},
                {Coords = vec3(-46.6880, -1757.8430, 29.4210)}
            },
            StoreShelves = {
                {Coords = vec3(-51.2737, -1753.2230, 29.4210)},
                {Coords = vec3(-48.3073, -1753.8469, 29.4210)},
            },
            Safe = {
                {Coords = vec3(-43.4282, -1748.3297, 29.4210)},
            }
        }
    },
    [3] = {
        Coords = vec3(1134.3834, -983.5386, 45.4158),
        Heading = 282.0896,
        Type = "grocery",
        PositionNPC = {Coords = vec3(1133.1693, -985.1602, 45.4158), Heading = 310.8448},
        Loots = {
            CashRegister = {
                {Coords = vec3(1134.2202, -982.4551, 46.4158)},
            },
            StoreShelves = {
                {Coords = vec3(1138.6030, -978.4352, 46.4158)},
                {Coords = vec3(1137.7955, -982.0631, 46.4158)},
                {Coords = vec3(1138.3778, -984.4227, 46.4158)}
            },
            Safe = {
                {Coords = vec3(1126.7216, -980.0662, 45.4159)},
            }
        }
    },
    [4] = {
        Coords = vec3(1164.5416, -322.0866, 68.2050),
        Heading = 101.6851,
        Type = "grocery",
        PositionNPC = {Coords = vec3(1162.0283, -319.4686, 69.2050), Heading = 216.4090},
        Loots = {
            CashRegister = {
                {Coords = vec3(1164.6501, -322.6800, 69.2050)},
                {Coords = vec3(1165.0613, -324.4826, 69.2050)},
            },
            StoreShelves = {
                {Coords = vec3(1158.1998, -322.9624, 69.2050)},
                {Coords = vec3(1155.4573, -323.0468, 69.2050)},
            },
            Safe = {
                {Coords = vec3(1159.4574, -313.9596, 69.2050)},
            }
        }
    },
    [5] = {
        Coords = vec3(373.1424, 326.9729, 102.5662),
        Heading = 262.0553,
        Type = "grocery",
        PositionNPC = {Coords = vec3(375.6443, 330.3748, 103.5662), Heading = 185.3757},
        Loots = {
            CashRegister = {
                {Coords = vec3(373.3371, 327.6888, 103.5664)},
                {Coords = vec3(372.8254, 325.8064, 103.5664)},
            },
            StoreShelves = {
                {Coords = vec3(381.7286, 324.6560, 103.5663)},
                {Coords = vec3(378.9305, 327.0092, 103.5663)},
            },
            Safe = {
                {Coords = vec3(381.0391, 332.5438, 103.5664)},
            }
        }
    },
    [6] = {
        Coords = vec3(-706.1328, -913.0532, 18.2156),
        Heading = 88.8824,
        Type = "grocery",
        PositionNPC = {Coords = vec3(-705.3860, -910.1396, 19.2156), Heading = 92.5051},
        Loots = {
            CashRegister = {
                {Coords = vec3(-706.1579, -913.5543, 19.2156)},
                {Coords = vec3(-706.0503, -915.4207, 19.2156)},
            },
            StoreShelves = {
                {Coords = vec3(-715.5468, -909.1751, 19.2156)},
                {Coords = vec3(-718.1109, -911.4780, 19.2156)},
            },
            Safe = {
                {Coords = vec3(-709.6874, -904.0332, 19.2156)},
            }
        }
    },
    [7] = {
        Coords = vec3(-1221.4061, -908.0616, 11.3263),
        Heading = 28.2770,
        Type = "grocery",
        PositionNPC = {Coords = vec3(-1219.1686, -908.0490, 12.3263), Heading = 69.8820},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1221.9401, -908.2543, 12.3263)},
            },
            StoreShelves = {
                {Coords = vec3(-1225.6954, -908.8395, 12.3263)},
                {Coords = vec3(-1223.3198, -902.6970, 12.3264)},
                {Coords = vec3(-1220.8134, -905.5305, 12.3273)},
            },
            Safe = {
                {Coords = vec3(-1220.8815, -916.0198, 11.3263)},
            }
        }
    },
    [8] = {
        Coords = vec3(-1486.5773, -377.6134, 39.1634),
        Heading = 133.9365,
        Type = "grocery",
        PositionNPC = {Coords = vec3(-1487.0569, -375.3044, 40.1634), Heading = 183.2078},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1486.2628, -378.0324, 40.1634)},
            },
            StoreShelves = {
                {Coords = vec3(-1487.8079, -383.3281, 40.163)},
                {Coords = vec3(-1491.0120, -379.1680, 40.1634)},
                {Coords = vec3(-1489.3511, -377.6512, 40.1634)},
            },
            Safe = {
                {Coords = vec3(-1478.9280, -375.4777, 39.1643)},
            }
        }
    },
    [9] = {
        Coords = vec3(-1819.6190, 793.6205, 137.0868),
        Heading = 126.5348,
        Type = "grocery",
        PositionNPC = {Coords = vec3(-1823.3716, 799.4485, 138.0881), Heading = 182.4406},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1820.2823, 794.3092, 138.0892)},
                {Coords = vec3(-1818.9298, 792.8889, 138.0827)},
            },
            StoreShelves = {
                {Coords = vec3(-1829.2198, 791.9059, 138.2633)},
                {Coords = vec3(-1831.4636, 789.9865, 138.3203)},
            },
            Safe = {
                {Coords = vec3(-1829.1292, 798.7665, 138.1909)},
            }
        }
    },
    [10] = {
        Coords = vec3(-2966.3081, 391.5025, 14.0433),
        Heading = 85.0766,
        Type = "grocery",
        PositionNPC = {Coords = vec3(-2964.8132, 393.2999, 15.0433), Heading = 95.4954},
        Loots = {
            CashRegister = {
                {Coords = vec3(-2966.4355, 390.8570, 15.0433)},
            },
            StoreShelves = {
                {Coords = vec3(-2967.9546, 387.5809, 15.0433)},
                {Coords = vec3(-2971.3201, 387.8122, 15.0433)},
                {Coords = vec3(-2969.9133, 391.1988, 15.0433)},
            },
            Safe = {
                {Coords = vec3(-2959.5762, 387.1032, 14.0433)},
            }
        }
    },
    [11] = {
        Coords = vec3(-3040.5327, 584.4858, 6.9089),
        Heading = 23.4069,
        Type = "grocery",
        PositionNPC = {Coords = vec3(-3042.8982, 587.2454, 7.9089), Heading = 209.3006},
        Loots = {
            CashRegister = {
                {Coords = vec3(-3040.5261, 584.4749, 7.9089)},
                {Coords = vec3(-3038.4915, 585.1379, 7.9089)},
            },
            StoreShelves = {
                {Coords = vec3(-3041.9753, 593.2526, 7.9089)},
                {Coords = vec3(-3045.3809, 587.9263, 7.9089)},
            },
            Safe = {
                {Coords = vec3(-3048.7332, 588.4609, 7.9089)},
            }
        }
    },
    [12] = {
        Coords = vec3(-3242.7993, 1000.3360, 11.8306),  -- PNJ
        Heading = 356.1885,  -- Heading pour PNJ
        Type = "grocery",
        PositionNPC = {Coords = vec3(-3247.0166, 1002.8862, 11.8306), Heading = 254.6758},  -- NPC
        Loots = {
            CashRegister = {
                {Coords = vec3(-3241.6367, 1000.3409, 12.8306)},
                {Coords = vec3(-3243.8667, 1000.5403, 12.8306)},
            },
            StoreShelves = {
                {Coords = vec3(-3243.9666, 1003.8830, 12.8306)},
                {Coords = vec3(-3243.6616, 1007.6102, 12.8306)},
            },
            Safe = {
                {Coords = vec3(-3249.6997, 1007.3655, 12.8307)},
            },
        },
    },
    [13] = {
        Coords = vec3(548.7770, 2670.1721, 41.1565),
        Heading = 96.7714,
        Type = "grocery",
        PositionNPC = {Coords = vec3(547.3018, 2666.3081, 41.1564), Heading = 331.6939},
        Loots = {
            CashRegister = {
                {Coords = vec3(548.5749, 2671.8145, 42.1565)},
                {Coords = vec3(548.8575, 2669.6138, 42.1565)},
            },
            StoreShelves = {
                {Coords = vec3(545.1371, 2665.7107, 42.1564)},
                {Coords = vec3(545.6443, 2669.0762, 42.1564)},
            },
            Safe = {
                {Coords = vec3(543.7834, 2662.4958, 42.1565)},
            },
        },
    },
    [14] = {
        Coords = vec3(2677.5881, 3280.1194, 54.2411),
        Heading = 333.6042,
        Type = "grocery",
        PositionNPC = {Coords = vec3(2674.8804, 3284.0652, 54.2411), Heading = 224.4321},
        Loots = {
            CashRegister = {
                {Coords = vec3(2676.8755, 3280.4521, 55.2411)},
                {Coords = vec3(2678.8086, 3279.4714, 55.2411)},
            },
            StoreShelves = {
                {Coords = vec3(2676.1536, 3286.2629, 55.2411)},
                {Coords = vec3(2679.1824, 3285.5911, 55.2411)},
            },
            Safe = {
                {Coords = vec3(2674.3416, 3289.1582, 55.2411)},
            },
        },
    },
    [15] = {
        Coords = vec3(2556.6995, 381.2431, 107.6228),
        Heading = 354.4736,
        Type = "grocery",
        PositionNPC = {Coords = vec3(2552.3882, 383.5199, 107.6228), Heading = 266.2253},
        Loots = {
            CashRegister = {
                {Coords = vec3(2555.5625, 381.2931, 108.6228)},
                {Coords = vec3(2557.8730, 381.2215, 108.6228)},
            },
            StoreShelves = {
                {Coords = vec3(2557.0425, 390.0586, 108.6228)},
                {Coords = vec3(2555.3118, 388.3748, 108.6228)},
            },
            Safe = {
                {Coords = vec3(2549.4092, 387.8554, 108.6229)},
            },
        },
    },
    [16] = {
        Coords = vec3(1960.1652, 3740.5613, 31.3437),
        Heading = 303.2426,
        Type = "grocery",
        PositionNPC = {Coords = vec3(1961.7308, 3744.6411, 31.3437), Heading = 133.8907},
        Loots = {
            CashRegister = {
                {Coords = vec3(1960.8779, 3739.5344, 32.3437)},
                {Coords = vec3(1959.6030, 3741.7246, 32.3437)},
            },
            StoreShelves = {
                {Coords = vec3(1960.1510, 3745.8911, 32.3437)},
                {Coords = vec3(1964.2365, 3744.7085, 32.3437)},
            },
            Safe = {
                {Coords = vec3(1961.7479, 3750.3152, 32.3437)},
            },
        },
    },
    [17] = {
        Coords = vec3(1391.2244, 3605.8960, 33.9809),
        Heading = 199.3879,
        Type = "grocery",
        PositionNPC = {Coords = vec3(1389.7621, 3602.5100, 33.9809), Heading = 301.0382},
        Loots = {
            CashRegister = {
                {Coords = vec3(1392.8101, 3606.4634, 34.9809)},
            },
            StoreShelves = {
                {Coords = vec3(1398.4711, 3607.0078, 34.9809)},
                {Coords = vec3(1399.5986, 3603.9084, 34.9809)},
                {Coords = vec3(1395.8539, 3601.4614, 34.9809)},
            },
            Safe = {
                {Coords = vec3(1394.8778, 3613.8818, 34.9809)},
            },
        },
    },
    [18] = {
        Coords = vec3(1165.5031, 2710.7913, 37.1577),
        Heading = 184.2275,
        Type = "grocery",
        PositionNPC = {Coords = vec3(1163.6589, 2712.0732, 37.1577), Heading = 254.5768},
        Loots = {
            CashRegister = {
                {Coords = vec3(1165.8430, 2710.7715, 38.1577)},
            },
            StoreShelves = {
                {Coords = vec3(1169.3007, 2709.3533, 38.1577)},
                {Coords = vec3(1169.2887, 2706.3130, 38.1577)},
                {Coords = vec3(1165.8501, 2707.5168, 38.1577)},
            },
            Safe = {
                {Coords = vec3(1169.2770, 2717.6709, 37.1577)},
            },
        },
    },
    [19] = {
        Coords = vec3(1697.4778, 4923.2773, 41.0637),
        Heading = 330.2059,
        Type = "grocery",
        PositionNPC = {Coords = vec3(1700.5709, 4920.3350, 41.0637), Heading = 326.2580},
        Loots = {
            CashRegister = {
                {Coords = vec3(1698.1738, 4922.8882, 42.0637)},
                {Coords = vec3(1696.6083, 4923.8633, 42.0637)},
            },
            StoreShelves = {
                {Coords = vec3(1702.4635, 4927.3657, 42.0637)},
                {Coords = vec3(1706.2699, 4926.8809, 42.0637)},
            },
            Safe = {
                {Coords = vec3(1707.9438, 4920.3394, 42.0637)},
            },
        },
    },
    [20] = {
        Coords = vec3(1728.3634, 6415.5376, 34.0371),
        Heading = 247.4221,
        Type = "grocery",
        PositionNPC = {Coords = vec3(1732.4480, 6418.4165, 34.0371), Heading = 164.6240},
        Loots = {
            CashRegister = {
                {Coords = vec3(1728.9948, 6416.5796, 35.0371)},
                {Coords = vec3(1727.9935, 6414.4951, 35.0371)},
            },
            StoreShelves = {
                {Coords = vec3(1731.9709, 6415.2212, 35.0371)},
                {Coords = vec3(1736.2330, 6411.3433, 35.0371)},
            },
            Safe = {
                {Coords = vec3(1737.4471, 6419.4360, 35.0371)},
            },
        },
    },
    [21] = {
        Coords = vec3(161.1949, 6642.2153, 31.6989),
        Heading = 222.6243,
        Type = "grocery",
        PositionNPC = {Coords = vec3(165.9056, 6643.2017, 30.6989), Heading = 143.2755},
        Loots = {
            CashRegister = {
                {Coords = vec3(160.5134, 6640.9785, 31.6989)},
                {Coords = vec3(161.9918, 6642.4790, 31.6989)},
            },
            StoreShelves = {
                {Coords = vec3(164.3475, 6640.2261, 31.6989)},
                {Coords = vec3(166.1702, 6638.8618, 31.6989)},
            },
            Safe = {
                {Coords = vec3(170.9816, 6642.5732, 31.6989)},
            },
        },
    },
    [22] = {
        Coords = vec3(321.1440, 182.8927, 102.5880),
        Heading = 160.4510,
        Type = "tattoo",
        PositionNPC = {Coords = vec3(319.9798, 183.8451, 103.5881), Heading = 224.1519},
        Loots = {
            CashRegister = {
                {Coords = vec3(321.6819, 182.7090, 103.5880)},
            },
            StoreShelves = {
                {Coords = vec3(326.4576, 181.2272, 103.5881)},
                {Coords = vec3(327.2081, 182.8346, 103.5881)},
                {Coords = vec3(319.3783, 180.3884, 103.5881)},
            },
            Safe = {
                {Coords = vec3(321.5357, 186.0421, 103.5881)},
            },
        },
    },
    [23] = {
        Coords = vec3(-1151.3431, -1426.1758, 3.9560),
        Heading = 33.0352,
        Type = "tattoo",
        PositionNPC = {Coords = vec3(-1150.0896, -1425.3318, 3.9560), Heading = 89.6045},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1151.8774, -1426.4825, 4.9560)},
            },
            StoreShelves = {
                {Coords = vec3(-1152.3625, -1423.3766, 4.9560)},
                {Coords = vec3(-1153.9615, -1430.6842, 4.9560)},
                {Coords = vec3(-1154.9340, -1430.8134, 4.9560)},
            },
            Safe = {
                {Coords = vec3(-1149.0182, -1428.1716, 4.9559)},
            },
        },
    },
    [24] = {
        Coords = vec3(1325.5820, -1652.3605, 51.2772),
        Heading = 38.2306,
        Type = "tattoo",
        PositionNPC = {Coords = vec3(1326.7444, -1651.8000, 51.2772), Heading = 111.6176},
        Loots = {
            CashRegister = {
                {Coords = vec3(1324.9941, -1652.8414, 52.2772)},
            },
            StoreShelves = {
                {Coords = vec3(1324.2603, -1649.6656, 52.2765)},
                {Coords = vec3(1322.2094, -1657.2568, 52.2777)},
                {Coords = vec3(1323.4359, -1657.0017, 52.2778)},
            },
            Safe = {
                {Coords = vec3(1327.8792, -1654.1373, 52.2779)},
            },
        },
    },
    [25] = {
        Coords = vec3(-3172.5547, 1074.3748, 19.8307),
        Heading = 249.0204,
        Type = "tattoo",
        PositionNPC = {Coords = vec3(-3173.0557, 1073.4424, 19.8307), Heading = 328.5538},
        Loots = {
            CashRegister = {
                {Coords = vec3(-3172.2349, 1075.0115, 20.8307)},
            },
            StoreShelves = {
                {Coords = vec3(-3171.0798, 1073.0999, 20.8307)},
                {Coords = vec3(-3171.5840, 1080.3276, 20.8307)},
                {Coords = vec3(-3172.5408, 1079.8130, 20.8307)},
            },
            Safe = {
                {Coords = vec3(-3175.3965, 1075.0286, 20.8307)},
            },
        },
    },
    [26] = {
        Coords = vec3(1864.0327, 3750.9001, 32.0294),
        Heading = 118.0544,
        Type = "tattoo",
        PositionNPC = {Coords = vec3(1863.7815, 3752.1414, 32.0294), Heading = 192.7772},
        Loots = {
            CashRegister = {
                {Coords = vec3(1864.4384, 3750.1614, 33.0294)},
            },
            StoreShelves = {
                {Coords = vec3(1861.3467, 3750.2241, 33.0294)},
                {Coords = vec3(1867.9017, 3746.9431, 33.0294)},
                {Coords = vec3(1868.3345, 3747.8521, 33.0294)},
            },
            Safe = {
                {Coords = vec3(1865.2732, 3752.1707, 33.0294)},
            },
        },
    },
    [27] = {
        Coords = vec3(-292.8109, 6196.9746, 30.4892),
        Heading = 315.5670,
        Type = "tattoo",
        PositionNPC = {Coords = vec3(-292.0890, 6196.0415, 30.4893), Heading = 28.1497},
        Loots = {
            CashRegister = {
                {Coords = vec3(-293.3811, 6197.5112, 31.4890)},
            },
            StoreShelves = {
                {Coords = vec3(-297.7874, 6199.6831, 31.4881)},
                {Coords = vec3(-297.5760, 6198.4888, 31.4883)},
                {Coords = vec3(-290.6615, 6198.2207, 31.4847)},
            },
            Safe = {
                {Coords = vec3(-293.7715, 6195.4390, 31.4894)},
            },
        },
    },
    [28] = {
        Coords = vec3(-280.6210, 6228.1587, 30.6958),
        Heading = 60.0908,
        Type = "barber",
        PositionNPC = {Coords = vec3(-279.0234, 6231.3652, 30.6958), Heading = 127.7405},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-276.0319, 6223.0410, 30.6958), Head = 317.4162},
        Loots = {
            CashRegister = {
                {Coords = vec3(-280.0370, 6229.7231, 31.6958)},
            },
            StoreShelves = {
                {Coords = vec3(-278.4916, 6225.3179, 31.6958)},
                {Coords = vec3(-275.8087, 6227.8198, 31.6958)},
                {Coords = vec3(-273.5190, 6225.0635, 31.6958)},
            },
            Safe = {
                {Coords = vec3(-275.5131, 6223.5469, 31.6958)},
            },
        },
    },
    [29] = {
        Coords = vec3(-34.1237, -150.1963, 56.0768),
        Heading = 345.1536,
        Type = "barber",
        PositionNPC = {Coords = vec3(-30.9215, -151.2715, 56.0768), Heading = 73.4971},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-36.6564, -156.5667, 56.0768), Head = 250.0255},
        Loots = {
            CashRegister = {
                {Coords = vec3(-33.5677, -150.3603, 57.0768)},
            },
            StoreShelves = {
                {Coords = vec3(-32.7500, -156.0405, 57.0768)},
                {Coords = vec3(-36.3366, -154.9152, 57.0768)},
                {Coords = vec3(-33.6875, -158.0549, 57.0768)},
            },
            Safe = {
                {Coords = vec3(-36.1716, -156.7484, 57.0768)},
            },
        },
    },
    [30] = {
        Coords = vec3(1210.2161, -474.1236, 65.2082),
        Heading = 69.0529,
        Type = "barber",
        PositionNPC = {Coords = vec3(1211.1063, -470.8745, 65.2082), Heading = 167.1693},
        needPropSafe = true,
        PropCoord = {Coords = vec3(1217.0170, -476.0666, 65.2082), Head = 338.4523},
        Loots = {
            CashRegister = {
                {Coords = vec3(1210.4723, -473.1514, 66.2082)},
            },
            StoreShelves = {
                {Coords = vec3(1214.6588, -471.8799, 66.2082)},
                {Coords = vec3(1213.6328, -475.4785, 66.2082)},
                {Coords = vec3(1211.4493, -471.0129, 66.2082)},
            },
            Safe = {
                {Coords = vec3(1217.1388, -475.6154, 66.2082)},
            },
        },
    },
    [31] = {
        Coords = vec3(1933.8394, 3729.5759, 31.8446),
        Heading = 215.0646,
        Type = "barber",
        PositionNPC = {Coords = vec3(1931.3203, 3727.8242, 31.8446), Heading = 302.1824},
        needPropSafe = true,
        PropCoord = {Coords = vec3(1930.7227, 3735.6089, 31.8447), Head = 119.7061},
        Loots = {
            CashRegister = {
                {Coords = vec3(1933.1871, 3729.1626, 32.8446)},
            },
            StoreShelves = {
                {Coords = vec3(1929.4546, 3731.2529, 32.8447)},
                {Coords = vec3(1932.7227, 3733.0825, 32.8447)},
                {Coords = vec3(1927.8441, 3734.3411, 32.8447)},
            },
            Safe = {
                {Coords = vec3(1930.2054, 3735.2979, 32.8447)},
            },
        },
    },
    [32] = {
        Coords = vec3(-1284.4751, -1117.9504, 5.9903),
        Heading = 89.7722,
        Type = "barber",
        PositionNPC = {Coords = vec3(-1284.7719, -1115.6653, 5.9903), Heading = 182.6738},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-1277.7177, -1119.1670, 5.9903), Head = 1.4669},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1284.4751, -1117.9504, 6.9903)},
            },
            StoreShelves = {
                {Coords = vec3(-1280.8262, -1115.7653, 6.9903)},
                {Coords = vec3(-1279.1934, -1115.7653, 6.9903)},
                {Coords = vec3(-1279.1678, -1119.5070, 6.9903)},
            },
            Safe = {
                {Coords = vec3(-1277.7164, -1118.6621, 6.9903)},
            },
        },
    },
    [33] = {
        Coords = vec3(137.1266, -1710.4250, 28.2919),
        Heading = 140.4925,
        Type = "barber",
        PositionNPC = {Coords = vec3(134.5293, -1708.5262, 28.2919), Heading = 233.9485},
        needPropSafe = true,
        PropCoord = {Coords = vec3(141.8210, -1705.3605, 28.2919), Head = 51.0251},
        Loots = {
            CashRegister = {
                {Coords = vec3(135.5270, -1710.0277, 29.2919)},
            },
            StoreShelves = {
                {Coords = vec3(137.0944, -1705.6250, 29.2919)},
                {Coords = vec3(139.9219, -1708.0764, 29.2919)},
                {Coords = vec3(139.4674, -1703.0538, 29.2919)},
            },
            Safe = {
                {Coords = vec3(141.4531, -1705.0692, 29.2919)},
            },
        },
    },
    [34] = {
        Coords = vec3(-822.8153, -183.8018, 36.5689),
        Heading = 214.5277,
        Type = "barber",
        PositionNPC = {Coords = vec3(-818.0628, -187.8027, 36.5690), Heading = 62.7253},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-808.0796, -180.7415, 36.5689), Head = 122.1157},
        Loots = {
            CashRegister = {
                {Coords = vec3(-821.8990, -183.3677, 37.5689)},
            },
            StoreShelves = {
                {Coords = vec3(-815.2637, -188.8463, 37.5693)},
                {Coords = vec3(-817.2271, -183.1132, 37.5689)},
                {Coords = vec3(-813.6736, -181.0616, 37.5689)},
            },
            Safe = {
                {Coords = vec3(-808.4619, -180.9586, 37.5689)},
            },
        },
    },
    [35] = {
        Coords = vec3(1690.5708, 4818.2393, 41.0654),
        Heading = 22.0547,
        Type = "clothes",
        PositionNPC = {Coords = vec3(1696.1609, 4817.7241, 41.0654), Heading = 7.4756},
        needPropSafe = true,
        PropCoord = {Coords = vec3(1699.9515, 4817.8345, 41.0654), Head = 7.9436},
        Loots = {
            CashRegister = {
                {Coords = vec3(1691.4872, 4818.4321, 42.0654)},
                {Coords = vec3(1688.1191, 4817.8721, 42.0654)},
            },
            StoreShelves = {
                {Coords = vec3(1695.1542, 4823.5425, 42.0654)},
                {Coords = vec3(1691.9363, 4822.5542, 42.0654)},
            },
            Safe = {
                {Coords = vec3(1699.8618, 4818.3696, 42.0654)},
            },
        },
    },
    [36] = {
        Coords = vec3(-707.0109, -150.7064, 36.4152),
        Heading = 113.5667,
        Type = "clothes",
        PositionNPC = {Coords = vec3(-704.2300, -149.3202, 36.4152), Heading = 121.2800},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-700.1008, -156.7178, 36.4152), Head = 120.4481},
        Loots = {
            CashRegister = {
                {Coords = vec3(-706.6956, -151.4148, 37.4152)},
            },
            StoreShelves = {
                {Coords = vec3(-701.7155, -153.4830, 37.4152)},
                {Coords = vec3(-708.9336, -147.2208, 37.4152)},
                {Coords = vec3(-713.6429, -150.1151, 37.4153)},
            },
            Safe = {
                {Coords = vec3(-700.8337, -157.1216, 37.4152)},
            },
        },
    },
    [37] = {
        Coords = vec3(-1197.2803, -779.0845, 16.3300),
        Heading = 37.7976,
        Type = "clothes",
        PositionNPC = {Coords = vec3(-1192.9888, -777.7975, 17.3331), Heading = 64.9199},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-1185.4517, -771.8170, 16.3328), Head = 122.7225},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1196.7072, -778.5280, 17.3300)},
                {Coords = vec3(-1198.3511, -779.8661, 17.3301)},
            },
            StoreShelves = {
                {Coords = vec3(-1195.6140, -771.6614, 17.3212)},
                {Coords = vec3(-1191.2128, -772.2216, 17.3269)},
            },
            Safe = {
                {Coords = vec3(-1185.8529, -772.1126, 17.3328)},
            },
        },
    },
    [38] = {
        Coords = vec3(422.6203, -810.2946, 28.4934),
        Heading = 1.4897,
        Type = "clothes",
        PositionNPC = {Coords = vec3(426.7463, -811.5666, 28.4934), Heading = 351.8904},
        needPropSafe = true,
        PropCoord = {Coords = vec3(430.9560, -810.9932, 28.4934), Head = 92.6531},
        Loots = {
            CashRegister = {
                {Coords = vec3(422.6203, -810.2946, 29.4934)},
                {Coords = vec3(419.1819, -810.3596, 29.4934)},
            },
            StoreShelves = {
                {Coords = vec3(423.9141, -806.2397, 29.4934)},
                {Coords = vec3(419.6382, -802.6334, 29.4934)},
            },
            Safe = {
                {Coords = vec3(430.4836, -811.0027, 29.4934)},
            },
        },
    },
    [39] = {
        Coords = vec3(-166.8789, -301.8030, 38.7334),
        Heading = 256.0793,
        Type = "clothes",
        PositionNPC = {Coords = vec3(-169.6855, -299.8656, 38.7334), Heading = 254.3028},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-172.5223, -309.4064, 38.7334), Head = 248.4171},
        Loots = {
            CashRegister = {
                {Coords = vec3(-165.4451, -301.9565, 39.7334)},
            },
            StoreShelves = {
                {Coords = vec3(-162.8128, -300.1902, 39.7421)},
                {Coords = vec3(-163.0586, -307.4335, 39.7334)},
                {Coords = vec3(-156.0283, -296.1086, 39.7334)},
            },
            Safe = {
                {Coords = vec3(-171.8872, -309.6059, 39.7334)},
            },
        },
    },
    [40] = {
        Coords = vec3(78.2927, -1388.8601, 28.3785),
        Heading = 173.8787,
        Type = "clothes",
        PositionNPC = {Coords = vec3(74.6144, -1387.5201, 28.3785), Heading = 181.1916},
        needPropSafe = true,
        PropCoord = {Coords = vec3(69.9730, -1388.3140, 28.3785), Head = 264.9172},
        Loots = {
            CashRegister = {
                {Coords = vec3(78.2927, -1388.8601, 29.3785)},
                {Coords = vec3(81.8173, -1388.8046, 29.3785)},
            },
            StoreShelves = {
                {Coords = vec3(76.9889, -1392.9091, 29.3785)},
                {Coords = vec3(74.1470, -1393.5348, 29.3785)},
            },
            Safe = {
                {Coords = vec3(70.9229, -1388.2784, 29.3785)},
            },
        },
    },
    [41] = {
        Coords = vec3(-817.3712, -1074.0706, 10.3304),
        Heading = 116.8383,
        Type = "clothes",
        PositionNPC = {Coords = vec3(-818.3496, -1070.0403, 10.3304), Heading = 121.9065},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-823.4243, -1068.8976, 10.3304), Head = 208.6512},
        Loots = {
            CashRegister = {
                {Coords = vec3(-817.3712, -1074.0706, 11.3304)},
                {Coords = vec3(-815.8887, -1076.7799, 11.3304)},
            },
            StoreShelves = {
                {Coords = vec3(-823.6906, -1072.8792, 11.3304)},
                {Coords = vec3(-822.3464, -1080.3805, 11.3304)},
            },
            Safe = {
                {Coords = vec3(-823.1448, -1069.3954, 11.3304)},
            },
        },
    },
    [42] = {
        Coords = vec3(-1447.7632, -240.0329, 48.8177),
        Heading = 54.2757,
        Type = "clothes",
        PositionNPC = {Coords = vec3(-1445.7943, -242.3543, 48.8236), Heading = 37.1600},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-1450.9374, -247.9467, 48.8235), Head = 47.2494},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1448.8949, -239.0876, 49.8149)},
            },
            StoreShelves = {
                {Coords = vec3(-1459.9935, -238.5754, 49.7979)},
                {Coords = vec3(-1456.0907, -244.0058, 49.8133)},
                {Coords = vec3(-1448.8436, -233.0854, 49.8070)},
            },
            Safe = {
                {Coords = vec3(-1451.2439, -247.6678, 49.8226)},
            },
        },
    },
    [43] = {
        Coords = vec3(-0.0336, 6511.7837, 30.8801),
        Heading = 302.7176,
        Type = "clothes",
        PositionNPC = {Coords = vec3(1.7139, 6507.9995, 30.8801), Heading = 305.4110},
        needPropSafe = true,
        PropCoord = {Coords = vec3(4.8137, 6505.3027, 30.8801), Head = 41.7393},
        Loots = {
            CashRegister = {
                {Coords = vec3(-2.4625, 6514.2437, 31.8801)},
                {Coords = vec3(-0.0336, 6511.7837, 31.8801)},
            },
            StoreShelves = {
                {Coords = vec3(6.0753, 6511.9165, 31.8801)},
                {Coords = vec3(3.2955, 6519.1528, 31.8801)},
            },
            Safe = {
                {Coords = vec3(4.6005, 6505.5386, 31.8801)},
            },
        },
    },
    [44] = {
        Coords = vec3(621.2971, 2753.9634, 41.0883),
        Heading = 96.1974,
        Type = "clothes",
        PositionNPC = {Coords = vec3(622.5836, 2755.4919, 41.0883), Heading = 94.9445},
        needPropSafe = true,
        PropCoord = {Coords = vec3(621.6296, 2766.9680, 41.0883), Head = 178.2921},
        Loots = {
            CashRegister = {
                {Coords = vec3(621.2971, 2753.9634, 42.0883)},
                {Coords = vec3(621.4205, 2752.0000, 42.0883)},
            },
            StoreShelves = {
                {Coords = vec3(616.0023, 2758.6775, 42.0883)},
                {Coords = vec3(619.2055, 2760.4543, 41.0882)},
            },
            Safe = {
                {Coords = vec3(621.6556, 2766.5823, 42.0883)},
            },
        },
    },
    [45] = {
        Coords = vec3(1200.6716, 2707.1716, 37.2249),
        Heading = 83.3538,
        Type = "clothes",
        PositionNPC = {Coords = vec3(1202.0228, 2711.1902, 37.2249), Heading = 96.0444},
        needPropSafe = true,
        PropCoord = {Coords = vec3(1201.6979, 2715.4915, 37.2249), Head = 166.7156},
        Loots = {
            CashRegister = {
                {Coords = vec3(1200.6716, 2707.1716, 38.2249)},
                {Coords = vec3(1200.7845, 2703.9658, 38.2249)},
            },
            StoreShelves = {
                {Coords = vec3(1196.0549, 2711.5032, 38.2249)},
                {Coords = vec3(1193.1987, 2704.2827, 38.2249)},
            },
            Safe = {
                {Coords = vec3(1201.7181, 2714.9922, 38.2249)},
            },
        },
    },
    [46] = {
        Coords = vec3(-3172.8057, 1055.1606, 19.8633),
        Heading = 233.9579,
        Type = "clothes",
        PositionNPC = {Coords = vec3(-3174.5852, 1053.8523, 19.8633), Heading = 239.1633},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-3179.1765, 1043.2261, 19.8633), Head = 338.5793},
        Loots = {
            CashRegister = {
                {Coords = vec3(-3172.8057, 1055.1606, 20.8633)},
                {Coords = vec3(-3171.8662, 1056.7136, 20.8633)},
            },
            StoreShelves = {
                {Coords = vec3(-3170.3198, 1047.9556, 20.8633)},
                {Coords = vec3(-3173.8779, 1048.1677, 20.8633)},
            },
            Safe = {
                {Coords = vec3(-3179.0220, 1043.6172, 20.8633)},
            },
        },
    },
    [47] = {
        Coords = vec3(-1096.4338, 2711.1079, 18.1101),
        Heading = 131.1612,
        Type = "clothes",
        PositionNPC = {Coords = vec3(-1098.1492, 2714.7969, 18.1101), Heading = 127.0785},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-1101.3844, 2717.6130, 18.1101), Head = 222.4702},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1096.4338, 2711.1079, 19.1101)},
                {Coords = vec3(-1094.1898, 2708.6077, 19.1101)},
            },
            StoreShelves = {
                {Coords = vec3(-1102.6888, 2711.1033, 19.1101)},
                {Coords = vec3(-1100.3464, 2709.3354, 19.1101)},
            },
            Safe = {
                {Coords = vec3(-1101.0510, 2717.2761, 19.1101)},
            },
        },
    },
    [48] = {
        Coords = vec3(-1127.2893, -1439.4509, 4.2283),
        Heading = 305.9734,
        Type = "clothes",
        PositionNPC = {Coords = vec3(-1126.4794, -1441.9156, 4.2283), Heading = 297.3907},
        needPropSafe = true,
        PropCoord = {Coords = vec3(-1127.5951, -1446.2018, 4.2283), Head = 18.4140},
        Loots = {
            CashRegister = {
                {Coords = vec3(-1127.2893, -1439.4509, 5.2283)},
            },
            StoreShelves = {
                {Coords = vec3(-1119.8988, -1441.2977, 5.2283)},
                {Coords = vec3(-1123.8229, -1436.9863, 5.2283)},
                {Coords = vec3(-1125.0948, -1443.8840, 5.2283)},
            },
            Safe = {
                {Coords = vec3(-1127.7604, -1445.7323, 5.2283)},
            },
        },
    },
    [49] = {
        Coords = vec3(123.1718, -212.1649, 53.5577),
        Heading = 250.4458,
        Type = "clothes",
        PositionNPC = {Coords = vec3(120.9922, -214.1375, 53.5576), Heading = 248.8543},
        needPropSafe = true,
        PropCoord = {Coords = vec3(117.4124, -224.5840, 53.5576), Head = 338.9098},
        Loots = {
            CashRegister = {
                {Coords = vec3(122.9403, -212.8138, 54.5576)},
                {Coords = vec3(123.6737, -210.8025, 54.5577)},
            },
            StoreShelves = {
                {Coords = vec3(123.5886, -215.7043, 54.5576)},
                {Coords = vec3(122.4295, -219.6643, 54.5576)},
            },
            Safe = {
                {Coords = vec3(117.5649, -224.1866, 54.5576)},
            },
        },
    },
}

