Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 25
Config.MarkerSize                 = { x = 1.25, y = 1.25, z = 1.25 }
Config.MarkerColor                = { r = 0, g = 0, b = 255 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableJobLogs              = false -- only turn this on if you are using esx_joblogs
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

    Politie = {

        Blip = {
            Pos     = { x = 425.130, y = -979.558, z = 30.711 },
            Sprite  = 60,
            Display = 4,
            Scale   = 1.2,
            Colour  = 45,
        },

        --https://wiki.rage.mp/index.php?title=Weapons
        AuthorizedWeapons = {
            { name = 'WEAPON_NIGHTSTICK', price = 200, ammo = 1, label = "Wapenstok" },
            { name = 'WEAPON_FLASHLIGHT', price = 80, ammo = 1, label = "Zaklamp" },
            { name = 'WEAPON_STUNGUN', price = 500, ammo = 30, label = "Taser" },
            { name = 'WEAPON_FIREEXTINGUISHER', price = 120, ammo = 4500, label = "Brandblusser" },
            { name = 'WEAPON_BZGAS', price = 500, ammo = 5, label = "BZ GAS /ME/DSI/AT" },
            { name = 'niks', price = 120, ammo = 0, label = "===============================" },
            { name = 'WEAPON_PISTOL', price = 300, ammo = 50, label = "Walther P99Q"},
            { name = 'WEAPON_COMBATPISTOL', price = 300, ammo = 50, label = "Glock 17 (DSI/AT)"},
            { name = 'WEAPON_SMG', price = 1250, ammo = 120, label = "MP5 (DSI/AT)" },
            { name = 'WEAPON_MICROSMG', price = 1250, ammo = 120, label = "MP7 (DSI/AT)" },
            { name = 'WEAPON_CARBINERIFLE', price = 1250, ammo = 120, label = "HK416 (DSI/AT)" },
        },

        Cloakrooms = {
            { x = 471.13, y = -988.38, z = 25.73 },
        },

        Armories = {
            { x = 484.99, y = -1006.33, z = 25.73, h = 0.0 },
        },

        Vehicles = {
            {
                Spawner    = { x = 463.35, y = -990.92, z = 25.79 },
                SpawnPoints = {
                    { x = 447.46, y = -986.95, z = 25.73, heading = 180.0, radius = 6.0 },
                }
            },
        },

        Helicopters = {
            {
                Spawner    = { x = 460.76, y = -983.95, z = 43.69 },
                SpawnPoint = { x = 449.44, y = -981.16, z = 43.69 },
                Heading    = 90.0
            }
        },

        VehicleDeleters = {
            { x = 459.81, y = -984.71, z = 25.73 },
            { x = 459.84, y = -978.49, z = 25.73 }
        },

        BossActions = {
            { x = 472.18, y = -1006.04, z = 30.7 }
        },

    },

    
    PolitieS = {
        Blip = {
            Pos     = { x = 1853.28, y = 3686.34, z = 33.26 },
            Sprite  = 60,
            Display = 4,
            Scale   = 1.2,
            Colour  = 45,
        },

        AuthorizedWeapons = {
            { name = 'WEAPON_NIGHTSTICK', price = 200, ammo = 1, label = "Wapenstok" },
            { name = 'WEAPON_FLASHLIGHT', price = 80, ammo = 1, label = "Zaklamp" },
            { name = 'WEAPON_STUNGUN', price = 500, ammo = 30, label = "Taser" },
            { name = 'WEAPON_FIREEXTINGUISHER', price = 120, ammo = 4500, label = "Brandblusser" },
            { name = 'niks', price = 120, ammo = 0, label = "===============================" },
            { name = 'WEAPON_COMBATPISTOL', price = 300, ammo = 60, label = "Glock-17 (KMAR)"},
            { name = 'WEAPON_SMG', price = 1250, ammo = 120, label = "MP5 (KMAR)" },
            { name = 'WEAPON_PUMPSHOTGUN', price = 300, ammo = 60, label = "Beanbag (KMAR)"},
            { name = 'WEAPON_SPECIALCARBINE_MK2', price = 1250, ammo = 60, label = "Special Carbine (BSB)" },
        },

        Cloakrooms = {
            { x = 1849.65, y = 3695.36, z = 34.26 },
        },

        Armories = {
            { x = 1852.8, y = 3696.79, z = 34.26 },
        },

        Vehicles = {
            {
                Spawner    = { x = 1865.94, y = 3688.46, z = 34.27 },
                SpawnPoints = {
                    { x = 1868.88, y = 3695.69, z = 33.57, heading = 210.44, radius = 6.0 },
                }
            }
        },

        Helicopters = {},

        VehicleDeleters = {
            { x = 1858.27, y = 3712.21, z = 33.29 }
        },

        BossActions = {
            { x = 1861.43, y = 3690.39, z = 34.26 }
        },

    }
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
    Shared = {
        -- {
            -- model = 'kmar2',
            -- label = 'Eerste Kmar Voertuig'
        -- },
        -- {
            -- model = 'kmar3',
            -- label = 'Tweede Kmar Voertuig'
        -- },
        -- {
            -- model = 'kmar3',
            -- label = 'Derde Kmar Voertuig'
        -- },
        -- {
            -- model = 'kmarmotor',
            -- label = 'Kmar Motor'
        -- },
    },

    aspirant = {
        {
            model = 'polfiets',
            label = 'Politie Fiets'
        }
    },

    surveillant = {
        {
            model = 'polmerc',
            label = 'Mercedes B-Klasse'
        },
        {
            model = 'poltouran2016',
            label = 'VW Touran 2016'
        },
        {
            model = 'polfiets',
            label = 'Politie Fiets'
        },
    },

    agent = {
        {
            model = 'polmerc',
            label = 'Mercedes B-Klasse'
        },
        {
            model = 'poltouran2016',
            label = 'VW Touran 2016'
        },
        {
            model = 'polaudi',
            label = 'Politie Audi A6'
        },
        {
            model = 'polvito2016',
            label = 'Mercedes Vito 2016'
        },
        {
            model = 'polmotor',
            label = 'Politie Zware motor'
        },
        {
            model = 'polmotor3',
            label = 'Politie Medium motor'
        },
        {
            model = 'polmotor2',
            label = 'Politie Lichte Motor'
        },
        {
            model = 'polfiets',
            label = 'Politie Fiets'
        },
        {
            model = 'polskoda',
            label = 'Politie Skoda (UNMARKED)'
        },

    },

    hoofdagent = {
        {
            model = 'polmerc',
            label = 'Mercedes B-Klasse'
        },
        {
            model = 'poltouran2016',
            label = 'VW Touran 2016'
        },
        {
            model = 'polaudi',
            label = 'Politie Audi A6'
        },
        {
            model = 'poltransporter6',
            label = 'Politie Transporter T6'
        },
        {
            model = 'polvito2016',
            label = 'Mercedes Vito 2016'
        },
        {
            model = 'polmotor',
            label = 'Politie Zware motor'
        },
        {
            model = 'polmotor3',
            label = 'Politie Medium motor'
        },
        {
            model = 'polmotor2',
            label = 'Politie Lichte Motor'
        },
        {
            model = 'polfiets',
            label = 'Politie Fiets'
        },
        {
            model = 'polaudiq7',
            label = 'Politie Audi Q7 (UNMARKED)'
        },
        {
            model = 'polskoda',
            label = 'Politie Skoda (UNMARKED)'
        },

    },

    brigadier = {
        {
            model = 'polmerc',
            label = 'Mercedes B-Klasse'
        },
        {
            model = 'poltouran2016',
            label = 'VW Touran 2016'
        },
        {
            model = 'polaudi',
            label = 'Politie Audi A6'
        },
        {
            model = 'poltransporter6',
            label = 'Politie Transporter T6'
        },
        {
            model = 'polvito2016',
            label = 'Mercedes Vito 2016'
        },
        {
            model = 'polmotor',
            label = 'Politie Zware motor'
        },
        {
            model = 'polmotor3',
            label = 'Politie Medium motor'
        },
        {
            model = 'polmotor2',
            label = 'Politie Lichte Motor'
        },
        {
            model = 'polfiets',
            label = 'Politie Fiets'
        },
        {
            model = 'polaudiq7',
            label = 'Politie Audi Q7 (UNMARKED)'
        },
        {
            model = 'polskoda',
            label = 'Politie Skoda (UNMARKED)'
        },

    },

    inspecteur = {
        {
            model = 'polmerc',
            label = 'Mercedes B-Klasse'
        },
        {
            model = 'poltouran2016',
            label = 'VW Touran 2016'
        },
        {
            model = 'polaudi',
            label = 'Politie Audi A6'
        },
        {
            model = 'poltransporter6',
            label = 'Politie Transporter T6'
        },
        {
            model = 'polvito2016',
            label = 'Mercedes Vito 2016'
        },
        {
            model = 'polmotor',
            label = 'Politie Zware motor'
        },
        {
            model = 'polmotor3',
            label = 'Politie Medium motor'
        },
        {
            model = 'polmotor2',
            label = 'Politie Lichte Motor'
        },
        {
            model = 'polfiets',
            label = 'Politie Fiets'
        },
        {
            model = 'polaudiat',
            label = 'Audi RS6 (AT/DSI UNMARKED)'
        },
        {
            model = 'bearcat',
            label = 'Politie Bearcat (AT/DSI UNMARKED)'
        },
        {
            model = 'polaudiq7',
            label = 'Politie Audi Q7 (UNMARKED)'
        },
        {
            model = 'polskoda',
            label = 'Politie Skoda (UNMARKED)'
        },

    },

    hoofdinspecteur = {
        {
            model = 'polmerc',
            label = 'Mercedes B-Klasse'
        },
        {
            model = 'poltouran2016',
            label = 'VW Touran 2016'
        },
        {
            model = 'polaudi',
            label = 'Politie Audi A6'
        },
        {
            model = 'poltransporter6',
            label = 'Politie Transporter T6'
        },
        {
            model = 'polvito2016',
            label = 'Mercedes Vito 2016'
        },
        {
            model = 'polmotor',
            label = 'Politie Zware motor'
        },
        {
            model = 'polmotor3',
            label = 'Politie Medium motor'
        },
        {
            model = 'polmotor2',
            label = 'Politie Lichte Motor'
        },
        {
            model = 'polfiets',
            label = 'Politie Fiets'
        },
        {
            model = 'polaudiat',
            label = 'Audi RS6 (AT/DSI UNMARKED)'
        },
        {
            model = 'bearcat',
            label = 'Politie Bearcat (AT/DSI UNMARKED)'
        },
        {
            model = 'polaudiq7',
            label = 'Politie Audi Q7 (UNMARKED)'
        },
        {
            model = 'polskoda',
            label = 'Politie Skoda (UNMARKED)'
        },

    },
    
    boss = {
        {
            model = 'polmerc',
            label = 'Mercedes B-Klasse'
        },
        {
            model = 'poltouran2009',
            label = 'VW Touran'
        },
        {
            model = 'poltouran2016',
            label = 'VW Touran 2016'
        },
        {
            model = 'polaudi',
            label = 'Politie Audi A6'
        },
        {
            model = 'poltransporter6',
            label = 'Politie Transporter T6'
        },
        {
            model = 'polvito2016',
            label = 'Mercedes Vito 2016'
        },
        {
            model = 'polmotor',
            label = 'Politie Zware motor'
        },
        {
            model = 'polmotor3',
            label = 'Politie Medium motor'
        },
        {
            model = 'polmotor2',
            label = 'Politie Lichte Motor'
        },
        {
            model = 'polfiets',
            label = 'Politie Fiets'
        },
        {
            model = 'polaudiat',
            label = 'Audi RS6 (AT/DSI UNMARKED)'
        },
        {
            model = 'bearcat',
            label = 'Politie Bearcat (AT/DSI UNMARKED)'
        },
        {
            model = 'polaudiq7',
            label = 'Politie Audi Q7 (UNMARKED)'
        },
        {
            model = 'polskoda',
            label = 'Politie Skoda (UNMARKED)'
        },
    },
    
    kmar1 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar2 = {
       {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar3 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar4 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar5 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar6 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar7 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar8 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar9 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar10 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar11 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar12 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar13 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar14 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
    
    kmar15 = {
        {
            model = 'kmar3',
            label = 'KMAR Opel Astra'
        },
        {
            model = 'kmar2',
            label = 'KMAR Amarok'
        },
        {
            model = 'kmarmotor',
            label = 'KMAR BMW R1200RT'
        },
        {
            model = 'kmar5',
            label = 'KMAR Mercedes Vito'
        },
        {
            model = 'polaudiq7',
            label = 'KMAR Audi Q7'
        },
        {
            model = 'kmarmerc',
            label = 'KMAR Mercedes G-Klasse'
        },
        {
            model = 'kmaraudi',
            label = 'KMAR Audi A6'
        },
    },
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    kortnh_wear = { -- Korte mauwen noodhulp
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 2,
			['mask_1'] = 121,   ['mask_2'] = 0,
			['helmet_1'] = 10,  ['helmet_2'] = 0,
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['arms'] = 46,
			['pants_1'] = 61,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 2,
			['mask_1'] = 121,   ['mask_2'] = 0
		}
    },
    unmarked_wear = { -- Lange mauwen noodhulp
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 139,   ['torso_2'] = 3,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 121,   ['mask_2'] = 0,
			['helmet_1'] = 10,  ['helmet_2'] = 0,
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
    },
    langnh_wear = { -- Lange mauwen noodhulp
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 1,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 2,
			['mask_1'] = 121,   ['mask_2'] = 0,
			['helmet_1'] = 10,  ['helmet_2'] = 0,
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 89,   ['torso_2'] = 0,
			['arms'] = 46,
			['pants_1'] = 61,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 2,
			['mask_1'] = 121,   ['mask_2'] = 0
		}
    },
    bullet_wear = { -- Kogelwerend vest
        male = {
			['bproof_1'] = 11,  ['bproof_2'] = 2
		},
		female = {
			['ears_1'] = 2,     ['ears_2'] = 0
		}
    },
    bullet1_wear = { -- Kogelwerend vest
        male = {
			['bproof_1'] = 11,  ['bproof_2'] = 2,
		},
		female = {
			['ears_1'] = 2,     ['ears_2'] = 0
		}
    },
    bullet2_wear = { -- Kogelwerend vest
        male = {
			['bproof_1'] = 11,  ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 11,  ['bproof_2'] = 1,
		}
    },
    pet_wear = {
        male = {
			['helmet_1'] = 10,  ['helmet_2'] = 0
		},
		female = {
			['helmet_1'] = 10,  ['helmet_2'] = 0
		}
    },
    ovdp_vest = {
        male = {
			['bproof_1'] = 11,  ['bproof_2'] = 4,
		},
		female = {
			['bproof_1'] = 11,  ['bproof_2'] = 4,
		}
    },
    no_vest = {
        male = {
			['bproof_1'] = 0,  ['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 0,  ['bproof_2'] = 0,
		}
    },
    verkeerkort_wear = { -- Verkeer korte mauwen
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 3,
			['mask_1'] = 121,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['arms'] = 46,
			['pants_1'] = 61,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 1,
			['mask_1'] = 121,   ['mask_2'] = 0
		}
    },
    verkeerlang_wear = { -- Verkeer lange mauwen
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 1,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 3,
			['mask_1'] = 121,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 89,   ['torso_2'] = 0,
			['arms'] = 46,
			['pants_1'] = 61,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 3,
			['mask_1'] = 121,   ['mask_2'] = 0
		}
    },
    ovdpkort_wear = { -- OvD-P / OPCO Kort -- Deze is voor hogere rank!
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 4,
			['mask_1'] = 121,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
    },
    ovdplang_wear = { -- OvD-P / OPCO Lang -- Deze is voor hogere rank!
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 1,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 4,
			['mask_1'] = 121,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
    },
    motor_wear = { -- Motor
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 61,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = -11,  ['bproof_2'] = 3,
			['mask_1'] = 121,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
    },
    dsi_wear = { -- TPE outfit
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 53,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 44,
			['pants_1'] = 31,  ['pants_2'] = 0,
			['shoes_1'] = 24,  ['shoes_2'] = 0,
            ['bproof_1'] = 3,  ['bproof_2'] = 0,
            ['chain_1'] = 1,  ['chain_2'] = 0,
			['mask_1'] = 55,  ['mask_2'] = 0,
            ['helmet_1'] = 117,  ['helmet_2'] = 0,
        },
        female = {
            ['tshirt_1'] = 2,  ['tshirt_2'] = 0,
            ['torso_1'] = 136,   ['torso_2'] = 3,
            ['arms'] = 0,
            ['pants_1'] = 61,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 116,  ['helmet_2'] = 0,
            ['glasses_1'] = 5,  ['glasses_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['bproof_1'] = 18,  ['bproof_2'] = 2,
            ['mask_1'] = 57,   ['mask_2'] = 0
        }
    },
    at_vest = { -- TPE outfit
        male = {
            ['bproof_1'] = 21,  ['bproof_2'] = 3,
        },
        female = {
            ['bproof_1'] = 21,  ['bproof_2'] = 3,
        }
    },
    dsi_vest = { -- TPE outfit
        male = {
			['bproof_1'] = 7,  ['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 31,  ['bproof_2'] = 1,
		}
    },
    tpe_wear = { -- KMAR outfit
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['bproof_1'] = 11,  ['bproof_2'] = 1,
			['chain_1'] = 1,  ['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] =2,
			['arms'] = 20,
			['pants_1'] = 52,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['glasses_1'] = 5,  ['glasses_2'] = 4,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 1,
			['mask_1'] = 4,   ['mask_2'] = 0
		}
    },
    tpe_vest = { -- KMAR outfit
        male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1,
		},
		female = {
			['bproof_1'] = 11,  ['bproof_2'] = 1,
		}
    },
    cuffs = {
        male = {
            ['chain_1'] = 41,  ['chain_2'] = 0,
        },
        female = {
            ['chain_1'] = 41,  ['chain_2'] = 0,
        }
    },
    no_cuffs = {
        male = {
            ['chain_1'] = 0,  ['chain_2'] = 0,
        },
        female = {
            ['chain_1'] = 0,  ['chain_2'] = 0,
        }
    },
    kmarlang_wear = { -- Lange mauwen noodhulp
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 17,
			['pants_1'] = 52,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 48,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 1,
			['mask_1'] = 121,   ['mask_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 17,
			['pants_1'] = 52,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 48,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 1,
			['mask_1'] = 121,   ['mask_2'] = 0,
		}
    },
    kmarkort_wear = { -- Lange mauwen noodhulp
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 52,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 48,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 1,
			['mask_1'] = 121,   ['mask_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 17,
			['pants_1'] = 52,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 48,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 11,  ['bproof_2'] = 1,
			['mask_1'] = 121,   ['mask_2'] = 0,
		}
    },
    kmarmotor_wear = { -- Lange mauwen noodhulp
        male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 61,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 1,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 121,   ['mask_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 61,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 1,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 121,   ['mask_2'] = 0,
		}
    },
    bsb_wear = {
        male = {
            ['tshirt_1'] = 53, ['tshirt_2'] = 0,
            ['torso_1'] = 53,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 9,   ['pants_2'] = 7,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 119,  ['helmet_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
            ['ears_1'] = -0,     ['ears_2'] = 0,
            ['bproof_1'] = 10,  ['bproof_2'] = 1,
            ['mask_1'] = 52,   ['mask_2'] = 0, 
        },      
        female = {
            ['sex'] = 0,
            ['tshirt_1'] = 41,  ['tshirt_2'] = 1,
            ['torso_1'] = 53,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 4,
            ['pants_1'] = 9,   ['pants_2'] = 7,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 119,  ['helmet_2'] = 0,
            ['chain_1'] = 6,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['bproof_1'] = 12,  ['bproof_2'] = 0,
            ['mask_1'] = 52,   ['mask_2'] = 0,
        }
    },
    hrb_wear = {
        male = {
            ['tshirt_1'] = 53, ['tshirt_2'] = 0,
            ['torso_1'] = 53,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 9,   ['pants_2'] = 7,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -48,  ['helmet_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bproof_1'] = 16,  ['bproof_2'] = 2,
            ['mask_1'] = 0,   ['mask_2'] = 0,        },
        female = {
            ['sex'] = 0,
            ['tshirt_1'] = 41, ['tshirt_2'] = 1,
			['torso_1'] = 53,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 9,   ['pants_2'] = 7,
			['shoes_1'] = 71,   ['shoes_2'] = 1,
			['helmet_1'] = -28,  ['helmet_2'] = 0,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = -0,     ['ears_2'] = 0,
			['bproof_1'] = 21,  ['bproof_2'] = 1,
			['mask_1'] = 0,   ['mask_2'] = 0,
        }
    }
}