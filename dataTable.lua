if AZP == nil then AZP = {} end
if AZP.ZoneQuests == nil then AZP.ZoneQuests = {} end

AZP.ZoneQuests.Textures =
{
    PlusButton = GetFileIDFromPath("Interface\\BUTTONS\\UI-PlusButton-Up.blp"),
    MinusButton = GetFileIDFromPath("Interface\\BUTTONS\\UI-MinusButton-Up.blp"),
}

AZP.ZoneQuests.Quests =
{
    ZerethMortis =
    {
        QLNames = {"Into the Unknown", "We Battle Onward", "Forming an Understanding", "Forging a New Path", "Crown of Wills", "A Means To An End", "Starting Over", "Epilogue; Judgement", "Other Quests"},
        IDs =
        {
            [        "Into the Unknown"] = {64942, 64944, 64945, 65456, 64947, 64949, 64950, 64951, 65271, 64952, 64953, 64957, 64958},
            [        "We Battle Onward"] = {64794, 64796, 64797, 64814, 64815, 64817, 64818, 64820, 64821, 64822, 64823, 64824, 64825},
            ["Forming an Understanding"] = {64218, 64219, 64223, 64224, 64225, 64226, 64227, 64228, 65149, 64230, 65305},
            [      "Forging a New Path"] = {65335, 64830, 64833, 64832, 64831, 64837, 64834, 64838, 64969, 64835, 64836, 64839, 64841, 64840, 65331}, -- {64799, 64800, 64802, 64801, 64804, 64803, 64805, 64853},
            [          "Crown of Wills"] = {64809, 64811, 64810, 64806, 64807, 64808, 64798, 64812, 64813},
            [       "A Means To An End"] = {64875, 64876, 64878, 64888, 65245, 64936, 64937, 65237},
            [           "Starting Over"] = {65328, 64879, 64723, 64733, 64718, 64720, 64706, 64722, 64727, 64726, 64725, 64962, 64728, 64730, 64731, 64729, 65238},
            [     "Epilogue; Judgement"] = {65329},
            [            "Other Quests"] = {64960},
        },

        [00000] = {Name = "Coming Soon™"},

        [64942] = {Name = "Call of the Primus"},
        [64944] = {Name = "A Hasty Voyage"},
        [64945] = {Name = "Strangers in a Strange Land"},
        [65456] = {Name = "A Lot to Pack"},
        [64947] = {Name = "Give Me A Hand"},
        [64949] = {Name = "For Research Purposes"},
        [64950] = {Name = "A Mutual Exchange"},
        [64951] = {Name = "The Road to Haven"},
        [65271] = {Name = "Forging Connections"},
        [64952] = {Name = "Destroying the Destructors"},
        [64953] = {Name = "Defending Haven"},
        [64957] = {Name = "This Old Waystone"},
        [64958] = {Name = "The Forces Gather"},

        [64794] = {Name = "Knowing is Half the Battle"},
        [64796] = {Name = "Scour the Sands"},
        [64797] = {Name = "Harmony and Discord"},
        [64815] = {Name = "Together, We Ride"},
        [64814] = {Name = "Battle for the Forge"},
        [64817] = {Name = "In Plains Sight"},
        [64818] = {Name = "Reinforcements May Be Necessary"},
        [64820] = {Name = "This is Your Fault, Fix It"},
        [64821] = {Name = "Nothing is True"},
        [64822] = {Name = "A Break in Communication"},
        [64823] = {Name = "Doppelganger Duel"},
        [64824] = {Name = "Fighting for the Forge"},
        [64825] = {Name = "Seeking Haven"},

        [64218] = {Name = "Danger Near And Far"},
        [64219] = {Name = "A Mysterious Voice"},
        [64223] = {Name = "Core of the Matter"},
        [64224] = {Name = "Seeking the Unknown"},
        [64225] = {Name = "Finding Firim"},
        [64226] = {Name = "Security Measures"},
        [64227] = {Name = "Unseen Agents"},
        [64228] = {Name = "Now You May Speak"},
        [65149] = {Name = "Surveying Cyphers"},
        [64230] = {Name = "Cyphers of the First Ones"},
        [65305] = {Name = "The Way Forward"},

        [65335] = {Name = "News from Oribos"},
        [64830] = {Name = "Enlisting the Englightened"},
        [64833] = {Name = "Forging Unity from Diversity"},
        [64832] = {Name = "Reclaiming Provis Esper"},
        [64831] = {Name = "Fragments of the First Ones"},
        [64837] = {Name = "The Pilgrim's Journey"},
        [64834] = {Name = "Glow and Behold"},
        [64838] = {Name = "Where There's a Pilgrim, There's a Way"},
        [64969] = {Name = "In The Weeds"},
        [64835] = {Name = "Pluck from the Vines"},
        [64836] = {Name = "Nip It in the Bud"},
        [64839] = {Name = "Root of the Problem"},
        [64841] = {Name = "Take Charge"},
        [64840] = {Name = "Unchecked Growth"},
        [65331] = {Name = "Herbal Remedies"},

        [64842] = {Name = "Catalyst Crush"},
        [64843] = {Name = "Key Crafting"},
        [64844] = {Name = "The Pilgrimage Ends"},

        [64799] = {Name = "The Broken Crown"},
        [64800] = {Name = "Our Last Option"},
        [64802] = {Name = "Hello, Darkness"},
        [64801] = {Name = "Elder Eru"},
        [64804] = {Name = "Cryptic Catalogue"},
        [64803] = {Name = "Testing One Two"},
        [64805] = {Name = "The Not-Scientific Method"},
        [64853] = {Name = "Two Paths to Tread"},

        [64809] = {Name = "One Half of the Equation"},
        [64810] = {Name = "Oppress and Destroy"},
        [64811] = {Name = "Aggressive Excavation"},
        [64806] = {Name = "Where the Memory Resides"},
        [64807] = {Name = "What We Wish to Forget"},
        [64808] = {Name = "What Makes Us Stronger"},
        [64798] = {Name = "What We Overcome"},
        [64812] = {Name = "Forge of Domination"},
        [64813] = {Name = "The Crown of Wills"},
        [64816] = {Name = "Reality's Doorstep"},

        [64875] = {Name = "Something Wonderful"},
        [64876] = {Name = "Music of the Spheres"},
        [64878] = {Name = "What A Long Strange Trip"},
        [64888] = {Name = "Borrowed Power"},
        [65245] = {Name = "Pop Goes the Devourer!"},
        [64936] = {Name = "Searching High and Low"},
        [64937] = {Name = "You Light Up My Life"},
        [65237] = {Name = "Oracle, Heal Thyself"},

        [65328] = {Name = "Arbiter in the Makin"},
        [64879] = {Name = "A Monumental Discovery"},
        [64723] = {Name = "Restoration Project"},
        [64733] = {Name = "Help From Beyond"},
        [64718] = {Name = "Keys to Victory"},
        [64720] = {Name = "Cleaving A Path"},
        [64706] = {Name = "A Matter Of Motivation"},
        [64722] = {Name = "Knocking On Death's Door"},
        [64727] = {Name = "The Infinite Circle"},
        [64726] = {Name = "Th Order Of Things"},
        [64725] = {Name = "Unforgivable Intrusion"},
        [64962] = {Name = "As Foretold"},
        [64728] = {Name = "Acquaintances Forgotten"},
        [64730] = {Name = "The Turning Point"},
        [64731] = {Name = "For Every Soul"},
        [64729] = {Name = "Lifetimes To Consider"},
        [65238] = {Name = "Souls Entwined"},

        [65329] = {Name = "Safe Haven"},

        [64960] = {Name = "Englightened Exodus"},
        [65431] = {Name = "Further Research: Aealic"},
    },
    Korthia =
    {
        IDs = {63860, 63892, 63899, 63909, 63910, 63911, 63912, 63913, 63914, 63915, 63916, 63917, 63918, 63919, 63920, 63921, 63924},
        [63860] = {Name =         "Talisman of the Eternal Scholar", Location = {xVal = 40.6, yVal = 41.4,},},
        [63892] = {Name =                    "Diviner's Rune Chits", Location = {xVal =  nil, yVal =  nil,},},
        [63899] = {Name =          "Book of Binding: The Mad Witch", Location = {xVal = 30.5, yVal = 54.7,},},
        [63909] = {Name =                 "Guise of the Changeling", Location = {xVal = 42.2, yVal = 41.0,},},
        [63910] = {Name =                          "The Netherstar", Location = {xVal = 33.0, yVal = 41.9,},},
        [63911] = {Name =                     "Singing Steel Ingot", Location = {xVal = 61.9, yVal = 56.8,},},
        [63912] = {Name =             "Celestial Shadowlands Chart", Location = {xVal = 45.3, yVal = 56.0,},},
        [63913] = {Name =                  "Unstable Explosive Orb", Location = {xVal = 51.4, yVal = 20.2,},},
        [63914] = {Name =                 "Cipher of Understanding", Location = {xVal = 28.8, yVal = 54.2,},},
        [63915] = {Name =                   "Drum of the Death Loa", Location = {xVal = 39.3, yVal = 52.4,},},
        [63916] = {Name =                    "Sack of Strange Soil", Location = {xVal = 45.0, yVal = 35.5,},},
        [63917] = {Name =                    "Everliving Statuette", Location = {xVal = 39.3, yVal = 52.4,},},
        [63918] = {Name =                 "Obelisk of Dark Tidings", Location = {xVal = 45.0, yVal = 35.5,},},
        [63919] = {Name = "Book of Binding: The Tormented Sorcerer", Location = {xVal = 60.8, yVal = 34.8,},},
        [63920] = {Name =             "Enigmatic Decrypting Device", Location = {xVal = 51.8, yVal = 52.4,},},
        [63921] = {Name =                 "Ring of Self Reflection", Location = {xVal = 43.8, yVal = 77.0,},},
        [63924] = {Name =                       "Gorak Claw Fetish", Location = {xVal = 43.5, yVal = 57.4,},},
    },
}

AZP.ZoneQuests.BossInfo =
{
    Tarragrue =
    {
        Name = "Tarragrue",
        ID = 2423,
        Index = 1,
        Active = "Soon",
        FileID = GetFileIDFromPath("Interface\\ENCOUNTERJOURNAL\\UI-EJ-BOSS-Tarragrue.blp"),
    },
    TheEye =
    {
        Name = "The Eye",
        ID = 2433,
        Index = 2,
        Active = true,
        FileID = GetFileIDFromPath("Interface\\ENCOUNTERJOURNAL\\UI-EJ-BOSS- Eye of the Jailer.blp"),
        Spells =
        {
            StygianEjection = 348117,
        },
    },
}