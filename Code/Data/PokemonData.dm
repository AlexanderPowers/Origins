mob/Pokemon
	density = 1
	Bulbasaur
		icon = '001Bulbasaur.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 4,/obj/Moves/Leech_Seed = 7,/obj/Moves/Vine_Whip = 10,/obj/Moves/PoisonPowder = 15,/obj/Moves/SleepPowder = 15,/obj/Moves/Razor_Leaf = 20,/obj/Moves/Sweet_Scent = 25,/obj/Moves/Growth = 32,/obj/Moves/Synthesis = 39,/obj/Moves/SolarBeam = 46)
		Evolve = list("Level 16" = /mob/Pokemon/Ivysaur)
		Type1 = "Grass"
		Type2 = "Poison"
		BaseStats = list("HP" = 45, "ATK" = 49, "DEF" = 49, "SPL ATK" = 69, "SPL DEF" = 69, "SPD" = 45, "EXP" = 64)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 1
		POKEIMAGE = '1.png'
		EggGroups = list("Monster", "Grass")
		EggMoves = list(/obj/Moves/Light_Screen,/obj/Moves/Petal_Dance,/obj/Moves/Razor_Wind,/obj/Moves/Safeguard,/obj/Moves/Skull_Bash,/obj/Moves/Charm,/obj/Moves/Curse,/obj/Moves/GrassWhistle)
		Weight = 15.2
		Cry = '001.WAV'
		Abilities = list("Overgrow")
		HiddenAbility = list("Chlorophyll")
	Ivysaur
		icon = '002Ivysaur.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 1,/obj/Moves/Leech_Seed = 1,/obj/Moves/Vine_Whip = 10,/obj/Moves/PoisonPowder = 15,/obj/Moves/SleepPowder = 15,/obj/Moves/Razor_Leaf = 22,/obj/Moves/Sweet_Scent = 29,/obj/Moves/Growth = 38,/obj/Moves/Synthesis = 47,/obj/Moves/SolarBeam = 56)
		Evolve = list("Level 36" = /mob/Pokemon/Venusaur)
		Type1 = "Grass"
		Type2 = "Poison"
		BaseStats = list("HP" = 60, "ATK" = 62, "DEF" = 63, "SPL ATK" = 80, "SPL DEF" = 80, "SPD" = 60, "EXP" = 141)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 2
		POKEIMAGE = '2.png'
		EggGroups = list("Monster", "Grass")
		EggMoves = list(/obj/Moves/Light_Screen,/obj/Moves/Petal_Dance,/obj/Moves/Razor_Wind,/obj/Moves/Safeguard,/obj/Moves/Skull_Bash,/obj/Moves/Charm,/obj/Moves/Curse,/obj/Moves/GrassWhistle)
		Weight = 28.7
		Cry = '002.WAV'
		Unevolve = /mob/Pokemon/Bulbasaur
		Abilities = list("Overgrow")
		HiddenAbility = list("Chlorophyll")

	Venusaur
		icon = '003Venusaur.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 1,/obj/Moves/Leech_Seed = 1,/obj/Moves/Vine_Whip = 1,/obj/Moves/PoisonPowder = 15,/obj/Moves/SleepPowder = 15,/obj/Moves/Razor_Leaf = 22,/obj/Moves/Sweet_Scent = 29,/obj/Moves/Growth = 41,/obj/Moves/Synthesis = 53,/obj/Moves/SolarBeam = 65)
		Type1 = "Grass"
		Type2 = "Poison"
		BaseStats = list("HP" = 80, "ATK" = 82, "DEF" = 83, "SPL ATK" = 100, "SPL DEF" = 100, "SPD" = 80, "EXP" = 208)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 3
		POKEIMAGE = '3.png'
		EggGroups = list("Monster", "Grass")
		EggMoves = list(/obj/Moves/Light_Screen,/obj/Moves/Petal_Dance,/obj/Moves/Razor_Wind,/obj/Moves/Safeguard,/obj/Moves/Skull_Bash,/obj/Moves/Charm,/obj/Moves/Curse,/obj/Moves/GrassWhistle)
		Weight = 220.5
		Cry = '003.WAV'
		Unevolve = /mob/Pokemon/Ivysaur
		Abilities = list("Overgrow")
		HiddenAbility = list("Chlorophyll")
	Charmander
		icon = '004Charmander.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Growl = 1,/obj/Moves/Ember = 7,/obj/Moves/Smokescreen = 13,/obj/Moves/Rage = 19,/obj/Moves/Scary_Face = 25,/obj/Moves/Slash = 37,/obj/Moves/Flamethrower = 31,/obj/Moves/Fire_Spin = 49,/obj/Moves/Dragon_Rage = 43,/obj/Moves/Metal_Claw = 13)
		Evolve = list("Level 16" = /mob/Pokemon/Charmeleon)
		Type1 = "Fire"
		BaseStats = list("HP" = 39, "ATK" = 52, "DEF" = 43, "SPL ATK" = 60, "SPL DEF" = 50, "SPD" = 65, "EXP" = 65)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 4
		POKEIMAGE = '4.png'
		EggGroups = list("Monster", "Dragon")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Beat_Up,/obj/Moves/Belly_Drum,/obj/Moves/Bite,/obj/Moves/Crunch,/obj/Moves/Outrage,/obj/Moves/Rock_Slide,/obj/Moves/Belly_Drum,/obj/Moves/Dragon_Dance,/obj/Moves/Metal_Claw,/obj/Moves/Swords_Dance)
		Weight = 18.7
		Cry = '004.WAV'
		Abilities = list("Blaze")
		HiddenAbility = list("Solar Power")
	Charmeleon
		icon = '005Charmeleon.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Growl = 1,/obj/Moves/Ember = 1,/obj/Moves/Smokescreen = 13,/obj/Moves/Rage = 20,/obj/Moves/Scary_Face = 27,/obj/Moves/Slash = 41,/obj/Moves/Flamethrower = 34,/obj/Moves/Fire_Spin = 55,/obj/Moves/Metal_Claw = 13)
		Evolve = list("Level 36" = /mob/Pokemon/Charizard)
		Type1 = "Fire"
		BaseStats = list("HP" = 58, "ATK" = 64, "DEF" = 58, "SPL ATK" = 80, "SPL DEF" = 65, "SPD" = 80, "EXP" = 142)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 5
		POKEIMAGE = '5.png'
		EggGroups = list("Monster", "Dragon")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Beat_Up,/obj/Moves/Belly_Drum,/obj/Moves/Bite,/obj/Moves/Crunch,/obj/Moves/Outrage,/obj/Moves/Rock_Slide,/obj/Moves/Belly_Drum,/obj/Moves/Dragon_Dance,/obj/Moves/Metal_Claw,/obj/Moves/Swords_Dance)
		Weight = 41.9
		Cry = '005.WAV'
		Unevolve = /mob/Pokemon/Charmander
		Abilities = list("Blaze")
		HiddenAbility = list("Solar Power")
	Charizard
		icon = '006Charizard.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Growl = 1,/obj/Moves/Ember = 1,/obj/Moves/Smokescreen = 1,/obj/Moves/Rage = 20,/obj/Moves/Scary_Face = 27,/obj/Moves/Slash = 44,/obj/Moves/Flamethrower = 34,/obj/Moves/Fire_Spin = 64,/obj/Moves/Wing_Attack = 36,/obj/Moves/Metal_Claw = 13,/obj/Moves/Dragon_Rage = 55)
		Type1 = "Fire"
		Type2 = "Flying"
		BaseStats = list("HP" = 78, "ATK" = 84, "DEF" = 78, "SPL ATK" = 109, "SPL DEF" = 85, "SPD" = 101, "EXP" = 209)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 6
		POKEIMAGE = '6.png'
		EggGroups = list("Monster", "Dragon")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Beat_Up,/obj/Moves/Belly_Drum,/obj/Moves/Bite,/obj/Moves/Crunch,/obj/Moves/Outrage,/obj/Moves/Rock_Slide,/obj/Moves/Belly_Drum,/obj/Moves/Dragon_Dance,/obj/Moves/Metal_Claw,/obj/Moves/Swords_Dance)
		Weight = 199.5
		Cry = '006.WAV'
		Unevolve = /mob/Pokemon/Charmeleon
		Abilities = list("Blaze")
		HiddenAbility = list("Solar Power")
	Squirtle
		icon = '007Squirtle.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Tail_Whip = 4, /obj/Moves/Bubble = 7, /obj/Moves/Withdraw = 10, /obj/Moves/Water_Gun = 13, /obj/Moves/Bite = 18, /obj/Moves/Rapid_Spin = 23, /obj/Moves/Protect = 28, /obj/Moves/Hydro_Pump = 47, /obj/Moves/Rain_Dance = 33,/obj/Moves/Skull_Bash = 40)
		Evolve = list("Level 16" = /mob/Pokemon/Wartortle)
		Type1 = "Water"
		BaseStats = list("HP" = 44, "ATK" = 48, "DEF" = 65, "SPL ATK" = 50, "SPL DEF" = 64, "SPD" = 43, "EXP" = 66)
		GrowthRate = "Medium-Slow"//1,059,860
		SurfPixelY = 8
		Number = 7
		POKEIMAGE = '7.png'
		EggGroups = list("Monster", "Water 1")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Foresight,/obj/Moves/Haze,/obj/Moves/Mist,/obj/Moves/Mirror_Coat,/obj/Moves/Mud_Sport,/obj/Moves/Refresh,/obj/Moves/Yawn)
		Weight = 19.8
		Cry = '007.WAV'
		Abilities = list("Torrent")
		HiddenAbility = list("Rain Dish")
	Wartortle
		icon = '008Wartortle.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Tail_Whip = 1, /obj/Moves/Bubble = 1, /obj/Moves/Withdraw = 10, /obj/Moves/Water_Gun = 13, /obj/Moves/Bite = 19, /obj/Moves/Rapid_Spin = 25, /obj/Moves/Skull_Bash = 39, /obj/Moves/Hydro_Pump = 47, /obj/Moves/Rain_Dance = 37,/obj/Moves/Protect = 31)
		Evolve = list("Level 36" = /mob/Pokemon/Blastoise)
		Type1 = "Water"
		BaseStats = list("HP" = 59, "ATK" = 63, "DEF" = 80, "SPL ATK" = 65, "SPL DEF" = 80, "SPD" = 58, "EXP" = 143)
		GrowthRate = "Medium-Slow"//1,059,860
		SurfPixelY = 8
		Number = 8
		POKEIMAGE = '8.png'
		EggGroups = list("Monster", "Water 1")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Foresight,/obj/Moves/Haze,/obj/Moves/Mist,/obj/Moves/Mirror_Coat,/obj/Moves/Mud_Sport,/obj/Moves/Refresh,/obj/Moves/Yawn)
		Weight = 49.6
		Cry = '008.WAV'
		Unevolve = /mob/Pokemon/Squirtle
		Abilities = list("Torrent")
		HiddenAbility = list("Rain Dish")
	Blastoise
		icon = '009Blastoise.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Tail_Whip = 1, /obj/Moves/Bubble = 1, /obj/Moves/Withdraw = 1, /obj/Moves/Water_Gun = 13, /obj/Moves/Bite = 19, /obj/Moves/Rapid_Spin = 25, /obj/Moves/Skull_Bash = 55, /obj/Moves/Hydro_Pump = 68, /obj/Moves/Rain_Dance = 42,/obj/Moves/Protect = 31)
		Type1 = "Water"
		BaseStats = list("HP" = 79, "ATK" = 83, "DEF" = 100, "SPL ATK" = 85, "SPL DEF" = 105, "SPD" = 78, "EXP" = 210)
		GrowthRate = "Medium-Slow"//1,059,860
		SurfPixelY = 8
		Number = 9
		POKEIMAGE = '9.png'
		EggGroups = list("Monster", "Water 1")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Foresight,/obj/Moves/Haze,/obj/Moves/Mist,/obj/Moves/Mirror_Coat,/obj/Moves/Mud_Sport,/obj/Moves/Refresh,/obj/Moves/Yawn)
		Weight = 188.5
		Cry = '009.WAV'
		Unevolve = /mob/Pokemon/Wartortle
		Abilities = list("Torrent")
		HiddenAbility = list("Rain Dish")
	Caterpie
		icon = '010Caterpie.dmi'
		CaptureRate = 255
		Gender = 50
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/String_Shot = 1)
		Evolve = list("Level 7" = /mob/Pokemon/Metapod)
		Type1 = "Bug"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 45, "ATK" = 30, "DEF" = 35, "SPL ATK" = 20, "SPL DEF" = 20, "SPD" = 45, "EXP" = 53)
		Number = 10
		POKEIMAGE = '10.png'
		EggGroups = list("Bug")
		Weight = 6.4
		Cry = '010.WAV'
		Abilities = list("Shield Dust","Run Away")
	Metapod
		icon = '011Metapod.dmi'
		CaptureRate = 120
		Gender = 50
		LearnMoves = list(/obj/Moves/Harden = 1)
		Type1 = "Bug"
		Evolve = list("Level 10" = /mob/Pokemon/Butterfree)
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 50, "ATK" = 20, "DEF" = 55, "SPL ATK" = 25, "SPL DEF" = 25, "SPD" = 30, "EXP" = 72)
		Number = 11
		POKEIMAGE = '11.png'
		EggGroups = list("Bug")
		Weight = 21.8
		Cry = '011.WAV'
		Unevolve = /mob/Pokemon/Caterpie
		Abilities = list("Shed Skin")
	Butterfree
		icon = '012Butterfree.dmi'
		CaptureRate = 45
		Gender = 50
		LearnMoves = list(/obj/Moves/Confusion = 1, /obj/Moves/PoisonPowder = 13, /obj/Moves/Stun_Spore = 14,/obj/Moves/SleepPowder = 15,/obj/Moves/Gust = 28,/obj/Moves/Supersonic = 18, /obj/Moves/Whirlwind = 23, /obj/Moves/Psybeam = 34,/obj/Moves/Safeguard = 40,/obj/Moves/Silver_Wind)
		Type1 = "Bug"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 45, "DEF" = 50, "SPL ATK" = 80, "SPL DEF" = 80, "SPD" = 101, "EXP" = 160)
		Number = 12
		POKEIMAGE = '12.png'
		EggGroups = list("Bug")
		Weight = 70.5
		Cry = '012.WAV'
		Abilities = list("Compoundeyes","Tinted Lens")
	Weedle
		icon = '013Weedle.dmi'
		CaptureRate = 255
		Gender = 50
		Type2 = "Poison"
		Type1 = "Bug"
		Evolve = list("Level 7" = /mob/Pokemon/Kakuna)
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 40, "ATK" = 35, "DEF" = 30, "SPL ATK" = 20, "SPL DEF" = 20, "SPD" = 50, "EXP" = 52)
		LearnMoves = list(/obj/Moves/Poison_Sting = 1, /obj/Moves/String_Shot = 1)
		Number = 13
		POKEIMAGE = '13.png'
		EggGroups = list("Bug")
		Weight = 7.1
		Cry = '013.WAV'
		Abilities = list("Shield Dust","Run Away")
	Kakuna
		icon = '014Kakuna.dmi'
		CaptureRate = 120
		Gender = 50
		Type2 = "Poison"
		Type1 = "Bug"
		Evolve = list("Level 10" = /mob/Pokemon/Bedrill)
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 45, "ATK" = 25, "DEF" = 50, "SPL ATK" = 25, "SPL DEF" = 25, "SPD" = 35, "EXP" = 71)
		LearnMoves = list(/obj/Moves/Harden = 1)
		Number = 14
		EggGroups = list("Bug")
		Weight = 22.0
		POKEIMAGE = '14.png'
		Cry = '014.WAV'
		Unevolve = /mob/Pokemon/Weedle
		Abilities = list("Shed Skin")
	Bedrill
		name = "Beedrill"
		icon = '015Beedrill.dmi'
		CaptureRate = 45
		Gender = 50
		Type2 = "Poison"
		Type1 = "Bug"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 80, "DEF" = 40, "SPL ATK" = 45, "SPL DEF" = 80, "SPD" = 75, "EXP" = 159)
		LearnMoves = list(/obj/Moves/Poison_Sting= 1, /obj/Moves/Fury_Attack = 1, /obj/Moves/Focus_Energy = 15, /obj/Moves/Twineedle = 20, /obj/Moves/Rage = 25, /obj/Moves/Pin_Missle = 35, /obj/Moves/Agility = 40,/obj/Moves/Pursuit = 30,/obj/Moves/Endeavor = 45)
		Number = 15
		POKEIMAGE = '15.png'
		EggGroups = list("Bug")
		Weight = 65.0
		Cry = '015.WAV'
		Unevolve = /mob/Pokemon/Kakuna
		Abilities = list("Swarm","Sniper")
	Pidgey
		icon = '016Pidgey.dmi'
		GrowthRate = "Medium-Slow"//1,059,860
		CaptureRate = 255
		Gender = 50
		Type2 = "Flying"
		Type1 = "Normal"
		Evolve = list("Level 18" = /mob/Pokemon/Pidgeotto)
		BaseStats = list("HP" = 40, "ATK" = 45, "DEF" = 40, "SPL ATK" = 35, "SPL DEF" = 35, "SPD" = 56, "EXP" = 55)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Sand_Attack = 5, /obj/Moves/Gust = 9, /obj/Moves/Quick_Attack = 13, /obj/Moves/Whirlwind = 19, /obj/Moves/Agility = 39,/obj/Moves/Wing_Attack = 25,/obj/Moves/Mirror_Move = 47,/obj/Moves/FeatherDance = 31)
		Number = 16
		POKEIMAGE = '16.png'
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Pursuit,/obj/Moves/Foresight,/obj/Moves/Faint_Attack,/obj/Moves/Air_Cutter)
		Weight = 4.0
		Cry = '016.WAV'
		Abilities = list("Keen Eye","Tangled Feet","Big Pecks")
	Pidgeotto
		icon = '017Pidgeotto.dmi'
		GrowthRate = "Medium-Slow"//1,059,860
		Gender = 50
		Type2 = "Flying"
		Type1 = "Normal"
		Evolve = list("Level 36" = /mob/Pokemon/Pidgeot)
		Unevolve = /mob/Pokemon/Pidgey
		CaptureRate = 120
		BaseStats = list("HP" = 63, "ATK" = 60, "DEF" = 55, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 71, "EXP" = 113)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Sand_Attack = 1, /obj/Moves/Gust = 1, /obj/Moves/Quick_Attack = 13, /obj/Moves/Whirlwind = 20, /obj/Moves/Agility = 43,/obj/Moves/Wing_Attack = 27, /obj/Moves/Mirror_Move = 52,/obj/Moves/FeatherDance = 34)
		Number = 17
		POKEIMAGE = '17.png'
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Pursuit,/obj/Moves/Foresight,/obj/Moves/Faint_Attack,/obj/Moves/Air_Cutter)
		Weight = 66.1
		Cry = '017.WAV'
		Unevolve = /mob/Pokemon/Pidgey
		Abilities = list("Keen Eye","Tangled Feet","Big Pecks")
	Pidgeot
		icon = '018Pidgeot.dmi'
		GrowthRate = "Medium-Slow"//1,059,860
		Gender = 50
		Type2 = "Flying"
		Type1 = "Normal"
		Unevolve = /mob/Pokemon/Pidgeotto
		CaptureRate = 45
		BaseStats = list("HP" = 83, "ATK" = 80, "DEF" = 75, "SPL ATK" = 70, "SPL DEF" = 70, "SPD" = 101, "EXP" = 172)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Sand_Attack = 1, /obj/Moves/Gust = 1, /obj/Moves/Quick_Attack = 1, /obj/Moves/Whirlwind = 20, /obj/Moves/Agility = 48,/obj/Moves/Wing_Attack = 27, /obj/Moves/Mirror_Move = 62,/obj/Moves/FeatherDance = 34)
		Number = 18
		POKEIMAGE = '18.png'
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Pursuit,/obj/Moves/Foresight,/obj/Moves/Faint_Attack,/obj/Moves/Air_Cutter)
		Weight = 87.1
		Cry = '018.WAV'
		Unevolve = /mob/Pokemon/Pidgeotto
		Abilities = list("Keen Eye","Tangled Feet","Big Pecks")
	Rattata
		icon = '019Rattata.dmi'
		CaptureRate = 255
		Gender = 50
		GrowthRate = "Medium-Fast"
		Type1 = "Normal"
		Evolve = list("Level 20" = /mob/Pokemon/Raticate)
		BaseStats = list("HP" = 30, "ATK" = 56, "DEF" = 35, "SPL ATK" = 25, "SPL DEF" = 35, "SPD" = 78, "EXP" = 57)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Tail_Whip = 1, /obj/Moves/Quick_Attack = 7, /obj/Moves/Focus_Energy = 20,/obj/Moves/Hyper_Fang = 13, /obj/Moves/Super_Fang = 34,/obj/Moves/Pursuit = 27,/obj/Moves/Endeavor = 41)
		Number = 19
		POKEIMAGE = '19.png'
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Bite,/obj/Moves/Counter,/obj/Moves/Flame_Wheel,/obj/Moves/Fury_Swipes,/obj/Moves/Reversal,/obj/Moves/Screech,/obj/Moves/Swagger,/obj/Moves/Uproar)
		Weight = 7.7
		Cry = '019.WAV'
		Abilities = list("Run Away","Guts","Hustle")
	Raticate
		icon = '020Raticate.dmi'
		CaptureRate = 127
		Gender = 50
		GrowthRate = "Medium-Fast"
		Type1 = "Normal"
		Unevolve = /mob/Pokemon/Rattata
		BaseStats = list("HP" = 55, "ATK" = 81, "DEF" = 60, "SPL ATK" = 50, "SPL DEF" = 70, "SPD" = 101, "EXP" = 116)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Tail_Whip = 1, /obj/Moves/Quick_Attack = 1,/obj/Moves/Hyper_Fang = 13, /obj/Moves/Scary_Face = 20, /obj/Moves/Double_Edge = 39,/obj/Moves/Pursuit = 30,/obj/Moves/Super_Fang = 40,/obj/Moves/Endeavor = 50)
		Number = 20
		POKEIMAGE = '20.png'
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Bite,/obj/Moves/Counter,/obj/Moves/Flame_Wheel,/obj/Moves/Fury_Swipes,/obj/Moves/Reversal,/obj/Moves/Screech,/obj/Moves/Swagger,/obj/Moves/Uproar)
		Weight = 40.8
		Cry = '020.WAV'
		Unevolve = /mob/Pokemon/Rattata
		Abilities = list("Run Away","Guts","Hustle")
	Spearow
		icon = '021Spearow.dmi'
		CaptureRate = 255
		Gender = 50
		Evolve = list("Level 20" = /mob/Pokemon/Fearow)
		Type1 = "Normal"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 40, "ATK" = 60, "DEF" = 30, "SPL ATK" = 31, "SPL DEF" = 31, "SPD" = 70, "EXP" = 58)
		LearnMoves = list(/obj/Moves/Peck = 1, /obj/Moves/Growl = 1, /obj/Moves/Leer = 7, /obj/Moves/Fury_Attack = 13, /obj/Moves/Mirror_Move = 31,/obj/Moves/Agility = 43,/obj/Moves/Drill_Peck = 37,/obj/Moves/Pursuit = 19,/obj/Moves/Aerial_Ace = 25)
		Number = 21
		POKEIMAGE = '21.png'
		EggGroups = list("Flying")
		Weight = 4.4
		Cry = '021.WAV'
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/False_Swipe,/obj/Moves/Quick_Attack,/obj/Moves/Scary_Face,/obj/Moves/Astonish,/obj/Moves/Tri_Attack,/obj/Moves/Sky_Attack)
		Abilities = list("Keen Eye","Sniper")

	Fearow
		icon = '022Fearow.dmi'
		CaptureRate = 90
		Gender = 50
		Type1 = "Normal"
		Type2 = "Flying"
		Unevolve = /mob/Pokemon/Spearow
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 90, "DEF" = 65, "SPL ATK" = 61, "SPL DEF" = 61, "SPD" = 101, "EXP" = 162)
		LearnMoves = list(/obj/Moves/Peck = 1, /obj/Moves/Growl = 1, /obj/Moves/Leer = 7, /obj/Moves/Fury_Attack = 13, /obj/Moves/Mirror_Move = 32,/obj/Moves/Agility = 47,/obj/Moves/Drill_Peck = 40,/obj/Moves/Pursuit = 26)
		Number = 22
		POKEIMAGE = '22.png'
		EggGroups = list("Flying")
		Weight = 83.8
		Cry = '022.WAV'
		Unevolve = /mob/Pokemon/Spearow
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/False_Swipe,/obj/Moves/Quick_Attack,/obj/Moves/Scary_Face,/obj/Moves/Astonish,/obj/Moves/Tri_Attack,/obj/Moves/Sky_Attack)
		Abilities = list("Keen Eye","Sniper")


	Ekans
		icon = '023Ekans.dmi'
		CaptureRate = 255
		Gender = 50
		GrowthRate = "Medium-Fast"
		WrapDistance = 2
		Type1 = "Poison"
		Evolve = list("Level 22" = /mob/Pokemon/Arbok)
		BaseStats = list("HP" = 35, "ATK" = 60, "DEF" = 44, "SPL ATK" = 40, "SPL DEF" = 54, "SPD" = 55, "EXP" = 62)
		LearnMoves = list(/obj/Moves/Wrap = 1, /obj/Moves/Leer = 1, /obj/Moves/Poison_Sting = 8, /obj/Moves/Bite = 13, /obj/Moves/Glare = 20, /obj/Moves/Screech = 25,/obj/Moves/Acid = 32,/obj/Moves/Haze= 44,/obj/Moves/Stockpile = 37,/obj/Moves/Swallow = 37,/obj/Moves/Spit_Up = 37)
		Number = 23
		POKEIMAGE = '23.png'
		EggGroups = list("Field","Dragon")
		EggMoves = list(/obj/Moves/Beat_Up,/obj/Moves/Crunch,/obj/Moves/Pursuit,/obj/Moves/Slam,/obj/Moves/Spite,/obj/Moves/Poison_Fang)
		Weight = 15.2
		Cry = '023.WAV'
		Abilities = list("Intimidate","Shed Skin","Unnerve")
	Arbok
		icon = '024Arbok.dmi'
		CaptureRate = 90
		Gender = 50
		GrowthRate = "Medium-Fast"
		Type1 = "Poison"
		WrapDistance = 2
		BaseStats = list("HP" = 60, "ATK" = 85, "DEF" = 69, "SPL ATK" = 65, "SPL DEF" = 79, "SPD" = 80, "EXP" = 147)
		LearnMoves = list(/obj/Moves/Wrap = 1, /obj/Moves/Leer = 1, /obj/Moves/Poison_Sting = 8, /obj/Moves/Bite = 13, /obj/Moves/Glare = 20, /obj/Moves/Screech = 28,/obj/Moves/Acid = 38,/obj/Moves/Haze = 56,/obj/Moves/Stockpile = 46,/obj/Moves/Swallow = 46,/obj/Moves/Spit_Up = 46)
		Number = 24
		POKEIMAGE = '24.png'
		EggGroups = list("Field","Dragon")
		Weight = 143.3
		EggMoves = list(/obj/Moves/Beat_Up,/obj/Moves/Crunch,/obj/Moves/Pursuit,/obj/Moves/Slam,/obj/Moves/Spite,/obj/Moves/Poison_Fang)
		Cry = '024.WAV'
		Unevolve = /mob/Pokemon/Ekans
		Abilities = list("Intimidate","Shed Skin","Unnerve")
	Pikachu
		icon = '025Pikachu.dmi'
		GrowthRate = "Medium-Fast"
		Gender = 50
		Evolve = list("Thunderstone" = /mob/Pokemon/Raichu)
		Unevolve = /mob/Pokemon/Pichu
		Type1 = "Electric"
		CaptureRate = 190
		BaseStats = list("HP" = 60, "ATK" = 62, "DEF" = 63, "SPL ATK" = 80, "SPL DEF" = 80, "SPD" = 90, "EXP" = 82)
		LearnMoves = list(/obj/Moves/Thundershock = 1, /obj/Moves/Growl = 1, /obj/Moves/Tail_Whip = 6, /obj/Moves/Thunder_Wave = 8, /obj/Moves/Quick_Attack = 11, /obj/Moves/Double_Team = 15,/obj/Moves/Slam = 20, /obj/Moves/Thunderbolt = 26, /obj/Moves/Agility = 33, /obj/Moves/Thunder = 41, /obj/Moves/Light_Screen = 50)
		Number = 25
		POKEIMAGE = '25.png'
		EggGroups = list("Field", "Fairy")
		EggMoves = list(/obj/Moves/Bide,/obj/Moves/Charge,/obj/Moves/DoubleSlap,/obj/Moves/Encore,/obj/Moves/Present,/obj/Moves/Reversal,/obj/Moves/Wish)
		Weight = 13.2
		Cry = '025.WAV'
		Abilities = list("Static","Lightningrod")
	Raichu
		icon = '026Raichu.dmi'
		Type1 = "Electric"
		Unevolve = /mob/Pokemon/Pikachu
		Gender = 50
		GrowthRate = "Medium-Fast"
		CaptureRate = 75
		BaseStats = list("HP" = 60, "ATK" = 90, "DEF" = 55, "SPL ATK" = 90, "SPL DEF" = 80, "SPD" = 101, "EXP" = 122)
		LearnMoves = list(/obj/Moves/Thundershock = 1, /obj/Moves/Growl = 1, /obj/Moves/Tail_Whip = 1, /obj/Moves/Thunder_Wave = 1, /obj/Moves/Quick_Attack = 1, /obj/Moves/Thunderbolt = 1)
		Number = 26
		POKEIMAGE = '26.png'
		EggGroups = list("Field", "Fairy")
		EggMoves = list(/obj/Moves/Bide,/obj/Moves/Charge,/obj/Moves/DoubleSlap,/obj/Moves/Encore,/obj/Moves/Present,/obj/Moves/Reversal,/obj/Moves/Wish)
		Weight = 66.1
		Cry = '026.WAV'
		Abilities = list("Static","Lightningrod")
	Sandshrew
		icon = '027Sandshrew.dmi'
		Gender = 50
		Evolve = list("Level 22" = /mob/Pokemon/Sandslash)
		Type1 = "Ground"
		GrowthRate = "Medium-Fast"
		CaptureRate = 255
		BaseStats = list("HP" = 50, "ATK" = 75, "DEF" = 85, "SPL ATK" = 20, "SPL DEF" = 30, "SPD" = 40, "EXP" = 93)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Defense_Curl = 6, /obj/Moves/Sand_Attack = 11, /obj/Moves/Poison_Sting = 17, /obj/Moves/Swift = 30, /obj/Moves/Fury_Swipes = 37,/obj/Moves/Slash = 23,/obj/Moves/Sandstorm = 53,/obj/Moves/Sand_Tomb = 45)
		Number = 27
		POKEIMAGE = '27.png'
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Crush_Claw,/obj/Moves/Counter,/obj/Moves/Flail,/obj/Moves/Metal_Claw,/obj/Moves/Rapid_Spin,/obj/Moves/Safeguard,/obj/Moves/Rock_Slide,/obj/Moves/Swords_Dance)
		Weight = 26.5
		Cry = '027.WAV'
		Abilities = list("Sand Veil","Sand Rush")

	Sandslash
		icon = '028Sandslash.dmi'
		Gender = 50
		GrowthRate = "Medium-Fast"
		CaptureRate = 90
		Type1 = "Ground"
		BaseStats = list("HP" = 75, "ATK" = 100, "DEF" = 110, "SPL ATK" = 45, "SPL DEF" = 55, "SPD" = 75, "EXP" = 163)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Defense_Curl = 1, /obj/Moves/Sand_Attack = 1, /obj/Moves/Poison_Sting = 17, /obj/Moves/Swift = 33, /obj/Moves/Fury_Swipes = 42, /obj/Moves/Slash = 24,/obj/Moves/Sandstorm = 62,/obj/Moves/Sand_Tomb = 52)
		Number = 28
		POKEIMAGE = '28.png'
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Crush_Claw,/obj/Moves/Counter,/obj/Moves/Flail,/obj/Moves/Metal_Claw,/obj/Moves/Rapid_Spin,/obj/Moves/Safeguard,/obj/Moves/Rock_Slide,/obj/Moves/Swords_Dance)
		Weight = 65.0
		Cry = '028.WAV'
		Unevolve = /mob/Pokemon/Sandslash
		Abilities = list("Sand Veil","Sand Rush")
	NidoranF
		name = "Nidoran"
		Gender = 0
		icon = '029NidoranF.dmi'
		Type1 = "Poison"
		Evolve = list("Level 16" = /mob/Pokemon/Nidorina)
		GrowthRate =  "Medium-Slow"
		CaptureRate = 235
		BaseStats = list("HP" = 55, "ATK" = 47, "DEF" = 52, "SPL ATK" = 40, "SPL DEF" = 40, "SPD" = 41, "EXP" = 59)
		LearnMoves = list(/obj/Moves/Growl = 1, /obj/Moves/Scratch = 1, /obj/Moves/Poison_Sting = 17, /obj/Moves/Tail_Whip = 8, /obj/Moves/Bite = 20,/obj/Moves/Fury_Swipes = 30,/obj/Moves/Double_Kick = 12,/obj/Moves/Flatter = 38,/obj/Moves/Crunch = 47)
		Number = 29
		POKEIMAGE = '29.png'
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Beat_Up,/obj/Moves/Charm,/obj/Moves/Counter,/obj/Moves/Disable,/obj/Moves/Focus_Energy,/obj/Moves/Supersonic,/obj/Moves/Take_Down)
		Weight = 15.4
		Cry = '029.WAV'
		Abilities = list("Poison Point","Rivalry","Hustle")

	Nidorina
		icon = '030Nidorina.dmi'
		Gender = 0
		Type1 = "Poison"
		Evolve = list("Moonstone" = /mob/Pokemon/Nidoqueen)
		GrowthRate =  "Medium-Slow"
		CaptureRate = 120
		BaseStats = list("HP" = 70, "ATK" = 62, "DEF" = 67, "SPL ATK" = 55, "SPL DEF" = 55, "SPD" = 56, "EXP" = 117)
		LearnMoves = list(/obj/Moves/Growl = 1, /obj/Moves/Scratch = 1, /obj/Moves/Double_Kick = 12, /obj/Moves/Poison_Sting = 18, /obj/Moves/Tail_Whip = 8, /obj/Moves/Bite = 22,/obj/Moves/Fury_Swipes = 34,/obj/Moves/Helping_Hand = 26,/obj/Moves/Flatter = 43,/obj/Moves/Crunch = 53)
		Number = 30
		POKEIMAGE = '30.png'
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Beat_Up,/obj/Moves/Charm,/obj/Moves/Counter,/obj/Moves/Disable,/obj/Moves/Focus_Energy,/obj/Moves/Supersonic,/obj/Moves/Take_Down)
		Weight = 44.1
		Cry = '030.WAV'
		Unevolve = /mob/Pokemon/NidoranF
		Abilities = list("Poison Point","Rivalry","Hustle")
	Nidoqueen
		icon = '031Nidoqueen.dmi'
		Gender = 0
		Type1 = "Poison"
		Type2 = "Ground"
		GrowthRate =  "Medium-Slow"
		CaptureRate = 45
		BaseStats = list("HP" = 90, "ATK" = 82, "DEF" = 87, "SPL ATK" = 75, "SPL DEF" = 85, "SPD" = 76, "EXP" = 194)
		LearnMoves = list(/obj/Moves/Growl = 1, /obj/Moves/Tail_Whip = 1, /obj/Moves/Scratch = 1, /obj/Moves/Double_Kick = 1, /obj/Moves/Poison_Sting = 1, /obj/Moves/Body_Slam = 23,/obj/Moves/Superpower = 43)
		Number = 31
		POKEIMAGE = '31.png'
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Beat_Up,/obj/Moves/Charm,/obj/Moves/Counter,/obj/Moves/Disable,/obj/Moves/Focus_Energy,/obj/Moves/Supersonic,/obj/Moves/Take_Down)
		Weight = 132.3
		Cry = '031.WAV'
		Unevolve = /mob/Pokemon/Nidorina
		Abilities = list("Poison Point","Rivalry","Sheer Force")
	NidoranM
		name = "Nidoran"
		Gender = 100
		icon = '032NidoranM.dmi'
		Type1 = "Poison"
		Evolve = list("Level 16" = /mob/Pokemon/Nidorino)
		GrowthRate =  "Medium-Slow"
		CaptureRate = 235
		BaseStats = list("HP" = 46, "ATK" = 57, "DEF" = 40, "SPL ATK" = 40, "SPL DEF" = 40, "SPD" = 50, "EXP" = 59)
		LearnMoves = list(/obj/Moves/Leer = 1, /obj/Moves/Peck = 1, /obj/Moves/Horn_Attack= 20, /obj/Moves/Double_Kick = 12, /obj/Moves/Poison_Sting = 17, /obj/Moves/Focus_Energy = 8, /obj/Moves/Fury_Attack = 30,/obj/Moves/Horn_Drill = 47,/obj/Moves/Helping_Hand = 23,/obj/Moves/Flatter = 38)
		Number = 32
		POKEIMAGE = '32.png'
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Beat_Up,/obj/Moves/Confusion,/obj/Moves/Counter,/obj/Moves/Disable,/obj/Moves/Supersonic,/obj/Moves/Take_Down)
		Weight = 19.8
		Cry = '032.WAV'
		Abilities = list("Poison Point","Rivalry","Hustle")
	Nidorino
		icon = '033Nidorino.dmi'
		Gender = 100
		Type1 = "Poison"
		Evolve = list("Moonstone" = /mob/Pokemon/Nidoking)
		GrowthRate =  "Medium-Slow"
		CaptureRate = 120
		BaseStats = list("HP" = 70, "ATK" = 62, "DEF" = 67, "SPL ATK" = 55, "SPL DEF" = 55, "SPD" = 65, "EXP" = 117)
		LearnMoves = list(/obj/Moves/Peck = 1, /obj/Moves/Leer = 1, /obj/Moves/Double_Kick = 12, /obj/Moves/Poison_Sting = 18, /obj/Moves/Horn_Attack = 22,/obj/Moves/Fury_Attack = 34,/obj/Moves/Horn_Attack = 22,/obj/Moves/Helping_Hand = 26,/obj/Moves/Flatter = 43,/obj/Moves/Horn_Drill = 53)
		Number = 33
		POKEIMAGE = '33.png'
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Beat_Up,/obj/Moves/Confusion,/obj/Moves/Counter,/obj/Moves/Disable,/obj/Moves/Supersonic,/obj/Moves/Take_Down)
		Weight = 43.3
		Cry = '033.WAV'
		Unevolve = /mob/Pokemon/NidoranM
		Abilities = list("Poison Point","Rivalry","Hustle")
	Nidoking
		icon = '034Nidoking.dmi'
		Gender = 100
		Type1 = "Poison"
		Type2 = "Ground"
		GrowthRate =  "Medium-Slow"
		CaptureRate = 45
		BaseStats = list("HP" = 81, "ATK" = 92, "DEF" = 77, "SPL ATK" = 85, "SPL DEF" = 75, "SPD" = 85, "EXP" = 194)
		LearnMoves = list(/obj/Moves/Peck = 1, /obj/Moves/Focus_Energy = 1, /obj/Moves/Double_Kick = 1, /obj/Moves/Poison_Sting = 1, /obj/Moves/Thrash = 23,/obj/Moves/Megahorn = 43)
		Number = 34
		POKEIMAGE = '34.png'
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Beat_Up,/obj/Moves/Confusion,/obj/Moves/Counter,/obj/Moves/Disable,/obj/Moves/Supersonic,/obj/Moves/Take_Down)
		Weight = 136.7
		Cry = '034.WAV'
		Unevolve = /mob/Pokemon/Nidorino
		Abilities = list("Poison Point","Rivalry","Sheer Force")
	Clefairy
		icon = '035Clefairy.dmi'
		Gender = 25
		Type1 = "Normal"
		GrowthRate = "Fast" //800000
		Evolve = list("Moonstone" = /mob/Pokemon/Clefable)
		Unevolve = /mob/Pokemon/Cleffa
		CaptureRate = 150
		LearnMoves = list(/obj/Moves/Growl = 1, /obj/Moves/Pound = 1, /obj/Moves/Sing = 9, /obj/Moves/Encore = 5, /obj/Moves/DoubleSlap = 13, /obj/Moves/Minimize = 21, /obj/Moves/Defense_Curl = 25, /obj/Moves/Metronome = 29, /obj/Moves/Light_Screen = 41,/obj/Moves/Moonlight = 37,/obj/Moves/Cosmic_Power = 33,/obj/Moves/Meteor_Mash = 45)
		BaseStats = list("HP" = 70, "ATK" = 45, "DEF" = 48, "SPL ATK" = 60, "SPL DEF" = 65, "SPD" = 35, "EXP" = 68)
		Number = 35
		POKEIMAGE = '35.png'
		EggGroups = list("Fairy")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Belly_Drum,/obj/Moves/Metronome,/obj/Moves/Mimic,/obj/Moves/Present,/obj/Moves/Splash,/obj/Moves/Substitute,/obj/Moves/Wish)
		Weight = 16.5
		Cry = '035.WAV'
		Abilities = list("Cute Charm","Magic Guard","Friend Guard")
	Clefable
		icon = '036Clefable.dmi'
		Gender = 25
		Type1 = "Normal"
		GrowthRate = "Fast" //800000
		CaptureRate = 25
		LearnMoves = list(/obj/Moves/Sing = 1,/obj/Moves/DoubleSlap = 1, /obj/Moves/Minimize = 1, /obj/Moves/Metronome = 1)
		BaseStats = list("HP" = 95, "ATK" = 70, "DEF" = 73, "SPL ATK" = 85, "SPL DEF" = 90, "SPD" = 66, "EXP" = 129)
		Number = 36
		POKEIMAGE = '36.png'
		EggGroups = list("Fairy")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Belly_Drum,/obj/Moves/Metronome,/obj/Moves/Mimic,/obj/Moves/Present,/obj/Moves/Splash,/obj/Moves/Substitute,/obj/Moves/Wish)
		Weight = 16.5
		Cry = '036.WAV'
		Unevolve = /mob/Pokemon/Clefairy
		Abilities = list("Cute Charm","Magic Guard","Unaware")
	Vulpix
		icon = '037Vulpix.dmi'
		Gender = 25
		CaptureRate = 190
		GrowthRate = "Medium-Fast"
		Type1 = "Fire"
		Evolve = list("Firestone" = /mob/Pokemon/Ninetales)
		BaseStats = list("HP" = 38, "ATK" = 41, "DEF" = 40, "SPL ATK" = 50, "SPL DEF" = 65, "SPD" = 70, "EXP" = 63)
		LearnMoves = list(/obj/Moves/Ember = 1, /obj/Moves/Tail_Whip = 5, /obj/Moves/Quick_Attack = 13, /obj/Moves/Roar = 9, /obj/Moves/Confuse_Ray = 21, /obj/Moves/Flamethrower = 29,/obj/Moves/Fire_Spin = 41,/obj/Moves/Imprison = 25,/obj/Moves/Safeguard = 33,/obj/Moves/Grudge = 37)
		Number = 37
		POKEIMAGE = '37.png'
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Disable,/obj/Moves/Faint_Attack,/obj/Moves/Flail,/obj/Moves/Hypnosis,/obj/Moves/Spite,/obj/Moves/Heat_Wave,/obj/Moves/Howl,/obj/Moves/Psych_Up)
		Weight = 21.8
		Cry = '037.WAV'
		Abilities = list("Flash Fire")
		HiddenAbility = list("Drought")
	Ninetales
		icon = '038Ninetails.dmi'
		Gender = 25
		CaptureRate = 75
		GrowthRate = "Medium-Fast"
		Type1 = "Fire"
		BaseStats = list("HP" = 73, "ATK" = 76, "DEF" = 75, "SPL ATK" = 81, "SPL DEF" = 100, "SPD" = 101, "EXP" = 178)
		LearnMoves = list(/obj/Moves/Ember = 1, /obj/Moves/Confuse_Ray = 1, /obj/Moves/Quick_Attack = 1, /obj/Moves/Safeguard = 1,/obj/Moves/Fire_Spin)
		Number = 38
		POKEIMAGE = '38.png'
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Disable,/obj/Moves/Faint_Attack,/obj/Moves/Flail,/obj/Moves/Hypnosis,/obj/Moves/Spite,/obj/Moves/Heat_Wave,/obj/Moves/Howl,/obj/Moves/Psych_Up)
		Weight = 43.9
		Cry = '038.WAV'
		Unevolve = /mob/Pokemon/Vulpix
		Abilities = list("Flash Fire")
		HiddenAbility = list("Drought")
	Jigglypuff
		icon = '039Jigglypuff.dmi'
		Gender = 25
		CaptureRate = 170
		Type1 = "Normal"
		GrowthRate = "Fast" //800000
		Evolve = list("Moonstone" = /mob/Pokemon/Wigglytuff)
		BaseStats = list("HP" = 115, "ATK" = 45, "DEF" = 20, "SPL ATK" = 45, "SPL DEF" = 25, "SPD" = 20, "EXP" = 76)
		LearnMoves = list(/obj/Moves/Sing = 1, /obj/Moves/Defense_Curl = 4, /obj/Moves/Pound = 9, /obj/Moves/Disable = 14, /obj/Moves/Rollout = 19, /obj/Moves/DoubleSlap = 24, /obj/Moves/Rest = 29, /obj/Moves/Body_Slam = 34, /obj/Moves/Mimic = 39,/obj/Moves/Hyper_Voice = 44,/obj/Moves/Double_Edge = 49)
		Number = 39
		POKEIMAGE = '39.png'
		EggGroups = list("Fairy")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Perish_Song,/obj/Moves/Present,/obj/Moves/Fake_Tears,/obj/Moves/Wish)
		Weight = 12.1
		Cry = '039.WAV'
		Abilities = list("Cute Charm","Friend Guard")
	Wigglytuff
		icon = '040Wigglytuff.dmi'
		Type1 = "Normal"
		Gender = 25
		GrowthRate = "Fast" //800000
		CaptureRate = 50
		BaseStats = list("HP" = 140, "ATK" = 70, "DEF" = 45, "SPL ATK" = 75, "SPL DEF" = 50, "SPD" = 45, "EXP" = 109)
		LearnMoves = list(/obj/Moves/Sing = 1, /obj/Moves/Disable = 1, /obj/Moves/DoubleSlap = 1,/obj/Moves/Defense_Curl = 1)
		Number = 40
		POKEIMAGE = '40.png'
		EggGroups = list("Fairy")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Perish_Song,/obj/Moves/Present,/obj/Moves/Fake_Tears,/obj/Moves/Wish)
		Weight = 26.5
		Cry = '040.WAV'
		Unevolve = /mob/Pokemon/Jigglypuff
		Abilities = list("Cute Charm","Frisk")
	Zubat
		icon = '041Zubat.dmi'
		Gender = 50
		GrowthRate = "Medium-Fast"
		CaptureRate = 255
		Type1 = "Poison"
		Type2 = "Flying"
		Evolve = list("Level 22" = /mob/Pokemon/Golbat)
		BaseStats = list("HP" = 40, "ATK" = 45, "DEF" = 35, "SPL ATK" = 30, "SPL DEF" = 40, "SPD" = 60, "EXP" = 54)
		LearnMoves = list(/obj/Moves/Leech_Life = 1, /obj/Moves/Supersonic = 6, /obj/Moves/Bite = 16, /obj/Moves/Confuse_Ray = 26, /obj/Moves/Wing_Attack = 21, /obj/Moves/Haze = 46,/obj/Moves/Mean_Look = 36,/obj/Moves/Astonish = 11,/obj/Moves/Air_Cutter = 31,/obj/Moves/Poison_Fang = 41)
		Number = 41
		POKEIMAGE = '41.png'
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Gust,/obj/Moves/Pursuit,/obj/Moves/Quick_Attack,/obj/Moves/Whirlwind,/obj/Moves/Curse)
		Weight = 16.5
		Cry = '041.WAV'
		Abilities = list("Inner Focus","Infiltrator")
	Golbat
		icon = '042Golbat.dmi'
		Gender = 50
		CaptureRate = 90
		GrowthRate = "Medium-Fast"
		Type1 = "Poison"
		Type2 = "Flying"
		Evolve = list("Happiness" = /mob/Pokemon/Crobat)
		BaseStats = list("HP" = 75, "ATK" = 80, "DEF" = 70, "SPL ATK" = 65, "SPL DEF" = 75, "SPD" = 90, "EXP" = 171)
		LearnMoves = list(/obj/Moves/Screech = 1,/obj/Moves/Leech_Life = 1, /obj/Moves/Supersonic = 1, /obj/Moves/Bite = 16, /obj/Moves/Confuse_Ray = 21, /obj/Moves/Wing_Attack = 28, /obj/Moves/Haze = 56,/obj/Moves/Mean_Look = 42,/obj/Moves/Astonish = 1,/obj/Moves/Air_Cutter = 35,/obj/Moves/Poison_Fang = 49)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Gust,/obj/Moves/Pursuit,/obj/Moves/Quick_Attack,/obj/Moves/Whirlwind,/obj/Moves/Curse)
		Weight = 121.3
		Number = 42
		POKEIMAGE = '42.png'
		Cry = '042.WAV'
		Unevolve = /mob/Pokemon/Zubat
		Abilities = list("Inner Focus","Infiltrator")
	Oddish
		icon = '043Oddish.dmi'
		GrowthRate = "Medium-Slow" //1,059,860
		Gender = 50
		Type1 = "Grass"
		Type2 = "Poison"
		Evolve = list("Level 21" = /mob/Pokemon/Gloom)
		CaptureRate = 255
		BaseStats = list("HP" = 45, "ATK" = 50, "DEF" = 55, "SPL ATK" = 75, "SPL DEF" = 65, "SPD" = 30, "EXP" = 30)
		LearnMoves = list(/obj/Moves/Absorb = 1, /obj/Moves/Acid = 23, /obj/Moves/PoisonPowder = 14, /obj/Moves/Stun_Spore = 16 ,/obj/Moves/SleepPowder = 18,/obj/Moves/Moonlight = 32,/obj/Moves/Petal_Dance = 39,/obj/Moves/Sweet_Scent = 7)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Razor_Leaf,/obj/Moves/Swords_Dance,/obj/Moves/Synthesis,/obj/Moves/Charm,/obj/Moves/Ingrain)
		Weight = 11.9
		Number = 43
		POKEIMAGE = '43.png'
		Cry = '043.WAV'
		Abilities = list("Chlorophyll","Stench")
	Gloom
		icon = '044Gloom.dmi'
		GrowthRate = "Medium-Slow" //1,059,860
		Gender = 50
		Evolve = list("Leafstone" = /mob/Pokemon/Vileplume, "Sunstone" = /mob/Pokemon/Bellossom)
		Type1 = "Grass"
		Type2 = "Poison"
		CaptureRate = 120
		BaseStats = list("HP" = 60, "ATK" = 65, "DEF" = 70, "SPL ATK" = 85, "SPL DEF" = 75, "SPD" = 40, "EXP" = 132)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Sweet_Scent = 1,/obj/Moves/Acid = 24, /obj/Moves/PoisonPowder = 1, /obj/Moves/Stun_Spore = 18 ,/obj/Moves/SleepPowder = 16,/obj/Moves/Moonlight = 35,/obj/Moves/Petal_Dance = 44)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Razor_Leaf,/obj/Moves/Swords_Dance,/obj/Moves/Synthesis,/obj/Moves/Charm,/obj/Moves/Ingrain)
		Weight = 19.0
		Number = 44
		POKEIMAGE = '44.png'
		Unevolve = /mob/Pokemon/Oddish
		Cry = '044.WAV'
		Abilities = list("Chlorophyll","Stench")
	Vileplume
		icon = '045Vileplume.dmi'
		Gender = 50
		GrowthRate = "Medium-Slow" //1,059,860
		Type1 = "Grass"
		Type2 = "Poison"
		CaptureRate = 45
		BaseStats = list("HP" = 75, "ATK" = 80, "DEF" = 85, "SPL ATK" = 100, "SPL DEF" = 90, "SPD" = 50, "EXP" = 184)
		LearnMoves = list(/obj/Moves/PoisonPowder = 1, /obj/Moves/Stun_Spore = 1 ,/obj/Moves/SleepPowder = 1)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Razor_Leaf,/obj/Moves/Swords_Dance,/obj/Moves/Synthesis,/obj/Moves/Charm,/obj/Moves/Ingrain)
		Weight = 41.0
		Number = 45
		POKEIMAGE = '45.png'
		Unevolve = /mob/Pokemon/Gloom
		Cry = '045.WAV'
		Abilities = list("Chlorophyll","Stench")
	Paras
		icon = '046Paras.dmi'
		Evolve = list("Level 24" = /mob/Pokemon/Parasect)
		Gender = 50
		CaptureRate = 190
		GrowthRate = "Medium-Fast" // 1000000
		Type1 = "Grass"
		Type2 = "Bug"
		BaseStats = list("HP" = 35, "ATK" = 70, "DEF" = 55, "SPL ATK" = 45, "SPL DEF" = 55, "SPD" = 25, "EXP" = 70)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Stun_Spore = 7 ,/obj/Moves/Leech_Life = 19,/obj/Moves/Spore = 25,/obj/Moves/Slash = 31,/obj/Moves/Growth = 37,/obj/Moves/Giga_Drain = 43,/obj/Moves/PoisonPowder = 13,/obj/Moves/Aromatherapy = 49)
		EggGroups = list("Bug","Grass")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/False_Swipe,/obj/Moves/Flail,/obj/Moves/Light_Screen,/obj/Moves/Psybeam,/obj/Moves/Pursuit,/obj/Moves/Screech,/obj/Moves/Sweet_Scent)
		Weight = 11.9
		Number = 46
		POKEIMAGE = '46.png'
		Cry = '046.WAV'
		Abilities = list("Effect Spore","Dry Skin","Damp")
	Parasect
		icon = '047Parasect.dmi'
		CaptureRate = 75
		Gender = 50
		GrowthRate = "Medium-Fast" // 1000000
		Type1 = "Grass"
		Type2 = "Bug"
		BaseStats = list("HP" = 60, "ATK" = 95, "DEF" = 80, "SPL ATK" = 95, "SPL DEF" = 80, "SPD" = 30, "EXP" = 128)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Stun_Spore = 1 ,/obj/Moves/PoisonPowder = 1,/obj/Moves/Leech_Life = 19,/obj/Moves/Spore = 28,/obj/Moves/Slash = 37,/obj/Moves/Growth = 46,/obj/Moves/Giga_Drain = 53,/obj/Moves/Aromatherapy = 59)
		EggGroups = list("Bug","Grass")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/False_Swipe,/obj/Moves/Flail,/obj/Moves/Light_Screen,/obj/Moves/Psybeam,/obj/Moves/Pursuit,/obj/Moves/Screech,/obj/Moves/Sweet_Scent)
		Weight = 65.0
		Number = 47
		POKEIMAGE = '47.png'
		Unevolve = /mob/Pokemon/Paras
		Cry = '047.WAV'
		Abilities = list("Effect Spore","Dry Skin","Damp")
	Venonat
		icon = '048Venonat.dmi'
		CaptureRate = 190
		Number = 48
		POKEIMAGE = '48.png'
		Gender = 50
		GrowthRate = "Medium-Fast" // 1000000
		Type1 = "Bug"
		Type2 = "Poison"
		Evolve = list("Level 31" = /mob/Pokemon/Venomoth)
		BaseStats = list("HP" = 60, "ATK" = 55, "DEF" = 50, "SPL ATK" = 40, "SPL DEF" = 55, "SPD" = 45, "EXP" = 75)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Disable = 1 ,/obj/Moves/Foresight = 1,/obj/Moves/Supersonic = 9,/obj/Moves/Confusion = 17,/obj/Moves/PoisonPowder = 20,/obj/Moves/Leech_Life = 25,/obj/Moves/Stun_Spore = 28,/obj/Moves/Psybeam = 33,/obj/Moves/SleepPowder = 36,/obj/Moves/Psychic = 41)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Screech,/obj/Moves/Giga_Drain,/obj/Moves/Signal_Beam)
		Weight = 66.1
		Cry = '048.WAV'
		Abilities = list("Compoundeyes","Tinted Lens","Run Away")
	Venomoth
		icon = '049Venomoth.dmi'
		CaptureRate = 75
		Number = 49
		POKEIMAGE = '49.png'
		Gender = 50
		GrowthRate = "Medium-Fast" // 1000000
		Type1 = "Bug"
		Type2 = "Poison"
		BaseStats = list("HP" = 70, "ATK" = 65, "DEF" = 60, "SPL ATK" = 90, "SPL DEF" = 75, "SPD" = 90, "EXP" = 138)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Disable = 1 ,/obj/Moves/Supersonic = 1,/obj/Moves/Foresight = 1,/obj/Moves/Confusion = 17,/obj/Moves/PoisonPowder = 20,/obj/Moves/Leech_Life = 25,/obj/Moves/Stun_Spore = 28,/obj/Moves/Psybeam = 36,/obj/Moves/SleepPowder = 42,/obj/Moves/Psychic = 52,/obj/Moves/Gust = 31,/obj/Moves/Silver_Wind = 1)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Screech,/obj/Moves/Giga_Drain,/obj/Moves/Signal_Beam)
		Weight = 27.6
		Unevolve = /mob/Pokemon/Venonat
		Cry = '049.WAV'
		Abilities = list("Shield Dust","Tinted Lens","Wonder Skin")
	Diglett
		icon = '050Diglett.dmi'
		Gender = 50
		Number = 50
		POKEIMAGE = '50.png'
		Type1 = "Ground"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 26" = /mob/Pokemon/Dugtrio)
		CaptureRate = 255
		BaseStats = list("HP" = 10, "ATK" = 55, "DEF" = 25, "SPL ATK" = 35, "SPL DEF" = 45, "SPD" = 95, "EXP" = 81)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Growl = 5 ,/obj/Moves/Magnitude = 9,/obj/HMs/Dig = 17,/obj/Moves/Sand_Attack = 1,/obj/Moves/Slash = 33,/obj/Moves/Earthquake = 41,/obj/Moves/Fissure = 49,/obj/Moves/Fury_Swipes = 21,/obj/Moves/Mud_Slap = 25)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Beat_Up,/obj/Moves/Faint_Attack,/obj/Moves/Pursuit,/obj/Moves/Screech,/obj/Moves/Rock_Slide,/obj/Moves/Uproar)
		Weight = 1.8
		Cry = '050.WAV'
		Abilities = list("Sand Veil","Arena Trap","Sand Force")
	Dugtrio
		icon = '051Dugtrio.dmi'
		Type1 = "Ground"
		GrowthRate = "Medium-Fast"
		Gender = 50
		Number = 51
		POKEIMAGE = '51.png'
		CaptureRate = 50
		BaseStats = list("HP" = 35, "ATK" = 80, "DEF" = 50, "SPL ATK" = 50, "SPL DEF" = 70, "SPD" = 120, "EXP" = 153)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Growl = 1 ,/obj/Moves/Magnitude = 9,/obj/HMs/Dig = 17,/obj/Moves/Sand_Attack = 1,/obj/Moves/Slash = 37,/obj/Moves/Earthquake = 51,/obj/Moves/Fissure = 64,/obj/Moves/Tri_Attack = 1,/obj/Moves/Fury_Swipes = 21,/obj/Moves/Mud_Slap = 25,/obj/Moves/Sand_Tomb = 26)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Beat_Up,/obj/Moves/Faint_Attack,/obj/Moves/Pursuit,/obj/Moves/Screech,/obj/Moves/Rock_Slide,/obj/Moves/Uproar)
		Weight = 73.4
		Unevolve = /mob/Pokemon/Diglett
		Cry = '051.WAV'
		Abilities = list("Sand Veil","Arena Trap","Sand Force")
	Meowth
		icon = '052Meowth.dmi'
		Gender = 50
		Number = 52
		POKEIMAGE = '52.png'
		CaptureRate = 255
		Type1 = "Normal"
		GrowthRate = "Medium-Fast" // 1000000
		Evolve = list("Level 28" = /mob/Pokemon/Persian)
		BaseStats = list("HP" = 40, "ATK" = 45, "DEF" = 35, "SPL ATK" = 40, "SPL DEF" = 40, "SPD" = 40, "EXP" = 90)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Growl = 1 ,/obj/Moves/Bite = 11,/obj/Moves/Fury_Swipes = 41,/obj/Moves/Screech = 35,/obj/Moves/Pay_Day = 20,/obj/Moves/Slash = 46,/obj/Moves/Faint_Attack = 28,/obj/Moves/Fake_Out = 50,/obj/Moves/Swagger = 45)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Charm,/obj/Moves/Hypnosis,/obj/Moves/Spite,/obj/Moves/Assist,/obj/Moves/Psych_Up)
		Weight = 9.3
		Cry = '052.WAV'
		Abilities = list("Pickup","Technician","Unnerve")
	Persian
		icon = '053Persian.dmi'
		Gender = 50
		CaptureRate = 90
		Type1 = "Normal"
		GrowthRate = "Medium-Fast" // 1000000
		BaseStats = list("HP" = 65, "ATK" = 70, "DEF" = 60, "SPL ATK" = 65, "SPL DEF" = 65, "SPD" = 115, "EXP" = 148)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Growl = 1 ,/obj/Moves/Bite = 1,/obj/Moves/Fury_Swipes = 46,/obj/Moves/Screech = 38,/obj/Moves/Slash = 53,/obj/Moves/Pay_Day = 20,/obj/Moves/Faint_Attack = 29,/obj/Moves/Fake_Out = 59,/obj/Moves/Swagger = 61)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Charm,/obj/Moves/Hypnosis,/obj/Moves/Spite,/obj/Moves/Assist,/obj/Moves/Psych_Up)
		Weight = 70.5
		Number = 53
		POKEIMAGE = '53.png'
		Unevolve = /mob/Pokemon/Meowth
		Cry = '053.WAV'
		Abilities = list("Limber","Technician","Unnerve")
	Psyduck
		icon = '054Psyduck.dmi'
		GrowthRate = "Medium-Fast"
		Type1 = "Water"
		Gender = 50
		CaptureRate = 190
		Evolve = list("Level 33" = /mob/Pokemon/Golduck)
		BaseStats = list("HP" = 50, "ATK" = 52, "DEF" = 48, "SPL ATK" = 65, "SPL DEF" = 50, "SPD" = 55, "EXP" = 80)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Tail_Whip = 5 ,/obj/Moves/Disable = 10,/obj/Moves/Confusion = 16,/obj/Moves/Screech = 23,/obj/Moves/Fury_Swipes = 40,/obj/Moves/Hydro_Pump = 50,/obj/Moves/Psych_Up = 31,/obj/Moves/Water_Sport = 1)
		EggGroups = list ("Field","Water 1")
		EggMoves = list(/obj/Moves/Cross_Chop,/obj/Moves/Foresight,/obj/Moves/Future_Sight,/obj/Moves/Hypnosis,/obj/Moves/Light_Screen,/obj/Moves/Psybeam,/obj/Moves/Psychic)
		Weight = 43.2
		Number = 54
		POKEIMAGE = '54.png'
		Cry = '054.WAV'
		Abilities = list("Damp","Cloud Nine","Swift Swim")
	Golduck
		icon = '055Golduck.dmi'
		GrowthRate = "Medium-Fast"
		Type1 = "Water"
		Gender = 50
		CaptureRate = 75
		BaseStats = list("HP" = 80, "ATK" = 82, "DEF" = 78, "SPL ATK" = 95, "SPL DEF" = 80, "SPD" = 85, "EXP" = 174)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Tail_Whip = 1 ,/obj/Moves/Disable = 1,/obj/Moves/Confusion = 1,/obj/Moves/Screech = 23,/obj/Moves/Fury_Swipes = 44,/obj/Moves/Hydro_Pump = 58,/obj/Moves/Psych_Up = 31,/obj/Moves/Water_Sport = 1)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Cross_Chop,/obj/Moves/Foresight,/obj/Moves/Future_Sight,/obj/Moves/Hypnosis,/obj/Moves/Light_Screen,/obj/Moves/Psybeam,/obj/Moves/Psychic)
		Weight = 168.9
		Number = 55
		POKEIMAGE = '55.png'
		Unevolve = /mob/Pokemon/Psyduck
		Cry = '055.WAV'
		Abilities = list("Damp","Cloud Nine","Swift Swim")
	Mankey
		icon = '056Mankey.dmi'
		GrowthRate = "Medium-Fast"
		Type1 = "Fighting"
		Gender = 50
		CaptureRate = 190
		Evolve = list("Level 28" = /mob/Pokemon/Primeape)
		BaseStats = list("HP" = 40, "ATK" = 80, "DEF" = 35, "SPL ATK" = 35, "SPL DEF" = 45, "SPD" = 70, "EXP" = 74)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Leer = 1,/obj/Moves/Low_Kick = 9,/obj/Moves/Karate_Chop = 15,/obj/Moves/Fury_Swipes = 21,/obj/Moves/Focus_Energy = 27,/obj/Moves/Seismic_Toss = 33, /obj/Moves/Cross_Chop = 39, /obj/Moves/Screech = 45,/obj/Moves/Thrash = 51)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Foresight,/obj/Moves/Meditate,/obj/Moves/Reversal,/obj/Moves/Rock_Slide,/obj/Moves/Beat_Up,/obj/Moves/Revenge,/obj/Moves/SmellingSalt)
		Weight = 67.1
		Number = 56
		POKEIMAGE = '56.png'
		Cry = '056.WAV'
		Abilities = list("Vital Spirit","Anger Point","Defiant")
	Primeape
		icon = '057Primeape.dmi'
		GrowthRate = "Medium-Fast"
		Type1 = "Fighting"
		Gender = 50
		CaptureRate = 75
		BaseStats = list("HP" = 65, "ATK" = 105, "DEF" = 60, "SPL ATK" = 60, "SPL DEF" = 70, "SPD" = 95, "EXP" = 149)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Leer = 1,/obj/Moves/Low_Kick = 1, /obj/Moves/Karate_Chop = 15,/obj/Moves/Fury_Swipes = 21,/obj/Moves/Focus_Energy = 27,/obj/Moves/Rage = 28,/obj/Moves/Seismic_Toss = 36,/obj/Moves/Cross_Chop = 45,/obj/Moves/Screech = 54,/obj/Moves/Thrash = 63)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Foresight,/obj/Moves/Meditate,/obj/Moves/Reversal,/obj/Moves/Rock_Slide,/obj/Moves/Beat_Up,/obj/Moves/Revenge,/obj/Moves/SmellingSalt)
		Weight = 70.5
		Number = 57
		POKEIMAGE = '57.png'
		Unevolve = /mob/Pokemon/Mankey
		Cry = '057.WAV'
		Abilities = list("Vital Spirit","Anger Point","Defiant")
	Growlithe
		icon = '058Growlithe.dmi'
		Gender = 75
		CaptureRate = 190
		Type1 = "Fire"
		Evolve = list("Firestone" = /mob/Pokemon/Arcanine)
		GrowthRate = "Slow"
		BaseStats = list("HP" = 50, "ATK" = 70, "DEF" = 45, "SPL ATK" = 70, "SPL DEF" = 50, "SPD" = 70, "EXP" = 91)
		LearnMoves = list(/obj/Moves/Bite = 1, /obj/Moves/Roar = 1, /obj/Moves/Ember = 7, /obj/Moves/Leer = 13 ,/obj/Moves/Take_Down = 25,/obj/Moves/Agility = 43,/obj/Moves/Flamethrower = 49,/obj/Moves/Flame_Wheel = 31,/obj/Moves/Odor_Sleuth = 19)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Crunch,/obj/Moves/Fire_Spin,/obj/Moves/Safeguard,/obj/Moves/Thrash,/obj/Moves/Heat_Wave,/obj/Moves/Howl)
		Weight = 41.9
		Number = 58
		POKEIMAGE = '58.png'
		Cry = '058.WAV'
		Abilities = list("Intimidate","Flash Fire","Justified")
	Arcanine
		icon = '059Arcanine.dmi'
		Gender = 75
		Type1 = "Fire"
		GrowthRate = "Slow"
		CaptureRate = 75
		BaseStats = list("HP" = 90, "ATK" = 110, "DEF" = 80, "SPL ATK" = 100, "SPL DEF" = 80, "SPD" =95, "EXP" = 213)
		LearnMoves = list(/obj/Moves/Roar = 1, /obj/Moves/Ember = 1, /obj/Moves/Bite = 1 ,/obj/Moves/Odor_Sleuth = 1,/obj/Moves/Extremespeed = 49)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Crunch,/obj/Moves/Fire_Spin,/obj/Moves/Safeguard,/obj/Moves/Thrash,/obj/Moves/Heat_Wave,/obj/Moves/Howl)
		Weight = 341.7
		Number = 59
		POKEIMAGE = '59.png'
		Unevolve = /mob/Pokemon/Growlithe
		Cry = '059.WAV'
		Abilities = list("Intimidate","Flash Fire","Justified")
	Poliwag
		icon = '060Poliwag.dmi'
		Gender = 50
		Type1 = "Water"
		GrowthRate = "Medium-Slow"//1,059,860
		Evolve = list("Level 25" = /mob/Pokemon/Poliwhirl)
		CaptureRate = 255
		BaseStats = list("HP" = 40, "ATK" = 50, "DEF" = 40, "SPL ATK" = 40, "SPL DEF" = 40, "SPD" = 90, "EXP" = 77)
		LearnMoves = list(/obj/Moves/Bubble = 1, /obj/Moves/Hypnosis = 7, /obj/Moves/Water_Gun = 13, /obj/Moves/DoubleSlap = 19 ,/obj/Moves/Body_Slam = 31,/obj/Moves/Belly_Drum = 38,/obj/Moves/Rain_Dance = 25,/obj/Moves/Hydro_Pump = 43)
		EggGroups = list("Water 1")
		EggMoves = list(/obj/Moves/Bubblebeam,/obj/Moves/Haze,/obj/Moves/Mind_Reader,/obj/Moves/Splash,/obj/Moves/Mist,/obj/Moves/Ice_Ball,/obj/Moves/Water_Sport)
		Weight = 27.3
		Number = 60
		POKEIMAGE = '60.png'
		Cry = '060.WAV'
		Abilities = list("Water Absorb","Damp","Swift Swim")
	Poliwhirl
		icon = '061Poliwhirl.dmi'
		Gender = 50
		CaptureRate = 120
		Type1 = "Water"
		GrowthRate = "Medium-Slow"//1,059,860
		Evolve = list("Waterstone" = /mob/Pokemon/Poliwrath,"Trade" = /mob/Pokemon/Politoed,"TradeItem" = /obj/HeldItems/Evolution/Kings_Rock)
		BaseStats = list("HP" = 65, "ATK" = 65, "DEF" = 65, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 90, "EXP" = 131)
		LearnMoves = list(/obj/Moves/Bubble = 1, /obj/Moves/Hypnosis = 1, /obj/Moves/Water_Gun = 11, /obj/Moves/DoubleSlap = 19 ,/obj/Moves/Body_Slam = 35,/obj/Moves/Belly_Drum = 43,/obj/Moves/Hydro_Pump = 51,/obj/Moves/Water_Sport = 25)
		EggGroups = list("Water 1")
		EggMoves = list(/obj/Moves/Bubblebeam,/obj/Moves/Haze,/obj/Moves/Mind_Reader,/obj/Moves/Splash,/obj/Moves/Mist,/obj/Moves/Ice_Ball,/obj/Moves/Water_Sport)
		Weight = 44.1
		Number = 61
		POKEIMAGE = '61.png'
		Unevolve = /mob/Pokemon/Poliwag
		Cry = '061.WAV'
		Abilities = list("Water Absorb","Damp","Swift Swim")
	Poliwrath
		icon = '062Poliwrath.dmi'
		Gender = 50
		CaptureRate = 45
		Type1 = "Water"
		Type2 = "Fighting"
		Number = 62
		POKEIMAGE = '62.png'
		GrowthRate = "Medium-Slow"//1,059,860
		BaseStats = list("HP" = 90, "ATK" = 85, "DEF" = 95, "SPL ATK" = 70, "SPL DEF" = 90, "SPD" = 75, "EXP" = 185)
		LearnMoves = list(/obj/Moves/Water_Gun = 1, /obj/Moves/DoubleSlap = 1, /obj/Moves/Hypnosis = 1, /obj/Moves/Submission = 35 ,/obj/Moves/Mind_Reader = 51)
		EggGroups = list("Water 1")
		EggMoves = list(/obj/Moves/Bubblebeam,/obj/Moves/Haze,/obj/Moves/Mind_Reader,/obj/Moves/Splash,/obj/Moves/Mist,/obj/Moves/Ice_Ball,/obj/Moves/Water_Sport)
		Weight = 119.0
		Unevolve = /mob/Pokemon/Poliwhirl
		Cry = '062.WAV'
		Abilities = list("Water Absorb","Damp","Swift Swim")
	Abra
		icon = '063Abra.dmi'
		GrowthRate = "Medium-Slow"
		Type1 = "Psychic"
		Evolve = list("Level 16" = /mob/Pokemon/Kadabra)
		Gender = 75
		Number = 63
		POKEIMAGE = '63.png'
		CaptureRate = 200
		BaseStats = list("HP" = 25, "ATK" = 20, "DEF" = 15, "SPL ATK" = 105, "SPL DEF" = 55, "SPD" = 90, "EXP" = 73)
		LearnMoves = list(/obj/HMs/Teleport = 1)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Encore,/obj/Moves/Fire_Punch,/obj/Moves/Ice_Punch,/obj/Moves/Thunder_Punch,/obj/Moves/Knock_Off)
		Weight = 43.0
		Cry = '063.WAV'
		Abilities = list("Synchronize","Inner Focus","Magic Guard")
	Kadabra
		icon = '064Kadabra.dmi'
		Gender = 75
		GrowthRate = "Medium-Slow"
		Type1 = "Psychic"
		CaptureRate = 100
		Evolve = list("Trade" = /mob/Pokemon/Alakazam)
		BaseStats = list("HP" = 40, "ATK" = 35, "DEF" = 30, "SPL ATK" = 120, "SPL DEF" = 70, "SPD" = 105, "EXP" = 145)
		LearnMoves = list(/obj/HMs/Teleport = 1,/obj/Moves/Kinesis = 1,/obj/Moves/Confusion = 16,/obj/Moves/Disable = 18,/obj/Moves/Psybeam = 21,/obj/Moves/Recover = 25,/obj/Moves/Future_Sight = 30, /obj/Moves/Psychic = 36,/obj/Moves/Reflect = 23,/obj/Moves/Role_Play = 33,/obj/Moves/Trick = 43)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Encore,/obj/Moves/Fire_Punch,/obj/Moves/Ice_Punch,/obj/Moves/Thunder_Punch,/obj/Moves/Knock_Off)
		Weight = 124.6
		Number = 64
		POKEIMAGE = '64.png'
		Unevolve = /mob/Pokemon/Abra
		Cry = '064.WAV'
		Abilities = list("Synchronize","Inner Focus","Magic Guard")
	Alakazam
		icon = '065Alakazam.dmi'
		Gender = 75
		GrowthRate = "Medium-Slow"
		Type1 = "Psychic"
		CaptureRate = 50
		BaseStats = list("HP" = 55, "ATK" = 50, "DEF" = 45, "SPL ATK" = 135, "SPL DEF" = 85, "SPD" = 120, "EXP" = 186)
		LearnMoves = list(/obj/HMs/Teleport = 1,/obj/Moves/Kinesis = 1,/obj/Moves/Confusion = 16,/obj/Moves/Disable = 18,/obj/Moves/Psybeam = 21,/obj/Moves/Recover = 25,/obj/Moves/Future_Sight = 30, /obj/Moves/Psychic = 36,/obj/Moves/Reflect = 23,/obj/Moves/Role_Play = 33,/obj/Moves/Trick = 43)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Encore,/obj/Moves/Fire_Punch,/obj/Moves/Ice_Punch,/obj/Moves/Thunder_Punch,/obj/Moves/Knock_Off)
		Weight = 105.8
		Number = 65
		POKEIMAGE = '65.png'
		Unevolve = /mob/Pokemon/Kadabra
		Cry = '065.WAV'
		Abilities = list("Synchronize","Inner Focus","Magic Guard")
	Machop
		icon = '066Machop.dmi'
		Type1 = "Fighting"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 28" = /mob/Pokemon/Machoke)
		Gender = 75
		Number = 66
		POKEIMAGE = '66.png'
		CaptureRate = 255
		BaseStats = list("HP" = 70, "ATK" = 80, "DEF" = 50, "SPL ATK" = 35, "SPL DEF" = 35, "SPD" = 35, "EXP" = 75)
		LearnMoves = list(/obj/Moves/Low_Kick = 1,/obj/Moves/Leer = 1,/obj/Moves/Focus_Energy = 7,/obj/Moves/Karate_Chop = 13,/obj/Moves/Seismic_Toss = 19,/obj/Moves/Foresight = 22,/obj/Moves/Vital_Throw = 31,/obj/Moves/Cross_Chop = 40, /obj/Moves/Scary_Face = 43,/obj/Moves/Submission = 37,/obj/Moves/DynamicPunch = 49)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Light_Screen,/obj/Moves/Meditate,/obj/Moves/Rolling_Kick,/obj/Moves/SmellingSalt)
		Weight = 43.0
		Cry = '066.WAV'
		Abilities = list("Guts","Steadfast")
	Machoke
		icon = '067Machoke.dmi'
		Type1 = "Fighting"
		GrowthRate = "Medium-Slow"
		Gender = 75
		Evolve = list("Trade" = /mob/Pokemon/Machamp)
		CaptureRate = 120
		BaseStats = list("HP" = 80, "ATK" = 100, "DEF" = 70, "SPL ATK" = 50, "SPL DEF" = 60, "SPD" = 45, "EXP" = 146)
		LearnMoves = list(/obj/Moves/Low_Kick = 1,/obj/Moves/Leer = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Karate_Chop = 13,/obj/Moves/Seismic_Toss = 19,/obj/Moves/Foresight = 22,/obj/Moves/Vital_Throw = 33,/obj/Moves/Cross_Chop = 46,/obj/Moves/Scary_Face = 51,/obj/Moves/Submission = 41,/obj/Moves/Revenge = 25,/obj/Moves/DynamicPunch = 59)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Light_Screen,/obj/Moves/Meditate,/obj/Moves/Rolling_Kick,/obj/Moves/SmellingSalt)
		Weight = 155.4
		Number = 67
		POKEIMAGE = '67.png'
		Unevolve = /mob/Pokemon/Machop
		Cry = '067.WAV'
		Abilities = list("Guts","Steadfast")
	Machamp
		icon = '068Machamp.dmi'
		Type1 = "Fighting"
		GrowthRate = "Medium-Slow"
		Gender = 75
		CaptureRate = 45
		BaseStats = list("HP" = 90, "ATK" = 130, "DEF" = 80, "SPL ATK" = 65, "SPL DEF" = 85, "SPD" = 75, "EXP" = 193)
		LearnMoves = list(/obj/Moves/Low_Kick = 1,/obj/Moves/Leer = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Karate_Chop = 13,/obj/Moves/Seismic_Toss = 19,/obj/Moves/Foresight = 22,/obj/Moves/Vital_Throw = 33,/obj/Moves/Cross_Chop = 46,/obj/Moves/Scary_Face = 51,/obj/Moves/Submission = 41,/obj/Moves/Revenge = 25,/obj/Moves/DynamicPunch = 59)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Light_Screen,/obj/Moves/Meditate,/obj/Moves/Rolling_Kick,/obj/Moves/SmellingSalt)
		Weight = 286.6
		Number = 68
		POKEIMAGE = '68.png'
		Unevolve = /mob/Pokemon/Machoke
		Cry = '068.WAV'
		Abilities = list("Guts","Steadfast")
	Bellsprout
		icon = '069Bellsprout.dmi'
		Type1 = "Grass"
		Type2 = "Poison"
		Evolve = list("Level 21" = /mob/Pokemon/Weepinbell)
		GrowthRate = "Medium-Slow"
		Gender = 50
		CaptureRate = 255
		BaseStats = list("HP" = 60, "ATK" = 75, "DEF" = 35, "SPL ATK" = 70, "SPL DEF" = 30, "SPD" = 40, "EXP" = 84)
		LearnMoves = list(/obj/Moves/Vine_Whip = 1,/obj/Moves/Growth = 6,/obj/Moves/Wrap = 11,/obj/Moves/SleepPowder = 15,/obj/Moves/PoisonPowder = 17,/obj/Moves/Stun_Spore = 19,/obj/Moves/Acid= 23,/obj/Moves/Sweet_Scent = 30, /obj/Moves/Razor_Leaf = 37,/obj/Moves/Slam = 45)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Encore,/obj/Moves/Leech_Life,/obj/Moves/Reflect,/obj/Moves/Swords_Dance,/obj/Moves/Synthesis,/obj/Moves/Ingrain,/obj/Moves/Magical_Leaf)
		Number = 69
		POKEIMAGE = '69.png'
		Weight = 8.8
		Cry = '069.WAV'
		Abilities = list("Chlorophyll","Gluttony")
	Weepinbell
		icon = '070Weepinbell.dmi'
		Type1 = "Grass"
		Type2 = "Poison"
		Evolve = list("Leafstone" = /mob/Pokemon/Victreebel)
		GrowthRate = "Medium-Slow"
		Gender = 50
		CaptureRate = 120
		BaseStats = list("HP" = 65, "ATK" = 90, "DEF" = 50, "SPL ATK" = 85, "SPL DEF" = 45, "SPD" = 55, "EXP" = 151)
		LearnMoves = list(/obj/Moves/Vine_Whip = 1,/obj/Moves/Growth = 1,/obj/Moves/Wrap = 11,/obj/Moves/SleepPowder = 15,/obj/Moves/PoisonPowder = 17,/obj/Moves/Stun_Spore = 19,/obj/Moves/Acid= 24,/obj/Moves/Sweet_Scent = 33, /obj/Moves/Razor_Leaf = 42,/obj/Moves/Slam = 54)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Encore,/obj/Moves/Leech_Life,/obj/Moves/Reflect,/obj/Moves/Swords_Dance,/obj/Moves/Synthesis,/obj/Moves/Ingrain,/obj/Moves/Magical_Leaf)
		Number = 70
		POKEIMAGE = '70.png'
		Weight = 14.1
		Unevolve = /mob/Pokemon/Bellsprout
		Cry = '070.WAV'
		Abilities = list("Chlorophyll","Gluttony")
	Victreebel
		icon = '071Victreebel.dmi'
		Gender = 50
		Type1 = "Grass"
		Type2 = "Poison"
		GrowthRate = "Medium-Slow"
		CaptureRate = 45
		BaseStats = list("HP" = 80, "ATK" = 105, "DEF" = 65, "SPL ATK" = 100, "SPL DEF" = 60, "SPD" = 70, "EXP" = 191)
		LearnMoves = list(/obj/Moves/Vine_Whip = 1,/obj/Moves/Growth = 1,/obj/Moves/Wrap = 1,/obj/Moves/SleepPowder = 1,/obj/Moves/PoisonPowder = 1,/obj/Moves/Stun_Spore = 1,/obj/Moves/Acid= 1)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Encore,/obj/Moves/Leech_Life,/obj/Moves/Reflect,/obj/Moves/Swords_Dance,/obj/Moves/Synthesis,/obj/Moves/Ingrain,/obj/Moves/Magical_Leaf)
		Number = 71
		POKEIMAGE = '71.png'
		Weight = 34.2
		Unevolve = /mob/Pokemon/Weepinbell
		Cry = '071.WAV'
		Abilities = list("Chlorophyll","Gluttony")
	Tentacool
		icon = '072Tentacool.dmi'
		Gender = 50
		Type1 = "Water"
		Type2 = "Poison"
		GrowthRate = "Slow"
		Evolve = list("Level 30" = /mob/Pokemon/Tentacruel)
		CaptureRate = 190
		BaseStats = list("HP" = 40, "ATK" = 40, "DEF" = 35, "SPL ATK" = 50, "SPL DEF" = 100, "SPD" = 70, "EXP" = 105)
		LearnMoves = list(/obj/Moves/Poison_Sting = 1,/obj/Moves/Supersonic = 6,/obj/Moves/Constrict = 12,/obj/Moves/Acid = 19,/obj/Moves/Bubblebeam = 25,/obj/Moves/Wrap = 30,/obj/Moves/Barrier = 36,/obj/Moves/Screech = 43,,/obj/Moves/Hydro_Pump = 49)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Haze,/obj/Moves/Mirror_Coat,/obj/Moves/Rapid_Spin,/obj/Moves/Safeguard,/obj/Moves/Confuse_Ray)
		Number = 72
		POKEIMAGE = '72.png'
		Weight = 100.3
		Cry = '072.WAV'
		Abilities = list("Clear Body","Liquid Ooze","Rain Dash")

	Tentacruel
		icon = '073Tentacruel.dmi'
		Gender = 50
		Type1 = "Water"
		Type2 = "Poison"
		GrowthRate = "Slow"
		CaptureRate = 60
		BaseStats = list("HP" = 80, "ATK" = 70, "DEF" = 65, "SPL ATK" = 80, "SPL DEF" = 120, "SPD" = 101, "EXP" = 205)
		LearnMoves = list(/obj/Moves/Poison_Sting = 1,/obj/Moves/Supersonic = 6,/obj/Moves/Constrict = 12,/obj/Moves/Acid = 19,/obj/Moves/Bubblebeam = 25,/obj/Moves/Wrap = 30,/obj/Moves/Barrier = 36,/obj/Moves/Screech = 43,,/obj/Moves/Hydro_Pump = 49)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Haze,/obj/Moves/Mirror_Coat,/obj/Moves/Rapid_Spin,/obj/Moves/Safeguard,/obj/Moves/Confuse_Ray)
		Number = 73
		POKEIMAGE = '73.png'
		Weight = 121.3
		Unevolve = /mob/Pokemon/Tentacool
		Cry = '073.WAV'
		Abilities = list("Clear Body","Liquid Ooze","Rain Dash")
	Geodude
		icon = '074Geodude.dmi'
		Gender = 50
		Type1 = "Rock"
		Type2 = "Ground"
		GrowthRate = "Medium-Slow" //1,059,860
		Evolve = list("Level 25" = /mob/Pokemon/Graveler)
		CaptureRate = 255
		BaseStats = list("HP" = 40, "ATK" = 80, "DEF" = 100, "SPL ATK" = 30, "SPL DEF" = 30, "SPD" = 20, "EXP" = 86)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Defense_Curl = 1, /obj/Moves/Rock_Throw = 11, /obj/Moves/Magnitude = 16 ,/obj/Moves/Selfdestruct = 21,/obj/Moves/Rollout = 26,/obj/Moves/Earthquake = 36,/obj/Moves/Explosion = 41,/obj/Moves/Rock_Blast = 31,/obj/Moves/Double_Edge = 46,/obj/Moves/Mud_Sport = 6)
		EggGroups = list("Mineral")
		EggMoves = list(/obj/Moves/Mega_Punch,/obj/Moves/Rock_Slide,/obj/Moves/Block)
		Number = 74
		POKEIMAGE = '74.png'
		Weight = 44.1
		Cry = '074.WAV'
		Abilities = list("Rock Head","Sand Veil")

	Graveler
		icon = '075Graveler.dmi'
		Gender = 50
		Type1 = "Rock"
		Type2 = "Ground"
		GrowthRate = "Medium-Slow" //1,059,860
		Evolve = list("Trade" = /mob/Pokemon/Golem)
		CaptureRate = 120
		BaseStats = list("HP" = 55, "ATK" = 95, "DEF" = 115, "SPL ATK" = 45, "SPL DEF" = 45, "SPD" = 40, "EXP" = 134)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Defense_Curl = 1, /obj/Moves/Rock_Throw = 11, /obj/Moves/Magnitude = 16 ,/obj/Moves/Selfdestruct = 21,/obj/Moves/Rollout = 29,/obj/Moves/Earthquake = 45,/obj/Moves/Explosion = 53,/obj/Moves/Mud_Sport = 6,/obj/Moves/Rock_Blast = 37,/obj/Moves/Double_Edge = 62)
		EggGroups = list("Mineral")
		EggMoves = list(/obj/Moves/Mega_Punch,/obj/Moves/Rock_Slide,/obj/Moves/Block)
		Number = 75
		POKEIMAGE = '75.png'
		Weight = 231.5
		Unevolve = /mob/Pokemon/Geodude
		Cry = '075.WAV'
		Abilities = list("Rock Head","Sand Veil")
	Golem
		icon = '076Golem.dmi'
		Gender = 50
		CaptureRate = 45
		Type1 = "Rock"
		Type2 = "Ground"
		GrowthRate = "Medium-Slow" //1,059,860
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Defense_Curl = 1, /obj/Moves/Rock_Throw = 11, /obj/Moves/Magnitude = 16 ,/obj/Moves/Selfdestruct = 21,/obj/Moves/Rollout = 29,/obj/Moves/Earthquake = 45,/obj/Moves/Explosion = 53,/obj/Moves/Mud_Sport = 6,/obj/Moves/Rock_Blast = 37,/obj/Moves/Double_Edge = 62)
		BaseStats = list("HP" = 80, "ATK" = 110, "DEF" = 130, "SPL ATK" = 55, "SPL DEF" = 65, "SPD" = 45, "EXP" = 177)
		EggGroups = list("Mineral")
		EggMoves = list(/obj/Moves/Mega_Punch,/obj/Moves/Rock_Slide,/obj/Moves/Block)
		Number = 76
		POKEIMAGE = '76.png'
		Weight = 661.4
		Unevolve = /mob/Pokemon/Graveler
		Cry = '076.WAV'
		Abilities = list("Rock Head","Sand Veil")
	Ponyta
		icon = '077Ponyta.dmi'
		CaptureRate = 190
		Gender = 50
		Type1 = "Fire"
		GrowthRate = "Medium-Fast" //1,059,860
		Evolve = list("Level 40" = /mob/Pokemon/Rapidash)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 5, /obj/Moves/Tail_Whip = 9, /obj/Moves/Ember = 14 ,/obj/Moves/Stomp = 19,/obj/Moves/Fire_Spin = 25,/obj/Moves/Take_Down = 31,/obj/Moves/Agility = 38,/obj/Moves/Fire_Blast = 53,/obj/Moves/Quick_Attack = 1,/obj/Moves/Bounce = 45)
		BaseStats = list("HP" = 50, "ATK" = 85, "DEF" = 55, "SPL ATK" = 65, "SPL DEF" = 65, "SPD" = 90, "EXP" = 152)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Double_Kick,/obj/Moves/Flame_Wheel,/obj/Moves/Hypnosis,/obj/Moves/Double_Edge,/obj/Moves/Thrash)
		Number = 77
		POKEIMAGE = '77.png'
		Weight = 66.1
		Cry = '077.WAV'
		Abilities = list("Run Away","Flash Fire","Flame Body")

	Rapidash
		icon = '078Rapidash.dmi'
		CaptureRate = 60
		Gender = 50
		Type1 = "Fire"
		GrowthRate = "Medium-Fast" //1,059,860
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 1, /obj/Moves/Tail_Whip = 1, /obj/Moves/Ember = 1 ,/obj/Moves/Stomp = 19,/obj/Moves/Fire_Spin = 25,/obj/Moves/Take_Down = 34,/obj/Moves/Fury_Attack = 40,/obj/Moves/Agility = 38,/obj/Moves/Fire_Blast = 63,/obj/Moves/Quick_Attack = 1,/obj/Moves/Bounce = 50)
		BaseStats = list("HP" = 65, "ATK" = 100, "DEF" = 70, "SPL ATK" = 80, "SPL DEF" = 80, "SPD" = 105, "EXP" = 192)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Double_Kick,/obj/Moves/Flame_Wheel,/obj/Moves/Hypnosis,/obj/Moves/Double_Edge,/obj/Moves/Thrash)
		Number = 78
		POKEIMAGE = '78.png'
		Weight = 209.4
		Unevolve = /mob/Pokemon/Ponyta
		Cry = '078.WAV'
		Abilities = list("Run Away","Flash Fire","Flame Body")
	Slowpoke
		icon = '079Slowpoke.dmi'
		CaptureRate = 190
		Type1 = "Water"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 1" = /mob/Pokemon/Slowbro, "Trade" = /mob/Pokemon/Slowking, "LevelPokemon" = /mob/Pokemon/Shellder, "TradeItem" = /obj/HeldItems/Evolution/Kings_Rock) //When Traded, they must have the "TradeItem" in order to evolve
		Gender = 50
		LearnMoves = list(/obj/Moves/Curse = 1, /obj/Moves/Tackle = 1, /obj/Moves/Growl = 6, /obj/Moves/Water_Gun = 15 ,/obj/Moves/Confusion = 20,/obj/Moves/Disable = 29,/obj/Moves/Headbutt = 34,/obj/Moves/Amnesia = 43,/obj/Moves/Psychic = 53,/obj/Moves/Yawn = 1,/obj/Moves/Psych_Up = 47)
		BaseStats = list("HP" = 90, "ATK" = 65, "DEF" = 65, "SPL ATK" = 40, "SPL DEF" = 40, "SPD" = 15, "EXP" = 99)
		EggGroups = list("Monster", "Water 1")
		EggMoves = list(/obj/Moves/Belly_Drum,/obj/Moves/Future_Sight,/obj/Moves/Mud_Sport,/obj/Moves/Sleep_Talk,/obj/Moves/Snore)
		Number = 79
		POKEIMAGE = '79.png'
		Weight = 79.4
		Cry = '079.WAV'
		Abilities = list("Oblivious","Own Tempo","Regenerator")

	Slowbro
		icon = '080Slowbro.dmi'
		CaptureRate = 75
		Gender = 50
		Type1 = "Water"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		LearnMoves = list(/obj/Moves/Curse = 1, /obj/Moves/Tackle = 1, /obj/Moves/Growl = 6, /obj/Moves/Water_Gun = 15 ,/obj/Moves/Confusion = 20,/obj/Moves/Disable = 29,/obj/Moves/Headbutt = 34,/obj/Moves/Amnesia = 43,/obj/Moves/Psychic = 53,/obj/Moves/Yawn = 1,/obj/Moves/Psych_Up = 47)
		BaseStats = list("HP" = 95, "ATK" = 75, "DEF" = 110, "SPL ATK" = 100, "SPL DEF" = 80, "SPD" = 30, "EXP" = 164)
		EggGroups = list("Monster", "Water 1")
		EggMoves = list(/obj/Moves/Belly_Drum,/obj/Moves/Future_Sight,/obj/Moves/Mud_Sport,/obj/Moves/Sleep_Talk,/obj/Moves/Snore)
		Number = 80
		POKEIMAGE = '80.png'
		Weight = 173.1
		Unevolve = /mob/Pokemon/Slowpoke
		Cry = '080.WAV'
		Abilities = list("Oblivious","Own Tempo","Regenerator")

	Magnemite
		icon = '081Magnemite.dmi'
		CaptureRate = 190
		Gender = "Genderless"
		Type1 = "Electric"
		Type2 = "Steel"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 30" = /mob/Pokemon/Magneton)
		BaseStats = list("HP" = 25, "ATK" = 35, "DEF" = 70, "SPL ATK" = 95, "SPL DEF" = 55, "SPD" = 45, "EXP" = 89)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Thundershock = 6,/obj/Moves/Supersonic = 11,/obj/Moves/Sonicboom = 16,/obj/Moves/Thunder_Wave = 21,/obj/Moves/Lock_On = 32,/obj/Moves/Swift = 38,/obj/Moves/Screech = 53,/obj/Moves/Zap_Cannon = 62,/obj/Moves/Metal_Sound = 1,/obj/Moves/Spark = 26)
		EggGroups = list("Mineral")
		Weight = 13.2
		Number = 81
		POKEIMAGE = '81.png'
		Cry = '081.WAV'
		Abilities = list("Magnet Pull","Analytic")
	Magneton
		icon = '082Magneton.dmi'
		CaptureRate = 60
		Gender = "Genderless"
		Type1 = "Electric"
		Type2 = "Steel"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 50, "ATK" = 60, "DEF" = 95, "SPL ATK" = 120, "SPL DEF" = 70, "SPD" = 70, "EXP" = 161)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Thundershock = 1,/obj/Moves/Supersonic = 1,/obj/Moves/Sonicboom = 11,/obj/Moves/Thunder_Wave = 21,/obj/Moves/Lock_On = 35,/obj/Moves/Metal_Sound = 1,/obj/Moves/Tri_Attack = 44,/obj/Moves/Screech = 53,/obj/Moves/Zap_Cannon = 62,/obj/Moves/Spark = 26)
		EggGroups = list("Mineral")
		Weight = 132.3
		Number = 82
		POKEIMAGE = '82.png'
		Unevolve = /mob/Pokemon/Magnemite
		//Cry = '082.WAV'
		Abilities = list("Magnet Pull","Analytic")
	Farfetchd
		icon = '083Farfetchd.dmi'
		Gender = 50
		CaptureRate = 45
		Type1 = "Normal"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 52, "ATK" = 65, "DEF" = 55, "SPL ATK" = 58, "SPL DEF" = 62, "SPD" = 60, "EXP" = 94)
		LearnMoves = list(/obj/Moves/Peck = 1, /obj/Moves/Sand_Attack = 7, /obj/Moves/False_Swipe = 46, /obj/Moves/Leer = 11 ,/obj/Moves/Fury_Attack = 16,/obj/Moves/Slash = 41,/obj/Moves/Swords_Dance = 31,/obj/Moves/Agility = 36,/obj/Moves/Knock_Off = 21,/obj/Moves/Fury_Cutter = 26)
		name = "Farfetch'd"
		EggGroups = list("Flying","Field")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Foresight,/obj/Moves/Gust,/obj/Moves/Mirror_Move,/obj/Moves/Quick_Attack,/obj/Moves/Curse,/obj/Moves/FeatherDance,/obj/Moves/Steel_Wing)
		Weight = 33.1
		Number = 83
		POKEIMAGE = '83.png'
		//Cry = '083.WAV'
		Abilities = list("Keen Eye","Inner Focus","Defiant")
	Doduo
		CaptureRate = 190
		Gender = 50
		icon = '084Doduo.dmi'
		Type1 = "Normal"
		Type2 = "Flying"
		Evolve = list("Level 31" = /mob/Pokemon/Dodrio)
		GrowthRate = "Medium-Fast"
		LearnMoves = list(/obj/Moves/Peck = 1, /obj/Moves/Growl = 1, /obj/Moves/Pursuit = 9,/obj/Moves/Fury_Attack = 13,/obj/Moves/Agility = 45,/obj/Moves/Rage = 25,/obj/Moves/Drill_Peck = 37,/obj/Moves/Tri_Attack = 21,/obj/Moves/Uproar = 33)
		BaseStats = list("HP" = 35, "ATK" = 85, "DEF" = 45, "SPL ATK" = 35, "SPL DEF" = 35, "SPD" = 75, "EXP" = 96)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Flail,/obj/Moves/Haze,/obj/Moves/Quick_Attack,/obj/Moves/Supersonic,/obj/Moves/Endeavor)
		Weight = 86.4
		Number = 84
		POKEIMAGE = '84.png'
		//Cry = '084.WAV'
		Abilities = list("Run Away","Early Bird","Tangled Feet")
	Dodrio
		CaptureRate = 45
		Gender = 50
		icon = '085Dodrio.dmi'
		Type1 = "Normal"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		LearnMoves = list(/obj/Moves/Peck = 1, /obj/Moves/Growl = 1, /obj/Moves/Pursuit = 1,/obj/Moves/Fury_Attack = 1,/obj/Moves/Agility = 60,/obj/Moves/Rage = 25,/obj/Moves/Drill_Peck = 47,/obj/Moves/Tri_Attack = 21,/obj/Moves/Uproar = 38)
		BaseStats = list("HP" = 60, "ATK" = 110, "DEF" = 70, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 101, "EXP" = 158)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Flail,/obj/Moves/Haze,/obj/Moves/Quick_Attack,/obj/Moves/Supersonic,/obj/Moves/Endeavor)
		Weight = 187.8
		Number = 85
		POKEIMAGE = '85.png'
		Unevolve = /mob/Pokemon/Doduo
		//Cry = '085.WAV'
		Abilities = list("Run Away","Early Bird","Tangled Feet")
	Seel
		icon = '086Seel.dmi'
		Type1 = "Water"
		Evolve = list("Level 34" = /mob/Pokemon/Dewgong)
		GrowthRate = "Medium-Fast"
		CaptureRate = 190
		Gender = 50
		BaseStats = list("HP" = 65, "ATK" = 45, "DEF" = 55, "SPL ATK" = 45, "SPL DEF" = 70, "SPD" = 45, "EXP" = 100)
		LearnMoves = list(/obj/Moves/Headbutt = 1,/obj/Moves/Growl = 9,/obj/Moves/Aurora_Beam = 21,/obj/Moves/Rest = 29,/obj/Moves/Take_Down = 37,/obj/Moves/Ice_Beam = 41,/obj/Moves/Safeguard = 49,/obj/Moves/Icy_Wind = 17)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Disable,/obj/Moves/Encore,/obj/Moves/Lick,/obj/Moves/Perish_Song,/obj/Moves/Slam,/obj/Moves/Fake_Out,/obj/Moves/Horn_Drill,/obj/Moves/Icicle_Spear)
		Weight = 198.4
		Number = 86
		POKEIMAGE = '86.png'
		Cry = '086.WAV'
		Abilities = list("Thick Fat","Hydration","Ice Body")
	Dewgong
		CaptureRate = 75
		Gender = 50
		icon = '087Dewgong.dmi'
		Number = 87
		POKEIMAGE = '87.png'
		Type1 = "Water"
		Type2 = "Ice"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 90, "ATK" = 70, "DEF" = 80, "SPL ATK" = 70, "SPL DEF" = 95, "SPD" = 70, "EXP" = 176)
		LearnMoves = list(/obj/Moves/Headbutt = 1,/obj/Moves/Growl = 1,/obj/Moves/Aurora_Beam = 1,/obj/Moves/Rest = 29,/obj/Moves/Take_Down = 42,/obj/Moves/Ice_Beam = 51,/obj/Moves/Safeguard = 64,/obj/Moves/Signal_Beam = 1,/obj/Moves/Icy_Wind = 1,/obj/Moves/Sheer_Cold = 34)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Disable,/obj/Moves/Encore,/obj/Moves/Lick,/obj/Moves/Perish_Song,/obj/Moves/Slam,/obj/Moves/Fake_Out,/obj/Moves/Horn_Drill,/obj/Moves/Icicle_Spear)
		Weight = 264.6
		Unevolve = /mob/Pokemon/Seel
		Cry = '087.WAV'
		Abilities = list("Thick Fat","Hydration","Ice Body")
	Grimer
		CaptureRate = 190
		Gender = 50
		icon = '088Grimer.dmi'
		Type1 = "Poison"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 38" = /mob/Pokemon/Muk)
		BaseStats = list("HP" = 80, "ATK" = 80, "DEF" = 50, "SPL ATK" = 40, "SPL DEF" = 50, "SPD" = 25, "EXP" = 90)
		LearnMoves = list(/obj/Moves/Poison_Gas = 1,/obj/Moves/Pound = 1,/obj/Moves/Harden = 4,/obj/Moves/Disable = 8,/obj/Moves/Sludge = 13,/obj/Moves/Minimize = 19,/obj/Moves/Screech = 26,/obj/Moves/Acid_Armor = 34,/obj/Moves/Sludge_Bomb = 43,/obj/Moves/Memento = 53)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Lick,/obj/Moves/Mean_Look,/obj/Moves/Curse,/obj/Moves/Explosion,/obj/Moves/Imprison,/obj/Moves/Shadow_Punch)
		Weight = 66.1
		Number = 88
		POKEIMAGE = '88.png'
		Cry = '088.WAV'
		Abilities = list("Stench","Sticky Hold","Poison Touch")
	Muk
		Gender = 50
		CaptureRate = 75
		icon = '089Muk.dmi'
		Type1 = "Poison"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 105, "ATK" = 105, "DEF" = 75, "SPL ATK" = 65, "SPL DEF" = 100, "SPD" = 50, "EXP" = 157)
		LearnMoves = list(/obj/Moves/Poison_Gas = 1,/obj/Moves/Pound = 1,/obj/Moves/Harden = 1,/obj/Moves/Disable = 8,/obj/Moves/Sludge = 13,/obj/Moves/Minimize = 19,/obj/Moves/Screech = 26,/obj/Moves/Acid_Armor = 34,/obj/Moves/Sludge_Bomb = 47,/obj/Moves/Memento = 61)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Lick,/obj/Moves/Mean_Look,/obj/Moves/Curse,/obj/Moves/Explosion,/obj/Moves/Imprison,/obj/Moves/Shadow_Punch)
		Weight = 66.1
		Number = 89
		POKEIMAGE = '89.png'
		Unevolve = /mob/Pokemon/Grimer
		Cry = '089.WAV'
		Abilities = list("Stench","Sticky Hold","Poison Touch")
	Shellder
		CaptureRate = 190
		Gender = 50
		icon = '090Shellder.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Slow"
		Evolve = list("Waterstone" = /mob/Pokemon/Cloyster)
		BaseStats = list("HP" = 30, "ATK" = 65, "DEF" = 100, "SPL ATK" = 45, "SPL DEF" = 25, "SPD" = 40, "EXP" = 97)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Withdraw = 1,/obj/Moves/Supersonic = 9,/obj/Moves/Aurora_Beam = 17,/obj/Moves/Protect = 25,/obj/Moves/Leer = 33,/obj/Moves/Clamp = 41,/obj/Moves/Ice_Beam = 49,/obj/Moves/Icicle_Spear = 8)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Bubblebeam,/obj/Moves/Rapid_Spin,/obj/Moves/Screech,/obj/Moves/Take_Down,/obj/Moves/Icicle_Spear)
		Weight = 8.8
		Number = 90
		POKEIMAGE = '90.png'
		Cry = '090.WAV'
		Abilities = list("Shell Armor","Skill Link","Overcoat")
	Cloyster
		CaptureRate = 60
		Gender = 50
		icon = '091Cloyster.dmi'
		Type1 = "Water"
		Type2 = "Ice"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 50, "ATK" = 95, "DEF" = 180, "SPL ATK" = 85, "SPL DEF" = 45, "SPD" = 70, "EXP" = 203)
		LearnMoves = list(/obj/Moves/Withdraw = 1,/obj/Moves/Supersonic = 1,/obj/Moves/Aurora_Beam = 1,/obj/Moves/Protect = 1,/obj/Moves/Spikes = 33,/obj/Moves/Spike_Cannon = 41)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Bubblebeam,/obj/Moves/Rapid_Spin,/obj/Moves/Screech,/obj/Moves/Take_Down,/obj/Moves/Icicle_Spear)
		Weight = 292.1
		Number = 91
		POKEIMAGE = '91.png'
		Unevolve = /mob/Pokemon/Shellder
		Cry = '091.WAV'
		Abilities = list("Shell Armor","Skill Link","Overcoat")
	Gastly
		icon = '092Gastly.dmi'
		CaptureRate = 190
		Gender = 50
		Evolve = list("level 25" = /mob/Pokemon/Haunter)
		Type1 = "Ghost"
		Type2 = "Poison"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 30, "ATK" = 35, "DEF" = 30, "SPL ATK" = 100, "SPL DEF" = 35, "SPD" = 80, "EXP" = 95)
		LearnMoves = list(/obj/Moves/Lick = 1,/obj/Moves/Hypnosis = 1,/obj/Moves/Spite = 8,/obj/Moves/Mean_Look = 13,/obj/Moves/Curse = 16,/obj/Moves/Night_Shade = 21,/obj/Moves/Confuse_Ray = 28,/obj/Moves/Dream_Eater = 33,/obj/Moves/Destiny_Bond = 36,/obj/Moves/Shadow_Ball = 36,/obj/Moves/Nightmare = 41)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Perish_Song,/obj/Moves/Psywave,/obj/Moves/Astonish,/obj/Moves/Explosion,/obj/Moves/Grudge,/obj/Moves/Will_O_Wisp)
		Weight = 0.2
		Number = 92
		POKEIMAGE = '92.png'
		Cry = '092.WAV'
		Abilities = list("Levitate")
	Haunter
		icon = '093Haunter.dmi'
		CaptureRate = 90
		Gender = 50
		Evolve = list("Trade" = /mob/Pokemon/Gengar)
		Type1 = "Ghost"
		Type2 = "Poison"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 45, "ATK" = 50, "DEF" = 45, "SPL ATK" = 115, "SPL DEF" = 55, "SPD" = 95, "EXP" = 125)
		LearnMoves = list(/obj/Moves/Hypnosis = 1,/obj/Moves/Lick = 1,/obj/Moves/Spite = 1,/obj/Moves/Mean_Look = 13,/obj/Moves/Curse = 16,/obj/Moves/Night_Shade = 21,/obj/Moves/Confuse_Ray = 31,/obj/Moves/Dream_Eater = 39,/obj/Moves/Destiny_Bond = 48,/obj/Moves/Shadow_Ball = 45,/obj/Moves/Nightmare = 53,/obj/Moves/Shadow_Punch = 25)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Perish_Song,/obj/Moves/Psywave,/obj/Moves/Astonish,/obj/Moves/Explosion,/obj/Moves/Grudge,/obj/Moves/Will_O_Wisp)
		Weight = 0.2
		Number = 93
		POKEIMAGE = '93.png'
		Unevolve = /mob/Pokemon/Gastly
		Cry = '093.WAV'
		Abilities = list("Levitate")
	Gengar
		icon = '094Gengar.dmi'
		CaptureRate = 45
		Gender = 50
		Type1 = "Ghost"
		Type2 = "Poison"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 60, "ATK" = 65, "DEF" = 60, "SPL ATK" = 130, "SPL DEF" = 75, "SPD" = 110, "EXP" = 190)
		LearnMoves = list(/obj/Moves/Hypnosis = 1,/obj/Moves/Lick = 1,/obj/Moves/Spite = 1,/obj/Moves/Mean_Look = 13,/obj/Moves/Curse = 16,/obj/Moves/Night_Shade = 21,/obj/Moves/Confuse_Ray = 31,/obj/Moves/Dream_Eater = 39,/obj/Moves/Destiny_Bond = 48,/obj/Moves/Shadow_Ball = 45,/obj/Moves/Nightmare = 53,/obj/Moves/Shadow_Punch = 25)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Perish_Song,/obj/Moves/Psywave,/obj/Moves/Astonish,/obj/Moves/Explosion,/obj/Moves/Grudge,/obj/Moves/Will_O_Wisp)
		Weight = 89.3
		Number = 94
		POKEIMAGE = '94.png'
		Unevolve = /mob/Pokemon/Haunter
		Cry = '094.WAV'
		Abilities = list("Levitate")
	Onix
		CaptureRate = 45
		Gender = 50
		icon = '095Onix.dmi'
		pixel_x = -29
		//pixel_y = -16
		Type1 = "Rock"
		Type2 = "Ground"
		GrowthRate = "Medium-Fast"
		Evolve = list("Trade" = /mob/Pokemon/Steelix,"TradeItem" = /obj/HeldItems/Evolution/Metal_Coat)
		BaseStats = list("HP" = 35, "ATK" = 45, "DEF" = 160, "SPL ATK" = 30, "SPL DEF" = 45, "SPD" = 70, "EXP" = 108)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Screech = 1,/obj/Moves/Bind = 9,/obj/Moves/Rock_Throw = 13,/obj/Moves/Harden = 21,/obj/Moves/Rage = 25,/obj/Moves/Sandstorm = 34,/obj/Moves/Slam = 37,/obj/Moves/Dragon_Breath = 30,/obj/Moves/Iron_Tail = 45,/obj/Moves/Sand_Tomb = 49,/obj/Moves/Double_Edge = 57)
		EggGroups = list("Mineral")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Rock_Slide,/obj/Moves/Block,/obj/Moves/Explosion)
		Weight = 463.0
		Number = 95
		POKEIMAGE = '95.png'
		Cry = '095.WAV'
		Abilities = list("Rock Head","Weak Armor")
	Drowzee
		CaptureRate = 190
		Gender = 50
		icon = '096Drowzee.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 26" = /mob/Pokemon/Hypno)
		BaseStats = list("HP" = 60, "ATK" = 48, "DEF" = 45, "SPL ATK" = 43, "SPL DEF" = 90, "SPD" = 42, "EXP" = 102)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Hypnosis = 1,/obj/Moves/Disable = 10,/obj/Moves/Confusion = 18,/obj/Moves/Headbutt = 25,/obj/Moves/Poison_Gas = 31,/obj/Moves/Meditate = 36,/obj/Moves/Psychic = 40,/obj/Moves/Psych_Up = 43,/obj/Moves/Future_Sight = 45)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Light_Screen)
		Number = 96
		POKEIMAGE = '96.png'
		Weight = 71.4
		Cry = '096.WAV'
		Abilities = list("Insomia","Forewarn","Inner Focus")
	Hypno
		CaptureRate = 75
		Gender = 50
		icon = '097Hypno.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 85, "ATK" = 73, "DEF" = 70, "SPL ATK" = 73, "SPL DEF" = 115, "SPD" = 67, "EXP" = 165)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Hypnosis = 1,/obj/Moves/Disable = 1,/obj/Moves/Confusion = 1,/obj/Moves/Headbutt = 25,/obj/Moves/Poison_Gas = 33,/obj/Moves/Meditate = 40,/obj/Moves/Psychic = 49,/obj/Moves/Psych_Up = 55,/obj/Moves/Future_Sight = 60)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Light_Screen)
		Weight = 166.7
		Unevolve = /mob/Pokemon/Drowzee
		Number = 97
		POKEIMAGE = '97.png'
		Cry = '097.WAV'
		Abilities = list("Insomia","Forewarn","Inner Focus")
	Krabby
		icon = '098Krabby.dmi'
		Type1 = "Water"
		Evolve = list("Level 28" = /mob/Pokemon/Kingler)
		GrowthRate = "Medium-Fast"
		CaptureRate = 255
		Gender = 50
		Weight = 14.3
		Number = 98
		POKEIMAGE = '98.png'
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Amnesia,/obj/HMs/Dig,/obj/Moves/Flail,/obj/Moves/Haze,/obj/Moves/Slam,/obj/Moves/Swords_Dance,/obj/Moves/Knock_Off)
		BaseStats = list("HP" = 30, "ATK" = 105, "DEF" = 90, "SPL ATK" = 25, "SPL DEF" = 25, "SPD" = 50, "EXP" = 115)
		LearnMoves = list(/obj/Moves/Bubble = 1, /obj/Moves/Leer = 5, /obj/Moves/ViceGrip = 12, /obj/Moves/Harden = 16 ,/obj/Moves/Stomp = 27,/obj/Moves/Guillotine = 34,/obj/Moves/Protect= 41,/obj/Moves/Crabhammer = 45,/obj/Moves/Flail = 49,/obj/Moves/Mud_Shot = 23)
		Cry = '098.WAV'
		Abilities = list("Hyper Cutter","Shell Armor","Sheer Force")
	Kingler
		icon = '099Kingler.dmi'
		CaptureRate = 60
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		Gender = 50
		Weight = 132.3
		Number = 99
		POKEIMAGE = '99.png'
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Amnesia,/obj/HMs/Dig,/obj/Moves/Flail,/obj/Moves/Haze,/obj/Moves/Slam,/obj/Moves/Swords_Dance,/obj/Moves/Knock_Off)
		BaseStats = list("HP" = 55, "ATK" = 130, "DEF" = 115, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 75, "EXP" = 206)
		LearnMoves = list(/obj/Moves/Bubble = 1, /obj/Moves/Leer = 1, /obj/Moves/ViceGrip = 1, /obj/Moves/Harden = 1 ,/obj/Moves/Stomp = 27,/obj/Moves/Guillotine = 38,/obj/Moves/Protect= 49,/obj/Moves/Crabhammer = 57,/obj/Moves/Flail = 66,/obj/Moves/Metal_Claw = 1,/obj/Moves/Mud_Shot = 23)
		Unevolve = /mob/Pokemon/Krabby
		Cry = '099.WAV'
		Abilities = list("Hyper Cutter","Shell Armor","Sheer Force")
	Voltorb//Left off Fixing Movesets Here
		CaptureRate = 190
		Gender = "Genderless"
		icon = '100Voltorb.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 30" = /mob/Pokemon/Electrode)
		BaseStats = list("HP" = 40, "ATK" = 30, "DEF" = 50, "SPL ATK" = 55, "SPL DEF" = 55, "SPD" = 100, "EXP" = 103)
		LearnMoves = list(/obj/Moves/Charge = 1,/obj/Moves/Tackle = 1,/obj/Moves/Screech = 8,/obj/Moves/Sonicboom = 15,/obj/Moves/Spark = 21,/obj/Moves/Selfdestruct = 27,/obj/Moves/Rollout = 32,/obj/Moves/Light_Screen = 37,/obj/Moves/Swift = 42,/obj/Moves/Explosion = 46,/obj/Moves/Mirror_Coat = 49)
		EggGroups = list("Mineral")
		Weight = 22.9
		Number = 100
		POKEIMAGE = '100.png'
		Cry = '100.WAV'
		Abilities = list("Soundproof","Static","Aftermath")
	Electrode
		CaptureRate = 60
		Gender = "Genderless"
		icon = '101Electrode.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 50, "DEF" = 70, "SPL ATK" = 80, "SPL DEF" = 80, "SPD" = 140, "EXP" = 150)
		LearnMoves = list(/obj/Moves/Charge = 1,/obj/Moves/Tackle = 1,/obj/Moves/Screech = 1,/obj/Moves/Sonicboom = 1,/obj/Moves/Spark = 21,/obj/Moves/Selfdestruct = 27,/obj/Moves/Rollout = 34,/obj/Moves/Light_Screen = 41,/obj/Moves/Swift = 48,/obj/Moves/Explosion = 54,/obj/Moves/Mirror_Coat = 59)
		EggGroups = list("Mineral")
		Weight = 148.6
		Number = 101
		POKEIMAGE = '101.png'
		Unevolve = /mob/Pokemon/Voltorb
		Cry = '101.WAV'
		Abilities = list("Soundproof","Static","Aftermath")
	Exeggcute
		CaptureRate = 90
		Gender = 50
		icon = '102Exeggcute.dmi'
		Type1 = "Grass"
		Type2 = "Psychic"
		GrowthRate = "Medium-Slow"
		Evolve = list("Leafstone" = /mob/Pokemon/Exeggutor)
		BaseStats = list("HP" = 60, "ATK" = 40, "DEF" = 80, "SPL ATK" = 60, "SPL DEF" = 45, "SPD" = 40, "EXP" = 98)
		LearnMoves = list(/obj/Moves/Uproar,/obj/Moves/Barrage = 1,/obj/Moves/Hypnosis = 1,/obj/Moves/ = 1,/obj/Moves/Reflect = 7,/obj/Moves/Leech_Seed = 13,/obj/Moves/Confusion = 19,/obj/Moves/Stun_Spore = 25,/obj/Moves/PoisonPowder = 31,/obj/Moves/SleepPowder = 37,/obj/Moves/SolarBeam = 43)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Mega_Drain,/obj/Moves/Moonlight,/obj/Moves/Ingrain,/obj/Moves/Synthesis)
		Weight = 5.5
		Number = 102
		POKEIMAGE = '102.png'
		Cry = '102.WAV'
		Abilities = list("Chlorophyll","Harvest")
	Exeggutor
		CaptureRate = 45
		Gender = 50
		icon = '103Exeggutor.dmi'
		Type1 = "Grass"
		Type2 = "Psychic"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 95, "ATK" = 95, "DEF" = 85, "SPL ATK" = 125, "SPL DEF" = 65, "SPD" = 55, "EXP" = 212)
		LearnMoves = list(/obj/Moves/Confusion = 1,/obj/Moves/Barrage = 1,/obj/Moves/Hypnosis = 1,/obj/Moves/Stomp = 19,/obj/Moves/Egg_Bomb = 31)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Mega_Drain,/obj/Moves/Moonlight,/obj/Moves/Ingrain,/obj/Moves/Synthesis)
		Weight = 264.6
		Number = 103
		POKEIMAGE = '103.png'
		Unevolve = /mob/Pokemon/Exeggcute
		Cry = '103.WAV'
		Abilities = list("Chlorophyll","Harvest")
	Cubone
		CaptureRate = 190
		Gender = 50
		icon = '104Cubone.dmi'
		Type1 = "Ground"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 28" = /mob/Pokemon/Marowak)
		BaseStats = list("HP" = 50, "ATK" = 50, "DEF" = 95, "SPL ATK" = 40, "SPL DEF" = 50, "SPD" = 35, "EXP" = 87)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Tail_Whip = 5,/obj/Moves/Bone_Club = 9,/obj/Moves/Headbutt = 13,/obj/Moves/Leer = 17,/obj/Moves/Focus_Energy = 21,/obj/Moves/Bonemerang = 25,/obj/Moves/Rage = 29,/obj/Moves/False_Swipe = 33,/obj/Moves/Thrash = 27,/obj/Moves/Bone_Rush = 41,/obj/Moves/Double_Edge = 45)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Belly_Drum,/obj/Moves/Perish_Song,/obj/Moves/Rock_Slide,/obj/Moves/Screech,/obj/Moves/Skull_Bash,/obj/Moves/Swords_Dance)
		Weight = 14.3
		Number = 104
		POKEIMAGE = '104.png'
		Cry = '104.WAV'
		Abilities = list("Rock Head","Lightningrod","Battle Armor")
	Marowak
		CaptureRate = 75
		Gender = 50
		icon = '105Marowak.dmi'
		Type1 = "Ground"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 80, "DEF" = 110, "SPL ATK" = 50, "SPL DEF" = 80, "SPD" = 45, "EXP" = 124)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Bone_Club = 1,/obj/Moves/Headbutt = 1,/obj/Moves/Leer = 17,/obj/Moves/Focus_Energy = 21,/obj/Moves/Bonemerang = 25,/obj/Moves/Rage = 32,/obj/Moves/False_Swipe = 39,/obj/Moves/Thrash = 46,/obj/Moves/Bone_Rush = 53,/obj/Moves/Double_Edge)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Belly_Drum,/obj/Moves/Perish_Song,/obj/Moves/Rock_Slide,/obj/Moves/Screech,/obj/Moves/Skull_Bash,/obj/Moves/Swords_Dance)
		Weight = 99.2
		Number = 105
		POKEIMAGE = '105.png'
		Unevolve = /mob/Pokemon/Cubone
		Cry = '105.WAV'
		Abilities = list("Rock Head","Lightningrod","Battle Armor")
	Hitmonlee
		CaptureRate = 45
		Gender = 100
		icon = '106Hitmonlee.dmi'
		Type1 = "Fighting"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 50, "ATK" = 120, "DEF" = 53, "SPL ATK" = 35, "SPL DEF" = 110, "SPD" = 87, "EXP" = 139)
		LearnMoves = list(/obj/Moves/Double_Kick = 1,/obj/Moves/,Revenge = 1,/obj/Moves/Meditate = 6,/obj/Moves/Rolling_Kick = 11,/obj/Moves/Jump_Kick = 16,/obj/Moves/Brick_Break = 20,/obj/Moves/Focus_Energy = 21,/obj/Moves/Hi_Jump_Kick = 26,/obj/Moves/Mind_Reader = 31,/obj/Moves/Foresight = 36,/obj/Moves/Endure = 41,/obj/Moves/Mega_Kick = 46,/obj/Moves/Reversal = 51)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Hi_Jump_Kick,/obj/Moves/Mach_Punch,/obj/Moves/Mind_Reader,/obj/Moves/Rapid_Spin)
		Weight = 109.8
		Number = 106
		POKEIMAGE = '106.png'
		Unevolve = /mob/Pokemon/Tyrogue
		Cry = '106.WAV'
		Abilities = list("Limber","Reckless","Unburden")
	Hitmonchan
		CaptureRate = 45
		Gender = 100
		icon = '107Hitmonchan.dmi'
		Type1 = "Fighting"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 50, "ATK" = 105, "DEF" = 79, "SPL ATK" = 35, "SPL DEF" = 110, "SPD" = 76, "EXP" = 140)
		LearnMoves = list(/obj/Moves/Comet_Punch = 1,/obj/Moves/Revenge = 1,/obj/Moves/Agility = 7,/obj/Moves/Pursuit = 13,/obj/Moves/Fire_Punch = 26,/obj/Moves/Ice_Punch = 26,/obj/Moves/Thunder_Punch = 26,/obj/Moves/Mach_Punch = 20,/obj/Moves/Sky_Uppercut = 32,/obj/Moves/Mega_Punch = 38,/obj/Moves/Detect = 44,/obj/Moves/Counter = 50)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Hi_Jump_Kick,/obj/Moves/Mach_Punch,/obj/Moves/Mind_Reader,/obj/Moves/Rapid_Spin)
		Weight = 110.7
		Number = 107
		POKEIMAGE = '107.png'
		Unevolve = /mob/Pokemon/Tyrogue
		Cry = '107.WAV'
		Abilities = list("Keen Eye","Iron Fist","Inner Focus")
	Lickitung
		CaptureRate = 45
		Gender = 50
		icon = '108Lickitung.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 90, "ATK" = 55, "DEF" = 75, "SPL ATK" = 60, "SPL DEF" = 75, "SPD" = 40, "EXP" = 127)
		LearnMoves = list(/obj/Moves/Lick = 1,/obj/Moves/Supersonic = 7,/obj/Moves/Defense_Curl = 12,/obj/Moves/Knock_Off = 18,/obj/Moves/Stomp = 23,/obj/Moves/Wrap = 29,/obj/Moves/Disable = 34,/obj/Moves/Slam = 40,/obj/Moves/Screech = 45,/obj/Moves/Refresh = 51)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Belly_Drum,/obj/Moves/Body_Slam,/obj/Moves/Magnitude,/obj/Moves/Curse,/obj/Moves/Sleep_Talk,/obj/Moves/SmellingSalt,/obj/Moves/Snore,/obj/Moves/Substitute)
		Weight = 144.4
		Number = 108
		POKEIMAGE = '108.png'
		Cry = '108.WAV'
		Abilities = list("Own Tempo","Oblivious","Cloud Nine")
	Koffing
		CaptureRate = 190
		Gender = 50
		icon = '109Koffing.dmi'
		Type1 = "Poison"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 35" = /mob/Pokemon/Weezing)
		BaseStats = list("HP" = 40, "ATK" = 65, "DEF" = 95, "SPL ATK" = 60, "SPL DEF" = 45, "SPD" = 35, "EXP" = 114)
		LearnMoves = list(/obj/Moves/Poison_Gas = 1,/obj/Moves/Tackle = 1,/obj/Moves/Smog = 9,/obj/Moves/Selfdestruct = 17,/obj/Moves/Sludge = 21,/obj/Moves/Smokescreen = 25,/obj/Moves/Haze = 33,/obj/Moves/Explosion = 41,/obj/Moves/Destiny_Bond = 45,/obj/Moves/Memento = 49)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Destiny_Bond,/obj/Moves/Pain_Split,/obj/Moves/Psybeam,/obj/Moves/Psywave,/obj/Moves/Screech,/obj/Moves/Will_O_Wisp)
		Weight = 2.2
		Number = 109
		POKEIMAGE = '109.png'
		Cry = '109.WAV'
		Abilities = list("Levitate")
	Weezing
		CaptureRate = 60
		Gender = 50
		icon = '110Weezing.dmi'
		Type1 = "Poison"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 90, "DEF" = 120, "SPL ATK" = 85, "SPL DEF" = 70, "SPD" = 66, "EXP" = 173)
		LearnMoves = list(/obj/Moves/Poison_Gas = 1,/obj/Moves/Tackle = 1,/obj/Moves/Smog = 1,/obj/Moves/Selfdestruct = 1,/obj/Moves/Sludge = 21,/obj/Moves/Smokescreen = 25,/obj/Moves/Haze = 33,/obj/Moves/Explosion = 44,/obj/Moves/Destiny_Bond = 51,/obj/Moves/Memento = 58)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Destiny_Bond,/obj/Moves/Pain_Split,/obj/Moves/Psybeam,/obj/Moves/Psywave,/obj/Moves/Screech,/obj/Moves/Will_O_Wisp)
		Weight = 20.9
		Number = 110
		POKEIMAGE = '110.png'
		Unevolve = /mob/Pokemon/Koffing
		Cry = '110.WAV'
		Abilities = list("Levitate")
	Rhyhorn
		CaptureRate = 120
		Gender = 50
		icon = '111Rhyhorn.dmi'
		Type1 = "Ground"
		Type2 = "Rock"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 42" = /mob/Pokemon/Rhydon)
		BaseStats = list("HP" = 80, "ATK" = 85, "DEF" = 95, "SPL ATK" = 30, "SPL DEF" = 30, "SPD" = 25, "EXP" = 135)
		LearnMoves = list(/obj/Moves/Horn_Attack = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Stomp = 10,/obj/Moves/Fury_Attack = 15,/obj/Moves/Scary_Face = 24,/obj/Moves/Rock_Blast = 29,/obj/Moves/Horn_Drill = 38,/obj/Moves/Take_Down = 43,/obj/Moves/Earthquake = 52,/obj/Moves/Megahorn = 57)
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Crunch,/obj/Moves/Crush_Claw,/obj/Moves/Curse,/obj/Moves/Magnitude,/obj/Moves/Reversal,/obj/Moves/Rock_Slide,/obj/Moves/Thrash,/obj/Moves/Swords_Dance)
		Weight = 252.5
		Number = 111
		POKEIMAGE = '111.png'
		Cry = '111.WAV'
		Abilities = list("Lightningrod","Rock Head","Reckless")
	Rhydon
		CaptureRate = 60
		Gender = 50
		icon = '112Rhydon.dmi'
		Type1 = "Ground"
		Type2 = "Rock"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 105, "ATK" = 130, "DEF" = 120, "SPL ATK" = 45, "SPL DEF" = 45, "SPD" = 40, "EXP" = 204)
		LearnMoves = list(/obj/Moves/Horn_Attack = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Stomp = 1,/obj/Moves/Fury_Attack = 1,/obj/Moves/Scary_Face = 24,/obj/Moves/Rock_Blast = 29,/obj/Moves/Horn_Drill = 38,/obj/Moves/Take_Down = 46,/obj/Moves/Earthquake = 58,/obj/Moves/Megahorn = 66)
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Crunch,/obj/Moves/Crush_Claw,/obj/Moves/Curse,/obj/Moves/Magnitude,/obj/Moves/Reversal,/obj/Moves/Rock_Slide,/obj/Moves/Thrash,/obj/Moves/Swords_Dance)
		Weight = 264.6
		Number = 112
		POKEIMAGE = '112.png'
		Unevolve = /mob/Pokemon/Rhyhorn
		Cry = '112.WAV'
		Abilities = list("Lightningrod","Rock Head","Reckless")
	Chansey
		icon = '113Chansey.dmi'
		CaptureRate = 30
		GrowthRate = "Fast"
		Gender = 0
		Type1 = "Normal"
		Evolve = list("Happiness" = /mob/Pokemon/Blissey)
		BaseStats = list("HP" = 250, "ATK" = 5, "DEF" = 5, "SPL ATK" = 35, "SPL DEF" = 105, "SPD" = 50, "EXP" = 255)
		LearnMoves = list(/obj/Moves/Pound = 1, /obj/Moves/Growl = 5, /obj/Moves/Tail_Whip = 5, /obj/Moves/Refresh = 9, /obj/Moves/Softboiled = 13, /obj/Moves/DoubleSlap = 17, /obj/Moves/Minimize = 23,/obj/Moves/Sing = 29,/obj/Moves/Egg_Bomb = 35,/obj/Moves/Defense_Curl = 41,/obj/Moves/Light_Screen = 49,/obj/Moves/Double_Edge = 57)
		EggGroups = list("Fairy")
		EggMoves = list(/obj/Moves/Present,/obj/Moves/Metronome,/obj/Moves/Heal_Bell)
		Weight = 76.3
		Number = 113
		POKEIMAGE = '113.png'
		Cry = '113.WAV'
		Abilities = list("Natural Cure","Serene Grace","Healer")
	Tangela
		icon = '114Tangela.dmi'
		CaptureRate = 45
		GrowthRate = "Medium-Fast"
		Type1 = "Grass"
		Gender = 50
		BaseStats = list("HP" = 65, "ATK" = 55, "DEF" = 115, "SPL ATK" = 100, "SPL DEF" = 40, "SPD" = 60, "EXP" = 166)
		LearnMoves = list(/obj/Moves/Constrict = 1,/obj/Moves/Ingrain = 1,/obj/Moves/SleepPowder = 4,/obj/Moves/Absorb = 10,/obj/Moves/Growth = 13,/obj/Moves/PoisonPowder = 19,/obj/Moves/Vine_Whip = 22,/obj/Moves/Bind = 28,/obj/Moves/Mega_Drain = 31,/obj/Moves/Stun_Spore = 37,/obj/Moves/Slam = 40,/obj/Moves/Tickle = 46)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Confusion,/obj/Moves/Flail,/obj/Moves/Leech_Seed,/obj/Moves/Mega_Drain,/obj/Moves/Nature_Power,/obj/Moves/Reflect)
		Weight = 77.2
		Number = 114
		POKEIMAGE = '114.png'
		Cry = '114.WAV'
		Abilities = list("Chlorophyll","Leaf Guard","Regenerator")
	Kangaskhan
		CaptureRate = 45
		Gender = 0
		icon = '115Kangaskhan.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 105, "ATK" = 95, "DEF" = 80, "SPL ATK" = 40, "SPL DEF" = 80, "SPD" = 90, "EXP" = 175)
		LearnMoves = list(/obj/Moves/Comet_Punch = 1,/obj/Moves/Leer = 1,/obj/Moves/Bite = 7,/obj/Moves/Tail_Whip = 13,/obj/Moves/Fake_Out = 19,/obj/Moves/Mega_Punch = 25,/obj/Moves/Rage = 31,/obj/Moves/Endure = 37,/obj/Moves/Dizzy_Punch = 43,/obj/Moves/Reversal = 49)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Crush_Claw,/obj/Moves/Disable,/obj/Moves/Focus_Energy,/obj/Moves/Foresight,/obj/Moves/Safeguard,/obj/Moves/Stomp,/obj/Moves/Substitute)
		Weight = 176.4
		Number = 115
		POKEIMAGE = '115.png'
		Cry = '115.WAV'
		Abilities = list("Early Bird","Scrappy","Inner Focus")
	Horsea
		CaptureRate = 255
		Gender = 50
		icon = '116Horsea.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 32" = /mob/Pokemon/Seadra)
		BaseStats = list("HP" = 30, "ATK" = 40, "DEF" = 70, "SPL ATK" = 70, "SPL DEF" = 25, "SPD" = 60, "EXP" = 83)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Smokescreen = 8,/obj/Moves/Leer = 15,/obj/Moves/Water_Gun = 22,/obj/Moves/Twister = 29,/obj/Moves/Agility = 36,/obj/Moves/Hydro_Pump = 43,/obj/Moves/Dragon_Dance = 50)
		EggGroups = list("Water 1","Dragon")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Disable,/obj/Moves/Dragon_Breath,/obj/Moves/Dragon_Rage,/obj/Moves/Flail,/obj/Moves/Octazooka,/obj/Moves/Splash)
		Weight = 17.6
		Number = 116
		POKEIMAGE = '116.png'
		Cry = '116.WAV'
		Abilities = list("Swift Swim","Sniper","Damp")
	Seadra
		CaptureRate = 60
		Gender = 50
		icon = '117Seadra.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		Evolve = list("Trade" = /mob/Pokemon/Kingdra,"TradeItem" = /obj/HeldItems/Evolution/Dragon_Scale)
		BaseStats = list("HP" = 55, "ATK" = 65, "DEF" = 95, "SPL ATK" = 95, "SPL DEF" = 45, "SPD" = 85, "EXP" = 155)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Smokescreen = 1,/obj/Moves/Leer = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Twister = 29,/obj/Moves/Agility = 40,/obj/Moves/Hydro_Pump = 51,/obj/Moves/Dragon_Dance = 50)
		EggGroups = list("Water 1","Dragon")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Disable,/obj/Moves/Dragon_Breath,/obj/Moves/Dragon_Rage,/obj/Moves/Flail,/obj/Moves/Octazooka,/obj/Moves/Splash)
		Weight = 55.1
		Number = 117
		POKEIMAGE = '117.png'
		Unevolve = /mob/Pokemon/Horsea
		Cry = '117.WAV'
		Abilities = list("Poison Point","Sniper","Damp")
	Goldeen
		CaptureRate = 255
		Gender = 50
		icon = '118Goldeen.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 33" = /mob/Pokemon/Seaking)
		BaseStats = list("HP" = 45, "ATK" = 67, "DEF" = 60, "SPL ATK" = 35, "SPL DEF" = 50, "SPD" = 63, "EXP" = 111)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Water_Sport = 1,/obj/Moves/Supersonic = 10,/obj/Moves/Horn_Attack = 15,/obj/Moves/Flail = 24,/obj/Moves/Fury_Attack = 29,/obj/HMs/Waterfall = 38,/obj/Moves/Horn_Drill = 43,/obj/Moves/Agility = 52)
		EggGroups = list("Water 2")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Hydro_Pump,/obj/Moves/Psybeam)
		Weight = 33.1
		Number = 118
		POKEIMAGE = '118.png'
		Cry = '118.WAV'
		Abilities = list("Swift Swim","Water Veil","Lightningrod")
	Seaking
		CaptureRate = 60
		Gender = 50
		icon = '119Seaking.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 80, "ATK" = 92, "DEF" = 65, "SPL ATK" = 65, "SPL DEF" = 80, "SPD" = 68, "EXP" = 170)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Supersonic = 10,/obj/Moves/Horn_Attack = 15,/obj/Moves/Flail = 24,/obj/Moves/Fury_Attack = 29,/obj/HMs/Waterfall = 41,/obj/Moves/Horn_Drill = 49,/obj/Moves/Agility = 61)
		EggGroups = list("Water 2")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Hydro_Pump,/obj/Moves/Psybeam)
		Weight = 86.0
		Number = 119
		POKEIMAGE = '119.png'
		Unevolve = /mob/Pokemon/Goldeen
		Cry = '119.WAV'
		Abilities = list("Swift Swim","Water Veil","Lightningrod")
	Staryu
		CaptureRate = 225
		Gender = "Genderless"
		icon = '120Staryu.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Slow"
		Evolve = list("Waterstone" = /mob/Pokemon/Starmie)
		BaseStats = list("HP" = 30, "ATK" = 45, "DEF" = 55, "SPL ATK" = 70, "SPL DEF" = 55, "SPD" = 85, "EXP" = 106)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 1,/obj/Moves/Water_Gun = 6,/obj/Moves/Rapid_Spin = 10,/obj/Moves/Recover = 15,/obj/Moves/Camouflage = 19,/obj/Moves/Swift = 24,/obj/Moves/Bubblebeam = 28,/obj/Moves/Minimize = 33,/obj/Moves/Light_Screen = 37,/obj/Moves/Cosmic_Power = 42,/obj/Moves/Hydro_Pump = 46)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Barrier,/obj/Moves/Supersonic)
		Weight = 76.1
		Number = 120
		POKEIMAGE = '120.png'
		Cry = '120.WAV'
		Abilities = list("Illuminate","Natural Cure","Analytic")
	Starmie
		CaptureRate = 60
		Gender = "Genderless"
		icon = '121Starmie.dmi'
		Type1 = "Water"
		Type2 = "Psychic"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 60, "ATK" = 75, "DEF" = 85, "SPL ATK" = 100, "SPL DEF" = 85, "SPD" = 115, "EXP" = 207)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Rapid_Spin = 1,/obj/Moves/Swift = 1,/obj/Moves/Recover = 1,/obj/Moves/Confuse_Ray = 33)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Barrier,/obj/Moves/Supersonic)
		Weight = 176.4
		Number = 121
		POKEIMAGE = '121.png'
		Unevolve = /mob/Pokemon/Staryu
		Cry = '121.WAV'
		Abilities = list("Illuminate","Natural Cure","Analytic")
	MrMime
		name = "Mr.Mine"
		CaptureRate = 45
		Gender = 50
		icon = '122Mr. Mime.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 40, "ATK" = 45, "DEF" = 65, "SPL ATK" = 100, "SPL DEF" = 120, "SPD" = 90, "EXP" = 207)
		LearnMoves = list(/obj/Moves/Barrier = 1,/obj/Moves/Confusion = 6,/obj/Moves/Substitute = 11,/obj/Moves/Meditate = 16,/obj/Moves/DoubleSlap = 21,/obj/Moves/Light_Screen = 26,/obj/Moves/Reflect = 26,/obj/Moves/Encore = 31,/obj/Moves/Psybeam = 36,/obj/Moves/Baton_Pass = 41,/obj/Moves/Safeguard = 46)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Future_Sight,/obj/Moves/Hypnosis,/obj/Moves/Fake_Out,/obj/Moves/Future_Sight,/obj/Moves/Mimic,/obj/Moves/Psych_Up,/obj/Moves/Trick)
		Weight = 120.1
		Number = 122
		POKEIMAGE = '122.png'
		Cry = '122.WAV'
		Abilities = list("Soundproof","Filter","Technician")
	Scyther
		icon = '123Scyther.dmi'
		Type1 = "Bug"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		Evolve = list("Trade" = /mob/Pokemon/Scizor, "TradeItem" = /obj/HeldItems/Evolution/Metal_Coat)
		CaptureRate = 45
		Gender = 50
		BaseStats = list("HP" = 70, "ATK" = 110, "DEF" = 80, "SPL ATK" = 55, "SPL DEF" = 80, "SPD" = 105, "EXP" = 187)
		LearnMoves = list(/obj/Moves/Quick_Attack = 1,/obj/Moves/Leer = 1,/obj/Moves/Focus_Energy = 6,/obj/Moves/Pursuit = 11,/obj/Moves/False_Swipe = 16,/obj/Moves/Agility = 21,/obj/Moves/Wing_Attack = 26,/obj/Moves/Slash = 31,/obj/Moves/Swords_Dance = 36,/obj/Moves/Double_Team = 41,/obj/Moves/Fury_Cutter = 46)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Counter,/obj/Moves/Endure,/obj/Moves/Light_Screen,/obj/Moves/Razor_Wind,/obj/Moves/Reversal,/obj/Moves/Safeguard,/obj/Moves/Silver_Wind)
		Weight = 123.5
		Number = 123
		POKEIMAGE = '123.png'
		Cry = '123.WAV'
		Abilities = list("Swarm","Technician","Steadfast")
	Jynx
		CaptureRate = 45
		Gender = 0
		icon = '124Jynx.dmi'
		Type1 = "Ice"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 50, "DEF" = 35, "SPL ATK" = 115, "SPL DEF" = 95, "SPD" = 95, "EXP" = 137)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Lick = 1,/obj/Moves/Lovely_Kiss = 1,/obj/Moves/Powder_Snow = 1,/obj/Moves/DoubleSlap = 21,/obj/Moves/Ice_Punch = 25,/obj/Moves/Mean_Look = 35,/obj/Moves/Body_Slam = 41,/obj/Moves/Perish_Song = 51,/obj/Moves/Blizzard = 61)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Meditate,/obj/Moves/Ice_Punch,/obj/Moves/Fake_Out,/obj/Moves/Psych_Up,/obj/Moves/Wish)
		Weight = 89.5
		Number = 124
		POKEIMAGE = '124.png'
		Unevolve = /mob/Pokemon/Smoochum
		Cry = '124.WAV'
		Abilities = list("Oblivious","Forewarn","Dry Skin")
	Electabuzz
		CaptureRate = 45
		Gender = 75
		icon = '125Electabuzz.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 83, "DEF" = 57, "SPL ATK" = 95, "SPL DEF" = 85, "SPD" = 105, "EXP" = 156)
		LearnMoves = list(/obj/Moves/Quick_Attack = 1,/obj/Moves/Leer = 1,/obj/Moves/Thunder_Punch = 1,/obj/Moves/Light_Screen = 17,/obj/Moves/Swift = 25,/obj/Moves/Screech = 38,/obj/Moves/Thunderbolt = 47,/obj/Moves/Thunder = 58)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Cross_Chop,/obj/Moves/Fire_Punch,/obj/Moves/Ice_Punch,/obj/Moves/Karate_Chop,/obj/Moves/Meditate,/obj/Moves/Rolling_Kick)
		Weight = 66.1
		Number = 125
		POKEIMAGE = '125.png'
		Unevolve = /mob/Pokemon/Elekid
		Cry = '125.WAV'
		Abilities = list("Static","Vital Spirit")
	Magmar
		CaptureRate = 45
		Gender = 75
		icon = '126Magmar.dmi'
		Type1 = "Fire"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 95, "DEF" = 57, "SPL ATK" = 100, "SPL DEF" = 85, "SPD" = 93, "EXP" = 167)
		LearnMoves = list(/obj/Moves/Ember = 1,/obj/Moves/Leer = 7,/obj/Moves/Smog = 13,/obj/Moves/Fire_Punch = 19,/obj/Moves/Smokescreen = 25,/obj/Moves/Sunny_Day = 33,/obj/Moves/Flamethrower = 41,/obj/Moves/Confuse_Ray = 49,/obj/Moves/Fire_Blast = 57)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Cross_Chop,/obj/Moves/Karate_Chop,/obj/Moves/Mega_Punch,/obj/Moves/Screech,/obj/Moves/Thunder_Punch)
		Weight = 98.1
		Number = 126
		POKEIMAGE = '126.png'
		Unevolve = /mob/Pokemon/Magby
		Cry = '126.WAV'
		Abilities = list("Flame Body","Vital Spirit")
	Pinsir
		CaptureRate = 45
		Gender = 50
		icon = '127Pinsir.dmi'
		Type1 = "Bug"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 65, "ATK" = 125, "DEF" = 100, "SPL ATK" = 55, "SPL DEF" = 70, "SPD" = 85, "EXP" = 200)
		LearnMoves = list(/obj/Moves/ViceGrip = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Bind = 7,/obj/Moves/Seismic_Toss = 13,/obj/Moves/Harden = 19,/obj/Moves/Brick_Break = 31,/obj/Moves/Guillotine = 37,/obj/Moves/Submission = 43,/obj/Moves/Swords_Dance = 49)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Fury_Attack,/obj/Moves/Faint_Attack,/obj/Moves/False_Swipe)
		Weight = 121.3
		Number = 127
		POKEIMAGE = '127.png'
		Cry = '127.WAV'
		Abilities = list("Hyper Cutter","Mold Breaker","Moxie")
	Tauros
		CaptureRate = 45
		Gender = 100
		icon = '128Tauros.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 75, "ATK" = 100, "DEF" = 95, "SPL ATK" = 40, "SPL DEF" = 70, "SPD" = 110, "EXP" = 211)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Tail_Whip = 4,/obj/Moves/Rage = 8,/obj/Moves/Horn_Attack = 13,/obj/Moves/Scary_Face = 19,/obj/Moves/Pursuit = 26,/obj/Moves/Rest = 34,/obj/Moves/Thrash = 43,/obj/Moves/Take_Down = 53)
		EggGroups = list("Field")
		Weight = 194.9
		Number = 128
		POKEIMAGE = '128.png'
		Cry = '128.WAV'
		Abilities = list("Intimidate","Anger Point","Sheer Force")
	Magikarp
		icon = '129Magikarp.dmi'
		CaptureRate = 255
		Type1 = "Water"
		GrowthRate = "Slow"
		Evolve = list("Level 20" = /mob/Pokemon/Gyarados)
		Gender = 50
		BaseStats = list("HP" = 20, "ATK" = 10, "DEF" = 55, "SPL ATK" = 15, "SPL DEF" = 20, "SPD" = 80, "EXP" = 20)
		LearnMoves = list(/obj/Moves/Splash = 1, /obj/Moves/Tackle = 15,/obj/Moves/Flail = 30)
		EggGroups = list("Water 2","Dragon")
		Weight = 22.0
		Number = 129
		POKEIMAGE = '129.png'
		Cry = '129.WAV'
		Abilities = list("Swift Swim","Rattled")
	Gyarados
		icon = '130Gyarados.dmi'
		pixel_y = -25 //Size - 32 / 2
		pixel_x = -25
		Type1 = "Water"
		Type2 = "Flying"
		GrowthRate = "Slow"
		CaptureRate = 45
		Gender = 50
		BaseStats = list("HP" = 95, "ATK" = 125, "DEF" = 79, "SPL ATK" = 60, "SPL DEF" = 100, "SPD" = 81, "EXP" = 214)
		LearnMoves = list(/obj/Moves/Thrash = 1, /obj/Moves/Bite = 20, /obj/Moves/Dragon_Rage = 25, /obj/Moves/Leer = 30, /obj/Moves/Twister = 35, /obj/Moves/Hydro_Pump = 40,/obj/Moves/Hyper_Beam = 55,/obj/Moves/Rain_Dance = 45,/obj/Moves/Dragon_Dance = 50)
		EggGroups = list("Water 2","Dragon")
		Weight = 518.1
		Number = 130
		POKEIMAGE = '130.png'
		Unevolve = /mob/Pokemon/Magikarp
		Cry = '130.WAV'
		Abilities = list("Intimidate","Moxie")
	Lapras
		Gender = 50
		icon = '131Lapras.dmi'
		pixel_y = -7
		pixel_x = -7
		CaptureRate = 45
		Type1 = "Water"
		Type2 = "Ice"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 130, "ATK" = 85, "DEF" = 80, "SPL ATK" = 85, "SPL DEF" = 95, "SPD" = 60, "EXP" = 219)
		LearnMoves = list(/obj/Moves/Water_Gun = 1,/obj/Moves/Growl = 1,/obj/Moves/Sing = 1,/obj/Moves/Mist = 7,/obj/Moves/Body_Slam = 13,/obj/Moves/Confuse_Ray = 19,/obj/Moves/Perish_Song = 25,/obj/Moves/Ice_Beam = 31,/obj/Moves/Rain_Dance = 37,/obj/Moves/Safeguard = 43,/obj/Moves/Hydro_Pump = 49,/obj/Moves/Sheer_Cold = 55)
		EggGroups = list("Monster","Water 1")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Foresight)
		Weight = 485.0
		Number = 131
		POKEIMAGE = '131.png'
		Cry = '131.WAV'
		Abilities = list("Water Absorb","Shell Armor","Hydration")
	Ditto
		Gender = "Ditto"
		CaptureRate = 35
		icon = '132Ditto.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 48, "ATK" = 48, "DEF" = 48, "SPL ATK" = 48, "SPL DEF" = 48, "SPD" = 48, "EXP" = 61)
		LearnMoves = list(/obj/Moves/Transform = 1)
		EggGroups = list("Ditto")
		Weight = 8.8
		Number = 132
		POKEIMAGE = '132.png'
		Cry = '132.WAV'
		Abilities = list("Limber","Imposter")
	Eevee
		icon = '133Eevee.dmi'
		Gender = 87
		GrowthRate = "Medium-Fast"
		Type1 = "Normal"
		Weight = 14.3
		Number = 133
		EggGroups = list("Field")
		Evolve = list("Firestone" = /mob/Pokemon/Flareon, "Waterstone" = /mob/Pokemon/Vaporeon, "Thunderstone" = /mob/Pokemon/Jolteon, "DayHappiness" = /mob/Pokemon/Espeon, "NightHappiness" = /mob/Pokemon/Umbreon)
		CaptureRate = 45
		BaseStats = list("HP" = 55, "ATK" = 55, "DEF" = 50, "SPL ATK" = 45, "SPL DEF" = 65, "SPD" = 55, "EXP" = 92)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Tail_Whip = 1, /obj/Moves/Helping_Hand, /obj/Moves/Sand_Attack = 8, /obj/Moves/Growl = 16, /obj/Moves/Quick_Attack = 23, /obj/Moves/Bite = 30,/obj/Moves/Baton_Pass = 36,/obj/Moves/Take_Down = 42)
		POKEIMAGE = '133.png'
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Curse,/obj/Moves/Flail,/obj/Moves/Tickle,/obj/Moves/Wish)
		Cry = '133.WAV'
		Abilities = list("Run Away","Adaptability","Anticipation")
	Vaporeon
		icon = '134Vaporeon.dmi'
		Gender = 87
		CaptureRate = 45
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 130, "ATK" = 65, "DEF" = 60, "SPL ATK" = 110, "SPL DEF" = 95, "SPD" = 66, "EXP" = 196)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Helping_Hand,/obj/Moves/Sand_Attack = 8,/obj/Moves/Water_Gun = 16,/obj/Moves/Quick_Attack = 23,/obj/Moves/Bite = 30,/obj/Moves/Aurora_Beam = 36,/obj/Moves/Haze = 42,/obj/Moves/Acid_Armor = 47,/obj/Moves/Hydro_Pump = 52)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Curse,/obj/Moves/Flail,/obj/Moves/Tickle,/obj/Moves/Wish)
		Weight = 63.9
		Number = 134
		POKEIMAGE = '134.png'
		Unevolve = /mob/Pokemon/Eevee
		Cry = '134.WAV'
		Abilities = list("Water Absorb","Hydration")
	Jolteon
		icon = '135Jolteon.dmi'
		Gender = 87
		Number = 135
		POKEIMAGE = '135.png'
		CaptureRate = 45
		Type1 = "Electric"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 65, "DEF" = 60, "SPL ATK" = 110, "SPL DEF" = 95, "SPD" = 130, "EXP" = 197)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Sand_Attack = 8,/obj/Moves/Thundershock = 16,/obj/Moves/Quick_Attack = 23,/obj/Moves/Double_Kick = 30,/obj/Moves/Pin_Missle = 36,/obj/Moves/Thunder_Wave = 42,/obj/Moves/Agility = 47,/obj/Moves/Thunder = 52)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Curse,/obj/Moves/Flail,/obj/Moves/Tickle,/obj/Moves/Wish)
		Weight = 54.0
		Unevolve = /mob/Pokemon/Eevee
		Cry = '135.WAV'
		Abilities = list("Volt Absorb","Quick Feet")
	Flareon
		icon = '136Flareon.dmi'
		Gender = 87
		CaptureRate = 45
		Type1 = "Fire"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 130, "DEF" = 60, "SPL ATK" = 95, "SPL DEF" = 110, "SPD" = 66, "EXP" = 198)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Sand_Attack = 8,/obj/Moves/Ember = 16,/obj/Moves/Quick_Attack = 23,/obj/Moves/Bite = 30,/obj/Moves/Fire_Spin = 36,/obj/Moves/Smog = 42,/obj/Moves/Leer = 47,/obj/Moves/Flamethrower = 52)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Curse,/obj/Moves/Flail,/obj/Moves/Tickle,/obj/Moves/Wish)
		Weight = 55.1
		Number = 136
		POKEIMAGE = '136.png'
		Unevolve = /mob/Pokemon/Eevee
		Cry = '136.WAV'
		Abilities = list("Flash Fire","Guts")
	Porygon
		icon = '137Porygon.dmi'
		Gender = "Genderless"
		CaptureRate = 45
		GrowthRate = "Medium-Fast" //1,000,000
		Type1 = "Normal"
		Weight = 80.5
		Number = 137
		POKEIMAGE = '137.png'
		EggGroups = list("Mineral")
		Evolve = list("Trade" = /mob/Pokemon/Porygon2, "TradeItem" = /obj/HeldItems/Evolution/Up_Grade)
		BaseStats = list("HP" = 65, "ATK" = 60, "DEF" = 70, "SPL ATK" = 85, "SPL DEF" = 75, "SPD" = 40, "EXP" = 130)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Conversion = 1, /obj/Moves/Conversion_2 = 1, /obj/Moves/Agility = 9, /obj/Moves/Psybeam = 12, /obj/Moves/Recover = 20,/obj/Moves/Sharpen = 24,/obj/Moves/Lock_On = 32,/obj/Moves/Tri_Attack = 36,/obj/Moves/Zap_Cannon = 48 )
		Cry = '137.WAV'
		Abilities = list("Trace","Download","Analytic")
	Omanyte
		icon = '138Omanyte.dmi'
		Gender = 87
		CaptureRate = 45
		GrowthRate = "Medium-Fast" //1,000,000
		Type1 = "Rock"
		Type2 = "Water"
		Weight = 16.5
		Number = 138
		POKEIMAGE = '139.png'
		EggGroups = list("Water 1", "Water 3")
		Evolve = list("Level 40" = /mob/Pokemon/Omastar)
		BaseStats = list("HP" = 35, "ATK" = 40, "DEF" = 100, "SPL ATK" = 90, "SPL DEF" = 55, "SPD" = 35, "EXP" = 120)
		LearnMoves = list(/obj/Moves/Constrict = 1, /obj/Moves/Withdraw = 1, /obj/Moves/Bite = 13, /obj/Moves/Water_Gun = 19,/obj/Moves/Mud_Shot = 25, /obj/Moves/Leer = 31, /obj/Moves/Protect = 37,/obj/Moves/Tickle = 43,/obj/Moves/Ancient_Power = 49,/obj/Moves/Hydro_Pump = 55)
		Cry = '138.WAV'
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Haze,/obj/Moves/Bubblebeam,/obj/Moves/Slam,/obj/Moves/Supersonic)
		Abilities = list("Swift Swim","Shell Armor","Weak Armor")
	Omastar
		icon = '139Omastar.dmi'
		Gender = 87
		GrowthRate = "Medium-Fast" //1,000,000
		Type1 = "Rock"
		Type2 = "Water"
		Weight = 77.2
		Number = 139
		POKEIMAGE = '139.png'
		EggGroups = list("Water 1", "Water 3")
		Unevolve = /mob/Pokemon/Omanyte
		CaptureRate = 45
		BaseStats = list("HP" = 70, "ATK" = 60, "DEF" = 125, "SPL ATK" = 115, "SPL DEF" = 70, "SPD" = 66, "EXP" = 199)
		LearnMoves = list(/obj/Moves/Constrict = 1, /obj/Moves/Withdraw = 1, /obj/Moves/Bite = 1, /obj/Moves/Water_Gun = 19,/obj/Moves/Mud_Shot = 25, /obj/Moves/Leer = 31, /obj/Moves/Protect = 37,/obj/Moves/Spike_Cannon = 40,/obj/Moves/Tickle = 46,/obj/Moves/Ancient_Power = 55,/obj/Moves/Hydro_Pump = 65)
		Cry = '139.WAV'
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Haze,/obj/Moves/Bubblebeam,/obj/Moves/Slam,/obj/Moves/Supersonic)
		Abilities = list("Swift Swim","Shell Armor","Weak Armor")
	Kabuto
		icon = '140Kabuto.dmi'
		Gender = 87
		GrowthRate = "Medium-Fast" //1,000,000
		Type1 = "Rock"
		Type2 = "Water"
		CaptureRate = 45
		Weight = 25.4
		Number = 140
		POKEIMAGE = '140.png'
		Evolve = list("Level 40")
		EggGroups = list("Water 1", "Water 3")
		BaseStats = list("HP" = 30, "ATK" = 80, "DEF" = 90, "SPL ATK" = 55, "SPL DEF" = 45, "SPD" = 55, "EXP" = 119)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Harden = 1, /obj/Moves/Absorb = 13, /obj/Moves/Leer = 19,/obj/Moves/Mud_Shot = 25, /obj/Moves/Sand_Attack = 31, /obj/Moves/Endure = 37,/obj/Moves/Metal_Sound = 43,/obj/Moves/Mega_Drain = 49,/obj/Moves/Ancient_Power = 55)
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Bubblebeam,/obj/Moves/Confuse_Ray,/obj/HMs/Dig,/obj/Moves/Flail,/obj/Moves/Rapid_Spin)
		Cry = '140.WAV'
		Abilities = list("Swift Swim","Battle Armor","Weak Armor")
	Kabutops
		icon = '141Kabutops.dmi'
		Gender = 87
		GrowthRate = "Medium-Fast" //1,000,000
		Type1 = "Rock"
		Type2 = "Water"
		CaptureRate = 45
		Weight = 89.3
		Number = 141
		POKEIMAGE = '141.png'
		EggGroups = list("Water 1", "Water 3")
		BaseStats = list("HP" = 60, "ATK" = 115, "DEF" = 105, "SPL ATK" = 65, "SPL DEF" = 70, "SPD" = 80, "EXP" = 201)
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Harden = 1, /obj/Moves/Absorb = 1,/obj/Moves/Leer = 19,/obj/Moves/Mud_Shot = 25, /obj/Moves/Sand_Attack = 31, /obj/Moves/Endure = 37,/obj/Moves/Slash = 40,/obj/Moves/Metal_Sound = 46,/obj/Moves/Mega_Drain = 55,/obj/Moves/Ancient_Power = 65)
		Unevolve = /mob/Pokemon/Kabuto
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Bubblebeam,/obj/Moves/Confuse_Ray,/obj/HMs/Dig,/obj/Moves/Flail,/obj/Moves/Rapid_Spin)
		Cry = '141.WAV'
		Abilities = list("Swift Swim","Battle Armor","Weak Armor")
	Aerodactyl
		icon = '142Aerodactyl.dmi'
		Gender = 87
		GrowthRate = "Slow"//1,250,000
		Type1 = "Rock"
		Type2 = "Flying"
		CaptureRate = 45
		Weight = 130.1
		Number = 142
		POKEIMAGE = '142.png'
		EggGroups = list("Flying")
		BaseStats = list("HP" = 80, "ATK" = 105, "DEF" = 65, "SPL ATK" = 60, "SPL DEF" = 75, "SPD" = 130, "EXP" = 202)
		LearnMoves = list(/obj/Moves/Wing_Attack = 1, /obj/Moves/Agility = 8, /obj/Moves/Bite = 15, /obj/Moves/Supersonic = 22, /obj/Moves/Ancient_Power = 29, /obj/Moves/Scary_Face = 36,/obj/Moves/Take_Down = 43,/obj/Moves/Hyper_Beam = 50)
		POKEIMAGE = '142.png'
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Dragon_Breath,/obj/Moves/Foresight,/obj/Moves/Pursuit,/obj/Moves/Steel_Wing,/obj/Moves/Whirlwind)
		Cry = '142.WAV'
		Abilities = list("Rock Head","Pressure","Unnerve")
	Snorlax
		icon = '143Snorlax.dmi'
		Gender = 87
		GrowthRate = "Slow"//1,250,000
		Type1 = "Normal"
		CaptureRate = 25
		Weight = 1014.1
		Number = 143
		EggGroups = list("Monster")
		BaseStats = list("HP" = 160, "ATK" = 110, "DEF" = 65, "SPL ATK" = 65, "SPL DEF" = 110, "SPD" = 30, "EXP" = 154)
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Amnesia = 8, /obj/Moves/Defense_Curl = 15, /obj/Moves/Belly_Drum = 22, /obj/Moves/Headbutt = 29, /obj/Moves/Rest = 36,/obj/Moves/Snore = 36,/obj/Moves/Body_Slam = 43,/obj/Moves/Rollout = 50,/obj/Moves/Hyper_Beam = 57)
		POKEIMAGE = '143.png'
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Curse,/obj/Moves/Double_Edge,/obj/Moves/Fissure,/obj/Moves/Lick,/obj/Moves/Substitute)
		Cry = '143.WAV'
		Abilities = list("Immunity","Thick Fat","Gluttony")
	Articuno
		icon = '144Articuno.dmi'
		Gender = "Unbreedable"
		GrowthRate = "Slow"//1,250,000
		Type1 = "Ice"
		Type2 = "Flying"
		NonTradable = 1
		CaptureRate = 3
		Weight = 122.1
		Number = 144
		POKEIMAGE = '144.png'
		BaseStats = list("HP" = 90, "ATK" = 85, "DEF" = 100, "SPL ATK" = 95, "SPL DEF" = 125, "SPD" = 85, "EXP" = 215)
		LearnMoves = list(/obj/Moves/Wing_Attack = 1, /obj/Moves/Gust = 1, /obj/Moves/Powder_Snow = 1, /obj/Moves/Mist = 13, /obj/Moves/Agility = 25, /obj/Moves/Mind_Reader = 37,/obj/Moves/Ice_Beam = 49,/obj/Moves/Reflect = 61,/obj/Moves/Blizzard = 73)
		Cry = '144.WAV'
		Abilities = list("Pressure","Snow Cloak")
	Zapdos
		icon = '145Zapdos.dmi'
		Gender = "Unbreedable"
		GrowthRate = "Slow"//1,250,000
		Type1 = "Electric"
		Type2 = "Flying"
		NonTradable = 1
		CaptureRate = 3
		Weight = 116.0
		Number = 145
		POKEIMAGE = '145.png'
		pixel_y = -15
		pixel_x = -15
		BaseStats = list("HP" = 90, "ATK" = 90, "DEF" = 85, "SPL ATK" = 125, "SPL DEF" = 90, "SPD" = 100, "EXP" = 216)
		LearnMoves = list(/obj/Moves/Wing_Attack = 1, /obj/Moves/Thundershock = 1, /obj/Moves/Peck = 1, /obj/Moves/Thunder_Wave = 13, /obj/Moves/Agility = 25, /obj/Moves/Detect = 37,/obj/Moves/Drill_Peck = 49,/obj/Moves/Light_Screen = 61,/obj/Moves/Thunder = 73)
		Cry = '145.WAV'
		Abilities = list("Pressure","Lightningrod")
	Moltres
		icon = '146Moltres.dmi'
		pixel_y = -29
		pixel_x = -24
		Gender = "Unbreedable"
		GrowthRate = "Slow"//1,250,000
		Type1 = "Fire"
		Type2 = "Flying"
		NonTradable = 1
		CaptureRate = 3
		Weight = 132.3
		Number = 146
		POKEIMAGE = '146.png'
		BaseStats = list("HP" = 90, "ATK" = 100, "DEF" = 90, "SPL ATK" = 125, "SPL DEF" = 85, "SPD" = 90, "EXP" = 217)
		LearnMoves = list(/obj/Moves/Wing_Attack = 1, /obj/Moves/Ember = 1, /obj/Moves/Fire_Spin = 13, /obj/Moves/Agility = 25, /obj/Moves/Endure = 37, /obj/Moves/Flamethrower = 49,/obj/Moves/Safeguard = 61,/obj/Moves/Sky_Attack = 73)
		Cry = '146.WAV'
		Abilities = list("Pressure","Flame Body")
	Dratini
		icon = '147Dratini.dmi'
		Gender = 50
		GrowthRate = "Slow"//1,250,000
		Type1 = "Dragon"
		CaptureRate = 45
		Weight = 7.3
		Number = 147
		POKEIMAGE = '147.png'
		Evolve = list("Level 30" = /mob/Pokemon/Dragonair)
		EggGroups = list("Water 1","Dragon")
		BaseStats = list("HP" = 41, "ATK" = 64, "DEF" = 45, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 50, "EXP" = 67)
		LearnMoves = list(/obj/Moves/Wrap = 1, /obj/Moves/Leer = 1, /obj/Moves/Thunder_Wave = 8, /obj/Moves/Twister = 15, /obj/Moves/Dragon_Rage = 22, /obj/Moves/Slam = 29,/obj/Moves/Agility = 36,/obj/Moves/Safeguard = 43,/obj/Moves/Outrage = 50,/obj/Moves/Hyper_Beam = 57)
		EggMoves = list(/obj/Moves/Dragon_Breath,/obj/Moves/Dragon_Dance,/obj/Moves/Haze,/obj/Moves/Light_Screen,/obj/Moves/Mist,/obj/Moves/Supersonic)
		Cry = '147.WAV'
		Abilities = list("Shed Skin","Marvel Scale")
	Dragonair
		icon = '148Dragonair.dmi'
		GrowthRate = "Slow"//1,250,000
		Type1 = "Dragon"
		Gender = 50
		CaptureRate = 45
		Weight = 36.4
		Number = 148
		POKEIMAGE = '148.png'
		Evolve = list("Level 55" = /mob/Pokemon/Dragonite)
		Unevolve = /mob/Pokemon/Dratini
		EggGroups = list("Water 1","Dragon")
		BaseStats = list("HP" = 61, "ATK" = 84, "DEF" = 65, "SPL ATK" = 70, "SPL DEF" = 70, "SPD" = 70, "EXP" = 144)
		LearnMoves = list(/obj/Moves/Wrap = 1, /obj/Moves/Leer = 1, /obj/Moves/Thunder_Wave = 1, /obj/Moves/Twister = 15, /obj/Moves/Dragon_Rage = 22, /obj/Moves/Slam = 29,/obj/Moves/Agility = 38,/obj/Moves/Safeguard = 47,/obj/Moves/Outrage = 56,/obj/Moves/Hyper_Beam = 65)
		EggMoves = list(/obj/Moves/Dragon_Breath,/obj/Moves/Dragon_Dance,/obj/Moves/Haze,/obj/Moves/Light_Screen,/obj/Moves/Mist,/obj/Moves/Supersonic)
		Cry = '148.WAV'
		Abilities = list("Shed Skin","Marvel Scale")
	Dragonite
		icon = '149Dragonite.dmi'
		GrowthRate = "Slow"//1,250,000
		Gender = 50
		CaptureRate = 45
		Type1 = "Dragon"
		Type2 = "Flying"
		EggGroups = list("Water 1","Dragon")
		Unevolve = /mob/Pokemon/Dragonair
		Weight = 463.0
		Number = 149
		POKEIMAGE = '149.png'
		BaseStats = list("HP" = 91, "ATK" = 134, "DEF" = 95, "SPL ATK" = 100, "SPL DEF" = 100, "SPD" = 80, "EXP" = 218)
		LearnMoves = list(/obj/Moves/Wrap = 1, /obj/Moves/Leer = 1, /obj/Moves/Thunder_Wave = 1, /obj/Moves/Twister = 15, /obj/Moves/Dragon_Rage = 22, /obj/Moves/Slam = 29,/obj/Moves/Agility = 38,/obj/Moves/Safeguard = 45,/obj/Moves/Wing_Attack = 55,/obj/Moves/Outrage = 61,/obj/Moves/Hyper_Beam = 75)
		EggMoves = list(/obj/Moves/Dragon_Breath,/obj/Moves/Dragon_Dance,/obj/Moves/Haze,/obj/Moves/Light_Screen,/obj/Moves/Mist,/obj/Moves/Supersonic)
		Cry = '149.WAV'
		Abilities = list("Inner Focus","Multiscale")
	Mewtwo
		icon = '150Mewtwo.dmi'
		GrowthRate = "Slow"//1,250,000
		CaptureRate = 3
		Gender = "Unbreedable"
		Type1 = "Psychic"
		Number = 150
		POKEIMAGE = '150.png'
		Weight = 269.0
		NonTradable = 1
		BaseStats = list("HP" = 106, "ATK" = 110, "DEF" = 90, "SPL ATK" = 154, "SPL DEF" = 154, "SPD" = 130, "EXP" = 220)
		LearnMoves = list(/obj/Moves/Confusion = 1, /obj/Moves/Disable = 1, /obj/Moves/Barrier = 11, /obj/Moves/Swift = 22, /obj/Moves/Psych_Up,/obj/Moves/Future_Sight = 44, /obj/Moves/Mist = 55,/obj/Moves/Psychic = 66,/obj/Moves/Amnesia = 77,/obj/Moves/Recover = 88,/obj/Moves/Safeguard = 99)
		Cry = '150.WAV'
		Abilities = list("Pressure","Unnerve")
	Mew
		CaptureRate = 45
		Gender = "Unbreedable"
		icon = '151Mew.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 100, "ATK" = 100, "DEF" = 100, "SPL ATK" = 100, "SPL DEF" = 100, "SPD" = 100, "EXP" = 64)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Transform = 10,/obj/Moves/Mega_Punch = 20,/obj/Moves/Metronome = 30,/obj/Moves/Psychic = 40,/obj/Moves/Ancient_Power = 50)
		Weight = 8.8
		Number = 151
		POKEIMAGE = '151.png'
		Cry = '151.WAV'
		Abilities = list("Synchronize")
	Chikorita
		icon = '152Chikorita.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 1,/obj/Moves/Razor_Leaf = 8,/obj/Moves/Reflect = 12,/obj/Moves/PoisonPowder = 15,/obj/Moves/Synthesis = 22,/obj/Moves/Body_Slam = 29,/obj/Moves/Light_Screen = 36,/obj/Moves/Safeguard = 43,/obj/Moves/SolarBeam = 50)
		Evolve = list("Level 16" = /mob/Pokemon/Bayleef)
		Type1 = "Grass"
		BaseStats = list("HP" = 45, "ATK" = 49, "DEF" = 65, "SPL ATK" = 49, "SPL DEF" = 65, "SPD" = 45, "EXP" = 64)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 152
		EggGroups = list("Monster", "Grass")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Counter,/obj/Moves/Flail,/obj/Moves/Leech_Seed,/obj/Moves/Swords_Dance,/obj/Moves/Vine_Whip,/obj/Moves/Nature_Power,/obj/Moves/GrassWhistle,/obj/Moves/Ingrain)
		Weight = 14.1
		POKEIMAGE = '152.png'
		Abilities = list("Overgrow")
		HiddenAbility = list("Leaf Guard")
	Bayleef
		icon = '153Bayleef.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 1,/obj/Moves/Razor_Leaf = 1,/obj/Moves/Reflect = 1,/obj/Moves/PoisonPowder = 15,/obj/Moves/Synthesis = 22,/obj/Moves/Body_Slam = 31,/obj/Moves/Light_Screen = 39,/obj/Moves/Safeguard = 47,/obj/Moves/SolarBeam = 55)
		Unevolve = /mob/Pokemon/Chikorita
		Evolve = list("Level 36" = /mob/Pokemon/Meganium)
		Type1 = "Grass"
		BaseStats = list("HP" = 60, "ATK" = 62, "DEF" = 80, "SPL ATK" = 63, "SPL DEF" = 80, "SPD" = 60, "EXP" = 141)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 153
		EggGroups = list("Monster", "Grass")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Counter,/obj/Moves/Flail,/obj/Moves/Leech_Seed,/obj/Moves/Swords_Dance,/obj/Moves/Vine_Whip,/obj/Moves/Nature_Power,/obj/Moves/GrassWhistle,/obj/Moves/Ingrain)
		Weight = 14.1
		POKEIMAGE = '153.png'
		Abilities = list("Overgrow")
		HiddenAbility = list("Leaf Guard")
	Meganium
		icon = '154Meganium.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 1,/obj/Moves/Razor_Leaf = 1,/obj/Moves/Reflect = 1,/obj/Moves/PoisonPowder = 15,/obj/Moves/Synthesis = 22,/obj/Moves/Body_Slam = 31,/obj/Moves/Light_Screen = 41,/obj/Moves/Safeguard = 51,/obj/Moves/SolarBeam = 61)
		Type1 = "Grass"
		Unevolve = /mob/Pokemon/Bayleef
		BaseStats = list("HP" = 80, "ATK" = 82, "DEF" = 100, "SPL ATK" = 83, "SPL DEF" = 100, "SPD" = 80, "EXP" = 208)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 154
		EggGroups = list("Monster", "Grass")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Counter,/obj/Moves/Flail,/obj/Moves/Leech_Seed,/obj/Moves/Swords_Dance,/obj/Moves/Vine_Whip,/obj/Moves/Nature_Power,/obj/Moves/GrassWhistle,/obj/Moves/Ingrain)
		Weight = 221.6
		POKEIMAGE = '154.png'
		Abilities = list("Overgrow")
		HiddenAbility = list("Leaf Guard")
	Cyndaquil
		icon = '155Cyndaquil.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Leer = 1,/obj/Moves/Smokescreen = 6,/obj/Moves/Ember = 12,/obj/Moves/Quick_Attack = 19,/obj/Moves/Flame_Wheel = 27,/obj/Moves/Swift = 36,/obj/Moves/Flamethrower = 46)
		Evolve = list("Level 14" = /mob/Pokemon/Quilava)
		Type1 = "Fire"
		BaseStats = list("HP" = 39, "ATK" = 52, "DEF" = 43, "SPL ATK" = 60, "SPL DEF" = 50, "SPD" = 65, "EXP" = 65)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 155
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Covet,/obj/Moves/Crush_Claw,/obj/Moves/Foresight,/obj/Moves/Fury_Swipes,/obj/Moves/Howl,/obj/Moves/Reversal,/obj/Moves/Thrash)
		Weight = 17.4
		POKEIMAGE = '155.png'
		Abilities = list("Blaze")
		HiddenAbility = list("Flash Fire")
	Quilava
		icon = '156Quilava.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Leer = 1,/obj/Moves/Smokescreen = 1,/obj/Moves/Ember = 12,/obj/Moves/Quick_Attack = 21,/obj/Moves/Flame_Wheel = 31,/obj/Moves/Swift = 42,/obj/Moves/Flamethrower = 54)
		Unevolve = /mob/Pokemon/Cyndaquil
		Evolve = list("Level 36" = /mob/Pokemon/Typhlosion)
		Type1 = "Fire"
		BaseStats = list("HP" = 58, "ATK" = 64, "DEF" = 58, "SPL ATK" = 80, "SPL DEF" = 65, "SPD" = 80, "EXP" = 142)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 156
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Covet,/obj/Moves/Crush_Claw,/obj/Moves/Foresight,/obj/Moves/Fury_Swipes,/obj/Moves/Howl,/obj/Moves/Reversal,/obj/Moves/Thrash)
		Weight = 41.9
		POKEIMAGE = '156.png'
		Abilities = list("Blaze")
		HiddenAbility = list("Flash Fire")
	Typhlosion
		icon = '157Typhlosion.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Leer = 1,/obj/Moves/Smokescreen = 6,/obj/Moves/Ember = 12,/obj/Moves/Quick_Attack = 21,/obj/Moves/Flame_Wheel = 31,/obj/Moves/Swift = 45,/obj/Moves/Flamethrower = 60)
		Unevolve = /mob/Pokemon/Quilava
		Type1 = "Fire"
		BaseStats = list("HP" = 78, "ATK" = 84, "DEF" = 78, "SPL ATK" = 109, "SPL DEF" = 85, "SPD" = 101, "EXP" = 209)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 157
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Covet,/obj/Moves/Crush_Claw,/obj/Moves/Foresight,/obj/Moves/Fury_Swipes,/obj/Moves/Howl,/obj/Moves/Reversal,/obj/Moves/Thrash)
		Weight = 17.4
		POKEIMAGE = '157.png'
		Abilities = list("Blaze")
		HiddenAbility = list("Flash Fire")
	Totodile
		icon = '158Totodile.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Leer = 1,/obj/Moves/Rage = 7,/obj/Moves/Water_Gun = 13,/obj/Moves/Bite = 20,/obj/Moves/Scary_Face = 27,/obj/Moves/Slash = 35,/obj/Moves/Screech = 43,/obj/Moves/Hydro_Pump = 52)
		Evolve = list("Level 18" = /mob/Pokemon/Croconaw)
		Type1 = "Water"
		BaseStats = list("HP" = 50, "ATK" = 65, "DEF" = 64, "SPL ATK" = 44, "SPL DEF" = 48, "SPD" = 43, "EXP" = 66)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 158
		EggGroups = list("Monster", "Water 1")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Crunch,/obj/Moves/Dragon_Claw,/obj/Moves/Mud_Sport,/obj/Moves/Rock_Slide,/obj/Moves/Thrash,/obj/Moves/Water_Sport)
		Weight = 20.9
		POKEIMAGE = '158.png'
		Abilities = list("Torrent")
		HiddenAbility = list("Sheer Force")
	Croconaw
		icon = '159Croconaw.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Leer = 1,/obj/Moves/Rage = 7,/obj/Moves/Water_Gun = 13,/obj/Moves/Bite = 20,/obj/Moves/Scary_Face = 27,/obj/Moves/Slash = 35,/obj/Moves/Screech = 43,/obj/Moves/Hydro_Pump = 52)
		Evolve = list("Level 30" = /mob/Pokemon/Feraligatr)
		Unevolve = /mob/Pokemon/Totodile
		Type1 = "Water"
		BaseStats = list("HP" = 65, "ATK" = 80, "DEF" = 80, "SPL ATK" = 59, "SPL DEF" = 63, "SPD" = 58, "EXP" = 143)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 159
		EggGroups = list("Monster", "Water 1")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Crunch,/obj/Moves/Dragon_Claw,/obj/Moves/Mud_Sport,/obj/Moves/Rock_Slide,/obj/Moves/Thrash,/obj/Moves/Water_Sport)
		Weight = 55.1
		POKEIMAGE = '159.png'
		Abilities = list("Torrent")
		HiddenAbility = list("Sheer Force")
	Feraligatr
		icon = '160Feraligatr.dmi'
		CaptureRate = 45
		Gender = 87
		LearnMoves = list(/obj/Moves/Scratch = 1, /obj/Moves/Leer = 1,/obj/Moves/Rage = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Bite = 21,/obj/Moves/Scary_Face = 28,/obj/Moves/Slash = 38,/obj/Moves/Screech = 47,/obj/Moves/Hydro_Pump = 58)
		Unevolve = /mob/Pokemon/Croconaw
		Type1 = "Water"
		BaseStats = list("HP" = 85, "ATK" = 105, "DEF" = 100, "SPL ATK" = 79, "SPL DEF" = 83, "SPD" = 78, "EXP" = 210)
		GrowthRate = "Medium-Slow"//1,059,860
		Number = 160
		EggGroups = list("Monster", "Water 1")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Crunch,/obj/Moves/Dragon_Claw,/obj/Moves/Mud_Sport,/obj/Moves/Rock_Slide,/obj/Moves/Thrash,/obj/Moves/Water_Sport)
		Weight = 195.8
		POKEIMAGE = '160.png'
		Abilities = list("Torrent")
		HiddenAbility = list("Sheer Force")
	Sentret
		icon = '161Sentret.dmi'
		CaptureRate = 255
		Gender = 50
		icon = '161Sentret.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 15" = /mob/Pokemon/Furret)
		BaseStats = list("HP" = 35, "ATK" = 46, "DEF" = 34, "SPL ATK" = 35, "SPL DEF" = 45, "SPD" = 20, "EXP" = 57)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Defense_Curl = 4,/obj/Moves/Quick_Attack = 7,/obj/Moves/Fury_Swipes = 12,/obj/Moves/Helping_Hand = 17,/obj/Moves/Slam = 24,/obj/Moves/Follow_Me = 31,/obj/Moves/Rest = 40,/obj/Moves/Amnesia = 49)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Assist,/obj/Moves/Double_Edge,/obj/Moves/Focus_Energy,/obj/Moves/Pursuit,/obj/Moves/Reversal,/obj/Moves/Slash,/obj/Moves/Substitute,/obj/Moves/Trick)
		Weight = 13.2
		Number = 161
		POKEIMAGE = '161.png'
		Abilities = list("Run Away","Keen Eye","Frisk")
	Furret
		icon = '162Furret.dmi'
		CaptureRate = 90
		Gender = 50
		icon = '162Furret.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 85, "ATK" = 76, "DEF" = 64, "SPL ATK" = 45, "SPL DEF" = 55, "SPD" = 90, "EXP" = 116)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Defense_Curl = 1,/obj/Moves/Quick_Attack = 1,/obj/Moves/Fury_Swipes = 12,/obj/Moves/Helping_Hand = 19,/obj/Moves/Slam = 28,/obj/Moves/Follow_Me = 37,/obj/Moves/Rest = 48,/obj/Moves/Amnesia = 59)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Assist,/obj/Moves/Double_Edge,/obj/Moves/Focus_Energy,/obj/Moves/Pursuit,/obj/Moves/Reversal,/obj/Moves/Slash,/obj/Moves/Substitute,/obj/Moves/Trick)
		Weight = 71.6
		Unevolve = /mob/Pokemon/Sentret
		Number = 162
		POKEIMAGE = '162.png'
		Abilities = list("Run Away","Keen Eye","Frisk")
	Hoothoot
		icon = '163Hoothoot.dmi'
		CaptureRate = 255
		Gender = 50
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 1,/obj/Moves/Foresight = 6,/obj/Moves/Peck = 11,/obj/Moves/Hypnosis = 16,/obj/Moves/Reflect = 22,/obj/Moves/Take_Down = 28,/obj/Moves/Confusion = 34,/obj/Moves/Dream_Eater = 48)
		Evolve = list("Level 20" = /mob/Pokemon/Noctowl)
		Type1 = "Normal"
		Type2 = "Flying"
		BaseStats = list("HP" = 60, "ATK" = 30, "DEF" = 30, "SPL ATK" = 36, "SPL DEF" = 56, "SPD" = 50, "EXP" = 58)
		GrowthRate = "Medium-Fast"//1,059,860
		Number = 163
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Mirror_Move,/obj/Moves/Sky_Attack,/obj/Moves/Supersonic,/obj/Moves/Wing_Attack,/obj/Moves/Whirlwind)
		Weight = 46.7
		POKEIMAGE = '163.png'
		Abilities = list("Insomia","Keen Eye","Tinted Lens")
	Noctowl
		icon = '164Noctowl.dmi'
		CaptureRate = 255
		Gender = 50
		LearnMoves = list(/obj/Moves/Tackle = 1, /obj/Moves/Growl = 1,/obj/Moves/Foresight = 1,/obj/Moves/Peck = 1,/obj/Moves/Hypnosis = 16,/obj/Moves/Reflect = 25,/obj/Moves/Take_Down = 33,/obj/Moves/Confusion = 41,/obj/Moves/Dream_Eater = 57)
		Unevolve = /mob/Pokemon/Hoothoot
		Type1 = "Normal"
		Type2 = "Flying"
		BaseStats = list("HP" = 100, "ATK" = 50, "DEF" = 50, "SPL ATK" = 76, "SPL DEF" = 96, "SPD" = 70, "EXP" = 162)
		GrowthRate = "Medium-Fast"//1,059,860
		Number = 164
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Mirror_Move,/obj/Moves/Sky_Attack,/obj/Moves/Supersonic,/obj/Moves/Wing_Attack,/obj/Moves/Whirlwind)
		Weight = 89.9
		POKEIMAGE = '164.png'
		Abilities = list("Insomia","Keen Eye","Tinted Lens")

	Ledyba
		icon = '165Ledyba.dmi'
		Gender = 50
		GrowthRate = "Fast"
		Type1 = "Bug"
		Type2 = "Flying"
		Evolve = list("Level 18" = /mob/Pokemon/Ledian)
		CaptureRate = 255
		BaseStats = list("HP" = 40, "ATK" = 20, "DEF" = 30, "SPL ATK" = 40, "SPL DEF" = 80, "SPD" = 55, "EXP" = 54)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Supersonic = 8,/obj/Moves/Comet_Punch = 15,/obj/Moves/Light_Screen =22,/obj/Moves/Reflect = 22,/obj/Moves/Safeguard = 22,/obj/Moves/Baton_Pass = 29,/obj/Moves/Swift = 36,/obj/Moves/Agility = 43,/obj/Moves/Double_Edge = 50)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Bide,/obj/Moves/Psybeam)
		Number = 165
		Weight = 23.8
		POKEIMAGE = '165.png'
		Abilities = list("Swarm","Early Bird","Rattled", "Iron Fist")
	Ledian
		icon = '166Ledian.dmi'
		Gender = 50
		GrowthRate = "Fast"
		Type1 = "Bug"
		Type2 = "Flying"
		CaptureRate = 90
		BaseStats = list("HP" = 55, "ATK" = 35, "DEF" = 50, "SPL ATK" = 55, "SPL DEF" = 110, "SPD" = 85, "EXP" = 134)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Supersonic = 1,/obj/Moves/Comet_Punch = 15,/obj/Moves/Light_Screen =24,/obj/Moves/Reflect = 24,/obj/Moves/Safeguard = 24,/obj/Moves/Baton_Pass = 33,/obj/Moves/Swift = 42,/obj/Moves/Agility = 51,/obj/Moves/Double_Edge = 60)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Bide,/obj/Moves/Psybeam)
		Weight = 78.5
		Unevolve = /mob/Pokemon/Ledyba
		Number = 166
		POKEIMAGE = '166.png'
		Abilities = list("Swarm","Early Bird","Rattled", "Iron Fist")
	Spinarak
		icon = '167Spinarak.dmi'
		Gender = 50
		GrowthRate = "Fast"
		Type1 = "Bug"
		Type2 = "Poison"
		Evolve = list("Level 22" = /mob/Pokemon/Ariados)
		CaptureRate = 255
		BaseStats = list("HP" = 40, "ATK" = 60, "DEF" = 40, "SPL ATK" = 50, "SPL DEF" = 40, "SPD" = 30, "EXP" = 54)
		LearnMoves = list(/obj/Moves/Poison_Sting = 1,/obj/Moves/String_Shot = 1,/obj/Moves/Scary_Face = 6,/obj/Moves/Constrict = 11,/obj/Moves/Night_Shade = 17,/obj/Moves/Leech_Life = 23,/obj/Moves/Fury_Swipes = 30,/obj/Moves/Spider_Web = 37,/obj/Moves/Screech = 45,/obj/Moves/Agility = 45,/obj/Moves/Psychic = 53)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Disable,/obj/Moves/Pursuit,/obj/Moves/Psybeam,/obj/Moves/Sonicboom)
		Weight = 18.7
		Number = 167
		POKEIMAGE = '167.png'
		Abilities = list("Swarm","Insomia","Sniper")
	Ariados
		icon = '168Ariados.dmi'
		Gender = 50
		GrowthRate = "Fast"
		Type1 = "Bug"
		Type2 = "Poison"
		CaptureRate = 90
		BaseStats = list("HP" = 70, "ATK" = 90, "DEF" = 70, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 40, "EXP" = 134)
		LearnMoves = list(/obj/Moves/Poison_Sting = 1,/obj/Moves/String_Shot = 1,/obj/Moves/Scary_Face = 6,/obj/Moves/Constrict = 11,/obj/Moves/Night_Shade = 17,/obj/Moves/Leech_Life = 25,/obj/Moves/Fury_Swipes = 34,/obj/Moves/Spider_Web = 43,/obj/Moves/Screech = 53,/obj/Moves/Agility = 53,/obj/Moves/Psychic = 63)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Disable,/obj/Moves/Pursuit,/obj/Moves/Psybeam,/obj/Moves/Sonicboom)
		Weight = 73.9
		Number = 168
		Unevolve = /mob/Pokemon/Spinarak
		POKEIMAGE = '168.png'
		Abilities = list("Swarm","Insomia","Sniper")
	Crobat
		CaptureRate = 90
		Gender = 50
		icon = '169Crobat.dmi'
		Type1 = "Poison"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 85, "ATK" = 90, "DEF" = 80, "SPL ATK" = 70, "SPL DEF" = 80, "SPD" = 130, "EXP" = 204)
		LearnMoves = list(/obj/Moves/Screech = 1,/obj/Moves/Leech_Life = 1,/obj/Moves/Supersonic = 1,/obj/Moves/Bite = 1,/obj/Moves/Confuse_Ray = 19,/obj/Moves/Wing_Attack = 30,/obj/Moves/Mean_Look = 42,/obj/Moves/Haze = 55)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Gust,/obj/Moves/Pursuit,/obj/Moves/Quick_Attack,/obj/Moves/Whirlwind)
		Weight = 165.3
		Number = 169
		POKEIMAGE = '169.png'
		Abilities = list("Inner Focus","Infiltrator")
	Chinchou
		CaptureRate = 190
		Gender = 50
		icon = '170Chinchou.dmi'
		Type1 = "Water"
		Type2 = "Electric"
		GrowthRate = "Slow"
		Evolve = list("Level 27" = /mob/Pokemon/Lanturn)
		BaseStats = list("HP" = 75, "ATK" = 38, "DEF" = 38, "SPL ATK" = 56, "SPL DEF" = 56, "SPD" = 67, "EXP" = 90)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Thunder_Wave = 1,/obj/Moves/Supersonic = 5,/obj/Moves/Flail = 13,/obj/Moves/Water_Gun = 17,/obj/Moves/Spark = 25,/obj/Moves/Confuse_Ray = 29,/obj/Moves/Take_Down = 37,/obj/Moves/Hydro_Pump = 41)
		EggGroups = list("Water 2")
		EggMoves = list(/obj/Moves/Screech)
		Weight = 26.5
		Number = 170
		POKEIMAGE = '170.png'
		Abilities = list("Volt Absorb","Illuminate","Water Absorb")
	Lanturn
		CaptureRate = 75
		Gender = 50
		icon = '171Lanturn.dmi'
		Type1 = "Water"
		Type2 = "Electric"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 125, "ATK" = 58, "DEF" = 58, "SPL ATK" = 76, "SPL DEF" = 76, "SPD" = 67, "EXP" = 156)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Thunder_Wave = 1,/obj/Moves/Supersonic = 1,/obj/Moves/Flail = 13,/obj/Moves/Water_Gun = 17,/obj/Moves/Spark = 25,/obj/Moves/Confuse_Ray = 33,/obj/Moves/Take_Down = 45,/obj/Moves/Hydro_Pump = 53)
		EggGroups = list("Water 2")
		EggMoves = list(/obj/Moves/Screech)
		Weight = 49.6
		Number = 171
		POKEIMAGE = '171.png'
		Unevolve = /mob/Pokemon/Chinchou
		Abilities = list("Volt Absorb","Illuminate","Water Absorb")
	Pichu
		icon = '172Pichu.dmi'
		Gender = 50
		CaptureRate = 190
		Type1 = "Electric"
		Evolve = list("Happiness" = /mob/Pokemon/Pikachu)
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 20, "ATK" = 40, "DEF" = 15, "SPL ATK" = 35, "SPL DEF" = 35, "SPD" = 60, "EXP" = 42)
		LearnMoves = list(/obj/Moves/Thundershock = 1, /obj/Moves/Charm = 1, /obj/Moves/Tail_Whip = 6, /obj/Moves/Thunder_Wave = 8, /obj/Moves/Sweet_Kiss = 11)
		EggGroups = list("None")
		EggMoves = list(/obj/Moves/Bide,/obj/Moves/Charge,/obj/Moves/DoubleSlap,/obj/Moves/Encore,/obj/Moves/Present,/obj/Moves/Reversal,/obj/Moves/Wish)
		Weight = 4.4
		Number = 172
		POKEIMAGE = '172.png'
		Abilities = list("Static","Lightningrod")
	Cleffa
		CaptureRate = 150
		Gender = 25
		icon = '173Cleffa.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		Evolve = list("Happiness" = /mob/Pokemon/Clefairy)
		BaseStats = list("HP" = 50, "ATK" = 25, "DEF" = 28, "SPL ATK" = 45, "SPL DEF" = 55, "SPD" = 15, "EXP" = 37)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Charm = 1,/obj/Moves/Encore = 4,/obj/Moves/Sing = 8,/obj/Moves/Sweet_Kiss = 13)
		EggGroups = list("None")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Belly_Drum,/obj/Moves/Metronome,/obj/Moves/Mimic,/obj/Moves/Present,/obj/Moves/Splash)
		Weight = 6.6
		Number = 173
		POKEIMAGE = '173.png'
		Abilities = list("Cute Charm","Magic Guard","Friend Guard")
	Igglybuff
		CaptureRate = 170
		Gender = 25
		icon = '174Igglybuff.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		Evolve = list("Happiness" = /mob/Pokemon/Jigglypuff)
		BaseStats = list("HP" = 90, "ATK" = 30, "DEF" = 15, "SPL ATK" = 40, "SPL DEF" = 20, "SPD" = 15, "EXP" = 39)
		LearnMoves = list(/obj/Moves/Sing = 1,/obj/Moves/Charm = 1,/obj/Moves/Defense_Curl = 4,/obj/Moves/Pound = 9,/obj/Moves/Sweet_Kiss = 14)
		EggGroups = list("None")
		EggMoves = list(/obj/Moves/Faint_Attack,/obj/Moves/Perish_Song,/obj/Moves/Present)
		Weight = 2.2
		Number = 174
		POKEIMAGE = '174.png'
		Abilities = list("Cute Charm","Friend Guard")
	Togepi
		CaptureRate = 190
		Gender = 87.5
		icon = '175Togepi.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		Evolve = list("Happiness" = /mob/Pokemon/Togetic)
		BaseStats = list("HP" = 35, "ATK" = 20, "DEF" = 65, "SPL ATK" = 40, "SPL DEF" = 65, "SPD" = 20, "EXP" = 74)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Charm = 1,/obj/Moves/Metronome = 7,/obj/Moves/Sweet_Kiss = 18,/obj/Moves/Encore = 25,/obj/Moves/Safeguard = 31,/obj/Moves/Double_Edge = 38)
		EggGroups = list("None")
		EggMoves = list(/obj/Moves/Foresight,/obj/Moves/Future_Sight,/obj/Moves/Mirror_Move,/obj/Moves/Peck,/obj/Moves/Present)
		Weight = 3.3
		Number = 175
		POKEIMAGE = '175.png'
		Abilities = list("Hustle","Serene Grace","Super Luck")
	Togetic
		CaptureRate = 75
		Gender = 87.5
		icon = '176Togetic.dmi'
		Type1 = "Normal"
		Type2 = "Flying"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 55, "ATK" = 40, "DEF" = 85, "SPL ATK" = 80, "SPL DEF" = 105, "SPD" = 40, "EXP" = 114)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Charm = 1,/obj/Moves/Metronome = 7,/obj/Moves/Sweet_Kiss = 18,/obj/Moves/Encore = 25,/obj/Moves/Safeguard = 31,/obj/Moves/Double_Edge = 38)
		EggGroups = list("Flying","Fairy")
		EggMoves = list(/obj/Moves/Foresight,/obj/Moves/Future_Sight,/obj/Moves/Mirror_Move,/obj/Moves/Peck,/obj/Moves/Present)
		Weight = 7.1
		Number = 176
		Unevolve = /mob/Pokemon/Togepi
		POKEIMAGE = '176.png'
		Abilities = list("Hustle","Serene Grace","Super Luck")
	Natu
		CaptureRate = 190
		Gender = 50
		icon = '177Natu.dmi'
		Type1 = "Psychic"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 25" = /mob/Pokemon/Xatu)
		BaseStats = list("HP" = 40, "ATK" = 50, "DEF" = 45, "SPL ATK" = 70, "SPL DEF" = 45, "SPD" = 70, "EXP" = 73)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Leer = 1,/obj/Moves/Night_Shade = 10,/obj/HMs/Teleport = 20,/obj/Moves/Future_Sight = 30,/obj/Moves/Confuse_Ray = 40,/obj/Moves/Psychic = 50)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Drill_Peck,/obj/Moves/Faint_Attack,/obj/Moves/Haze,/obj/Moves/Quick_Attack,/obj/Moves/Steel_Wing)
		Weight = 4.4
		Number = 177
		POKEIMAGE = '177.png'
		Abilities = list("Synchronize","Early Bird","Magic Bounce")
	Xatu
		CaptureRate = 75
		Gender = 50
		icon = '178Xatu.dmi'
		Type1 = "Psychic"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 75, "DEF" = 70, "SPL ATK" = 95, "SPL DEF" = 70, "SPD" = 101, "EXP" = 171)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Leer = 1,/obj/Moves/Night_Shade = 1,/obj/HMs/Teleport = 20,/obj/Moves/Future_Sight = 35,/obj/Moves/Confuse_Ray = 50,/obj/Moves/Psychic = 65)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Drill_Peck,/obj/Moves/Faint_Attack,/obj/Moves/Haze,/obj/Moves/Quick_Attack,/obj/Moves/Steel_Wing)
		Weight = 33.1
		Number = 178
		Unevolve = /mob/Pokemon/Natu
		POKEIMAGE = '178.png'
		Abilities = list("Synchronize","Early Bird","Magic Bounce")
	Mareep
		CaptureRate = 235
		Gender = 50
		icon = '179Mareep.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 15" = /mob/Pokemon/Flaaffy)
		BaseStats = list("HP" = 55, "ATK" = 40, "DEF" = 40, "SPL ATK" = 65, "SPL DEF" = 45, "SPD" = 35, "EXP" = 59)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Thundershock = 9,/obj/Moves/Thunder_Wave = 16,/obj/Moves/Cotton_Spore = 23,/obj/Moves/Light_Screen = 30,/obj/Moves/Thunder = 37)
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Charge,/obj/Moves/Reflect,/obj/Moves/Safeguard,/obj/Moves/Screech,/obj/Moves/Take_Down)
		Weight = 17.2
		Number = 179
		POKEIMAGE = '179.png'
		Abilities = list("Static","Plus")
	Flaaffy
		CaptureRate = 120
		Gender = 50
		icon = '180Flaaffy.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 30" = /mob/Pokemon/Ampharos)
		BaseStats = list("HP" = 70, "ATK" = 55, "DEF" = 55, "SPL ATK" = 80, "SPL DEF" = 60, "SPD" = 45, "EXP" = 117)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Thundershock = 1,/obj/Moves/Thunder_Wave = 18,/obj/Moves/Cotton_Spore = 27,/obj/Moves/Light_Screen = 36,/obj/Moves/Thunder = 45)
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Charge,/obj/Moves/Reflect,/obj/Moves/Safeguard,/obj/Moves/Screech,/obj/Moves/Take_Down)
		Weight = 29.3
		Number = 180
		Unevolve = /mob/Pokemon/Mareep
		POKEIMAGE = '180.png'
		Abilities = list("Static","Plus")
	Ampharos
		CaptureRate = 45
		Gender = 50
		icon = '181Ampharos.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 90, "ATK" = 75, "DEF" = 75, "SPL ATK" = 115, "SPL DEF" = 90, "SPD" = 66, "EXP" = 194)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Thundershock = 1,/obj/Moves/Thunder_Wave = 1,/obj/Moves/Cotton_Spore = 27,/obj/Moves/Thunder_Punch = 30,/obj/Moves/Light_Screen = 42,/obj/Moves/Thunder = 57)
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Charge,/obj/Moves/Reflect,/obj/Moves/Safeguard,/obj/Moves/Screech,/obj/Moves/Take_Down)
		Weight = 135.6
		Number = 181
		Unevolve = /mob/Pokemon/Flaaffy
		POKEIMAGE = '181.png'
		Abilities = list("Static","Plus")
	Bellossom
		icon = '182Bellossom.dmi'
		Gender = 50
		GrowthRate = "Medium-Slow" //1,059,860
		Type1 = "Grass"
		CaptureRate = 45
		BaseStats = list("HP" = 75, "ATK" = 80, "DEF" = 85, "SPL ATK" = 90, "SPL DEF" = 100, "SPD" = 50, "EXP" = 184)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Sweet_Scent = 1,/obj/Moves/Stun_Spore = 1,/obj/Moves/Petal_Dance = 1,/obj/Moves/SolarBeam = 55)
		EggGroups = list("Grass")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Razor_Leaf,/obj/Moves/Swords_Dance,/obj/Moves/Synthesis)
		Weight = 12.8
		Number = 182
		Unevolve = /mob/Pokemon/Gloom
		POKEIMAGE = '183.png'
		Abilities = list("Chlorophyll","Healer")
	Marill
		CaptureRate = 190
		Gender = 50
		icon = '183Marill.dmi'
		Type1 = "Water"
		GrowthRate = "Fast"
		Evolve = list("Level 18" = /mob/Pokemon/Azumarill)
		BaseStats = list("HP" = 70, "ATK" = 20, "DEF" = 50, "SPL ATK" = 20, "SPL DEF" = 50, "SPD" = 40, "EXP" = 58)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Defense_Curl = 3,/obj/Moves/Tail_Whip = 6,/obj/Moves/Water_Gun = 10,/obj/Moves/Rollout = 15,/obj/Moves/Bubblebeam = 21,/obj/Moves/Double_Edge = 28,/obj/Moves/Rain_Dance = 36)
		EggGroups = list("Water 1","Fairy")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Belly_Drum,/obj/Moves/Foresight,/obj/Moves/Future_Sight,/obj/Moves/Light_Screen,/obj/Moves/Perish_Song,/obj/Moves/Present,/obj/Moves/Supersonic)
		Weight = 18.7
		Number = 183
		POKEIMAGE = '183.png'
		Abilities = list("Thick Fat","Huge Power","Sap Sipper")
	Azumarill
		CaptureRate = 75
		Gender = 50
		icon = '184Azumarill.dmi'
		Type1 = "Water"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 100, "ATK" = 50, "DEF" = 80, "SPL ATK" = 50, "SPL DEF" = 80, "SPD" = 50, "EXP" = 153)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Defense_Curl = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Rollout = 15,/obj/Moves/Bubblebeam = 25,/obj/Moves/Double_Edge = 36,/obj/Moves/Rain_Dance = 48)
		EggGroups = list("Water 1","Fairy")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Belly_Drum,/obj/Moves/Foresight,/obj/Moves/Future_Sight,/obj/Moves/Light_Screen,/obj/Moves/Perish_Song,/obj/Moves/Present,/obj/Moves/Supersonic)
		Weight = 62.8
		Number = 184
		Unevolve = /mob/Pokemon/Marill
		POKEIMAGE = '184.png'
		Abilities = list("Thick Fat","Huge Power","Sap Sipper")
	Sudowoodo
		CaptureRate = 65
		Gender = 50
		icon = '185Sudowoodo.dmi'
		Type1 = "Rock"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 70, "ATK" = 100, "DEF" = 115, "SPL ATK" = 30, "SPL DEF" = 65, "SPD" = 30, "EXP" = 135)
		LearnMoves = list(/obj/Moves/Rock_Throw = 1,/obj/Moves/Mimic = 1,/obj/Moves/Flail = 10,/obj/Moves/Low_Kick = 19,/obj/Moves/Rock_Slide = 28,/obj/Moves/Faint_Attack = 37,/obj/Moves/Slam = 46)
		EggGroups = list("Mineral")
		EggMoves = list(/obj/Moves/Selfdestruct)
		Weight = 83.8
		Number = 185
		POKEIMAGE = '185.png'
		Abilities = list("Rock Head","Rattled")
	Politoed
		CaptureRate = 45
		Gender = 50
		icon = '186Politoed.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 90, "ATK" = 75, "DEF" = 75, "SPL ATK" = 90, "SPL DEF" = 100, "SPD" = 70, "EXP" = 185)
		LearnMoves = list(/obj/Moves/Water_Gun = 1,/obj/Moves/DoubleSlap = 1,/obj/Moves/Hypnosis = 1,/obj/Moves/Perish_Song = 35,/obj/Moves/Swagger = 51)
		EggGroups = list("Water 1")
		EggMoves = list(/obj/Moves/Bubblebeam,/obj/Moves/Haze,/obj/Moves/Mind_Reader,/obj/Moves/Splash,/obj/Moves/Mist)
		Weight = 74.7
		Number = 186
		Unevolve = /mob/Pokemon/Poliwhirl
		POKEIMAGE = '186.png'
		Abilities = list("Watter Absorb","Damp")
		HiddenAbility = list("Drizzle")
	Hoppip
		CaptureRate = 255
		Gender = 50
		icon = '187Hoppip.dmi'
		Type1 = "Grass"
		Type2 = "Flying"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 18" = /mob/Pokemon/Skiploom)
		BaseStats = list("HP" = 35, "ATK" = 35, "DEF" = 40, "SPL ATK" = 35, "SPL DEF" = 55, "SPD" = 50, "EXP" = 74)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Synthesis = 1,/obj/Moves/Tail_Whip = 5,/obj/Moves/Tackle = 10,/obj/Moves/PoisonPowder = 13,/obj/Moves/Stun_Spore = 15,/obj/Moves/SleepPowder = 17,/obj/Moves/Leech_Seed = 20,/obj/Moves/Cotton_Spore = 25,/obj/Moves/Mega_Drain = 30)
		EggGroups = list("Fairy","Grass")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Confusion,/obj/Moves/Double_Edge,/obj/Moves/Encore,/obj/Moves/Growl,/obj/Moves/Pay_Day,/obj/Moves/Reflect)
		Weight = 1.1
		Number = 187
		POKEIMAGE = '187.png'
		Abilities = list("Chlorophyll","Leaf Guard","Infiltrator")
	Skiploom
		CaptureRate = 120
		Gender = 50
		icon = '188Skiploom.dmi'
		Type1 = "Grass"
		Type2 = "Flying"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 27" = /mob/Pokemon/Jumpluff)
		BaseStats = list("HP" = 45, "ATK" = 49, "DEF" = 65, "SPL ATK" = 49, "SPL DEF" = 65, "SPD" = 45, "EXP" = 64)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Synthesis = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Tackle = 1,/obj/Moves/PoisonPowder = 13,/obj/Moves/Stun_Spore = 15,/obj/Moves/SleepPowder = 17,/obj/Moves/Leech_Seed = 22,/obj/Moves/Cotton_Spore = 29,/obj/Moves/Mega_Drain = 36)
		EggGroups = list("Fairy","Grass")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Confusion,/obj/Moves/Double_Edge,/obj/Moves/Encore,/obj/Moves/Growl,/obj/Moves/Pay_Day,/obj/Moves/Reflect)
		Weight = 2.2
		Number = 188
		Unevolve = /mob/Pokemon/Hoppip
		POKEIMAGE = '188.png'
		Abilities = list("Chlorophyll","Leaf Guard","Infiltrator")
	Jumpluff
		CaptureRate = 45
		Gender = 50
		icon = '189Jumpluff.dmi'
		Type1 = "Grass"
		Type2 = "Flying"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 75, "ATK" = 55, "DEF" = 70, "SPL ATK" = 55, "SPL DEF" = 85, "SPD" = 110, "EXP" = 176)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Synthesis = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Tackle = 1,/obj/Moves/PoisonPowder = 13,/obj/Moves/Stun_Spore = 15,/obj/Moves/SleepPowder = 17,/obj/Moves/Leech_Seed = 22,/obj/Moves/Cotton_Spore = 33,/obj/Moves/Mega_Drain = 44)
		EggGroups = list("Fairy","Grass")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Confusion,/obj/Moves/Double_Edge,/obj/Moves/Encore,/obj/Moves/Growl,/obj/Moves/Pay_Day,/obj/Moves/Reflect)
		Weight = 6.6
		Number = 189
		Unevolve = /mob/Pokemon/Skiploom
		POKEIMAGE = '189.png'
		Abilities = list("Chlorophyll","Leaf Guard","Infiltrator")
	Aipom
		CaptureRate = 45
		Gender = 50
		icon = '190Aipom.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 55, "ATK" = 70, "DEF" = 55, "SPL ATK" = 40, "SPL DEF" = 55, "SPD" = 85, "EXP" = 94)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Sand_Attack = 6,/obj/Moves/Baton_Pass = 12,/obj/Moves/Fury_Swipes = 19,/obj/Moves/Swift = 27,/obj/Moves/Screech = 36,/obj/Moves/Agility = 46)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Agility,/obj/Moves/Beat_Up,/obj/Moves/Counter,/obj/Moves/DoubleSlap,/obj/Moves/Pursuit,/obj/Moves/Slam,/obj/Moves/Spite)
		Weight = 25.4
		Number = 190
		POKEIMAGE = '190.png'
		Abilities = list("Run Away","Pickup","Skill Link")
	Sunkern
		CaptureRate = 235
		Gender = 50
		icon = '191Sunkern.dmi'
		Type1 = "Grass"
		GrowthRate = "Medium-Slow"
		Evolve = list("Sunstone" = /mob/Pokemon/Sunflora)
		BaseStats = list("HP" = 30, "ATK" = 30, "DEF" = 30, "SPL ATK" = 30, "SPL DEF" = 30, "SPD" = 30, "EXP" = 52)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Growth = 4,/obj/Moves/Mega_Drain = 10,/obj/Moves/Sunny_Day = 19,/obj/Moves/Synthesis = 31,/obj/Moves/Giga_Drain = 46)
		EggGroups = list("Grass")
		Weight = 4.0
		Number = 191
		POKEIMAGE = '191.png'
		Abilities = list("Chlorophyll","Solar Power","Early Bird")
	Sunflora
		CaptureRate = 120
		Gender = 50
		icon = '192Sunflora.dmi'
		Type1 = "Grass"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 75, "ATK" = 75, "DEF" = 50, "SPL ATK" = 105, "SPL DEF" = 85, "SPD" = 50, "EXP" = 146)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Pound = 1,/obj/Moves/Growth = 4,/obj/Moves/Razor_Leaf = 10,/obj/Moves/Sunny_Day = 19,/obj/Moves/Petal_Dance = 31,/obj/Moves/SolarBeam = 46)
		EggGroups = list("Grass")
		Weight = 18.7
		Number = 192
		Unevolve = /mob/Pokemon/Sunkern
		POKEIMAGE = '192.png'
		Abilities = list("Chlorophyll","Solar Power","Early Bird")
	Yanma
		CaptureRate = 75
		Gender = 50
		icon = '193Yanma.dmi'
		Type1 = "Bug"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 65, "DEF" = 45, "SPL ATK" = 75, "SPL DEF" = 45, "SPD" = 95, "EXP" = 147)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Foresight = 1,/obj/Moves/Quick_Attack = 7,/obj/Moves/Double_Team = 13,/obj/Moves/Sonicboom = 19,/obj/Moves/Detect = 25,/obj/Moves/Supersonic = 31,/obj/Moves/Swift = 37,/obj/Moves/Wing_Attack = 37,/obj/Moves/Screech = 43)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Leech_Life,/obj/Moves/Reversal,/obj/Moves/Whirlwind)
		Weight = 83.8
		Number = 193
		POKEIMAGE = '193.png'
		Abilities = list("Speed Boost","Compoundeyes","Frisk")
	Wooper
		CaptureRate = 255
		Gender = 50
		icon = '194Wooper.dmi'
		Type1 = "Water"
		Type2 = "Ground"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 20" = /mob/Pokemon/Quagsire)
		BaseStats = list("HP" = 55, "ATK" = 45, "DEF" = 45, "SPL ATK" = 25, "SPL DEF" = 25, "SPD" = 15, "EXP" = 52)
		LearnMoves = list(/obj/Moves/Water_Gun = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Slam = 11,/obj/Moves/Amnesia = 21,/obj/Moves/Earthquake = 31,/obj/Moves/Rain_Dance = 41,/obj/Moves/Mist = 51,/obj/Moves/Haze = 51)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Body_Slam,/obj/Moves/Safeguard)
		Weight = 18.7
		Number = 194
		POKEIMAGE = '194.png'
		Abilities = list("Damp","Water Absorb","Unaware")
	Quagsire
		CaptureRate = 90
		Gender = 50
		icon = '195Quagsire.dmi'
		Type1 = "Water"
		Type2 = "Ground"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 95, "ATK" = 85, "DEF" = 85, "SPL ATK" = 65, "SPL DEF" = 65, "SPD" = 89, "EXP" = 173)
		LearnMoves = list(/obj/Moves/Water_Gun = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Slam = 11,/obj/Moves/Amnesia = 23,/obj/Moves/Earthquake = 35,/obj/Moves/Rain_Dance = 47,/obj/Moves/Mist = 59,/obj/Moves/Haze = 59)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Body_Slam,/obj/Moves/Safeguard)
		Weight = 165.3
		Number = 195
		Unevolve = /mob/Pokemon/Wooper
		POKEIMAGE = '195.png'
		Abilities = list("Damp","Water Absorb","Unaware")
	Espeon
		CaptureRate = 45
		Gender = 87
		icon = '196Espeon.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 65, "DEF" = 60, "SPL ATK" = 130, "SPL DEF" = 95, "SPD" = 110, "EXP" = 197)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Sand_Attack = 8,/obj/Moves/Confusion = 16,/obj/Moves/Quick_Attack = 23,/obj/Moves/Swift = 30,/obj/Moves/Psybeam = 36,/obj/Moves/Psych_Up = 42,/obj/Moves/Psychic = 47,/obj/Moves/Morning_Sun = 52)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Flail,/obj/Moves/Tickle)
		Weight = 58.4
		Number = 196
		Unevolve = /mob/Pokemon/Eevee
		POKEIMAGE = '196.png'
		Abilities = list("Synchronize","Magic Bounce")
	Umbreon
		CaptureRate = 45
		Gender = 50
		icon = '197Umbreon.dmi'
		Type1 = "Dark"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 95, "ATK" = 65, "DEF" = 110, "SPL ATK" = 60, "SPL DEF" = 130, "SPD" = 66, "EXP" = 197)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Sand_Attack = 8,/obj/Moves/Pursuit = 16,/obj/Moves/Quick_Attack = 23,/obj/Moves/Confuse_Ray = 30,/obj/Moves/Faint_Attack = 36,/obj/Moves/Mean_Look = 42,/obj/Moves/Screech = 47,/obj/Moves/Moonlight = 52)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Flail,/obj/Moves/Tickle)
		Weight = 59.5
		Number = 197
		Unevolve = /mob/Pokemon/Eevee
		POKEIMAGE = '197.png'
		Abilities = list("Synchronize","Inner Focus")
	Murkrow
		CaptureRate = 30
		Gender = 50
		icon = '198Murkrow.dmi'
		Type1 = "Dark"
		Type2 = "Flying"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 60, "ATK" = 85, "DEF" = 42, "SPL ATK" = 85, "SPL DEF" = 42, "SPD" = 91, "EXP" = 107)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Pursuit = 11,/obj/Moves/Haze = 16,/obj/Moves/Night_Shade = 26,/obj/Moves/Faint_Attack = 31,/obj/Moves/Mean_Look = 41)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Drill_Peck,/obj/Moves/Mirror_Move,/obj/Moves/Quick_Attack,/obj/Moves/Sky_Attack,/obj/Moves/Wing_Attack,/obj/Moves/Whirlwind)
		Weight = 4.6
		Number = 198
		POKEIMAGE = '198.png'
		Abilities = list("Insomia","Super Luck","Prankster")
	Slowking
		CaptureRate = 70
		Gender = 50
		icon = '199Slowking.dmi'
		Type1 = "Water"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 95, "ATK" = 75, "DEF" = 80, "SPL ATK" = 100, "SPL DEF" = 110, "SPD" = 30, "EXP" = 164)
		LearnMoves = list(/obj/Moves/Curse = 1,/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Confusion = 20,/obj/Moves/Disable = 29,/obj/Moves/Headbutt = 34,/obj/Moves/Swagger = 43,/obj/Moves/Psychic = 48)
		EggGroups = list("Monster","Water 1")
		EggMoves = list(/obj/Moves/Belly_Drum,/obj/Moves/Future_Sight,/obj/Moves/Safeguard,/obj/Moves/Stomp)
		Weight = 175.3
		Number = 199
		Unevolve = /mob/Pokemon/Slowpoke
		POKEIMAGE = '199.png'
		Abilities = list("Oblivious","Own Tempo","Regenerator")
	Misdreavus
		CaptureRate = 45
		Gender = 50
		icon = '200Misdreavus.dmi'
		Type1 = "Ghost"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 60, "ATK" = 60, "DEF" = 60, "SPL ATK" = 85, "SPL DEF" = 85, "SPD" = 85, "EXP" = 147)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Psywave = 1,/obj/Moves/Spite = 6,/obj/Moves/Confuse_Ray = 12,/obj/Moves/Mean_Look = 19,/obj/Moves/Psybeam = 27,/obj/Moves/Pain_Split = 36,/obj/Moves/Perish_Song = 46)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Destiny_Bond,/obj/Moves/Screech)
		Weight = 2.2
		Number = 200
		POKEIMAGE = '200.png'
		Abilities = list("Levitate")
	Unown
		CaptureRate = 255
		Gender = "Unbreedable"
		icon = '201Unown.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 48, "ATK" = 72, "DEF" = 48, "SPL ATK" = 72, "SPL DEF" = 48, "SPD" = 48, "EXP" = 61)
		LearnMoves = list(/obj/Moves/Hidden_Power = 1)
		Weight = 11.0
		Number = 201
		Abilities = list("Levitate")

		A
			icon_state = "A"
			POKEIMAGE = '201A.png'
		B
			icon_state = "B"
			POKEIMAGE = '201B.png'
		C
			icon_state = "C"
			POKEIMAGE = '201C.png'
		D
			icon_state = "D"
			POKEIMAGE = '201D.png'
		E
			icon_state = "E"
			POKEIMAGE = '201E.png'
		F
			icon_state = "F"
			POKEIMAGE = '201F.png'
		G
			icon_state = "G"
			POKEIMAGE = '201G.png'
		H
			icon_state = "H"
			POKEIMAGE = '201H.png'
		I
			icon_state = "I"
			POKEIMAGE = '201I.png'
		J
			icon_state = "J"
			POKEIMAGE = '201J.png'
		K
			icon_state = "K"
			POKEIMAGE = '201K.png'
		L
			icon_state = "L"
			POKEIMAGE = '201L.png'
		M
			icon_state = "M"
			POKEIMAGE = '201M.png'
		N
			icon_state = "N"
			POKEIMAGE = '201N.png'
		O
			icon_state = "O"
			POKEIMAGE = '201O.png'
		P
			icon_state = "P"
			POKEIMAGE = '201P.png'
		Q
			icon_state = "Q"
			POKEIMAGE = '201Q.png'
		R
			icon_state = "R"
			POKEIMAGE = '201R.png'
		S
			icon_state = "S"
			POKEIMAGE = '201S.png'
		T
			icon_state = "T"
			POKEIMAGE = '201T.png'
		U
			icon_state = "U"
			POKEIMAGE = '201U.png'
		V
			icon_state = "V"
			POKEIMAGE = '201V.png'
		W
			icon_state = "W"
			POKEIMAGE = '201W.png'
		X
			icon_state = "X"
			POKEIMAGE = '201X.png'
		Y
			icon_state = "Y"
			POKEIMAGE = '201Y.png'
		Z
			icon_state = "Z"
			POKEIMAGE = '201Z.png'
	Wobbuffet
		CaptureRate = 45
		Gender = 50
		icon = '202Wobbuffet.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 190, "ATK" = 33, "DEF" = 58, "SPL ATK" = 33, "SPL DEF" = 58, "SPD" = 33, "EXP" = 177)
		LearnMoves = list(/obj/Moves/Counter = 1,/obj/Moves/Mirror_Coat = 1,/obj/Moves/Safeguard = 1,/obj/Moves/Destiny_Bond = 1)
		EggGroups = list("Amorphous")
		Weight = 62.8
		Number = 202
		POKEIMAGE = '202.png'
		Abilities = list("Shadow Tag","Telepathy")
	Girafarig
		CaptureRate = 60
		Gender = 50
		icon = '203Girafarig.dmi'
		Type1 = "Normal"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 70, "ATK" = 80, "DEF" = 65, "SPL ATK" = 90, "SPL DEF" = 65, "SPD" = 85, "EXP" = 149)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Confusion = 7,/obj/Moves/Stomp = 13,/obj/Moves/Agility = 20,/obj/Moves/Baton_Pass = 30,/obj/Moves/Psybeam = 41,/obj/Moves/Crunch = 54)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Beat_Up,/obj/Moves/Foresight,/obj/Moves/Future_Sight,/obj/Moves/Take_Down)
		Weight = 91.5
		Number = 203
		POKEIMAGE = '203.png'
		Abilities = list("Inner Focus","Early Bird","Sap Sipper")
	Pineco
		CaptureRate = 190
		Gender = 50
		icon = '204Pineco.dmi'
		Type1 = "Bug"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 31" = /mob/Pokemon/Forretress)
		BaseStats = list("HP" = 50, "ATK" = 65, "DEF" = 90, "SPL ATK" = 35, "SPL DEF" = 35, "SPD" = 15, "EXP" = 60)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Protect = 1,/obj/Moves/Selfdestruct = 8,/obj/Moves/Take_Down = 15,/obj/Moves/Rapid_Spin = 22,/obj/Moves/Bide = 29,/obj/Moves/Explosion = 36,/obj/Moves/Spikes = 43,/obj/Moves/Double_Edge = 50)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Pin_Missle,/obj/Moves/Reflect,/obj/Moves/Swift)
		Weight = 15.9
		Number = 204
		POKEIMAGE = '204.png'
		Abilities = list("Overcoat")
	Forretress
		CaptureRate = 75
		Gender = 50
		icon = '205Forretress.dmi'
		Type1 = "Bug"
		Type2 = "Steel"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 75, "ATK" = 90, "DEF" = 140, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 40, "EXP" = 118)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Protect = 1,/obj/Moves/Selfdestruct = 1,/obj/Moves/Take_Down = 15,/obj/Moves/Rapid_Spin = 22,/obj/Moves/Bide = 29,/obj/Moves/Explosion = 39,/obj/Moves/Spikes = 49,/obj/Moves/Double_Edge = 59)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Pin_Missle,/obj/Moves/Reflect,/obj/Moves/Swift)
		Weight = 277.3
		Number = 205
		Unevolve = /mob/Pokemon/Pineco
		POKEIMAGE = '205.png'
		Abilities = list("Overcoat")
	Dunsparce
		CaptureRate = 190
		Gender = 50
		icon = '206Dunsparce.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 100, "ATK" = 70, "DEF" = 70, "SPL ATK" = 65, "SPL DEF" = 65, "SPD" = 45, "EXP" = 125)
		LearnMoves = list(/obj/Moves/Rage = 1,/obj/Moves/Defense_Curl = 4,/obj/Moves/Glare = 14,/obj/Moves/Spite = 21,/obj/Moves/Pursuit = 24,/obj/Moves/Screech = 31,/obj/Moves/Take_Down = 34,/obj/Moves/Endeavor = 41)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Astonish,/obj/Moves/Bide,/obj/Moves/Bite,/obj/Moves/Curse,/obj/Moves/Headbutt,/obj/Moves/Rock_Slide)
		Weight = 30.9
		Number = 206
		POKEIMAGE = '206.png'
		Abilities = list("Serene Grace","Run Away","Rattled")
	Gligar
		CaptureRate = 60
		Gender = 50
		icon = '207Gligar.dmi'
		Type1 = "Ground"
		Type2 = "Flying"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 65, "ATK" = 75, "DEF" = 105, "SPL ATK" = 35, "SPL DEF" = 65, "SPD" = 85, "EXP" = 108)
		LearnMoves = list(/obj/Moves/Poison_Sting = 1,/obj/Moves/Sand_Attack = 6,/obj/Moves/Harden = 13,/obj/Moves/Quick_Attack = 20,/obj/Moves/Faint_Attack = 28,/obj/Moves/Slash = 36,/obj/Moves/Screech = 44,/obj/Moves/Guillotine = 52)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Metal_Claw,/obj/Moves/Razor_Wind,/obj/Moves/Wing_Attack)
		Weight = 142.9
		Number = 207
		POKEIMAGE = '207.png'
		Abilities = list("Hyper Cutter","Sand Veil","Immunity")
	Steelix
		CaptureRate = 25
		Gender = 50
		icon = '208Steelix.dmi'
		pixel_y = -16 //Size - 32 / 2   90 65
		pixel_x = -29
		Type1 = "Steel"
		Type2 = "Ground"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 75, "ATK" = 85, "DEF" = 200, "SPL ATK" = 55, "SPL DEF" = 65, "SPD" = 30, "EXP" = 196)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Screech = 1,/obj/Moves/Bind = 10,/obj/Moves/Rock_Throw = 14,/obj/Moves/Harden = 23,/obj/Moves/Rage = 27,/obj/Moves/Sandstorm = 36,/obj/Moves/Slam = 40,/obj/Moves/Crunch = 49)
		EggGroups = list("Mineral")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Rock_Throw)
		Weight = 881.8
		Number = 208
		Unevolve = /mob/Pokemon/Onix
		POKEIMAGE = '208.png'
		Abilities = list("Rock Head","Sheer Force")
	Snubbull
		CaptureRate = 190
		Gender = 25
		icon = '209Snubbull.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		Evolve = list("Level 23" = /mob/Pokemon/Granbull)
		BaseStats = list("HP" = 60, "ATK" = 80, "DEF" = 50, "SPL ATK" = 40, "SPL DEF" = 40, "SPD" = 30, "EXP" = 63)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Scary_Face = 1,/obj/Moves/Tail_Whip = 4,/obj/Moves/Charm = 8,/obj/Moves/Bite = 13,/obj/Moves/Lick = 19,/obj/Moves/Roar = 26,/obj/Moves/Rage = 34,/obj/Moves/Take_Down = 43)
		EggGroups = list("Field","Fairy")
		EggMoves = list(/obj/Moves/Crunch,/obj/Moves/Faint_Attack,/obj/Moves/Heal_Bell,/obj/Moves/Leer,/obj/Moves/Lick,/obj/Moves/Metronome,/obj/Moves/Present,/obj/Moves/Reflect)
		Weight = 17.2
		Number = 209
		POKEIMAGE = '209.png'
		Abilities = list("Intimidate","Run Away","Rattled")
	Granbull
		CaptureRate = 75
		Gender = 25
		icon = '210Granbull.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 90, "ATK" = 120, "DEF" = 75, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 66, "EXP" = 178)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Scary_Face = 1,/obj/Moves/Tail_Whip = 4,/obj/Moves/Charm = 8,/obj/Moves/Bite = 13,/obj/Moves/Lick = 19,/obj/Moves/Roar = 28,/obj/Moves/Rage = 38,/obj/Moves/Take_Down = 51)
		EggGroups = list("Field","Fairy")
		EggMoves = list(/obj/Moves/Crunch,/obj/Moves/Faint_Attack,/obj/Moves/Heal_Bell,/obj/Moves/Leer,/obj/Moves/Lick,/obj/Moves/Metronome,/obj/Moves/Present,/obj/Moves/Reflect)
		Weight = 107.4
		Number = 210
		Unevolve = /mob/Pokemon/Snubbull
		POKEIMAGE = '210.png'
		Abilities = list("Intimidate","Quick Feet","Rattled")
	Qwilfish
		CaptureRate = 45
		Gender = 50
		icon = '211Qwilfish.dmi'
		Type1 = "Water"
		Type2 = "Poison"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 95, "DEF" = 75, "SPL ATK" = 55, "SPL DEF" = 55, "SPD" = 85, "EXP" = 100)
		LearnMoves = list(/obj/Moves/Spikes = 1,/obj/Moves/Tackle = 1,/obj/Moves/Poison_Sting = 1,/obj/Moves/Harden = 10,/obj/Moves/Minimize = 10,/obj/Moves/Water_Gun = 19,/obj/Moves/Pin_Missle = 28,/obj/Moves/Take_Down = 37,/obj/Moves/Hydro_Pump = 46)
		EggGroups = list("Water 2")
		EggMoves = list(/obj/Moves/Bubblebeam,/obj/Moves/Flail,/obj/Moves/Haze,/obj/Moves/Supersonic)
		Weight = 8.6
		Number = 211
		POKEIMAGE = '211.png'
		Abilities = list("Poison Point","Swift Swim","Intimidate")
	Scizor
		icon = '212Scizor.dmi'
		Gender = 50
		GrowthRate = "Medium-Fast"
		Type1 = "Bug"
		Type2 = "Steel"
		CaptureRate = 25
		BaseStats = list("HP" = 70, "ATK" = 130, "DEF" = 100, "SPL ATK" = 55, "SPL DEF" = 80, "SPD" = 65, "EXP" = 200)
		LearnMoves = list(/obj/Moves/Quick_Attack = 1,/obj/Moves/Leer = 1,/obj/Moves/Focus_Energy = 6,/obj/Moves/Pursuit = 12,/obj/Moves/False_Swipe,/obj/Moves/Agility = 21,/obj/Moves/Metal_Claw = 26,/obj/Moves/Slash = 31,/obj/Moves/Swords_Dance = 36,/obj/Moves/Double_Team = 41)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Counter,/obj/Moves/Razor_Wind,/obj/Moves/Reversal,/obj/Moves/Safeguard)
		Weight = 260.1
		Number = 212
		Unevolve = /mob/Pokemon/Scyther
		POKEIMAGE = '212.png'
		Abilities = list("Swarm","Technician","Light Metal")
	Shuckle
		CaptureRate = 190
		Gender = 50
		icon = '213Shuckle.dmi'
		Type1 = "Bug"
		Type2 = "Rock"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 20, "ATK" = 10, "DEF" = 230, "SPL ATK" = 10, "SPL DEF" = 230, "SPD" = 5, "EXP" = 80)
		LearnMoves = list(/obj/Moves/Constrict = 1,/obj/Moves/Withdraw = 1,/obj/Moves/Bide = 9,/obj/Moves/Encore = 14,/obj/Moves/Safeguard = 23,/obj/Moves/Wrap = 28,/obj/Moves/Rest = 37)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Sweet_Scent)
		Weight = 45.2
		Number = 213
		POKEIMAGE = '213.png'
		Abilities = list("Gluttony","Contrary")
	Heracross
		icon = '214Heracross.dmi'
		CaptureRate = 45
		Gender = 50
		Type1 = "Bug"
		Type2 = "Fighting"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 80, "ATK" = 125, "DEF" = 75, "SPL ATK" = 40, "SPL DEF" = 95, "SPD" = 85, "EXP" = 200)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Leer = 1,/obj/Moves/Horn_Attack = 6,/obj/Moves/Endure = 12,/obj/Moves/Fury_Attack = 19,/obj/Moves/Counter = 27,/obj/Moves/Take_Down = 35,/obj/Moves/Reversal = 44,/obj/Moves/Megahorn = 54)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Bide,/obj/Moves/Flail,/obj/Moves/Harden)
		Weight = 119.0
		Number = 214
		POKEIMAGE = '214.png'
		Abilities = list("Swarm","Guts","Moxie")
	Sneasel
		CaptureRate = 60
		Gender = 50
		icon = '215Sneasel.dmi'
		Type1 = "Dark"
		Type2 = "Ice"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 55, "ATK" = 95, "DEF" = 55, "SPL ATK" = 35, "SPL DEF" = 75, "SPD" = 115, "EXP" = 132)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Leer = 1,/obj/Moves/Quick_Attack = 9,/obj/Moves/Screech = 17,/obj/Moves/Faint_Attack = 25,/obj/Moves/Fury_Swipes = 33,/obj/Moves/Agility = 41,/obj/Moves/Slash = 49,/obj/Moves/Beat_Up = 57,/obj/Moves/Metal_Claw = 65)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Bite,/obj/Moves/Counter,/obj/Moves/Foresight,/obj/Moves/Reflect,/obj/Moves/Spite)
		Weight = 61.7
		Number = 215
		POKEIMAGE = '215.png'
		Abilities = list("Inner Focus","Keen Eye","Pickpocket")
	Teddiursa
		CaptureRate = 120
		Gender = 50
		icon = '216Teddiursa.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 30" = /mob/Pokemon/Ursaring)
		BaseStats = list("HP" = 60, "ATK" = 80, "DEF" = 50, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 40, "EXP" = 124)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Leer = 1,/obj/Moves/Lick = 8,/obj/Moves/Fury_Swipes = 15,/obj/Moves/Faint_Attack = 22,/obj/Moves/Rest = 29,/obj/Moves/Slash = 36,/obj/Moves/Snore = 43,/obj/Moves/Thrash = 50)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Crunch,/obj/Moves/Focus_Energy,/obj/Moves/Metal_Claw,/obj/Moves/Seismic_Toss,/obj/Moves/Take_Down)
		Weight = 19.4
		Number = 216
		POKEIMAGE = '216.png'
		Abilities = list("Pickup","Quick Feet","Honey Gather")
	Ursaring
		CaptureRate = 60
		Gender = 50
		icon = '217Ursaring.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 90, "ATK" = 130, "DEF" = 75, "SPL ATK" = 75, "SPL DEF" = 75, "SPD" = 55, "EXP" = 189)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Leer = 1,/obj/Moves/Lick = 1,/obj/Moves/Fury_Swipes = 1,/obj/Moves/Faint_Attack = 22,/obj/Moves/Rest = 29,/obj/Moves/Slash = 39,/obj/Moves/Snore = 49,/obj/Moves/Thrash = 59)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Crunch,/obj/Moves/Focus_Energy,/obj/Moves/Metal_Claw,/obj/Moves/Seismic_Toss,/obj/Moves/Take_Down)
		Weight = 277.3
		Number = 217
		Unevolve = /mob/Pokemon/Teddiursa
		POKEIMAGE = '217.png'
		Abilities = list("Guts","Quick Feet","Unnerve")
	Slugma
		CaptureRate = 190
		Gender = 50
		icon = '218Slugma.dmi'
		Type1 = "Fire"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 38" = /mob/Pokemon/Magcargo)
		BaseStats = list("HP" = 40, "ATK" = 40, "DEF" = 40, "SPL ATK" = 70, "SPL DEF" = 40, "SPD" = 20, "EXP" = 78)
		LearnMoves = list(/obj/Moves/Smog = 1,/obj/Moves/Ember = 8,/obj/Moves/Rock_Throw = 15,/obj/Moves/Harden = 22,/obj/Moves/Amnesia = 29,/obj/Moves/Flamethrower = 36,/obj/Moves/Rock_Slide = 43,/obj/Moves/Body_Slam = 50)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Acid_Armor)
		Weight = 77.2
		Number = 218
		POKEIMAGE = '218.png'
		Abilities = list("Magma Armor","Weak Armor","Flame Body")
	Magcargo
		CaptureRate = 75
		Gender = 50
		icon = '219Magcargo.dmi'
		Type1 = "Fire"
		Type2 = "Rock"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 50, "ATK" = 50, "DEF" = 120, "SPL ATK" = 80, "SPL DEF" = 80, "SPD" = 30, "EXP" = 154)
		LearnMoves = list(/obj/Moves/Smog = 1,/obj/Moves/Ember = 1,/obj/Moves/Rock_Throw = 1,/obj/Moves/Harden = 22,/obj/Moves/Amnesia = 29,/obj/Moves/Flamethrower = 36,/obj/Moves/Rock_Slide = 48,/obj/Moves/Body_Slam = 60)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Acid_Armor)
		Weight = 121.3
		Number = 219
		Unevolve = /mob/Pokemon/Slugma
		POKEIMAGE = '219.png'
		Abilities = list("Magma Armor","Weak Armor","Flame Body")
	Swinub
		CaptureRate = 225
		Gender = 50
		icon = '220Swinub.dmi'
		Type1 = "Ice"
		Type2 = "Ground"
		GrowthRate = "Slow"
		Evolve = list("Level 33" = /mob/Pokemon/Piloswine)
		BaseStats = list("HP" = 50, "ATK" = 50, "DEF" = 40, "SPL ATK" = 30, "SPL DEF" = 30, "SPD" = 50, "EXP" = 78)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Powder_Snow = 10,/obj/Moves/Endure = 19,/obj/Moves/Take_Down = 28,/obj/Moves/Mist = 37,/obj/Moves/Blizzard = 46,/obj/Moves/Amnesia = 55)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Bite,/obj/Moves/Body_Slam,/obj/Moves/Rock_Slide)
		Weight = 14.3
		Number = 220
		POKEIMAGE = '220.png'
		Abilities = list("Oblivious","Snow Cloak","Thick Fat")
	Piloswine
		CaptureRate = 75
		Gender = 50
		icon = '221Piloswine.dmi'
		Type1 = "Ice"
		Type2 = "Ground"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 100, "ATK" = 100, "DEF" = 80, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 66, "EXP" = 160)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Powder_Snow = 1,/obj/Moves/Endure = 1,/obj/Moves/Take_Down = 28,/obj/Moves/Fury_Attack = 33,/obj/Moves/Mist = 42,/obj/Moves/Blizzard = 56,/obj/Moves/Amnesia = 70)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Bite,/obj/Moves/Body_Slam,/obj/Moves/Rock_Slide)
		Weight = 123.0
		Number = 221
		Unevolve = /mob/Pokemon/Swinub
		POKEIMAGE = '221.png'
		Abilities = list("Oblivious","Snow Cloak","Thick Fat")
	Corsola
		CaptureRate = 60
		Gender = 25
		icon = '222Corsola.dmi'
		Type1 = "Water"
		Type2 = "Rock"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 55, "ATK" = 55, "DEF" = 85, "SPL ATK" = 65, "SPL DEF" = 85, "SPD" = 35, "EXP" = 113)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 7,/obj/Moves/Bubble = 13,/obj/Moves/Recover = 19,/obj/Moves/Bubblebeam = 25,/obj/Moves/Spike_Cannon = 31,/obj/Moves/Mirror_Coat = 37,/obj/Moves/Ancient_Power = 43)
		EggGroups = list("Water 1","Water 3")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Mist,/obj/Moves/Rock_Slide,/obj/Moves/Safeguard,/obj/Moves/Screech)
		Weight = 11.0
		Number = 222
		POKEIMAGE = '222.png'
		Abilities = list("Hustle","Natural Cure","Regenerator")
	Remoraid
		CaptureRate = 190
		Gender = 50
		icon = '223Remoraid.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 25" = /mob/Pokemon/Octillery)
		BaseStats = list("HP" = 35, "ATK" = 65, "DEF" = 35, "SPL ATK" = 65, "SPL DEF" = 35, "SPD" = 65, "EXP" = 78)
		LearnMoves = list(/obj/Moves/Water_Gun = 1,/obj/Moves/Lock_On = 11,/obj/Moves/Psybeam = 22,/obj/Moves/Aurora_Beam = 22,/obj/Moves/Bubblebeam = 22,/obj/Moves/Focus_Energy = 33,/obj/Moves/Ice_Beam = 44,/obj/Moves/Hyper_Beam = 55)
		EggGroups = list("Water 1","Water 2")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Supersonic,/obj/Moves/Screech,/obj/Moves/Octazooka)
		Weight = 26.5
		Number = 223
		POKEIMAGE = '223.png'
		Abilities = list("Hustle","Sniper","Moody")
	Octillery
		CaptureRate = 75
		Gender = 50
		icon = '224Octillery.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 75, "ATK" = 105, "DEF" = 75, "SPL ATK" = 105, "SPL DEF" = 75, "SPD" = 45, "EXP" = 164)
		LearnMoves = list(/obj/Moves/Water_Gun = 1,/obj/Moves/Constrict = 11,/obj/Moves/Psybeam = 22,/obj/Moves/Aurora_Beam = 22,/obj/Moves/Bubblebeam = 22,/obj/Moves/Octazooka = 25,/obj/Moves/Focus_Energy = 38,/obj/Moves/Ice_Beam = 54,/obj/Moves/Hyper_Beam = 70)
		EggGroups = list("Water 1","Water 2")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Supersonic,/obj/Moves/Screech,/obj/Moves/Octazooka)
		Weight = 62.8
		Number = 224
		Unevolve = /mob/Pokemon/Remoraid
		POKEIMAGE = '224.png'
		Abilities = list("Suction Cups","Sniper","Moody")
	Delibird
		CaptureRate = 45
		Gender = 50
		icon = '225Delibird.dmi'
		Type1 = "Ice"
		Type2 = "Flying"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 45, "ATK" = 55, "DEF" = 45, "SPL ATK" = 65, "SPL DEF" = 45, "SPD" = 75, "EXP" = 183)
		LearnMoves = list(/obj/Moves/Present = 1)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Future_Sight,/obj/Moves/Quick_Attack,/obj/Moves/Rapid_Spin,/obj/Moves/Splash)
		Weight = 35.3
		Number = 225
		POKEIMAGE = '225.png'
		Abilities = list("Vital Spirit","Hustle","Insomia")
	Mantine
		CaptureRate = 25
		Gender = 50
		icon = '226Mantine.dmi'
		Type1 = "Water"
		Type2 = "Flying"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 65, "ATK" = 40, "DEF" = 70, "SPL ATK" = 80, "SPL DEF" = 140, "SPD" = 70, "EXP" = 168)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Bubble = 1,/obj/Moves/Supersonic = 10,/obj/Moves/Bubblebeam = 18,/obj/Moves/Take_Down = 25,/obj/Moves/Agility = 32,/obj/Moves/Wing_Attack = 40,/obj/Moves/Confuse_Ray = 49)
		EggGroups = list("Water 1")
		EggMoves = list(/obj/Moves/Haze,/obj/Moves/Hydro_Pump,/obj/Moves/Slam,/obj/Moves/Twister)
		Weight = 485.0
		Number = 226
		POKEIMAGE = '226.png'
		Abilities = list("Swift Swim","Water Absorb","Water Veil")
	Skarmory
		CaptureRate = 25
		Gender = 50
		icon = '227Skarmory.dmi'
		Type1 = "Steel"
		Type2 = "Flying"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 65, "ATK" = 80, "DEF" = 140, "SPL ATK" = 40, "SPL DEF" = 70, "SPD" = 70, "EXP" = 168)
		LearnMoves = list(/obj/Moves/Leer = 1,/obj/Moves/Peck = 1,/obj/Moves/Sand_Attack = 13,/obj/Moves/Swift = 19,/obj/Moves/Agility = 25,/obj/Moves/Fury_Attack = 37,/obj/Moves/Steel_Wing = 49)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Drill_Peck,/obj/Moves/Pursuit,/obj/Moves/Sky_Attack,/obj/Moves/Whirlwind)
		Weight = 111.3
		Number = 227
		POKEIMAGE = '227.png'
		Abilities = list("Keen Eye","Sturdy","Weak Armor")
	Houndour
		CaptureRate = 120
		Gender = 50
		icon = '228Houndour.dmi'
		Type1 = "Fire"
		Type2 = "Dark"
		GrowthRate = "Slow"
		Evolve = list("Level 24" = /mob/Pokemon/Houndoom)
		BaseStats = list("HP" = 45, "ATK" = 60, "DEF" = 30, "SPL ATK" = 80, "SPL DEF" = 50, "SPD" = 65, "EXP" = 114)
		LearnMoves = list(/obj/Moves/Leer = 1,/obj/Moves/Ember = 1,/obj/Moves/Roar = 7,/obj/Moves/Smog = 13,/obj/Moves/Bite = 20,/obj/Moves/Faint_Attack = 27,/obj/Moves/Flamethrower = 35,/obj/Moves/Crunch = 43)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Beat_Up,/obj/Moves/Counter,/obj/Moves/Fire_Spin,/obj/Moves/Pursuit,/obj/Moves/Rage,/obj/Moves/Reversal,/obj/Moves/Spite)
		Weight = 23.8
		Number = 228
		POKEIMAGE = '228.png'
		Abilities = list("Early Bird","Flash Fire","Unnerve")
	Houndoom
		CaptureRate = 45
		Gender = 50
		icon = '229Houndoom.dmi'
		Type1 = "Fire"
		Type2 = "Dark"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 75, "ATK" = 90, "DEF" = 50, "SPL ATK" = 110, "SPL DEF" = 80, "SPD" = 95, "EXP" = 204)
		LearnMoves = list(/obj/Moves/Leer = 1,/obj/Moves/Ember = 1,/obj/Moves/Roar = 7,/obj/Moves/Smog = 13,/obj/Moves/Bite = 20,/obj/Moves/Faint_Attack = 30,/obj/Moves/Flamethrower = 41,/obj/Moves/Crunch = 52)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Beat_Up,/obj/Moves/Counter,/obj/Moves/Fire_Spin,/obj/Moves/Pursuit,/obj/Moves/Rage,/obj/Moves/Reversal,/obj/Moves/Spite)
		Weight = 77.2
		Number = 229
		Unevolve = /mob/Pokemon/Houndour
		POKEIMAGE = '229.png'
		Abilities = list("Early Bird","Flash Fire","Unnerve")
	Kingdra
		CaptureRate = 45
		Gender = 50
		icon = '230Kingdra.dmi'
		Type1 = "Water"
		Type2 = "Dragon"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 75, "ATK" = 95, "DEF" = 95, "SPL ATK" = 95, "SPL DEF" = 95, "SPD" = 85, "EXP" = 207)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Smokescreen = 1,/obj/Moves/Leer = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Twister = 29,/obj/Moves/Agility = 40,/obj/Moves/Hydro_Pump = 51)
		EggGroups = list("Water 1","Dragon")
		EggMoves = list(/obj/Moves/Aurora_Beam,/obj/Moves/Disable,/obj/Moves/Dragon_Rage,/obj/Moves/Flail,/obj/Moves/Octazooka,/obj/Moves/Splash)
		Weight = 335.1
		Number = 230
		Unevolve = /mob/Pokemon/Seadra
		POKEIMAGE = '230.png'
		Abilities = list("Swift Swim","Sniper","Damp")
	Phanpy
		CaptureRate = 120
		Gender = 50
		icon = '231Phanpy.dmi'
		Type1 = "Ground"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 25" = /mob/Pokemon/Donphan)
		BaseStats = list("HP" = 90, "ATK" = 60, "DEF" = 60, "SPL ATK" = 40, "SPL DEF" = 40, "SPD" = 40, "EXP" = 124)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Defense_Curl = 9,/obj/Moves/Flail = 17,/obj/Moves/Take_Down = 25,/obj/Moves/Rollout = 33,/obj/Moves/Endure = 41,/obj/Moves/Double_Edge = 49)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Body_Slam,/obj/Moves/Focus_Energy,/obj/Moves/Water_Gun)
		Weight = 73.9
		Number = 231
		POKEIMAGE = '231.png'
		Abilities = list("Pickup","Sand Veil")
	Donphan
		CaptureRate = 60
		Gender = 50
		icon = '232Donphan.dmi'
		Type1 = "Ground"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 90, "ATK" = 120, "DEF" = 120, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 50, "EXP" = 189)
		LearnMoves = list(/obj/Moves/Horn_Attack = 1,/obj/Moves/Growl = 1,/obj/Moves/Defense_Curl = 9,/obj/Moves/Flail = 17,/obj/Moves/Fury_Attack = 25,/obj/Moves/Rollout = 33,/obj/Moves/Rapid_Spin = 41,/obj/Moves/Earthquake = 49)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Body_Slam,/obj/Moves/Focus_Energy,/obj/Moves/Water_Gun)
		Weight = 264.6
		Number = 232
		Unevolve = /mob/Pokemon/Phanpy
		POKEIMAGE = '232.png'
		Abilities = list("Sand Veil")
	Porygon2
		CaptureRate = 45
		Gender = "Genderless"
		icon = '233Porygon2.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 85, "ATK" = 80, "DEF" = 90, "SPL ATK" = 105, "SPL DEF" = 95, "SPD" = 66, "EXP" = 180)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Conversion = 1,/obj/Moves/Conversion_2 = 1,/obj/Moves/Agility = 9,/obj/Moves/Psybeam = 12,/obj/Moves/Recover = 20,/obj/Moves/Defense_Curl = 24,/obj/Moves/Lock_On = 32,/obj/Moves/Tri_Attack = 36,/obj/Moves/Zap_Cannon = 44)
		EggGroups = list("Mineral")
		Weight = 71.6
		Number = 233
		Unevolve = /mob/Pokemon/Porygon
		POKEIMAGE = '233.png'
		Abilities = list("Trace","Download","Analytic")
	Stantler
		CaptureRate = 45
		Gender = 50
		icon = '234Stantler.dmi'
		Type1 = "Normal"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 73, "ATK" = 95, "DEF" = 62, "SPL ATK" = 85, "SPL DEF" = 65, "SPD" = 85, "EXP" = 165)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Leer = 8,/obj/Moves/Hypnosis = 15,/obj/Moves/Stomp = 23,/obj/Moves/Sand_Attack = 31,/obj/Moves/Take_Down = 40,/obj/Moves/Confuse_Ray = 49)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Bite,/obj/Moves/Disable,/obj/Moves/Light_Screen,/obj/Moves/Reflect,/obj/Moves/Reflect,/obj/Moves/Spite)
		Weight = 157.0
		Number = 234
		POKEIMAGE = '234.png'
		Abilities = list("Intimidate","Frisk","Sap Sipper")
	Smeargle
		CaptureRate = 45
		Gender = 50
		icon = '235Smeargle.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 55, "ATK" = 20, "DEF" = 35, "SPL ATK" = 20, "SPL DEF" = 45, "SPD" = 75, "EXP" = 106)
		LearnMoves = list(/obj/Moves/Sketch = 1)
		EggGroups = list("Field")
		Weight = 127.9
		Number = 235
		POKEIMAGE = '235.png'
		Abilities = list("Own Tempo","Technician","Moody")
	Tyrogue
		CaptureRate = 75
		Gender = 100
		icon = '236Tyrogue.dmi'
		Type1 = "Fighting"
		GrowthRate = "Medium-Fast"
		Evolve = list()
		BaseStats = list("HP" = 35, "ATK" = 35, "DEF" = 35, "SPL ATK" = 35, "SPL DEF" = 35, "SPD" = 35, "EXP" = 91)
		LearnMoves = list(/obj/Moves/Tackle = 1)
		EggMoves = list(/obj/Moves/Hi_Jump_Kick,/obj/Moves/Mach_Punch,/obj/Moves/Mind_Reader,/obj/Moves/Rapid_Spin)
		Weight = 46.3
		Number = 236
		POKEIMAGE = '236.png'
		Abilities = list("Guts","Steadfast","Vital Spirit")
	Hitmontop
		CaptureRate = 45
		Gender = 100
		icon = '237Hitmontop.dmi'
		Type1 = "Fighting"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 50, "ATK" = 95, "DEF" = 95, "SPL ATK" = 35, "SPL DEF" = 110, "SPD" = 70, "EXP" = 138)
		LearnMoves = list(/obj/Moves/Rolling_Kick = 1,/obj/Moves/Focus_Energy = 7,/obj/Moves/Pursuit = 13,/obj/Moves/Quick_Attack = 19,/obj/Moves/Rapid_Spin = 25,/obj/Moves/Counter = 31,/obj/Moves/Agility = 37,/obj/Moves/Detect = 43,/obj/Moves/Triple_Kick = 49)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Hi_Jump_Kick,/obj/Moves/Mach_Punch,/obj/Moves/Mind_Reader,/obj/Moves/Rapid_Spin)
		Weight = 105.8
		Number = 237
		Unevolve = /mob/Pokemon/Tyrogue
		POKEIMAGE = '237.png'
		Abilities = list("Intimidate","Technician","Steadfast")
	Smoochum
		CaptureRate = 45
		Gender = 0
		icon = '238Smoochum.dmi'
		Type1 = "Ice"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 30" = /mob/Pokemon/Jynx)
		BaseStats = list("HP" = 45, "ATK" = 30, "DEF" = 15, "SPL ATK" = 85, "SPL DEF" = 65, "SPD" = 65, "EXP" = 87)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Lick = 1,/obj/Moves/Sweet_Kiss = 9,/obj/Moves/Powder_Snow = 13,/obj/Moves/Confusion = 21,/obj/Moves/Sing = 25,/obj/Moves/Mean_Look = 33,/obj/Moves/Psychic = 37,/obj/Moves/Perish_Song = 45,/obj/Moves/Blizzard = 49)
		EggMoves = list(/obj/Moves/Meditate)
		Weight = 13.2
		Number = 238
		POKEIMAGE = '238.png'
		Abilities = list("Oblivious","Forewarn","Hydration")
	Elekid
		CaptureRate = 45
		Gender = 75
		icon = '239Elekid.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 30" = /mob/Pokemon/Electabuzz)
		BaseStats = list("HP" = 45, "ATK" = 63, "DEF" = 37, "SPL ATK" = 65, "SPL DEF" = 55, "SPD" = 95, "EXP" = 106)
		LearnMoves = list(/obj/Moves/Quick_Attack = 1,/obj/Moves/Leer = 1,/obj/Moves/Thunder_Punch = 9,/obj/Moves/Light_Screen = 17,/obj/Moves/Swift = 25,/obj/Moves/Screech = 33,/obj/Moves/Thunderbolt = 41,/obj/Moves/Thunder = 49)
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Cross_Chop,/obj/Moves/Karate_Chop,/obj/Moves/Meditate,/obj/Moves/Rolling_Kick)
		Weight = 51.8
		Number = 239
		POKEIMAGE = '239.png'
		Abilities = list("Static","Vital Spirit")
	Magby
		CaptureRate = 45
		Gender = 75
		icon = '240Magby.dmi'
		Type1 = "Fire"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 30" = /mob/Pokemon/Magmar)
		BaseStats = list("HP" = 45, "ATK" = 75, "DEF" = 37, "SPL ATK" = 70, "SPL DEF" = 55, "SPD" = 83, "EXP" = 117)
		LearnMoves = list(/obj/Moves/Ember = 1,/obj/Moves/Leer = 7,/obj/Moves/Smog = 13,/obj/Moves/Fire_Punch = 19,/obj/Moves/Smokescreen = 25,/obj/Moves/Sunny_Day = 31,/obj/Moves/Flamethrower = 37,/obj/Moves/Confuse_Ray = 43,/obj/Moves/Fire_Blast = 49)
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Cross_Chop,/obj/Moves/Karate_Chop,/obj/Moves/Mega_Punch,/obj/Moves/Screech)
		Weight = 47.2
		Number = 240
		POKEIMAGE = '240.png'
		Abilities = list("Flame Body","Vital Spirit")
	Miltank
		CaptureRate = 45
		Gender = 0
		icon = '241Miltank.dmi'
		Type1 = "Normal"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 95, "ATK" = 80, "DEF" = 105, "SPL ATK" = 40, "SPL DEF" = 70, "SPD" = 101, "EXP" = 200)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 4,/obj/Moves/Defense_Curl = 8,/obj/Moves/Stomp = 13,/obj/Moves/Milk_Drink = 19,/obj/Moves/Bide = 25,/obj/Moves/Rollout = 34,/obj/Moves/Body_Slam = 43,/obj/Moves/Heal_Bell = 53)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Present,/obj/Moves/Reversal,/obj/Moves/Seismic_Toss)
		Weight = 166.4
		Number = 241
		POKEIMAGE = '241.png'
		Abilities = list("Thick Fat","Scrappy","Sap Sipper")
	Blissey
		CaptureRate = 30
		Gender = 0
		icon = '242Blissey.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 255, "ATK" = 10, "DEF" = 10, "SPL ATK" = 75, "SPL DEF" = 135, "SPD" = 55, "EXP" = 608)
		LearnMoves = list(/obj/Moves/Pound = 1, /obj/Moves/Growl = 5, /obj/Moves/Tail_Whip = 9, /obj/Moves/Softboiled = 13, /obj/Moves/DoubleSlap = 17, /obj/Moves/Minimize = 23,/obj/Moves/Sing = 29,/obj/Moves/Defense_Curl = 41,/obj/Moves/Light_Screen = 49,/obj/Moves/Egg_Bomb = 35,/obj/Moves/Double_Edge = 57)
		EggGroups = list("Fairy")
		EggMoves = list(/obj/Moves/Present,/obj/Moves/Metronome,/obj/Moves/Heal_Bell)
		Weight = 103.2
		Number = 242
		Unevolve = /mob/Pokemon/Chansey
		POKEIMAGE = '242.png'
		Abilities = list("Natural Cure","Serene Grace","Healer")
	Raikou
		CaptureRate = 3
		Gender = "Unbreedable"
		icon = '243Raikou.dmi'
		Type1 = "Electric"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 90, "ATK" = 85, "DEF" = 75, "SPL ATK" = 115, "SPL DEF" = 100, "SPD" = 115, "EXP" = 216)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Leer = 1,/obj/Moves/Thundershock = 11,/obj/Moves/Roar = 21,/obj/Moves/Quick_Attack = 31,/obj/Moves/Spark = 41,/obj/Moves/Reflect = 51,/obj/Moves/Crunch = 61,/obj/Moves/Thunder = 71)
		Weight = 392.4
		Number = 243
		POKEIMAGE = '243.png'
		Abilities = list("Pressure","Volt Absorb")
	Entei
		CaptureRate = 3
		Gender = "Unbreedable"
		icon = '244Entei.dmi'
		Type1 = "Fire"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 115, "ATK" = 115, "DEF" = 85, "SPL ATK" = 90, "SPL DEF" = 75, "SPD" = 100, "EXP" = 217)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Leer = 1,/obj/Moves/Ember = 11,/obj/Moves/Roar = 21,/obj/Moves/Fire_Spin = 31,/obj/Moves/Stomp = 41,/obj/Moves/Flamethrower = 51,/obj/Moves/Swagger = 61,/obj/Moves/Fire_Blast = 71)
		Weight = 436.5
		Number = 244
		POKEIMAGE = '244.png'
		Abilities = list("Pressure","Flash Fire")
	Suicune
		CaptureRate = 3
		Gender = "Unbreedable"
		icon = '245Suicune.dmi'
		Type1 = "Water"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 100, "ATK" = 75, "DEF" = 115, "SPL ATK" = 90, "SPL DEF" = 115, "SPD" = 85, "EXP" = 215)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Leer = 1,/obj/Moves/Water_Gun = 11,/obj/Moves/Bubblebeam = 11,/obj/Moves/Roar = 21,/obj/Moves/Rain_Dance = 21,/obj/Moves/Gust = 31,/obj/Moves/Aurora_Beam = 41,/obj/Moves/Mist = 51,/obj/Moves/Mirror_Coat = 61,/obj/Moves/Hydro_Pump = 71)
		Weight = 412.3
		Number = 245
		POKEIMAGE = '245.png'
		Abilities = list("Pressure","Water Absorb")
	Larvitar
		CaptureRate = 45
		Gender = 50
		icon = '246Larvitar.dmi'
		Type1 = "Rock"
		Type2 = "Ground"
		GrowthRate = "Slow"
		Evolve = list("Level 30" = /mob/Pokemon/Pupitar)
		BaseStats = list("HP" = 50, "ATK" = 64, "DEF" = 50, "SPL ATK" = 45, "SPL DEF" = 50, "SPD" = 41, "EXP" = 67)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Leer = 1,/obj/Moves/Sandstorm = 8,/obj/Moves/Screech = 15,/obj/Moves/Rock_Slide = 22,/obj/Moves/Thrash = 29,/obj/Moves/Scary_Face = 36,/obj/Moves/Crunch = 43,/obj/Moves/Earthquake = 50,/obj/Moves/Hyper_Beam = 57)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Focus_Energy,/obj/Moves/Outrage,/obj/Moves/Pursuit,/obj/Moves/Stomp)
		Weight = 158.7
		Number = 246
		POKEIMAGE = '246.png'
		Abilities = list("Guts","Sand Viel")
	Pupitar
		CaptureRate = 45
		Gender = 50
		icon = '247Pupitar.dmi'
		Type1 = "Rock"
		Type2 = "Ground"
		GrowthRate = "Slow"
		Evolve = list("Level 55" = /mob/Pokemon/Tyranitar)
		BaseStats = list("HP" = 70, "ATK" = 84, "DEF" = 70, "SPL ATK" = 65, "SPL DEF" = 70, "SPD" = 51, "EXP" = 144)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Leer = 1,/obj/Moves/Sandstorm = 1,/obj/Moves/Screech = 1,/obj/Moves/Rock_Slide = 22,/obj/Moves/Thrash = 29,/obj/Moves/Scary_Face = 38,/obj/Moves/Crunch = 47,/obj/Moves/Earthquake = 56,/obj/Moves/Hyper_Beam = 65)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Focus_Energy,/obj/Moves/Outrage,/obj/Moves/Pursuit,/obj/Moves/Stomp)
		Weight = 335.1
		Number = 247
		Unevolve = /mob/Pokemon/Larvitar
		POKEIMAGE = '247.png'
		Abilities = list("Shed Skin")
	Tyranitar
		CaptureRate = 45
		Gender = 50
		icon = '248Tyranitar.dmi'
		Type1 = "Rock"
		Type2 = "Dark"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 100, "ATK" = 134, "DEF" = 110, "SPL ATK" = 95, "SPL DEF" = 100, "SPD" = 61, "EXP" = 218)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Leer = 1,/obj/Moves/Sandstorm = 1,/obj/Moves/Screech = 1,/obj/Moves/Rock_Slide = 22,/obj/Moves/Thrash = 29,/obj/Moves/Scary_Face = 38,/obj/Moves/Crunch = 47,/obj/Moves/Earthquake = 61,/obj/Moves/Hyper_Beam = 75)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Focus_Energy,/obj/Moves/Outrage,/obj/Moves/Pursuit,/obj/Moves/Stomp)
		Weight = 445.3
		Number = 248
		Unevolve = /mob/Pokemon/Pupitar
		POKEIMAGE = '248.png'
		Abilities = list("Guts","Sand Stream","Unnerve")
	Lugia
		CaptureRate = 3
		Gender = "Unbreedable"
		icon = '249Lugia.dmi'
		Type1 = "Psychic"
		Type2 = "Flying"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 106, "ATK" = 90, "DEF" = 130, "SPL ATK" = 90, "SPL DEF" = 154, "SPD" = 110, "EXP" = 220)
		LearnMoves = list(/obj/Moves/Aeroblast = 1,/obj/Moves/Safeguard = 11,/obj/Moves/Gust = 22,/obj/Moves/Recover = 33,/obj/Moves/Hydro_Pump = 44,/obj/Moves/Rain_Dance = 55,/obj/Moves/Swift = 66,/obj/Moves/Whirlwind = 77,/obj/Moves/Ancient_Power = 88,/obj/Moves/Future_Sight = 99)
		Weight = 476.2
		Number = 249
		POKEIMAGE = '249.png'
		Abilities = list("Pressure","Multiscale")
	HoOh
		name = "Ho-Oh"
		CaptureRate = 3
		Gender = "Unbreedable"
		icon = '250HoOh.dmi'
		Type1 = "Fire"
		Type2 = "Flying"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 106, "ATK" = 130, "DEF" = 90, "SPL ATK" = 110, "SPL DEF" = 154, "SPD" = 90, "EXP" = 220)
		LearnMoves = list(/obj/Moves/Sacred_Fire = 1,/obj/Moves/Safeguard = 11,/obj/Moves/Gust = 22,/obj/Moves/Recover = 33,/obj/Moves/Fire_Blast = 44,/obj/Moves/Sunny_Day = 55,/obj/Moves/Swift = 66,/obj/Moves/Whirlwind = 77,/obj/Moves/Ancient_Power = 88,/obj/Moves/Future_Sight = 99)
		Weight = 438.7
		Number = 250
		POKEIMAGE = '250.png'
		Abilities = list("Pressure","Regenerator")
	Celebi
		name = "Celebi"
		CaptureRate = 45
		Gender = "Unbreedable"
		icon = '251Celebi.dmi'
		Type1 = "Psychic"
		Type2 = "Grass"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 100, "ATK" = 100, "DEF" = 100, "SPL ATK" = 100, "SPL DEF" = 100, "SPD" = 101, "EXP" = 64)
		LearnMoves = list(/obj/Moves/Leech_Seed = 1,/obj/Moves/Confusion = 1,/obj/Moves/Heal_Bell = 1,/obj/Moves/Recover = 1,/obj/Moves/Safeguard = 10,/obj/Moves/Ancient_Power = 20,/obj/Moves/Future_Sight = 30,/obj/Moves/Baton_Pass = 40,/obj/Moves/Perish_Song = 50)
		Weight = 11
		Number = 251
		POKEIMAGE = '251.png'
		Abilities = list("Natural Cure")
	Treecko
		CaptureRate = 45
		Gender = 87
		icon = '252Treecko.dmi'
		Type1 = "Grass"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 16" = /mob/Pokemon/Grovyle)
		BaseStats = list("HP" = 40, "ATK" = 45, "DEF" = 35, "SPL ATK" = 65, "SPL DEF" = 55, "SPD" = 70, "EXP" = 65)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Leer = 1,/obj/Moves/Absorb = 6,/obj/Moves/Quick_Attack = 11,/obj/Moves/Pursuit = 16,/obj/Moves/Screech = 21,/obj/Moves/Mega_Drain = 26,/obj/Moves/Agility = 31,/obj/Moves/Slam = 36,/obj/Moves/Detect = 41,/obj/Moves/Giga_Drain = 46)
		EggGroups = list("Monster","Dragon")
		EggMoves = list(/obj/Moves/Crunch,/obj/Moves/Crush_Claw,/obj/Moves/Dragon_Breath,/obj/Moves/Endeavor,/obj/Moves/Leech_Seed,/obj/Moves/Mud_Sport)
		Weight = 11
		Number = 252
		POKEIMAGE = '252.png'
		Abilities = list("Overgrow")
		HiddenAbility = list("Unburden")
	Grovyle
		CaptureRate = 45
		Gender = 87
		icon = '253Grovyle.dmi'
		Type1 = "Grass"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 36" = /mob/Pokemon/Sceptile)
		BaseStats = list("HP" = 50, "ATK" = 65, "DEF" = 45, "SPL ATK" = 85, "SPL DEF" = 65, "SPD" = 95, "EXP" = 141)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Leer = 1,/obj/Moves/Absorb = 1,/obj/Moves/Quick_Attack = 1,/obj/Moves/Pursuit = 16,/obj/Moves/Fury_Cutter = 16,/obj/Moves/Screech = 23,/obj/Moves/Leaf_Blade = 29,/obj/Moves/Agility = 35,/obj/Moves/Slam = 41,/obj/Moves/Detect = 47,/obj/Moves/False_Swipe = 53)
		EggGroups = list("Monster","Dragon")
		EggMoves = list(/obj/Moves/Crunch,/obj/Moves/Crush_Claw,/obj/Moves/Dragon_Breath,/obj/Moves/Endeavor,/obj/Moves/Leech_Seed,/obj/Moves/Mud_Sport)
		Weight = 47.6
		POKEIMAGE = '253.png'
		Number = 253
		Unevolve = /mob/Pokemon/Treecko
		Abilities = list("Overgrow")
		HiddenAbility = list("Unburden")
	Sceptile
		CaptureRate = 45
		Gender = 87
		icon = '254Sceptile.dmi'
		Type1 = "Grass"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 70, "ATK" = 85, "DEF" = 65, "SPL ATK" = 105, "SPL DEF" = 85, "SPD" = 120, "EXP" = 208)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Leer = 1,/obj/Moves/Absorb = 1,/obj/Moves/Quick_Attack = 1,/obj/Moves/Fury_Cutter = 16,/obj/Moves/Pursuit = 17,/obj/Moves/Screech = 23,/obj/Moves/Leaf_Blade = 29,/obj/Moves/Agility = 35,/obj/Moves/Slam = 43,/obj/Moves/Detect = 51,/obj/Moves/False_Swipe = 59)
		EggGroups = list("Monster","Dragon")
		EggMoves = list(/obj/Moves/Crunch,/obj/Moves/Crush_Claw,/obj/Moves/Dragon_Breath,/obj/Moves/Endeavor,/obj/Moves/Leech_Seed,/obj/Moves/Mud_Sport)
		Weight = 115.1
		POKEIMAGE = '254.png'
		Number = 254
		Unevolve = /mob/Pokemon/Grovyle
		Abilities = list("Overgrow")
		HiddenAbility = list("Unburden")
	Torchic
		CaptureRate = 45
		Gender = 87
		icon = '255Torchic.dmi'
		Type1 = "Fire"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 16" = /mob/Pokemon/Combusken)
		BaseStats = list("HP" = 45, "ATK" = 60, "DEF" = 40, "SPL ATK" = 70, "SPL DEF" = 50, "SPD" = 45, "EXP" = 65)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Growl = 1,/obj/Moves/Focus_Energy = 7,/obj/Moves/Ember = 10,/obj/Moves/Peck = 16,/obj/Moves/Sand_Attack = 19,/obj/Moves/Fire_Spin = 25,/obj/Moves/Quick_Attack = 28,/obj/Moves/Slash = 34,/obj/Moves/Mirror_Move = 37,/obj/Moves/Flamethrower = 43)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Endure,/obj/Moves/Reversal,/obj/Moves/Rock_Slide,/obj/Moves/SmellingSalt,/obj/Moves/Swagger)
		Weight = 5.5
		Number = 255
		POKEIMAGE = '255.png'
		Abilities = list("Blaze")
		HiddenAbility = list("Speed Boost")
	Combusken
		CaptureRate = 45
		Gender = 87
		icon = '256Combusken.dmi'
		Type1 = "Fire"
		Type2 = "Fighting"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 36" = /mob/Pokemon/Blaziken)
		BaseStats = list("HP" = 60, "ATK" = 85, "DEF" = 60, "SPL ATK" = 85, "SPL DEF" = 60, "SPD" = 55, "EXP" = 142)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Growl = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Ember = 1,/obj/Moves/Double_Kick = 16,/obj/Moves/Peck = 17,/obj/Moves/Sand_Attack = 21,/obj/Moves/Bulk_Up = 28,/obj/Moves/Quick_Attack = 32,/obj/Moves/Slash = 39,/obj/Moves/Mirror_Move = 43,/obj/Moves/Sky_Uppercut = 50)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Endure,/obj/Moves/Reversal,/obj/Moves/Rock_Slide,/obj/Moves/SmellingSalt,/obj/Moves/Swagger)
		Weight = 43
		POKEIMAGE = '256.png'
		Number = 256
		Unevolve = /mob/Pokemon/Torchic
		Abilities = list("Blaze")
		HiddenAbility = list("Speed Boost")
	Blaziken
		CaptureRate = 45
		Gender = 87
		icon = '257Blaziken.dmi'
		Type1 = "Fire"
		Type2 = "Fighting"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 80, "ATK" = 120, "DEF" = 70, "SPL ATK" = 110, "SPL DEF" = 70, "SPD" = 80, "EXP" = 209)
		LearnMoves = list(/obj/Moves/Fire_Punch = 1,/obj/Moves/Scratch = 1,/obj/Moves/Growl = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Ember = 1,/obj/Moves/Double_Kick = 16,/obj/Moves/Peck = 17,/obj/Moves/Sand_Attack = 21,/obj/Moves/Bulk_Up = 28,/obj/Moves/Quick_Attack = 32,/obj/Moves/Blaze_Kick = 36,/obj/Moves/Slash = 42,/obj/Moves/Mirror_Move = 49,/obj/Moves/Sky_Uppercut = 59)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Endure,/obj/Moves/Reversal,/obj/Moves/Rock_Slide,/obj/Moves/SmellingSalt,/obj/Moves/Swagger)
		Weight = 114.6
		POKEIMAGE = '257.png'
		Number = 257
		Unevolve = /mob/Pokemon/Combusken
		Abilities = list("Blaze")
		HiddenAbility = list("Speed Boost")
	Mudkip
		CaptureRate = 45
		Gender = 87
		icon = '258Mudkip.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 16" = /mob/Pokemon/Marshtomp)
		BaseStats = list("HP" = 50, "ATK" = 70, "DEF" = 50, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 40, "EXP" = 65)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Mud_Slap = 6,/obj/Moves/Water_Gun = 10,/obj/Moves/Bide = 15,/obj/Moves/Foresight = 19,/obj/Moves/Mud_Sport = 24,/obj/Moves/Take_Down = 28,/obj/HMs/Whirlpool = 33,/obj/Moves/Protect = 37,/obj/Moves/Hydro_Pump = 42,/obj/Moves/Endeavor = 46)
		EggGroups = list("Monster","Water 1")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Mirror_Coat,/obj/Moves/Ice_Ball,/obj/Moves/Refresh,/obj/Moves/Uproar,/obj/Moves/Stomp)
		Weight = 16.8
		Number = 258
		POKEIMAGE = '258.png'
		Abilities = list("Torrent")
		HiddenAbility = list("Damp")
	Marshtomp
		CaptureRate = 45
		Gender = 87
		icon = '259Marshtomp.dmi'
		Type1 = "Water"
		Type2 = "Ground"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 36" = /mob/Pokemon/Swampert)
		BaseStats = list("HP" = 70, "ATK" = 85, "DEF" = 70, "SPL ATK" = 60, "SPL DEF" = 70, "SPD" = 50, "EXP" = 143)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Mud_Slap = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Bide = 15,/obj/Moves/Mud_Shot = 16,/obj/Moves/Foresight = 20,/obj/Moves/Mud_Sport = 25,/obj/Moves/Take_Down = 31,/obj/Moves/Muddy_Water = 37,/obj/Moves/Protect = 42,/obj/Moves/Earthquake = 46,/obj/Moves/Endeavor = 53)
		EggGroups = list("Monster","Water 1")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Mirror_Coat,/obj/Moves/Ice_Ball,/obj/Moves/Refresh,/obj/Moves/Uproar,/obj/Moves/Stomp)
		Weight = 61.7
		POKEIMAGE = '259.png'
		Number = 259
		Unevolve = /mob/Pokemon/Mudkip
		Abilities = list("Torrent")
		HiddenAbility = list("Damp")
	Swampert
		CaptureRate = 45
		Gender = 87
		icon = '260Swampert.dmi'
		Type1 = "Water"
		Type2 = "Ground"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 100, "ATK" = 110, "DEF" = 90, "SPL ATK" = 85, "SPL DEF" = 90, "SPD" = 60, "EXP" = 210)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Bide = 15,/obj/Moves/Mud_Shot = 16,/obj/Moves/Mud_Sport = 25,/obj/Moves/Take_Down = 31,/obj/Moves/Muddy_Water = 39,/obj/Moves/Foresight = 20,/obj/Moves/Protect = 46,/obj/Moves/Earthquake = 52,/obj/Moves/Endeavor = 61)
		EggGroups = list("Monster","Water 1")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Mirror_Coat,/obj/Moves/Ice_Ball,/obj/Moves/Refresh,/obj/Moves/Uproar,/obj/Moves/Stomp)
		Weight = 180.6
		POKEIMAGE = '260.png'
		Number = 260
		Unevolve = /mob/Pokemon/Marshtomp
		Abilities = list("Torrent")
		HiddenAbility = list("Damp")
	Poochyena
		CaptureRate = 255
		Gender = 50
		icon = '261Poochyena.dmi'
		Type1 = "Dark"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 18" = /mob/Pokemon/Mightyena)
		BaseStats = list("HP" = 35, "ATK" = 55, "DEF" = 35, "SPL ATK" = 30, "SPL DEF" = 30, "SPD" = 35, "EXP" = 55)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Howl = 5,/obj/Moves/Sand_Attack = 9,/obj/Moves/Bite = 13,/obj/Moves/Odor_Sleuth = 17,/obj/Moves/Roar = 21,/obj/Moves/Swagger = 25,/obj/Moves/Scary_Face = 29,/obj/Moves/Take_Down = 33,/obj/Moves/Taunt = 37,/obj/Moves/Crunch = 41,/obj/Moves/Thief = 45)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Astonish,/obj/Moves/Covet,/obj/Moves/Leer,/obj/Moves/Poison_Fang,/obj/Moves/Yawn)
		Weight = 30
		Number = 261
		POKEIMAGE = '261.png'
		Abilities = list("Run Away","Quick Feet","Rattled")
	Mightyena
		CaptureRate = 127
		Gender = 50
		icon = '262Mightyena.dmi'
		Type1 = "Dark"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 70, "ATK" = 90, "DEF" = 70, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 70, "EXP" = 128)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Howl = 1,/obj/Moves/Sand_Attack = 1,/obj/Moves/Bite = 1,/obj/Moves/Odor_Sleuth = 17,/obj/Moves/Roar = 22,/obj/Moves/Swagger = 27,/obj/Moves/Scary_Face = 32,/obj/Moves/Take_Down = 37,/obj/Moves/Taunt = 42,/obj/Moves/Crunch = 47,/obj/Moves/Thief = 52)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Astonish,/obj/Moves/Covet,/obj/Moves/Leer,/obj/Moves/Poison_Fang,/obj/Moves/Yawn)
		Weight = 81.6
		POKEIMAGE = '262.png'
		Number = 262
		Unevolve = /mob/Pokemon/Poochyena
		Abilities = list("Intimidate","Quick Feet","Moxie")
	Zigzagoon
		CaptureRate = 255
		Gender = 50
		icon = '263Zigzagoon.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 20" = /mob/Pokemon/Linoone)
		BaseStats = list("HP" = 38, "ATK" = 30, "DEF" = 41, "SPL ATK" = 30, "SPL DEF" = 41, "SPD" = 60, "EXP" = 60)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Tail_Whip = 5,/obj/Moves/Headbutt = 9,/obj/Moves/Sand_Attack = 13,/obj/Moves/Odor_Sleuth = 17,/obj/Moves/Mud_Sport = 21,/obj/Moves/Pin_Missle = 25,/obj/Moves/Covet = 29,/obj/Moves/Flail = 33,/obj/Moves/Rest = 37,/obj/Moves/Belly_Drum = 41)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Pursuit,/obj/Moves/Substitute,/obj/Moves/Tickle,/obj/Moves/Trick)
		Weight = 38.6
		Number = 263
		POKEIMAGE = '263.png'
		Abilities = list("Pickup","Gluttony","Quick Feet")
	Linoone
		CaptureRate = 90
		Gender = 50
		icon = '264Linoone.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 78, "ATK" = 70, "DEF" = 61, "SPL ATK" = 50, "SPL DEF" = 61, "SPD" = 101, "EXP" = 128)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Growl = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Headbutt = 1,/obj/Moves/Sand_Attack = 13,/obj/Moves/Odor_Sleuth = 17,/obj/Moves/Mud_Sport = 23,/obj/Moves/Fury_Swipes = 29,/obj/Moves/Covet = 35,/obj/Moves/Slash = 41,/obj/Moves/Rest = 47,/obj/Moves/Belly_Drum = 53)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Pursuit,/obj/Moves/Substitute,/obj/Moves/Tickle,/obj/Moves/Trick)
		Weight = 71.6
		POKEIMAGE = '264.png'
		Unevolve = /mob/Pokemon/Zigzagoon
		Abilities = list("Pickup","Gluttony","Quick Feet")
	Wurmple
		CaptureRate = 255
		Gender = 50
		icon = '265Wurmple.dmi'
		Type1 = "Bug"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 7" = list(/mob/Pokemon/Silcoon,/mob/Pokemon/Cascoon))
		BaseStats = list("HP" = 45, "ATK" = 45, "DEF" = 35, "SPL ATK" = 20, "SPL DEF" = 30, "SPD" = 20, "EXP" = 54)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/String_Shot = 1,/obj/Moves/Poison_Sting = 5)
		EggGroups = list("Bug")
		Weight = 7.9
		Number = 264
		POKEIMAGE = '265.png'
		Abilities = list("Shield Dust","Run Away")
	Silcoon
		CaptureRate = 120
		Gender = 50
		icon = '266Silcoon.dmi'
		Type1 = "Bug"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 10" = /mob/Pokemon/Beautifly)
		BaseStats = list("HP" = 50, "ATK" = 35, "DEF" = 55, "SPL ATK" = 25, "SPL DEF" = 25, "SPD" = 15, "EXP" = 72)
		LearnMoves = list(/obj/Moves/Harden = 1)
		EggGroups = list("Bug")
		Weight = 22
		POKEIMAGE = '266.png'
		Number = 265
		Unevolve = /mob/Pokemon/Wurmple
		Abilities = list("Shed Skin")
	Beautifly
		CaptureRate = 45
		Gender = 50
		icon = '267Beautifly.dmi'
		Type1 = "Bug"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 70, "DEF" = 50, "SPL ATK" = 90, "SPL DEF" = 50, "SPD" = 70, "EXP" = 161)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Gust = 13,/obj/Moves/Stun_Spore = 17,/obj/Moves/Morning_Sun = 20,/obj/Moves/Mega_Drain = 24,/obj/Moves/Whirlwind = 27,/obj/Moves/Attract = 31,/obj/Moves/Silver_Wind = 34,/obj/Moves/Giga_Drain = 38)
		EggGroups = list("Bug")
		Weight = 62.6
		POKEIMAGE = '267.png'
		Number = 267
		Unevolve = /mob/Pokemon/Silcoon
		Abilities = list("Swarm","Rivalry")
	Cascoon
		CaptureRate = 120
		Gender = 50
		icon = '268Cascoon.dmi'
		Type1 = "Bug"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 10" = /mob/Pokemon/Dustox)
		BaseStats = list("HP" = 50, "ATK" = 35, "DEF" = 55, "SPL ATK" = 25, "SPL DEF" = 25, "SPD" = 15, "EXP" = 72)
		LearnMoves = list(/obj/Moves/Harden = 1)
		EggGroups = list("Bug")
		Weight = 22
		POKEIMAGE = '268.png'
		Number = 268
		Unevolve = /mob/Pokemon/Wurmple
		Abilities = list("Shed Skin")
	Dustox
		CaptureRate = 45
		Gender = 50
		icon = '269Dustox.dmi'
		Type1 = "Bug"
		Type2 = "Poison"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 50, "DEF" = 70, "SPL ATK" = 50, "SPL DEF" = 90, "SPD" = 70, "EXP" = 161)
		LearnMoves = list(/obj/Moves/Confusion = 1,/obj/Moves/Gust = 13,/obj/Moves/Protect = 17,/obj/Moves/Moonlight = 20,/obj/Moves/Psybeam = 24,/obj/Moves/Whirlwind = 27,/obj/Moves/Light_Screen = 31,/obj/Moves/Silver_Wind = 34,/obj/Moves/Toxic = 37)
		EggGroups = list("Bug")
		Weight = 69.7
		POKEIMAGE = '269.png'
		Number = 269
		Unevolve = /mob/Pokemon/Cascoon
		Abilities = list("Shield Dust","Compoundeyes")
	Lotad
		CaptureRate = 255
		Gender = 50
		icon = '270Lotad.dmi'
		Type1 = "Water"
		Type2 = "Grass"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 14" = /mob/Pokemon/Lombre)
		BaseStats = list("HP" = 40, "ATK" = 30, "DEF" = 30, "SPL ATK" = 40, "SPL DEF" = 50, "SPD" = 30, "EXP" = 74)
		LearnMoves = list(/obj/Moves/Astonish = 1,/obj/Moves/Growl = 3,/obj/Moves/Absorb = 7,/obj/Moves/Nature_Power = 13,/obj/Moves/Mist = 21,/obj/Moves/Rain_Dance = 31,/obj/Moves/Mega_Drain = 43)
		EggGroups = list("Water 1","Grass")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Leech_Seed,/obj/Moves/Razor_Leaf,/obj/Moves/Sweet_Scent,/obj/Moves/Synthesis,/obj/Moves/Water_Gun)
		Weight = 5.7
		Number = 270
		POKEIMAGE = '270.png'
		Abilities = list("Swift Swim","Rain Dish","Own Tempo")
	Lombre
		CaptureRate = 120
		Gender = 50
		icon = '271Lombre.dmi'
		Type1 = "Water"
		Type2 = "Grass"
		GrowthRate = "Medium-Slow"
		Evolve = list("Waterstone" = /mob/Pokemon/Ludicolo)
		BaseStats = list("HP" = 60, "ATK" = 50, "DEF" = 50, "SPL ATK" = 60, "SPL DEF" = 70, "SPD" = 50, "EXP" = 141)
		LearnMoves = list(/obj/Moves/Astonish = 1,/obj/Moves/Growl = 3,/obj/Moves/Absorb = 7,/obj/Moves/Nature_Power = 13,/obj/Moves/Fake_Out = 19,/obj/Moves/Fury_Swipes = 25,/obj/Moves/Water_Sport = 31,/obj/Moves/Thief = 37,/obj/Moves/Uproar = 43,/obj/Moves/Hydro_Pump = 49)
		EggGroups = list("Water 1","Grass")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Leech_Seed,/obj/Moves/Razor_Leaf,/obj/Moves/Sweet_Scent,/obj/Moves/Synthesis,/obj/Moves/Water_Gun)
		Weight = 71.6
		POKEIMAGE = '271.png'
		Number = 271
		Unevolve = /mob/Pokemon/Lotad
		Abilities = list("Swift Swim","Rain Dish","Own Tempo")
	Ludicolo
		CaptureRate = 45
		Gender = 50
		icon = '272Ludicolo.dmi'
		Type1 = "Water"
		Type2 = "Grass"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 80, "ATK" = 70, "DEF" = 70, "SPL ATK" = 90, "SPL DEF" = 100, "SPD" = 70, "EXP" = 181)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Astonish = 1,/obj/Moves/Growl = 1,/obj/Moves/Nature_Power = 1)
		EggGroups = list("Water 1","Grass")
		EggMoves = list(/obj/Moves/Flail,/obj/Moves/Leech_Seed,/obj/Moves/Razor_Leaf,/obj/Moves/Sweet_Scent,/obj/Moves/Synthesis,/obj/Moves/Water_Gun)
		Weight = 121.3
		POKEIMAGE = '272.png'
		Number = 272
		Unevolve = /mob/Pokemon/Lombre
		Abilities = list("Swift Swim","Rain Dish","Own Tempo")
	Seedot
		CaptureRate = 255
		Gender = 50
		icon = '273Seedot.dmi'
		Type1 = "Grass"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 14" = /mob/Pokemon/Nuzleaf)
		BaseStats = list("HP" = 40, "ATK" = 40, "DEF" = 50, "SPL ATK" = 30, "SPL DEF" = 30, "SPD" = 30, "EXP" = 74)
		LearnMoves = list(/obj/Moves/Bide = 1,/obj/Moves/Harden = 1,/obj/Moves/Growth = 7,/obj/Moves/Nature_Power = 13,/obj/Moves/Synthesis = 21,/obj/Moves/Sunny_Day = 31,/obj/Moves/Explosion = 43)
		EggGroups = list("Field","Grass")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/False_Swipe,/obj/Moves/Leech_Seed,/obj/Moves/Quick_Attack,/obj/Moves/Razor_Wind,/obj/Moves/Take_Down)
		Weight = 8.8
		POKEIMAGE = '273.png'
		Number = 274
		Abilities = list("Chlorophyll","Early Bird","Pickpocket")
	Nuzleaf
		CaptureRate = 120
		Gender = 50
		icon = '274Nuzleaf.dmi'
		Type1 = "Grass"
		Type2 = "Dark"
		GrowthRate = "Medium-Slow"
		Evolve = list("Leafstone" = /mob/Pokemon/Shiftry)
		BaseStats = list("HP" = 70, "ATK" = 70, "DEF" = 40, "SPL ATK" = 60, "SPL DEF" = 40, "SPD" = 60, "EXP" = 141)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Harden = 3,/obj/Moves/Growth = 7,/obj/Moves/Nature_Power = 13,/obj/Moves/Fake_Out = 19,/obj/Moves/Torment = 25,/obj/Moves/Faint_Attack = 31,/obj/Moves/Razor_Wind = 37,/obj/Moves/Swagger = 43,/obj/Moves/Extrasensory = 49)
		EggGroups = list("Field","Grass")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/False_Swipe,/obj/Moves/Leech_Seed,/obj/Moves/Quick_Attack,/obj/Moves/Razor_Wind,/obj/Moves/Take_Down)
		Weight = 61.7
		POKEIMAGE = '274.png'
		Number = 275
		Unevolve = /mob/Pokemon/Seedot
		Abilities = list("Chlorophyll","Early Bird","Pickpocket")
	Shiftry
		CaptureRate = 45
		Gender = 50
		icon = '275Shiftry.dmi'
		Type1 = "Grass"
		Type2 = "Dark"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 90, "ATK" = 100, "DEF" = 60, "SPL ATK" = 90, "SPL DEF" = 60, "SPD" = 80, "EXP" = 181)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Harden = 1,/obj/Moves/Growth = 1,/obj/Moves/Nature_Power = 1)
		EggGroups = list("Field","Grass")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/False_Swipe,/obj/Moves/Leech_Seed,/obj/Moves/Quick_Attack,/obj/Moves/Razor_Wind,/obj/Moves/Take_Down)
		Weight = 131.4
		POKEIMAGE = '275.png'
		Number = 275
		Unevolve = /mob/Pokemon/Nuzleaf
		Abilities = list("Chlorophyll","Early Bird","Pickpocket")
	Taillow
		CaptureRate = 200
		Gender = 50
		icon = '276Taillow.dmi'
		Type1 = "Normal"
		Type2 = "Flying"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 22" = /mob/Pokemon/Swellow)
		BaseStats = list("HP" = 40, "ATK" = 55, "DEF" = 30, "SPL ATK" = 30, "SPL DEF" = 30, "SPD" = 85, "EXP" = 59)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Growl = 1,/obj/Moves/Focus_Energy = 4,/obj/Moves/Quick_Attack = 8,/obj/Moves/Wing_Attack = 13,/obj/Moves/Double_Team = 19,/obj/Moves/Endeavor = 26,/obj/Moves/Aerial_Ace = 34,/obj/Moves/Agility = 43)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Mirror_Move,/obj/Moves/Pursuit,/obj/Moves/Rage,/obj/Moves/Refresh,/obj/Moves/Sky_Attack,/obj/Moves/Supersonic)
		Weight = 5.1
		POKEIMAGE = '276.png'
		Number = 276
		Abilities = list("Guts","Scrappy")
	Swellow
		CaptureRate = 45
		Gender = 50
		icon = '277Swellow.dmi'
		Type1 = "Normal"
		Type2 = "Flying"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 60, "ATK" = 85, "DEF" = 60, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 125, "EXP" = 162)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Growl = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Quick_Attack = 1,/obj/Moves/Wing_Attack = 13,/obj/Moves/Double_Team = 19,/obj/Moves/Endeavor = 28,/obj/Moves/Aerial_Ace = 38,/obj/Moves/Agility = 49)
		EggGroups = list("Flying")
		EggMoves = list(/obj/Moves/Mirror_Move,/obj/Moves/Pursuit,/obj/Moves/Rage,/obj/Moves/Refresh,/obj/Moves/Sky_Attack,/obj/Moves/Supersonic)
		Weight = 43.7
		POKEIMAGE = '277.png'
		Number = 277
		Unevolve = /mob/Pokemon/Taillow
		Abilities = list("Guts","Scrappy")
	Wingull
		CaptureRate = 120
		Gender = 50
		icon = '278Wingull.dmi'
		Type1 = "Water"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 25" = /mob/Pokemon/Pelipper)
		BaseStats = list("HP" = 40, "ATK" = 30, "DEF" = 30, "SPL ATK" = 55, "SPL DEF" = 30, "SPD" = 85, "EXP" = 64)
		LearnMoves = list(/obj/Moves/Water_Gun = 1,/obj/Moves/Growl = 1,/obj/Moves/Supersonic = 7,/obj/Moves/Wing_Attack = 13,/obj/Moves/Mist = 21,/obj/Moves/Quick_Attack = 31,/obj/Moves/Pursuit = 43,/obj/Moves/Agility = 55)
		EggGroups = list("Water 1","Flying")
		EggMoves = list(/obj/Moves/Agility,/obj/Moves/Gust,/obj/Moves/Twister,/obj/Moves/Water_Sport)
		Weight = 20.9
		Number = 278
		POKEIMAGE = '278.png'
		Abilities = list("Keen Eye","Rain Dish")
	Pelipper
		CaptureRate = 45
		Gender = 50
		icon = '279Pelipper.dmi'
		Type1 = "Water"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 50, "DEF" = 100, "SPL ATK" = 85, "SPL DEF" = 70, "SPD" = 65, "EXP" = 164)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Water_Sport = 1,/obj/Moves/Wing_Attack = 1,/obj/Moves/Supersonic = 7,/obj/Moves/Mist = 21,/obj/Moves/Protect = 25,/obj/Moves/Stockpile = 33,/obj/Moves/Swallow = 33,/obj/Moves/Spit_Up = 47,/obj/Moves/Hydro_Pump = 61)
		EggGroups = list("Water 1","Flying")
		EggMoves = list(/obj/Moves/Agility,/obj/Moves/Gust,/obj/Moves/Twister,/obj/Moves/Water_Sport)
		Weight = 61.7
		POKEIMAGE = '279.png'
		Number = 279
		Unevolve = /mob/Pokemon/Wingull
		Abilities = list("Keen Eye","Rain Dish")
	Ralts
		CaptureRate = 235
		Gender = 50
		icon = '280Ralts.dmi'
		Type1 = "Psychic"
		GrowthRate = "Slow"
		Evolve = list("Level 20" = /mob/Pokemon/Kirlia)
		BaseStats = list("HP" = 28, "ATK" = 25, "DEF" = 25, "SPL ATK" = 45, "SPL DEF" = 35, "SPD" = 40, "EXP" = 70)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Confusion = 6,/obj/Moves/Double_Team = 11,/obj/HMs/Teleport = 16,/obj/Moves/Calm_Mind = 21,/obj/Moves/Psychic = 26,/obj/Moves/Imprison = 31,/obj/Moves/Future_Sight = 36,/obj/Moves/Hypnosis = 41,/obj/Moves/Dream_Eater = 46)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Destiny_Bond,/obj/Moves/Disable,/obj/Moves/Mean_Look,/obj/Moves/Memento,/obj/Moves/Will_O_Wisp)
		Weight = 14.6
		POKEIMAGE = '280.png'
		Number = 280
		Abilities = list("Synchronize","Trace","Telepathy")
	Kirlia
		CaptureRate = 120
		Gender = 50
		icon = '281Kirlia.dmi'
		Type1 = "Psychic"
		GrowthRate = "Slow"
		Evolve = list("Level 30" = /mob/Pokemon/Gardevoir)
		BaseStats = list("HP" = 38, "ATK" = 35, "DEF" = 35, "SPL ATK" = 65, "SPL DEF" = 55, "SPD" = 50, "EXP" = 140)
		LearnMoves = list(/obj/Moves/Magical_Leaf,/obj/Moves/Growl = 1,/obj/Moves/Confusion = 1,/obj/Moves/Double_Team = 1,/obj/HMs/Teleport = 1,/obj/Moves/Calm_Mind = 21,/obj/Moves/Psychic = 26,/obj/Moves/Imprison = 33,/obj/Moves/Future_Sight = 40,/obj/Moves/Hypnosis = 47,/obj/Moves/Dream_Eater = 54)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Destiny_Bond,/obj/Moves/Disable,/obj/Moves/Mean_Look,/obj/Moves/Memento,/obj/Moves/Will_O_Wisp)
		Weight = 44.5
		POKEIMAGE = '281.png'
		Number = 281
		Unevolve = /mob/Pokemon/Ralts
		Abilities = list("Synchronize","Trace","Telepathy")
	Gardevoir
		CaptureRate = 45
		Gender = 50
		icon = '282Gardevoir.dmi'
		Type1 = "Psychic"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 68, "ATK" = 65, "DEF" = 65, "SPL ATK" = 125, "SPL DEF" = 115, "SPD" = 80, "EXP" = 208)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Confusion = 1,/obj/Moves/Double_Team = 1,/obj/HMs/Teleport = 1,/obj/Moves/Calm_Mind = 21,/obj/Moves/Psychic = 26,/obj/Moves/Imprison = 33,/obj/Moves/Future_Sight = 42,/obj/Moves/Hypnosis = 51,/obj/Moves/Dream_Eater = 60)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Destiny_Bond,/obj/Moves/Disable,/obj/Moves/Mean_Look,/obj/Moves/Memento,/obj/Moves/Will_O_Wisp)
		Weight = 106.7
		POKEIMAGE = '282.png'
		Number = 282
		Unevolve = /mob/Pokemon/Kirlia
		Abilities = list("Synchronize","Trace","Telepathy")
	Surskit
		CaptureRate = 200
		Gender = 50
		icon = '283Surskit.dmi'
		Type1 = "Bug"
		Type2 = "Water"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 22" = /mob/Pokemon/Masquerain)
		BaseStats = list("HP" = 40, "ATK" = 30, "DEF" = 32, "SPL ATK" = 50, "SPL DEF" = 52, "SPD" = 65, "EXP" = 63)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Quick_Attack = 7,/obj/Moves/Sweet_Scent = 13,/obj/Moves/Water_Sport = 19,/obj/Moves/Bubblebeam = 25,/obj/Moves/Agility = 31,/obj/Moves/Mist = 37,/obj/Moves/Haze = 37)
		EggGroups = list("Water 1","Bug")
		EggMoves = list(/obj/Moves/Foresight,/obj/Moves/Hydro_Pump,/obj/Moves/Mind_Reader,/obj/Moves/Mud_Shot,/obj/Moves/Psybeam)
		Weight = 3.7
		POKEIMAGE = '283.png'
		Number = 283
		Abilities = list("Swift Swim","Rain Dish")
	Masquerain
		CaptureRate = 75
		Gender = 50
		icon = '284Masquerain.dmi'
		Type1 = "Bug"
		Type2 = "Flying"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 70, "ATK" = 60, "DEF" = 62, "SPL ATK" = 80, "SPL DEF" = 82, "SPD" = 60, "EXP" = 128)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Quick_Attack = 1,/obj/Moves/Sweet_Scent = 1,/obj/Moves/Water_Sport = 1,/obj/Moves/Gust = 26,/obj/Moves/Scary_Face = 33,/obj/Moves/Stun_Spore = 40,/obj/Moves/Silver_Wind = 47,/obj/Moves/Whirlwind = 53)
		EggGroups = list("Water 1","Bug")
		EggMoves = list(/obj/Moves/Foresight,/obj/Moves/Hydro_Pump,/obj/Moves/Mind_Reader,/obj/Moves/Mud_Shot,/obj/Moves/Psybeam)
		Weight = 7.9
		POKEIMAGE = '284.png'
		Number = 284
		Unevolve = /mob/Pokemon/Surskit
		Abilities = list("Intimidate","Unnerve")
	Shroomish
		CaptureRate = 255
		Gender = 50
		icon = '285Shroomish.dmi'
		Type1 = "Grass"
		GrowthRate = "Slow"
		Evolve = list("Level 23" = /mob/Pokemon/Breloom)
		BaseStats = list("HP" = 60, "ATK" = 40, "DEF" = 60, "SPL ATK" = 40, "SPL DEF" = 60, "SPD" = 35, "EXP" = 65)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Tackle = 4,/obj/Moves/Stun_Spore = 7,/obj/Moves/Leech_Seed = 10,/obj/Moves/Mega_Drain = 16,/obj/Moves/Headbutt = 22,/obj/Moves/PoisonPowder = 28,/obj/Moves/Growth = 36,/obj/Moves/Giga_Drain = 45,/obj/Moves/Spore = 54)
		EggGroups = list("Fairy","Grass")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Fake_Tears,/obj/Moves/False_Swipe,/obj/Moves/Helping_Hand,/obj/Moves/Swagger)
		Weight = 9.9
		POKEIMAGE = '285.png'
		Number = 285
		Abilities = list("Effect Spore","Poison Heal","Quick Feet")
	Breloom
		CaptureRate = 90
		Gender = 50
		icon = '286Breloom.dmi'
		Type1 = "Grass"
		Type2 = "Fighting"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 60, "ATK" = 130, "DEF" = 80, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 70, "EXP" = 165)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Tackle = 1,/obj/Moves/Stun_Spore = 1,/obj/Moves/Leech_Seed = 1,/obj/Moves/Mega_Drain = 16,/obj/Moves/Headbutt = 22,/obj/Moves/Mach_Punch = 23,/obj/Moves/Counter = 28,/obj/Moves/Sky_Uppercut = 36,/obj/Moves/Mind_Reader = 45,/obj/Moves/DynamicPunch = 54)
		EggGroups = list("Fairy","Grass")
		EggMoves = list(/obj/Moves/Charm,/obj/Moves/Fake_Tears,/obj/Moves/False_Swipe,/obj/Moves/Helping_Hand,/obj/Moves/Swagger)
		Weight = 86.4
		POKEIMAGE = '286.png'
		Number = 286
		Unevolve = /mob/Pokemon/Shroomish
		Abilities = list("Effect Spore","Poison Heal","Technician")
	Slakoth
		CaptureRate = 255
		Gender = 50
		icon = '287Slakoth.dmi'
		Type1 = "Normal"
		GrowthRate = "Slow"
		Evolve = list("Level 18" = /mob/Pokemon/Vigoroth)
		BaseStats = list("HP" = 60, "ATK" = 60, "DEF" = 60, "SPL ATK" = 35, "SPL DEF" = 35, "SPD" = 30, "EXP" = 83)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Yawn = 1,/obj/Moves/Encore = 7,/obj/Moves/Slack_Off = 13,/obj/Moves/Faint_Attack = 19,/obj/Moves/Amnesia = 25,/obj/Moves/Covet = 31,/obj/Moves/Counter = 37,/obj/Moves/Flail = 43)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Crush_Claw,/obj/Moves/Curse,/obj/Moves/Pursuit,/obj/Moves/Slash,/obj/Moves/Sleep_Talk,/obj/Moves/Snore)
		Weight = 52.9
		POKEIMAGE = '287.png'
		Number = 287
		Abilities = list("Traunt")
	Vigoroth
		CaptureRate = 120
		Gender = 50
		icon = '288Vigoroth.dmi'
		Type1 = "Normal"
		GrowthRate = "Slow"
		Evolve = list("Level 36" = /mob/Pokemon/Slaking)
		BaseStats = list("HP" = 80, "ATK" = 80, "DEF" = 80, "SPL ATK" = 55, "SPL DEF" = 55, "SPD" = 90, "EXP" = 126)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Encore = 1,/obj/Moves/Uproar = 1,/obj/Moves/Fury_Swipes = 19,/obj/Moves/Endure = 25,/obj/Moves/Slash = 31,/obj/Moves/Counter = 37,/obj/Moves/Focus_Punch = 43,/obj/Moves/Reversal = 49)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Crush_Claw,/obj/Moves/Curse,/obj/Moves/Pursuit,/obj/Moves/Slash,/obj/Moves/Sleep_Talk,/obj/Moves/Snore)
		Weight = 102.5
		POKEIMAGE = '288.png'
		Number = 288
		Unevolve = /mob/Pokemon/Slakoth
		Abilities = list("Vital Spirit")
	Slaking
		CaptureRate = 45
		Gender = 50
		icon = '289Slaking.dmi'
		Type1 = "Normal"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 150, "ATK" = 160, "DEF" = 100, "SPL ATK" = 95, "SPL DEF" = 65, "SPD" = 101, "EXP" = 210)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Yawn = 1,/obj/Moves/Encore = 1,/obj/Moves/Slack_Off = 1,/obj/Moves/Faint_Attack = 19,/obj/Moves/Amnesia = 25,/obj/Moves/Covet = 31,/obj/Moves/Swagger = 36,/obj/Moves/Counter = 37,/obj/Moves/Flail = 43)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Crush_Claw,/obj/Moves/Curse,/obj/Moves/Pursuit,/obj/Moves/Slash,/obj/Moves/Sleep_Talk,/obj/Moves/Snore)
		Weight = 287.7
		POKEIMAGE = '289.png'
		Number = 289
		Unevolve = /mob/Pokemon/Vigoroth
		Abilities = list("Traunt")
	Nincada
		CaptureRate = 255
		Gender = 50
		icon = '290Nincada.dmi'
		Type1 = "Bug"
		Type2 = "Ground"
		GrowthRate = "Fast"
		Evolve = list("Level 20" = /mob/Pokemon/Ninjask)
		BaseStats = list("HP" = 31, "ATK" = 45, "DEF" = 90, "SPL ATK" = 30, "SPL DEF" = 30, "SPD" = 40, "EXP" = 65)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Harden = 1,/obj/Moves/Leech_Life = 5,/obj/Moves/Sand_Attack = 9,/obj/Moves/Fury_Swipes = 14,/obj/Moves/Mind_Reader = 19,/obj/Moves/False_Swipe = 25,/obj/Moves/Mud_Slap = 31,/obj/Moves/Metal_Claw = 38,/obj/HMs/Dig = 45)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Endure,/obj/Moves/Faint_Attack,/obj/Moves/Gust,/obj/Moves/Silver_Wind)
		Weight = 12.1
		POKEIMAGE = '290.png'
		Number = 290
		Abilities = list("Compoundeyes","Run Away")
	Ninjask
		CaptureRate = 120
		Gender = 50
		icon = '291Ninjask.dmi'
		Type1 = "Bug"
		Type2 = "Flying"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 61, "ATK" = 90, "DEF" = 45, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 160, "EXP" = 155)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Harden = 1,/obj/Moves/Leech_Life = 1,/obj/Moves/Sand_Attack = 1,/obj/Moves/Fury_Swipes = 14,/obj/Moves/Mind_Reader = 19,/obj/Moves/Double_Team = 20,/obj/Moves/Fury_Cutter = 20,/obj/Moves/Screech = 20,/obj/Moves/Swords_Dance = 25,/obj/Moves/Slash = 31,/obj/Moves/Agility = 38,/obj/Moves/Baton_Pass = 45)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Endure,/obj/Moves/Faint_Attack,/obj/Moves/Gust,/obj/Moves/Silver_Wind)
		Weight = 26.5
		POKEIMAGE = '291.png'
		Number = 291
		Unevolve = /mob/Pokemon/Nincada
		Abilities = list("Speed Boost","Infiltrator")
	Shedinja
		BaseStats = list("HP" = 100, "ATK" = 134, "DEF" = 110, "SPL ATK" = 95, "SPL DEF" = 100, "SPD" = 61, "EXP" = 218)
	Whismur
		CaptureRate = 190
		Gender = 50
		icon = '293Whismur.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 20" = /mob/Pokemon/Loudred)
		BaseStats = list("HP" = 64, "ATK" = 51, "DEF" = 23, "SPL ATK" = 51, "SPL DEF" = 23, "SPD" = 28, "EXP" = 68)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Uproar = 5,/obj/Moves/Astonish = 11,/obj/Moves/Howl = 15,/obj/Moves/Supersonic = 21,/obj/Moves/Stomp = 25,/obj/Moves/Screech = 31,/obj/Moves/Roar = 35,/obj/Moves/Rest = 41,/obj/Moves/Sleep_Talk = 41,/obj/Moves/Hyper_Voice = 45)
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Extrasensory,/obj/Moves/SmellingSalt,/obj/Moves/Snore,/obj/Moves/Swagger,/obj/Moves/Take_Down)
		Weight = 35.9
		Number = 293
		Abilities = list("Soundproof","Rattled")
	Loudred
		CaptureRate = 120
		Gender = 50
		icon = '294Loudred.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 40" = /mob/Pokemon/Exploud)
		BaseStats = list("HP" = 84, "ATK" = 71, "DEF" = 43, "SPL ATK" = 71, "SPL DEF" = 43, "SPD" = 48, "EXP" = 126)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Uproar = 1,/obj/Moves/Astonish = 1,/obj/Moves/Howl = 1,/obj/Moves/Supersonic = 23,/obj/Moves/Stomp = 29,/obj/Moves/Screech = 37,/obj/Moves/Roar = 43,/obj/Moves/Rest = 51,/obj/Moves/Sleep_Talk = 51,/obj/Moves/Hyper_Voice = 57)
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Extrasensory,/obj/Moves/SmellingSalt,/obj/Moves/Snore,/obj/Moves/Swagger,/obj/Moves/Take_Down)
		Weight = 89.3
		Number = 294
		Unevolve = /mob/Pokemon/Whismur
		Abilities = list("Soundproof","Scrappy")
	Exploud
		CaptureRate = 45
		Gender = 50
		icon = '295Exploud.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 104, "ATK" = 91, "DEF" = 63, "SPL ATK" = 91, "SPL DEF" = 63, "SPD" = 68, "EXP" = 184)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Uproar = 1,/obj/Moves/Astonish = 1,/obj/Moves/Howl = 1,/obj/Moves/Supersonic = 23,/obj/Moves/Stomp = 29,/obj/Moves/Screech = 37,/obj/Moves/Hyper_Beam = 40,/obj/Moves/Roar = 45,/obj/Moves/Rest = 55,/obj/Moves/Sleep_Talk = 55,/obj/Moves/Hyper_Voice = 63)
		EggGroups = list("Monster","Field")
		EggMoves = list(/obj/Moves/Extrasensory,/obj/Moves/SmellingSalt,/obj/Moves/Snore,/obj/Moves/Swagger,/obj/Moves/Take_Down)
		Weight = 185.2
		Number = 295
		Unevolve = /mob/Pokemon/Loudred
		Abilities = list("Soundproof","Scrappy")
	Makuhita
		CaptureRate = 180
		Gender = 75
		icon = '296Makuhita.dmi'
		Type1 = "Fighting"
		GrowthRate = "Slow"
		Evolve = list("Level 24" = /mob/Pokemon/Hariyama)
		BaseStats = list("HP" = 72, "ATK" = 60, "DEF" = 30, "SPL ATK" = 20, "SPL DEF" = 30, "SPD" = 25, "EXP" = 87)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Sand_Attack = 4,/obj/Moves/Arm_Thrust = 10,/obj/Moves/Vital_Throw = 13,/obj/Moves/Fake_Out = 19,/obj/Moves/Whirlwind = 22,/obj/Moves/Knock_Off = 28,/obj/Moves/SmellingSalt = 31,/obj/Moves/Belly_Drum = 37,/obj/Moves/Endure = 40,/obj/Moves/Seismic_Toss = 46,/obj/Moves/Reversal = 49)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Cross_Chop,/obj/Moves/Detect,/obj/Moves/DynamicPunch,/obj/Moves/Faint_Attack,/obj/Moves/Foresight,/obj/Moves/Helping_Hand,/obj/Moves/Revenge)
		Weight = 190.5
		POKEIMAGE = '296.png'
		Number = 296
		Abilities = list("Thick Fat","Guts","Sheer Force")
	Hariyama
		CaptureRate = 200
		Gender = 75
		icon = '297Hariyama.dmi'
		Type1 = "Fighting"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 144, "ATK" = 120, "DEF" = 60, "SPL ATK" = 40, "SPL DEF" = 60, "SPD" = 50, "EXP" = 184)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Sand_Attack = 1,/obj/Moves/Arm_Thrust = 1,/obj/Moves/Vital_Throw = 13,/obj/Moves/Fake_Out = 19,/obj/Moves/Whirlwind = 22,/obj/Moves/Knock_Off = 29,/obj/Moves/SmellingSalt = 33,/obj/Moves/Belly_Drum = 40,/obj/Moves/Endure = 44,/obj/Moves/Seismic_Toss = 51,/obj/Moves/Reversal = 55)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Cross_Chop,/obj/Moves/Detect,/obj/Moves/DynamicPunch,/obj/Moves/Faint_Attack,/obj/Moves/Foresight,/obj/Moves/Helping_Hand,/obj/Moves/Revenge)
		Weight = 559.5
		POKEIMAGE = '297.png'
		Number = 297
		Unevolve = /mob/Pokemon/Makuhita
		Abilities = list("Thick Fat","Guts","Sheer Force")
	Azurill
		CaptureRate = 150
		Gender = 75
		icon = '298Azurill.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Charm = 3,/obj/Moves/Tail_Whip = 6,/obj/Moves/Bubble = 10,/obj/Moves/Slam = 15,/obj/Moves/Water_Gun = 21)
		EggGroups =  list("Undiscovered")
		BaseStats = list("HP" = 100, "ATK" = 134, "DEF" = 110, "SPL ATK" = 95, "SPL DEF" = 100, "SPD" = 61, "EXP" = 218)
		EggMoves = list(/obj/Moves/Encore,/obj/Moves/Refresh,/obj/Moves/Sing,/obj/Moves/Slam,/obj/Moves/Tickle)
		Weight = 4.4
		//POKEIMAGE = '298.png'
		Number = 298
		Abilities = list("Thick Fat", "Huge Power", "Sap Sipper")
	Nosepass
		CaptureRate = 255
		Gender = 50
		icon = '299Nosepass.dmi'
		Type1 = "Rock"
		GrowthRate = "Medium-Fast"
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 7,/obj/Moves/Rock_Throw = 13,/obj/Moves/Block = 16,/obj/Moves/Thunder_Wave = 22,/obj/Moves/Rock_Slide = 28,/obj/Moves/Sandstorm = 31,/obj/Moves/Rest = 37,/obj/Moves/Zap_Cannon = 43,/obj/Moves/Lock_On = 46)
		BaseStats = list("HP" = 30, "ATK" = 45, "DEF" = 135, "SPL ATK" = 45, "SPL DEF" = 90, "SPD" = 30, "EXP" = 108)
		EggGroups = list("Mineral")
		EggMoves = list(/obj/Moves/Explosion,/obj/Moves/Magnitude,/obj/Moves/Rollout)
		Weight = 213.8
		//POKEIMAGE = '299.png'
		Number = 299
		Abilities = list("Sturdy", "Magnet Pull", "Sand Force")
	Skitty
		CaptureRate = 255
		Gender = 75
		icon = '300Skitty.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Tackle = 1,/obj/Moves/Tail_Whip = 3,/obj/Moves/Attract = 7,/obj/Moves/Sing = 13,/obj/Moves/DoubleSlap = 15,/obj/Moves/Assist = 19,/obj/Moves/Charm = 25,/obj/Moves/Faint_Attack = 27,/obj/Moves/Covet = 31,/obj/Moves/Heal_Bell = 37,/obj/Moves/Double_Edge = 39)
		BaseStats = list("HP" = 50, "ATK" = 45, "DEF" = 45, "SPL ATK" = 35, "SPL DEF" = 35, "SPD" = 50, "EXP" = 65)
		EggGroups = list("Field", "Fairy")
		EggMoves = list(/obj/Moves/Fake_Tears,/obj/Moves/Helping_Hand,/obj/Moves/Psych_Up,/obj/Moves/Substitute,/obj/Moves/Tickle,/obj/Moves/Uproar,/obj/Moves/Wish)
		Weight = 24.3
		POKEIMAGE = '300.png'
		Number = 300
		Abilities = list("Cute Charm", "Normalize", "Wonder Skin")
	Delcatty
		CaptureRate = 60
		Gender = 75
		icon = '301Delcatty.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Attract = 1,/obj/Moves/Sing = 1,/obj/Moves/DoubleSlap = 1)
		BaseStats = list("HP" = 70, "ATK" = 65, "DEF" = 65, "SPL ATK" = 55, "SPL DEF" = 55, "SPD" = 70, "EXP" = 138)
		EggGroups = list("Field", "Fairy")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Fake_Tears,/obj/Moves/Helping_Hand,/obj/Moves/Psych_Up,/obj/Moves/Substitute,/obj/Moves/Tickle,/obj/Moves/Uproar,/obj/Moves/Wish)
		Weight = 71.9
		POKEIMAGE = '301.png'
		Number = 301
		Abilities = list("Cute Charm", "Normalize", "Wonder Skin")
	Sableye
		CaptureRate = 45
		Gender = 50
		icon = '302Sableye.dmi'
		Type1 = "Dark"
		Type2 = "Ghost"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 50, "ATK" = 75, "DEF" = 75, "SPL ATK" = 65, "SPL DEF" = 65, "SPD" = 50, "EXP" = 98)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Leer = 1,/obj/Moves/Foresight = 5,/obj/Moves/Night_Shade = 9,/obj/Moves/Astonish = 13,/obj/Moves/Fury_Swipes = 17,/obj/Moves/Fake_Out = 21,/obj/Moves/Detect = 25,/obj/Moves/Faint_Attack = 29,/obj/Moves/Knock_Off = 33,/obj/Moves/Confuse_Ray = 37,/obj/Moves/Shadow_Ball = 41,/obj/Moves/Mean_Look = 45)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Moonlight,/obj/Moves/Psych_Up,/obj/Moves/Recover)
		Weight = 24.3
		POKEIMAGE = '302.png'
		Number = 302
		Abilities = list("Keen Eye","Stall")
	Mawile
		CaptureRate = 45
		Gender = 50
		icon= '303Mawile.dmi'
		Type1 = "Steel"
		GrowthRate = "Fast"
		LearnMoves = list(/obj/Moves/Astonish = 1,/obj/Moves/Fake_Tears = 6,/obj/Moves/Bite = 11,/obj/Moves/Sweet_Scent = 16,/obj/Moves/ViceGrip = 21,/obj/Moves/Faint_Attack = 26,/obj/Moves/Baton_Pass = 31,/obj/Moves/Crunch = 36,/obj/Moves/Iron_Defence = 41,/obj/Moves/Stockpile = 46,/obj/Moves/Swallow = 46,/obj/Moves/Spit_Up = 46)
		BaseStats = list("HP" = 50, "ATK" = 85, "DEF" = 85, "SPL ATK" = 55, "SPL DEF" = 55, "SPD" = 50, "EXP" = 98)
		EggGroups = list("Field", "Fairy")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/False_Swipe,/obj/Moves/Poison_Fang,/obj/Moves/Psych_Up,/obj/Moves/Swords_Dance,/obj/Moves/Tickle)
		Weight = 25.4
		POKEIMAGE = '303.png'
		Number = 303
		Abilities = list("Hyper Cutter", "Intimidate", "Sheer Force")
	Aron
		CaptureRate = 180
		Gender = 50
		icon = '304Aron.dmi'
		Type1 = "Steel"
		Type2 = "Rock"
		GrowthRate = "Slow"
		Evolve = list("Level 32" = /mob/Pokemon/Lairon)
		BaseStats = list("HP" = 50, "ATK" = 70, "DEF" = 100, "SPL ATK" = 40, "SPL DEF" = 40, "SPD" = 30, "EXP" = 96)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 4,/obj/Moves/Mud_Slap = 7,/obj/Moves/Headbutt = 10,/obj/Moves/Metal_Claw = 13,/obj/Moves/Iron_Defence = 17,/obj/Moves/Roar = 21,/obj/Moves/Take_Down = 25,/obj/Moves/Iron_Tail = 29,/obj/Moves/Protect = 34,/obj/Moves/Metal_Sound = 39,/obj/Moves/Double_Edge = 44)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Endeavor,/obj/Moves/SmellingSalt,/obj/Moves/Stomp)
		Weight = 132.3
		POKEIMAGE = '304.png'
		Number = 304
		Abilities = list("Rock Head","Heavy Metal")
	Lairon
		CaptureRate = 90
		Gender = 50
		icon = '305Lairon.dmi'
		Type1 = "Steel"
		Type2 = "Rock"
		GrowthRate = "Slow"
		Evolve = list("Level 42" = /mob/Pokemon/Aggron)
		BaseStats = list("HP" = 60, "ATK" = 90, "DEF" = 140, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 40, "EXP" = 152)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 1,/obj/Moves/Mud_Slap = 1,/obj/Moves/Headbutt = 1,/obj/Moves/Metal_Claw = 13,/obj/Moves/Iron_Defence = 17,/obj/Moves/Roar = 21,/obj/Moves/Take_Down = 25,/obj/Moves/Iron_Tail = 29,/obj/Moves/Protect = 37,/obj/Moves/Metal_Sound = 46,/obj/Moves/Double_Edge = 53)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Endeavor,/obj/Moves/SmellingSalt,/obj/Moves/Stomp)
		Weight = 264.6
		POKEIMAGE = '305.png'
		Number = 305
		Unevolve = /mob/Pokemon/Aron
		Abilities = list("Rock Head","Heavy Metal")
	Aggron
		CaptureRate = 45
		Gender = 50
		icon = '306Aggron.dmi'
		Type1 = "Steel"
		Type2 = "Rock"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 70, "ATK" = 110, "DEF" = 180, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 50, "EXP" = 205)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 1,/obj/Moves/Mud_Slap = 1,/obj/Moves/Headbutt = 1,/obj/Moves/Metal_Claw = 13,/obj/Moves/Iron_Defence = 17,/obj/Moves/Roar = 21,/obj/Moves/Take_Down = 25,/obj/Moves/Iron_Tail = 29,/obj/Moves/Protect = 37,/obj/Moves/Metal_Sound = 50,/obj/Moves/Double_Edge = 63)
		EggGroups = list("Monster")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Endeavor,/obj/Moves/SmellingSalt,/obj/Moves/Stomp)
		Weight = 793.7
		POKEIMAGE = '306.png'
		Number = 306
		Unevolve = /mob/Pokemon/Lairon
		Abilities = list("Rock Head","Heavy Metal")
	Meditite
		CaptureRate = 180
		Gender = 50
		icon = '307Meditite.dmi'
		Type1 = "Fighting"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 37" = /mob/Pokemon/Medicham)
		BaseStats = list("HP" = 30, "ATK" = 40, "DEF" = 55, "SPL ATK" = 40, "SPL DEF" = 55, "SPD" = 60, "EXP" = 91)
		LearnMoves = list(/obj/Moves/Bide = 1,/obj/Moves/Meditate = 4,/obj/Moves/Confusion = 9,/obj/Moves/Detect = 12,/obj/Moves/Hidden_Power = 18,/obj/Moves/Swagger = 20,/obj/Moves/Mind_Reader = 22,/obj/Moves/Calm_Mind = 28,/obj/Moves/Hi_Jump_Kick = 32,/obj/Moves/Psych_Up = 38,/obj/Moves/Reversal = 42,/obj/Moves/Recover = 48)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/DynamicPunch,/obj/Moves/Fake_Out,/obj/Moves/Fire_Punch,/obj/Moves/Foresight,/obj/Moves/Ice_Punch,/obj/Moves/Thunder_Punch)
		Weight = 24.7
	//	POKEIMAGE = '307.png'
		Number = 307
		Abilities = list("Pure Power","Telepathy")
	Medicham
		CaptureRate = 90
		Gender = 50
		icon = '308Medicham.dmi'
		Type1 = "Fighting"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 60, "DEF" = 75, "SPL ATK" = 60, "SPL DEF" = 75, "SPD" = 80, "EXP" = 153)
		LearnMoves = list(/obj/Moves/Fire_Punch = 1,/obj/Moves/Thunder_Punch = 1,/obj/Moves/Ice_Punch = 1,/obj/Moves/Bide = 1,/obj/Moves/Meditate = 1,/obj/Moves/Confusion = 1,/obj/Moves/Detect = 1,/obj/Moves/Hidden_Power = 18,/obj/Moves/Swagger = 20,/obj/Moves/Mind_Reader = 22,/obj/Moves/Calm_Mind = 28,/obj/Moves/Hi_Jump_Kick = 32,/obj/Moves/Psych_Up = 40,/obj/Moves/Reversal = 46,/obj/Moves/Recover = 54)
		EggGroups = list("Human-Like")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/DynamicPunch,/obj/Moves/Fake_Out,/obj/Moves/Fire_Punch,/obj/Moves/Foresight,/obj/Moves/Ice_Punch,/obj/Moves/Thunder_Punch)
		Weight = 69.4
	//	POKEIMAGE = '308.png'
		Number = 308
		Unevolve = /mob/Pokemon/Meditite
		Abilities = list("Pure Power","Telepathy")
	Electrike
		CaptureRate = 120
		Gender = 50
		icon = '309Electrike.dmi'
		Type1 = "Electric"
		GrowthRate = "Slow"
		Evolve = list("Level 26" = /mob/Pokemon/Manectric)
		BaseStats = list("HP" = 40, "ATK" = 45, "DEF" = 40, "SPL ATK" = 65, "SPL DEF" = 40, "SPD" = 65, "EXP" = 104)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Thunder_Wave = 4,/obj/Moves/Leer = 9,/obj/Moves/Quick_Attack = 17,/obj/Moves/Spark = 20,/obj/Moves/Bite = 33, /obj/Moves/Roar = 28,/obj/Moves/Thunder = 36)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Crunch,/obj/Moves/Headbutt,/obj/Moves/Swift)
		Weight = 35.5
		Number = 309
		POKEIMAGE = '309.png'
		Abilities = list("Static","Lightningrod","Minus")
	Manectric
		CaptureRate = 45
		Gender = 50
		icon = '310Manectric.dmi'
		Type1 = "Electric"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 70, "ATK" = 75, "DEF" = 60, "SPL ATK" = 105, "SPL DEF" = 60, "SPD" = 105, "EXP" = 168)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Thunder_Wave = 1,/obj/Moves/Leer = 1,/obj/Moves/Quick_Attack = 17,/obj/Moves/Spark = 20,/obj/Moves/Roar = 31,/obj/Moves/Bite = 39,/obj/Moves/Thunder = 45)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Crunch,/obj/Moves/Headbutt,/obj/Moves/Swift)
		Weight = 88.6
		Number = 310
		Unevolve = /mob/Pokemon/Electrike
		POKEIMAGE = '310.png'
		Abilities = list("Static","Lightningrod","Minus")
	Plusle
		CaptureRate = 200
		Gender = 50
		icon = '311Plusle.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 50, "DEF" = 40, "SPL ATK" = 85, "SPL DEF" = 75, "SPD" = 95, "EXP" = 120)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Thunder_Wave = 4,/obj/Moves/Quick_Attack = 10,/obj/Moves/Helping_Hand = 13,/obj/Moves/Spark = 19,/obj/Moves/Encore = 22,/obj/Moves/Fake_Tears = 28,/obj/Moves/Charge = 31,/obj/Moves/Thunder = 37,/obj/Moves/Baton_Pass = 40,/obj/Moves/Agility = 47)
		EggGroups = list("Fairy")
		EggMoves = list(/obj/Moves/Wish,/obj/Moves/Substitute)
		Weight = 9.3
		//POKEIMAGE = '311.png'
		Number = 311
		Abilities = list("Plus")
	Minun
		CaptureRate = 200
		Gender = 50
		icon = '312Minun.dmi'
		Type1 = "Electric"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 40, "DEF" = 50, "SPL ATK" = 75, "SPL DEF" = 85, "SPD" = 95, "EXP" = 120)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Thunder_Wave = 4,/obj/Moves/Quick_Attack = 10,/obj/Moves/Helping_Hand = 13,/obj/Moves/Spark = 19,/obj/Moves/Encore = 22,/obj/Moves/Charm = 28,/obj/Moves/Charge = 31,/obj/Moves/Thunder = 37,/obj/Moves/Baton_Pass = 40,/obj/Moves/Agility = 47)
		EggGroups = list("Fairy")
		EggMoves = list(/obj/Moves/Wish,/obj/Moves/Substitute)
		Weight = 9.3
		//POKEIMAGE = '312.png'
		Number = 312
		Abilities = list("Minus")
	Volbeat
		CaptureRate = 150
		Gender = 100
		icon = '313Volbeat.dmi'
		Type1 = "Bug"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 65, "ATK" = 73, "DEF" = 55, "SPL ATK" = 47, "SPL DEF" = 75, "SPD" = 85, "EXP" = 146)
		EggGroups = list("Bug","Human-Like")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Growth,/obj/Moves/Silver_Wind)
		Weight = 39.0
		//POKEIMAGE = '313'.png'
		Number = 313
		Abilities = list("Illuminate","Swarm")
	Illumise
		CaptureRate = 150
		Gender = 0
		icon = '314Illumise.dmi'
		Type1 = "Bug"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 65, "ATK" = 47, "DEF" = 55, "SPL ATK" = 73, "SPL DEF" = 75, "SPD" = 85, "EXP" = 146)
		EggGroups = list("Bug","Human-Like")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Growth,/obj/Moves/Silver_Wind)
		Weight = 39.0
		//POKEIMAGE = '314'.png'
		Number = 314
		Abilities = list("Oblivious","Tinted Lens")
	Roselia
		CaptureRate = 150
		Gender = 50
		icon = '315Roselia.dmi'
		Type1 = "Grass"
		Type2 = "Poison"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 50, "ATK" = 60, "DEF" = 45, "SPL ATK" = 100, "SPL DEF" = 80, "SPD" = 65, "EXP" = 152)
		LearnMoves = list(/obj/Moves/Absorb = 1,/obj/Moves/Growth = 5,/obj/Moves/Poison_Sting = 9,/obj/Moves/Stun_Spore = 13,/obj/Moves/Mega_Drain = 17,/obj/Moves/Leech_Seed = 21,/obj/Moves/Magical_Leaf = 25,/obj/Moves/GrassWhistle = 29,/obj/Moves/Giga_Drain = 33,/obj/Moves/Sweet_Scent = 37,/obj/Moves/Ingrain = 41,/obj/Moves/Toxic = 45,/obj/Moves/Petal_Dance = 49,/obj/Moves/Aromatherapy = 53,/obj/Moves/Synthesis = 57)
		EggGroups = list("Fairy","Grass")
		EggMoves = list(/obj/Moves/Cotton_Spore,/obj/Moves/Pin_Missle,/obj/Moves/Spikes,/obj/Moves/Synthesis)
		Weight = 4.4
		//POKEIMAGE = '315'.png
		Number = 315
		Abilities = list("Natural Cure","Poison Point")
	Gulpin
		CaptureRate = 255
		Gender = 50
		icon = '316Gulpin.dmi'
		Type1 = "Poison"
		GrowthRate = "Medium-Slow"
		Evolve = list("level 26" = /mob/Pokemon/Swalot)
		BaseStats = list("HP" = 70, "ATK" = 43, "DEF" = 53, "SPL ATK" = 43, "SPL DEF" = 43, "SPD" = 40, "EXP" = 75)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Yawn = 6,/obj/Moves/Poison_Gas = 9,/obj/Moves/Sludge = 14,/obj/Moves/Amnesia = 17,/obj/Moves/Encore = 23,/obj/Moves/Toxic = 28,/obj/Moves/Stockpile = 34,/obj/Moves/Spit_Up = 34,/obj/Moves/Swallow = 34,/obj/Moves/Sludge_Bomb = 39)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Acid_Armor,/obj/Moves/Dream_Eater,/obj/Moves/Pain_Split,/obj/Moves/Smog)
		Weight = 22.7
		//POKEIMAGE = '316'.png
		Number = 316
		Abilities = list("Liquid Ooze","Sticky Hold","Gluttony")
	Swalot
		CaptureRate = 75
		Gender = 50
		icon = '317Swalot.dmi'
		Type1 = "Poison"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 100, "ATK" = 73, "DEF" = 83, "SPL ATK" = 73, "SPL DEF" = 83, "SPD" = 55, "EXP" = 168)
		LearnMoves = list(/obj/Moves/Pound = 1,/obj/Moves/Poison_Gas = 1,/obj/Moves/Sludge = 1,/obj/Moves/Amnesia = 17,/obj/Moves/Encore = 23,/obj/Moves/Body_Slam = 26,/obj/Moves/Toxic = 28,/obj/Moves/Stockpile = 40,/obj/Moves/Spit_Up = 40,/obj/Moves/Swallow = 40,/obj/Moves/Sludge_Bomb = 48)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Acid_Armor,/obj/Moves/Dream_Eater,/obj/Moves/Pain_Split,/obj/Moves/Smog)
		Weight = 176.4
		//POKEIMAGE = '317'.png
		Number = 317
		Unevolve = /mob/Pokemon/Gulpin
		Abilities = list("Liquid Ooze","Sticky Hold","Gluttony")
	Carvanha
		Carvanha
		CaptureRate = 225
		Gender = 50
		icon = '318Carvanha.dmi'
		Type1 = "Water"
		Type2 = "Dark"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 30" = /mob/Pokemon/Sharpedo)
		BaseStats = list("HP" = 45, "ATK" = 90, "DEF" = 20, "SPL ATK" = 65, "SPL DEF" = 20, "SPD" = 65, "EXP" = 88)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Leer = 1,/obj/Moves/Rage = 7,/obj/Moves/Focus_Energy = 13,/obj/Moves/Scary_Face = 16,/obj/Moves/Crunch = 22,/obj/Moves/Screech = 28,/obj/Moves/Take_Down = 31,/obj/Moves/Swagger = 37,/obj/Moves/Agility = 43)
		EggGroups = list("Water 2")
		EggMoves = list(/obj/Moves/Double_Edge,/obj/Moves/Hydro_Pump,/obj/Moves/Thrash)
		Weight = 45.9
		//POKEIMAGE = '318'.png
		Number = 318
		Abilities = list("Rough Skin","Speed Boost")
	Sharpedo
		CaptureRate = 60
		Gender = 50
		icon = '319Sharpedo.dmi'
		Type1 = "Water"
		Type2 = "Dark"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 70, "ATK" = 120, "DEF" = 40, "SPL ATK" = 95, "SPL DEF" = 40, "SPD" = 95, "EXP" = 175)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Leer = 1,/obj/Moves/Rage = 1,/obj/Moves/Focus_Energy = 1,/obj/Moves/Scary_Face = 16,/obj/Moves/Crunch = 22,/obj/Moves/Screech = 28,/obj/Moves/Slash = 33,/obj/Moves/Taunt = 38,/obj/Moves/Skull_Bash = 48,/obj/Moves/Agility = 53)
		EggGroups = list("Water 2")
		EggMoves = list(/obj/Moves/Double_Edge,/obj/Moves/Hydro_Pump,/obj/Moves/Thrash)
		Weight = 195.8
		//POKEIMAGE = '319'.png
		Unevolve = /mob/Pokemon/Carvanha
		Number = 319
		Abilities = list("Rough Skin","Speed Boost")
	Wailmer
		CaptureRate = 125
		Gender = 50
		icon = '320Wailmer.dmi'
		Type1 = "Water"
		GrowthRate = "Slow"
		Evolve = list("Level 40" = /mob/Pokemon/Wailord)
		BaseStats = list("HP" = 130, "ATK" = 70, "DEF" = 35, "SPL ATK" = 70, "SPL DEF" = 35, "SPD" = 60, "EXP" = 137)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Growl = 5,/obj/Moves/Water_Gun = 10,/obj/Moves/Rollout = 14,/obj/HMs/Whirlpool = 19,/obj/Moves/Astonish = 23,/obj/Moves/Water_Pulse = 28,/obj/Moves/Mist = 32,/obj/Moves/Rest = 37,/obj/Moves/Water_Spout = 41,/obj/Moves/Amnesia = 46,/obj/Moves/Hydro_Pump = 50)
		EggGroups = list("Field","Water 2")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Thrash,/obj/Moves/Double_Edge,/obj/Moves/Fissure,/obj/Moves/Sleep_Talk,/obj/Moves/Snore,/obj/Moves/Swagger,/obj/Moves/Tickle)
		Weight = 286.6
		POKEIMAGE = '320.png'
		Number = 320
		Abilities = list("Water Veil","Oblivious","Pressure")
	Wailord
		CaptureRate = 60
		Gender = 50
		icon = '321Wailord.dmi'
		Type1 = "Water"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 170, "ATK" = 90, "DEF" = 45, "SPL ATK" = 90, "SPL DEF" = 45, "SPD" = 70, "EXP" = 206)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Growl = 5,/obj/Moves/Water_Gun = 1,/obj/Moves/Rollout = 1,/obj/HMs/Whirlpool = 19,/obj/Moves/Astonish = 23,/obj/Moves/Water_Pulse = 28,/obj/Moves/Mist = 32,/obj/Moves/Rest = 37,/obj/Moves/Water_Spout = 44,/obj/Moves/Amnesia = 52,/obj/Moves/Hydro_Pump = 59)
		EggGroups = list("Field","Water 2")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Thrash,/obj/Moves/Double_Edge,/obj/Moves/Fissure,/obj/Moves/Sleep_Talk,/obj/Moves/Snore,/obj/Moves/Swagger,/obj/Moves/Tickle)
		Weight = 877.4
		POKEIMAGE = '321.png'
		Number = 321
		Unevolve = /mob/Pokemon/Wailmer
		Abilities = list("Water Veil","Oblivious","Pressure")
	Numel
		CaptureRate = 255
		Gender = 50
		icon = '322Numel.dmi'
		Type1 = "Fire"
		Type2 = "Ground"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 33" = /mob/Pokemon/Camerupt)
		BaseStats = list("HP" = 60, "ATK" = 60, "DEF" = 40, "SPL ATK" = 65, "SPL DEF" = 45, "SPD" = 35, "EXP" = 88)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Tackle = 1,/obj/Moves/Ember = 11,/obj/Moves/Magnitude = 19,/obj/Moves/Focus_Energy = 25,/obj/Moves/Take_Down = 29,/obj/Moves/Flamethrower = 41,/obj/Moves/Earthquake = 35,/obj/Moves/Double_Edge = 49,/obj/Moves/Amnesia = 31)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Defense_Curl,/obj/Moves/Rollout,/obj/Moves/Scary_Face,/obj/Moves/Stomp)
		Weight = 52.9
		Number = 322
		POKEIMAGE = '322.png'
		Abilities = list("Oblivious","Simple","Own Tempo")
	Camerupt
		CaptureRate = 150
		Gender = 50
		icon = '323Camerupt.dmi'
		Type1 = "Fire"
		Type2 = "Ground"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 70, "ATK" = 100, "DEF" = 70, "SPL ATK" = 105, "SPL DEF" = 70, "SPD" = 40, "EXP" = 175)
		LearnMoves = list(/obj/Moves/Growl = 1,/obj/Moves/Tackle = 1,/obj/Moves/Ember = 1,/obj/Moves/Magnitude = 1,/obj/Moves/Focus_Energy = 25,/obj/Moves/Take_Down = 29,/obj/Moves/Amnesia = 31,/obj/Moves/Rock_Slide = 33,/obj/Moves/Earthquake = 37,/obj/Moves/Fissure = 55)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Defense_Curl,/obj/Moves/Rollout,/obj/Moves/Scary_Face,/obj/Moves/Stomp)
		Weight = 485
		Number = 323
		Unevolve = /mob/Pokemon/Numel
		POKEIMAGE = '323.png'
		Abilities = list("Magma Armor","Solid Rock","Anger Point")
	Torkoal
		CaptureRate = 90
		Gender = 50
		icon = '324Torkoal.dmi'
		Type1 = "Fire"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 70, "ATK" = 85, "DEF" = 140, "SPL ATK" = 85, "SPL DEF" = 70, "SPD" = 20, "EXP" = 161)
		LearnMoves = list(/obj/Moves/Ember = 1,/obj/Moves/Smog = 4,/obj/Moves/Curse = 7,/obj/Moves/Smokescreen = 14,/obj/Moves/Fire_Spin = 17,/obj/Moves/Body_Slam = 20,/obj/Moves/Protect = 27,/obj/Moves/Flamethrower = 30,/obj/Moves/Iron_Defence = 33,/obj/Moves/Amnesia = 40,/obj/Moves/Flail = 43,/obj/Moves/Heat_Wave = 46)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Endure,/obj/Moves/Eruption,/obj/Moves/Sleep_Talk,/obj/Moves/Yawn)
		Weight = 177.2
		//POKEIMAGE = '324.png'
		Number = 324
		Abilities = list("White Smoke","Shell Armor")
	Spoink
		CaptureRate = 255
		Gender = 50
		icon = '325Spoink.dmi'
		Type1 = "Psychic"
		GrowthRate = "Fast"
		Evolve = list("Level 32" = /mob/Pokemon/Grumpig)
		BaseStats = list("HP" = 60, "ATK" = 25, "DEF" = 35, "SPL ATK" = 70, "SPL DEF" = 80, "SPD" = 60, "EXP" = 89)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Psywave = 7,/obj/Moves/Odor_Sleuth = 10,/obj/Moves/Psybeam = 16,/obj/Moves/Psych_Up = 19,/obj/Moves/Confuse_Ray = 25,/obj/Moves/Magic_Coat = 28,/obj/Moves/Psychic = 34,/obj/Moves/Rest = 37,/obj/Moves/Snore = 37,/obj/Moves/Bounce = 43)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Extrasensory,/obj/Moves/Future_Sight,/obj/Moves/Substitute,/obj/Moves/Trick)
		Weight = 67.5
		//POKEIMAGE = '325.png'
		Number = 325
		Abilities = list("Thick Fat","Own Tempo","Gluttony")
	Grumpig
		CaptureRate = 60
		Gender = 50
		icon = '326Grumpig.dmi'
		Type1 = "Psychic"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 80, "ATK" = 45, "DEF" = 65, "SPL ATK" = 90, "SPL DEF" = 110, "SPD" = 80, "EXP" = 164)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Psywave = 1,/obj/Moves/Odor_Sleuth = 1,/obj/Moves/Psybeam = 1,/obj/Moves/Psych_Up = 19,/obj/Moves/Confuse_Ray = 25,/obj/Moves/Magic_Coat = 28,/obj/Moves/Psychic = 37,/obj/Moves/Rest = 43,/obj/Moves/Snore = 43,/obj/Moves/Bounce = 55)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Extrasensory,/obj/Moves/Future_Sight,/obj/Moves/Substitute,/obj/Moves/Trick)
		Weight = 157.6
		//POKEIMAGE = '326.png'
		Number = 326
		Unevolve = /mob/Pokemon/Spoink
		Abilities = list("Thick Fat","Own Tempo","Gluttony")
	Spinda
		CaptureRate = 255
		Gender = 50
		icon = '327Spinda.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 60, "ATK" = 60, "DEF" = 60, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 60, "EXP" = 85)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Uproar = 5,/obj/Moves/Faint_Attack = 12,/obj/Moves/Psybeam = 16,/obj/Moves/Hypnosis = 23,/obj/Moves/Dizzy_Punch = 27,/obj/Moves/Teeter_Dance = 34,/obj/Moves/Psych_Up = 38,/obj/Moves/Double_Edge = 45,/obj/Moves/Flail = 49,/obj/Moves/Thrash = 56)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Assist,/obj/Moves/Baton_Pass,/obj/Moves/Disable,/obj/Moves/Encore,/obj/Moves/Rock_Slide,/obj/Moves/SmellingSalt,/obj/Moves/Trick,/obj/Moves/Wish)
		Weight = 11.0
		//POKEIMAGE = '327.png'
		Number = 327
		Abilities = list("Own Tempo","Tangled Feet")
	Trapinch
		CaptureRate = 255
		Gender = 50
		icon = '328Trapinch.dmi'
		Type1 = "Ground"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 35" = /mob/Pokemon/Vibrava)
		BaseStats = list("HP" = 45, "ATK" = 100, "DEF" = 45, "SPL ATK" = 45, "SPL DEF" = 45, "SPD" = 10, "EXP" = 73)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Sand_Attack = 9,/obj/Moves/Faint_Attack = 17,/obj/Moves/Sand_Tomb = 25,/obj/Moves/Crunch = 33,/obj/HMs/Dig = 41,/obj/Moves/Sandstorm = 49,/obj/Moves/Hyper_Beam = 57)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Focus_Energy,/obj/Moves/Gust,/obj/Moves/Quick_Attack)
		Weight = 33.1
		POKEIMAGE = '328.png'
		Number = 328
		Abilities = list("Hyper Cutter","Arena Trap","Sheer Force")
	Vibrava
		CaptureRate = 120
		Gender = 50
		icon = '329Vibrava.dmi'
		Type1 = "Ground"
		Type2 = "Dragon"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 45" = /mob/Pokemon/Flygon)
		BaseStats = list("HP" = 50, "ATK" = 70, "DEF" = 50, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 70, "EXP" = 126)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Sand_Attack = 1,/obj/Moves/Faint_Attack = 1,/obj/Moves/Sand_Tomb = 1,/obj/Moves/Crunch = 33,/obj/Moves/Dragon_Breath = 35,/obj/Moves/Screech = 41,/obj/Moves/Sandstorm = 49,/obj/Moves/Hyper_Beam = 57)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Focus_Energy,/obj/Moves/Gust,/obj/Moves/Quick_Attack)
		Weight = 33.7
		POKEIMAGE = '329.png'
		Number = 329
		Unevolve = /mob/Pokemon/Trapinch
		Abilities = list("Levitate")
	Flygon
		CaptureRate = 45
		Gender = 50
		icon = '330Flygon.dmi'
		Type1 = "Ground"
		Type2 = "Dragon"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 80, "ATK" = 100, "DEF" = 80, "SPL ATK" = 80, "SPL DEF" = 80, "SPD" = 101, "EXP" = 197)
		LearnMoves = list(/obj/Moves/Bite = 1,/obj/Moves/Sand_Attack = 1,/obj/Moves/Faint_Attack = 1,/obj/Moves/Sand_Tomb = 1,/obj/Moves/Crunch = 33,/obj/Moves/Dragon_Breath = 35,/obj/Moves/Screech = 41,/obj/Moves/Sandstorm = 53,/obj/Moves/Hyper_Beam = 65)
		EggGroups = list("Bug")
		EggMoves = list(/obj/Moves/Focus_Energy,/obj/Moves/Gust,/obj/Moves/Quick_Attack)
		Weight = 180.8
		POKEIMAGE = '330.png'
		Number = 330
		Unevolve = /mob/Pokemon/Vibrava
		Abilities = list("Levitate")
	Cacnea
		CaptureRate = 190
		Gender = 50
		icon = '331Cacnea.dmi'
		Type1 = "Grass"
		GrowthRate = "Medium-Slow"
		Evolve = list("Level 32" = /mob/Pokemon/Cacturne)
		BaseStats = list("HP" = 50, "ATK" = 85, "DEF" = 40, "SPL ATK" = 85, "SPL DEF" = 40, "SPD" = 35, "EXP" = 97)
		LearnMoves = list(/obj/Moves/Poison_Sting = 1,/obj/Moves/Leer = 1,/obj/Moves/Absorb = 5,/obj/Moves/Growth = 9,/obj/Moves/Leech_Seed = 13,/obj/Moves/Sand_Attack = 17,/obj/Moves/Pin_Missle = 21,/obj/Moves/Ingrain = 25,/obj/Moves/Faint_Attack = 29,/obj/Moves/Spikes = 33,/obj/Moves/Needle_Arm = 37,/obj/Moves/Cotton_Spore = 41,/obj/Moves/Sandstorm = 45,/obj/Moves/Destiny_Bond = 49)
		EggGroups = list("Grass","Human-Like")
		EggMoves = list(/obj/Moves/Acid,/obj/Moves/Counter,/obj/Moves/DynamicPunch,/obj/Moves/GrassWhistle,/obj/Moves/Teeter_Dance)
		Weight = 113.1
		POKEIMAGE = '331.png'
		Number = 331
		Abilities = list("Sand Veil","Water Absorb")
	Cacturne
		CaptureRate = 60
		Gender = 50
		icon = '332Cacturne.dmi'
		Type1 = "Grass"
		Type2 = "Dark"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 70, "ATK" = 115, "DEF" = 60, "SPL ATK" = 115, "SPL DEF" = 60, "SPD" = 55, "EXP" = 177)
		LearnMoves = list(/obj/Moves/Revenge = 1,/obj/Moves/Poison_Sting = 1,/obj/Moves/Leer = 1,/obj/Moves/Absorb = 1,/obj/Moves/Growth = 1,/obj/Moves/Leech_Seed = 13,/obj/Moves/Sand_Attack = 17,/obj/Moves/Pin_Missle = 21,/obj/Moves/Ingrain = 25,/obj/Moves/Faint_Attack = 29,/obj/Moves/Spikes = 35,/obj/Moves/Needle_Arm = 41,/obj/Moves/Cotton_Spore = 47,/obj/Moves/Sandstorm = 53,/obj/Moves/Destiny_Bond = 59)
		EggGroups = list("Grass","Human-Like")
		EggMoves = list(/obj/Moves/Acid,/obj/Moves/Counter,/obj/Moves/DynamicPunch,/obj/Moves/GrassWhistle,/obj/Moves/Teeter_Dance)
		Weight = 170.6
		POKEIMAGE = '332.png'
		Number = 332
		Unevolve = /mob/Pokemon/Cacnea
		Abilities = list("Sand Veil","Water Absorb")
	Swablu
		CaptureRate = 255
		Gender = 50
		icon = '333Swablu.dmi'
		Type1 = "Normal"
		Type2 = "Flying"
		GrowthRate = "Fast"
		Evolve = list("Level 35" = /mob/Pokemon/Altaria)
		BaseStats = list("HP" = 45, "ATK" = 40, "DEF" = 60, "SPL ATK" = 40, "SPL DEF" = 75, "SPD" = 50, "EXP" = 74)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Growl = 1,/obj/Moves/Sing = 11,/obj/Moves/Fury_Attack = 18,/obj/Moves/Safeguard = 21,/obj/Moves/Mist = 28,/obj/Moves/Take_Down = 31,/obj/Moves/Mirror_Move = 38,/obj/Moves/Perish_Song = 48)
		EggGroups = list("Flying","Dragon")
		EggMoves = list(/obj/Moves/Agility,/obj/Moves/Haze,/obj/Moves/Pursuit,/obj/Moves/Rage)
		Weight = 2.6
		Number = 333
		POKEIMAGE = '333.png'
		Abilities = list("Natural Cure","Cloud Nine")
	Altaria
		CaptureRate = 45
		Gender = 50
		icon = '334Altaria.dmi'
		Type1 = "Dragon"
		Type2 = "Flying"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 75, "ATK" = 70, "DEF" = 90, "SPL ATK" = 70, "SPL DEF" = 105, "SPD" = 80, "EXP" = 188)
		LearnMoves = list(/obj/Moves/Peck = 1,/obj/Moves/Growl = 1,/obj/Moves/Sing = 1,/obj/Moves/Astonish = 1,/obj/Moves/Fury_Attack = 18,/obj/Moves/Safeguard = 21,/obj/Moves/Mist = 28,/obj/Moves/Take_Down = 31,/obj/Moves/Dragon_Dance = 40,/obj/Moves/Refresh = 45,/obj/Moves/Perish_Song = 48,/obj/Moves/Sky_Attack = 59,/obj/Moves/Dragon_Breath = 35)
		EggGroups = list("Flying","Dragon")
		EggMoves = list(/obj/Moves/Agility,/obj/Moves/Haze,/obj/Moves/Pursuit,/obj/Moves/Rage)
		Weight = 45.4
		Number = 334
		Unevolve = /mob/Pokemon/Swablu
		POKEIMAGE = '334.png'
		Abilities = list("Natural Cure","Cloud Nine")
	Zangoose
		CaptureRate = 90
		Gender = 50
		icon = '335Zangoose.dmi'
		Type1 = "Normal"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 73, "ATK" = 115, "DEF" = 60, "SPL ATK" = 60, "SPL DEF" = 60, "SPD" = 90, "EXP" = 165)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Leer = 4,/obj/Moves/Quick_Attack = 7,/obj/Moves/Swords_Dance = 10,/obj/Moves/Fury_Cutter = 13,/obj/Moves/Slash = 19,/obj/Moves/Pursuit = 25,/obj/Moves/Crush_Claw = 31,/obj/Moves/Taunt = 37,/obj/Moves/Detect = 46,/obj/Moves/False_Swipe = 55)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Counter,/obj/Moves/Curse,/obj/Moves/Double_Kick,/obj/Moves/Flail,/obj/Moves/Razor_Wind)
		Weight = 88.8
		POKEIMAGE = '335.png'
		Number = 335
		Abilities = list("Immunity","Toxic Boost")
	Seviper
		CaptureRate = 90
		Gender = 50
		icon = '336Seviper.dmi'
		Type1 = "Poison"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 73, "ATK" = 100, "DEF" = 60, "SPL ATK" = 100, "SPL DEF" = 60, "SPD" = 65, "EXP" = 165)
		LearnMoves = list(/obj/Moves/Wrap = 1,/obj/Moves/Lick = 7,/obj/Moves/Bite = 10,/obj/Moves/Poison_Tail = 16,/obj/Moves/Screech = 19,/obj/Moves/Glare = 25,/obj/Moves/Crunch = 28,/obj/Moves/Poison_Fang = 34,/obj/Moves/Swagger = 37,/obj/Moves/Haze = 43)
		EggGroups = list("Field","Dragon")
		EggMoves = list(/obj/Moves/Body_Slam,/obj/Moves/Spit_Up,/obj/Moves/Stockpile,/obj/Moves/Swallow)
		Weight = 115.7
		POKEIMAGE = '336.png'
		Number = 336
		Abilities = list("Shed Skin","Infiltrator")
	Lunatone
		CaptureRate = 45
		Gender = "Genderless"
		icon = '337Lunatone.dmi'
		Type1 = "Rock"
		Type2 = "Psychic"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 70, "ATK" = 55, "DEF" = 65, "SPL ATK" = 95, "SPL DEF" = 85, "SPD" = 70, "EXP" = 150)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 1,/obj/Moves/Confusion = 7,/obj/Moves/Rock_Throw = 13,/obj/Moves/Hypnosis = 19,/obj/Moves/Psywave = 25,/obj/Moves/Cosmic_Power = 31,/obj/Moves/Psychic = 37,/obj/Moves/Future_Sight = 43,/obj/Moves/Explosion = 49)
		EggGroups = list("Mineral")
		Weight = 370.4
		POKEIMAGE = '337.png'
		Number = 337
		Abilities = list("Levitate")
	Solrock
		CaptureRate = 45
		Gender = "Genderless"
		icon = '338Solrock.dmi'
		Type1 = "Rock"
		Type2 = "Psychic"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 70, "ATK" = 95, "DEF" = 85, "SPL ATK" = 55, "SPL DEF" = 65, "SPD" = 75, "EXP" = 150)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Harden = 1,/obj/Moves/Confusion = 7,/obj/Moves/Rock_Throw = 13,/obj/Moves/Fire_Spin = 19,/obj/Moves/Psywave = 25,/obj/Moves/Cosmic_Power = 31,/obj/Moves/Rock_Slide = 37,/obj/Moves/SolarBeam = 43,/obj/Moves/Explosion = 49)
		EggGroups = list("Mineral")
		Weight = 339.5
		POKEIMAGE = '338.png'
		Number = 338
		Abilities = list("Levitate")
	Barboach
		CaptureRate = 190
		Gender = 50
		icon = '339Barboach.dmi'
		Type1 = "Water"
		Type2 = "Ground"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 50, "ATK" = 48, "DEF" = 43, "SPL ATK" = 46, "SPL DEF" = 41, "SPD" = 60, "EXP" = 92)
		LearnMoves = list(/obj/Moves/Mud_Slap = 1,/obj/Moves/Mud_Sport = 6,/obj/Moves/Water_Sport = 6,/obj/Moves/Water_Gun = 11,/obj/Moves/Magnitude = 16,/obj/Moves/Amnesia = 21,/obj/Moves/Rest = 26,/obj/Moves/Snore = 26,/obj/Moves/Earthquake = 31,/obj/Moves/Future_Sight = 36,/obj/Moves/Fissure = 41)
		EggGroups = list("Water2")
		EggMoves = list(/obj/Moves/Spark,/obj/Moves/Thrash,/obj/HMs/Whirlpool)
		Weight = 4.2
		POKEIMAGE = '339.png'
		Number = 339
		Abilities = list ("Oblivious", "Anticipation")
	Whiscash
		CaptureRate = 75
		Gender = 50
		icon = '340Whiscash.dmi'
		Type1 = "Water"
		Type2 = "Ground"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 110, "ATK" = 78, "DEF" = 73, "SPL ATK" = 76, "SPL DEF" = 71, "SPD" = 60, "EXP" = 158)
		LearnMoves = list(/obj/Moves/Mud_Slap = 1,/obj/Moves/Mud_Sport = 6,/obj/Moves/Water_Sport = 6,/obj/Moves/Water_Gun = 11,/obj/Moves/Magnitude = 16,/obj/Moves/Amnesia = 21,/obj/Moves/Rest = 26,/obj/Moves/Snore = 26,/obj/Moves/Earthquake = 36,/obj/Moves/Future_Sight = 46,/obj/Moves/Fissure = 56)
		EggGroups = list("Water2")
		EggMoves = list(/obj/Moves/Spark,/obj/Moves/Thrash,/obj/HMs/Whirlpool)
		Weight = 52
		POKEIMAGE = '340.png'
		Abilities = list ("Oblivious", "Anticipation")
	Corphish
		CaptureRate = 205
		Gender = 50
		icon = '341Corphish.dmi'
		Type1 = "Water"
		GrowthRate = "Slow"
		Evolve = list("Level 30" = /mob/Pokemon/Crawdaunt)
		BaseStats = list("HP" = 43, "ATK" = 80, "DEF" = 65, "SPL ATK" = 50, "SPL DEF" = 35, "SPD" = 35, "EXP" = 111)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Harden = 7,/obj/Moves/ViceGrip = 10,/obj/Moves/Bubblebeam = 19,/obj/Moves/Protect = 22,/obj/Moves/Knock_Off = 25,/obj/Moves/Taunt = 31,/obj/Moves/Crabhammer = 34,/obj/Moves/Swords_Dance = 37,/obj/Moves/Crunch = 43,/obj/Moves/Guillotine = 46)
		EggGroups = list("Water 1","Water 3")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Body_Slam,/obj/Moves/Endeavor,/obj/Moves/Mud_Sport)
		Weight = 25.4
		POKEIMAGE = '341.png'
		Number = 339
		Abilities = list("Hyper Cutter","Shell Armor")
		HiddenAbility = list("Adaptability")
	Crawdaunt
		CaptureRate = 155
		Gender = 50
		icon = '342Crawdaunt.dmi'
		Type1 = "Water"
		Type2 = "Dark"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 63, "ATK" = 120, "DEF" = 85, "SPL ATK" = 90, "SPL DEF" = 55, "SPD" = 55, "EXP" = 161)
		LearnMoves = list(/obj/Moves/Bubble = 1,/obj/Moves/Harden = 1,/obj/Moves/ViceGrip = 1,/obj/Moves/Leer = 1,/obj/Moves/Bubblebeam = 19,/obj/Moves/Protect = 22,/obj/Moves/Knock_Off = 25,/obj/Moves/Taunt = 33,/obj/Moves/Taunt = 33,/obj/Moves/Crabhammer = 38,/obj/Moves/Swords_Dance = 43,/obj/Moves/Crunch = 51,/obj/Moves/Guillotine = 56)
		EggGroups = list("Water 1","Water 3")
		EggMoves = list(/obj/Moves/Ancient_Power,/obj/Moves/Body_Slam,/obj/Moves/Endeavor,/obj/Moves/Mud_Sport)
		Weight = 72.3
		POKEIMAGE = '342.png'
		Number = 342
		Unevolve = /mob/Pokemon/Corphish
		Abilities = list("Hyper Cutter","Shell Armor")
		HiddenAbility = list("Adaptability")
	Baltoy
		CaptureRate = 255
		Gender = "Genderless"
		icon = '343Baltoy.dmi'
		Type1 = "Ground"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 36" = /mob/Pokemon/Claydol)
		BaseStats = list("HP" = 40, "ATK" = 40, "DEF" = 55, "SPL ATK" = 40, "SPL DEF" = 70, "SPD" = 55, "EXP" = 58)
		LearnMoves = list(/obj/Moves/Confusion = 1,/obj/Moves/Harden = 3,/obj/Moves/Rapid_Spin = 5,/obj/Moves/Psybeam = 11,/obj/Moves/Selfdestruct = 19,/obj/Moves/Ancient_Power = 25,/obj/Moves/Sandstorm = 31,/obj/Moves/Explosion = 45,/obj/Moves/Mud_Slap = 7,/obj/Moves/Rock_Tomb = 15,/obj/Moves/Cosmic_Power = 37)
		EggGroups = list("Mineral")
		Weight = 47.4
		Number = 343
		POKEIMAGE = '343.png'
		Abilities = list("Levitate")
	Claydol
		CaptureRate = 90
		Gender = "Genderless"
		icon = '344Claydol.dmi'
		Type1 = "Ground"
		Type2 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 60, "ATK" = 70, "DEF" = 105, "SPL ATK" = 70, "SPL DEF" = 120, "SPD" = 75, "EXP" = 189)
		LearnMoves = list(/obj/HMs/Teleport = 1,/obj/Moves/Confusion = 1,/obj/Moves/Harden = 1,/obj/Moves/Rapid_Spin = 1,/obj/Moves/Psybeam = 11,/obj/Moves/Selfdestruct = 19,/obj/Moves/Ancient_Power = 25,/obj/Moves/Sandstorm = 31,/obj/Moves/Hyper_Beam = 36,/obj/Moves/Explosion = 55,/obj/Moves/Mud_Slap = 7,/obj/Moves/Rock_Tomb = 15,/obj/Moves/Cosmic_Power = 42)
		EggGroups = list("Minerals")
		Weight = 238
		Number = 344
		Unevolve = /mob/Pokemon/Baltoy
		POKEIMAGE = '344.png'
		Abilities = list("Levitate")
	Lileep
		CaptureRate = 45
		Gender = 87
		icon = '345Lileep.dmi'
		Type1 = "Rock"
		Type2 = "Grass"
		GrowthRate = "Fast"
		Evolve = list("Level 40" = /mob/Pokemon/Cradily)
		BaseStats = list("HP" = 66, "ATK" = 41, "DEF" = 77, "SPL ATK" = 61, "SPL DEF" = 87, "SPD" = 23, "EXP" = 99)
		LearnMoves = list(/obj/Moves/Astonish = 1,/obj/Moves/Constrict = 8,/obj/Moves/Acid = 15,/obj/Moves/Ingrain = 22,/obj/Moves/Confuse_Ray = 29,/obj/Moves/Amnesia = 36,/obj/Moves/Ancient_Power = 43,/obj/Moves/Stockpile = 50,/obj/Moves/Swallow = 50,/obj/Moves/Spit_Up = 50)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Mirror_Coat,/obj/Moves/Recover,/obj/Moves/Rock_Slide)
		Weight = 52.5
		//POKEIMAGE = '345.png'
		Number = 345
		Abilities = list("Suction Cups","Storm Drain")
	Cradily
		CaptureRate = 45
		Gender = 87
		icon = '346Cradily.dmi'
		Type1 = "Rock"
		Type2 = "Grass"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 86, "ATK" = 81, "DEF" = 97, "SPL ATK" = 81, "SPL DEF" = 107, "SPD" = 43, "EXP" = 199)
		LearnMoves = list(/obj/Moves/Astonish = 1,/obj/Moves/Constrict = 8,/obj/Moves/Acid = 15,/obj/Moves/Ingrain = 22,/obj/Moves/Confuse_Ray = 29,/obj/Moves/Amnesia = 36,/obj/Moves/Ancient_Power = 48,/obj/Moves/Stockpile = 60,/obj/Moves/Swallow = 60,/obj/Moves/Spit_Up = 60)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Mirror_Coat,/obj/Moves/Recover,/obj/Moves/Rock_Slide)
		Weight = 133.2
		//POKEIMAGE = '346.png'
		Number = 346
		Abilities = list("Suction Cups","Storm Drain")
		Unevolve = /mob/Pokemon/Lileep
	Anorith
		CaptureRate = 45
		Gender = 87
		icon = '347Anorith.dmi'
		Type1 = "Rock"
		Type2 = "Bug"
		GrowthRate = "Fast"
		Evolve = list("Level 40" = /mob/Pokemon/Armaldo)
		BaseStats = list("HP" = 45, "ATK" = 95, "DEF" = 50, "SPL ATK" = 40, "SPL DEF" = 50, "SPD" = 75, "EXP" = 99)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Harden = 1,/obj/Moves/Mud_Sport = 13,/obj/Moves/Water_Gun = 19,/obj/Moves/Metal_Claw = 25,/obj/Moves/Protect = 31,/obj/Moves/Ancient_Power = 37,/obj/Moves/Fury_Cutter = 43,/obj/Moves/Slash = 49,/obj/Moves/Rock_Blast = 55)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Knock_Off,/obj/Moves/Swords_Dance,/obj/Moves/Rapid_Spin,/obj/Moves/Rock_Slide)
		Weight = 27.6
		//POKEIMAGE = '347.png'
		Number = 347
		Abilities = list("Battle Armor","Swift Swim")
	Armaldo
		CaptureRate = 45
		Gender = 87
		icon = '348Armaldo.dmi'
		Type1 = "Rock"
		Type2 = "Bug"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 75, "ATK" = 125, "DEF" = 100, "SPL ATK" = 70, "SPL DEF" = 80, "SPD" = 45, "EXP" = 199)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Harden = 1,/obj/Moves/Mud_Sport = 13,/obj/Moves/Water_Gun = 19,/obj/Moves/Metal_Claw = 25,/obj/Moves/Protect = 31,/obj/Moves/Ancient_Power = 37,/obj/Moves/Fury_Cutter = 46,/obj/Moves/Slash = 55,/obj/Moves/Rock_Blast = 64)
		EggGroups = list("Water 3")
		EggMoves = list(/obj/Moves/Knock_Off,/obj/Moves/Swords_Dance,/obj/Moves/Rapid_Spin,/obj/Moves/Rock_Slide)
		Weight = 150.4
		//POKEIMAGE = '348.png'
		Number = 348
		Abilities = list("Battle Armor","Swift Swim")
		Unevolve = /mob/Pokemon/Anorith
	Feebas
		CaptureRate = 255
		Gender = 50
		icon = '349Feebas.dmi'
		Type1 = "Water"
		GrowthRate = "Fast"
		Evolve = list("Trade" = /mob/Pokemon/Milotic,"TradeItem" = /obj/HeldItems/Evolution/Prism_Scale)
		BaseStats = list("HP" = 20, "ATK" = 15, "DEF" = 20, "SPL ATK" = 10, "SPL DEF" = 55, "SPD" = 80, "EXP" = 61)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Tackle = 15,/obj/Moves/Flail = 30)
		EggGroups = list("Water 1","Dragon")
		EggMoves = list(/obj/Moves/Confuse_Ray,/obj/Moves/Dragon_Breath,/obj/Moves/Hypnosis,/obj/Moves/Light_Screen,/obj/Moves/Mirror_Coat,/obj/Moves/Mud_Sport)
		Weight = 16.3
		POKEIMAGE = '349.png'
		Number = 349
		Abilities = list("Swift Swim","Adaptability")
	Milotic
		CaptureRate = 60
		Gender = 50
		icon = '350Milotic.dmi'
		Type1 = "Water"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 95, "ATK" = 60, "DEF" = 79, "SPL ATK" = 100, "SPL DEF" = 125, "SPD" = 81, "EXP" = 213)
		LearnMoves = list(/obj/Moves/Water_Gun = 1,/obj/Moves/Wrap = 5,/obj/Moves/Water_Sport = 10,/obj/Moves/Refresh = 15,/obj/Moves/Water_Pulse = 20,/obj/Moves/Twister = 25,/obj/Moves/Recover = 30,/obj/Moves/Rain_Dance = 35,/obj/Moves/Hydro_Pump = 40,/obj/Moves/Attract = 45,/obj/Moves/Safeguard = 50)
		EggGroups = list("Water 1","Dragon")
		EggMoves = list(/obj/Moves/Confuse_Ray,/obj/Moves/Dragon_Breath,/obj/Moves/Hypnosis,/obj/Moves/Light_Screen,/obj/Moves/Mirror_Coat,/obj/Moves/Mud_Sport)
		Weight = 357.1
		POKEIMAGE = '350.png'
		Number = 350
		Unevolve = /mob/Pokemon/Feebas
		Abilities = list("Marvel Scale","Cute Charm")
	Castform
		CaptureRate = 45
		Gender = 50
		icon = '351Castform.dmi'
		Type1 = "Normal"
		GrowthRate = "medium-fast"
		BaseStats = list("HP" = 70, "ATK" = 70, "DEF" = 70, "SPL ATK" = 70, "SPL DEF" = 70, "SPD" = 70, "EXP" = 145)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Water_Gun = 10,/obj/Moves/Ember = 10,/obj/Moves/Powder_Snow = 10,/obj/Moves/Rain_Dance = 20,/obj/Moves/Sunny_Day = 20,/obj/Moves/Hail = 20)//Just need to add Weather Ball.
		EggGroups = list("Fairy", "Amorphous")
		EggMoves = list(/obj/Moves/Future_Sight,/obj/Moves/Psych_Up)
		Weight = 1.8
		Number = 351
		Abilities = list("Forecast")
		//POKEIMAGE = '351.png'
	Kecleon
		CaptureRate = 200
		Gender = 50
		icon = '352Kecleon.dmi'
		Type1 = "Normal"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 60, "ATK" = 90, "DEF" = 70, "SPL ATK" = 60, "SPL DEF" = 120, "SPD" = 40, "EXP" = 132)
		LearnMoves = list(/obj/Moves/Thief = 1,/obj/Moves/Scratch = 1,/obj/Moves/Tail_Whip = 1,/obj/Moves/Astonish = 1,/obj/Moves/Lick = 1,/obj/Moves/Bind = 4,/obj/Moves/Faint_Attack = 7,/obj/Moves/Fury_Swipes = 12,/obj/Moves/Psybeam = 17,/obj/Moves/Screech = 24,/obj/Moves/Slash = 31,/obj/Moves/Substitute = 40,/obj/Moves/Ancient_Power = 49)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Disable,/obj/Moves/Magic_Coat,/obj/Moves/Trick)
		Weight = 48.5
		Number= 352
		Abilities = list("Color Change")
	Shuppet
		CaptureRate = 255
		Gender = 50
		icon = '353Shuppet.dmi'
		Type1 = "Ghost"
		GrowthRate = "Fast"
		Evolve = list("Level 37" = /mob/Pokemon/Banette)
		BaseStats = list("HP" = 44, "ATK" = 75, "DEF" = 35, "SPL ATK" = 63, "SPL DEF" = 33, "SPD" = 45, "EXP" = 97)
		LearnMoves = list(/obj/Moves/Knock_Off = 1,/obj/Moves/Screech = 8,/obj/Moves/Night_Shade = 13,/obj/Moves/Curse = 20,/obj/Moves/Spite = 25,/obj/Moves/Will_O_Wisp = 32,/obj/Moves/Faint_Attack = 37,/obj/Moves/Shadow_Ball = 44,/obj/Moves/Snatch = 49,/obj/Moves/Grudge = 56)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Astonish,/obj/Moves/Destiny_Bond,/obj/Moves/Disable,/obj/Moves/Foresight,/obj/Moves/Imprison)
		Weight = 5.1
		Number = 353
		Abilities = list("Insomia","Frisk","Cursed Body")

	Banette
		CaptureRate = 45
		Gender = 50
		icon ='354Banette.dmi'
		Type1 = "Ghost"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 64, "ATK" = 115, "DEF" = 65, "SPL ATK" = 83, "SPL DEF" = 63, "SPD" = 65, "EXP" = 179)
		LearnMoves = list(/obj/Moves/Knock_Off = 1,/obj/Moves/Screech = 1,/obj/Moves/Night_Shade = 1,/obj/Moves/Curse = 1,/obj/Moves/Screech = 8,/obj/Moves/Night_Shade = 13,/obj/Moves/Curse = 20,/obj/Moves/Spite = 25,/obj/Moves/Will_O_Wisp = 32,/obj/Moves/Faint_Attack = 39,/obj/Moves/Shadow_Ball = 48,/obj/Moves/Snatch = 55,/obj/Moves/Grudge = 64)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Astonish,/obj/Moves/Destiny_Bond,/obj/Moves/Disable,/obj/Moves/Foresight,/obj/Moves/Imprison)
		Weight = 27.6
		Number = 354
		Unevolve = /mob/Pokemon/Shuppet
		Abilities = list("Insomnia","Frisk")
	Duskull
		CaptureRate = 190
		Gender = 50
		icon = '355Duskull.dmi'
		Type1 = "Ghost"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 20, "ATK" = 40, "DEF" = 90, "SPL ATK" = 30, "SPL DEF" = 90, "SPD" = 25, "EXP" = 97)
		LearnMoves = list(/obj/Moves/Leer = 1,/obj/Moves/Night_Shade = 1,/obj/Moves/Disable = 5,/obj/Moves/Foresight = 12,/obj/Moves/Astonish = 16,/obj/Moves/Confuse_Ray = 23,/obj/Moves/Pursuit = 27,/obj/Moves/Curse = 34,/obj/Moves/Will_O_Wisp = 38,/obj/Moves/Mean_Look = 45,/obj/Moves/Future_Sight = 49)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Destiny_Bond,/obj/Moves/Faint_Attack,/obj/Moves/Grudge,/obj/Moves/Imprison,/obj/Moves/Memento,/obj/Moves/Pain_Split)
		Weight = 33.1
		Number = 355
		Abilities = list("Levitate")
	Dusclops
		CaptureRate = 90
		Gender = 50
		icon = '356Dusclops.dmi'
		Type1 = "Ghost"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 40, "ATK" = 70, "DEF" = 130, "SPL ATK" = 60, "SPL DEF" = 130, "SPD" = 25, "EXP" = 179)
		LearnMoves = list(/obj/Moves/Bind = 1,/obj/Moves/Leer = 1, /obj/Moves/Night_Shade = 1, /obj/Moves/Disable = 1, /obj/Moves/Disable = 5, /obj/Moves/Foresight = 12, /obj/Moves/Astonish = 16,/obj/Moves/Confuse_Ray = 23, /obj/Moves/Pursuit = 27, /obj/Moves/Curse = 34, /obj/Moves/Shadow_Punch = 37, /obj/Moves/Will_O_Wisp = 41, /obj/Moves/Mean_Look = 51)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Destiny_Bond,/obj/Moves/Faint_Attack,/obj/Moves/Grudge,/obj/Moves/Imprison,/obj/Moves/Memento,/obj/Moves/Pain_Split)
		Weight = 65.1
		Number = 356
		Abilities = list("Pressure")
		Unevolve = /mob/Pokemon/Duskull
	Tropius
		CaptureRate = 200
		Gender = 50
		icon = '357Tropius.dmi'
		Type1 = "Grass"
		Type2 = "Flying"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 99, "ATK" = 68, "DEF" = 83, "SPL ATK" = 72, "SPL DEF" = 87, "SPD" = 51, "EXP" = 169)
		LearnMoves = list(/obj/Moves/Leer = 1,/obj/Moves/Gust = 1,/obj/Moves/Growth = 7,/obj/Moves/Razor_Leaf = 11,/obj/Moves/Stomp = 17,/obj/Moves/Sweet_Scent = 21,/obj/Moves/Whirlwind = 27,/obj/Moves/Body_Slam = 37,/obj/Moves/SolarBeam = 41,/obj/Moves/Synthesis = 47)
		EggGroups = list("Monster","Grass")
		EggMoves = list(/obj/Moves/Headbutt,/obj/Moves/Leech_Seed,/obj/Moves/Slam)
		Weight = 220.5
		Number = 357
		POKEIMAGE = '357.png'
		Abilities = list("Chlorophyll","Solar Power","Harvest")
	Chimecho
		CaptureRate = 45
		Gender = 50
		icon = '358Chimecho.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 65, "ATK" = 50, "DEF" = 70, "SPL ATK" = 95, "SPL DEF" = 90, "SPD" = 65, "EXP" = 147)
		LearnMoves = list(/obj/Moves/Wrap = 1,/obj/Moves/Growl = 6,/obj/Moves/Astonish = 9,/obj/Moves/Confusion = 14,/obj/Moves/Take_Down = 17,/obj/Moves/Uproar = 22,/obj/Moves/Yawn = 25,/obj/Moves/Psywave = 30,/obj/Moves/Double_Edge = 33,/obj/Moves/Heal_Bell = 38,/obj/Moves/Safeguard = 41,/obj/Moves/Psychic = 46)
		EggGroups = list("Amorphous")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Disable,/obj/Moves/Dream_Eater,/obj/Moves/Hypnosis)
		Weight = 2.2
		Number = 358
		//POKEIMAGE = '358.png'
		Abilities = list("Levitate")
	Absol
		CaptureRate = 30
		Gender = 50
		icon = '359Absol.dmi'
		Type1 = "Dark"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 65, "ATK" = 130, "DEF" = 60, "SPL ATK" = 75, "SPL DEF" = 60, "SPD" = 75, "EXP" = 174)
		LearnMoves = list(/obj/Moves/Scratch = 1,/obj/Moves/Leer = 5,/obj/Moves/Quick_Attack = 13,/obj/Moves/Razor_Wind = 17,/obj/Moves/Bite = 21,/obj/Moves/Swords_Dance = 26,/obj/Moves/Double_Team = 31,/obj/Moves/Slash = 36,/obj/Moves/Future_Sight = 41,/obj/Moves/Perish_Song = 46)
		EggGroups = list("Field")
		EggMoves = list(/obj/Moves/Baton_Pass,/obj/Moves/Curse,/obj/Moves/Double_Edge,/obj/Moves/Faint_Attack,/obj/Moves/Substitute)
		Weight = 103.6
		Number = 359
		POKEIMAGE = '359.png'
		Abilities = list("Pressure","Super Luck","Justified")
	Wynaut

		CaptureRate = 120
		Gender = 50
		icon = '360Wynaut.dmi'
		Type1 = "Psychic"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 15" = /mob/Pokemon/Wobbuffet)
		BaseStats = list("HP" = 95, "ATK" = 23, "DEF" = 48, "SPL ATK" = 23, "SPL DEF" = 48, "SPD" = 23, "EXP" = 22)
		LearnMoves = list(/obj/Moves/Splash = 1,/obj/Moves/Charm = 1,/obj/Moves/Encore = 1,/obj/Moves/Counter = 15,/obj/Moves/Mirror_Coat = 15,/obj/Moves/Safeguard = 15,/obj/Moves/Destiny_Bond = 15)
		EggGroups = list("Undiscovered")
		Weight = 30.9
		//POKEIMAGE = '360.png'
		Abilities = list("Shadow Tag","Telepathy")
	Snorunt
		CaptureRate = 190
		Gender = 50
		icon = '361Snorunt.dmi'
		Type1 = "Ice"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 42" = /mob/Pokemon/Glalie)
		BaseStats = list("HP" = 50, "ATK" = 50, "DEF" = 50, "SPL ATK" = 50, "SPL DEF" = 50, "SPD" = 50, "EXP" = 74)
		LearnMoves = list(/obj/Moves/Powder_Snow = 1,/obj/Moves/Leer = 1,/obj/Moves/Double_Team = 7,/obj/Moves/Bite = 10,/obj/Moves/Icy_Wind = 16,/obj/Moves/Headbutt = 19,/obj/Moves/Protect = 25,/obj/Moves/Crunch = 28,/obj/Moves/Ice_Beam = 34,/obj/Moves/Hail = 37,/obj/Moves/Blizzard = 43)
		EggGroups = list("Fairy","Mineral")
		EggMoves = list(/obj/Moves/Block,/obj/Moves/Spikes)
		Weight = 37.0
		POKEIMAGE = '361.png'
		Number = 361
		Abilities = list("Inner Focus","Ice Body","Moody")
	Glalie
		CaptureRate = 75
		Gender = 50
		icon = '362Glalie.dmi'
		Type1 = "Ice"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 80, "ATK" = 80, "DEF" = 80, "SPL ATK" = 80, "SPL DEF" = 80, "SPD" = 80, "EXP" = 187)
		LearnMoves = list(/obj/Moves/Powder_Snow = 1,/obj/Moves/Leer = 1,/obj/Moves/Double_Team = 1,/obj/Moves/Bite = 1,/obj/Moves/Icy_Wind = 16,/obj/Moves/Headbutt = 19,/obj/Moves/Protect = 25,/obj/Moves/Crunch = 28,/obj/Moves/Ice_Beam = 34,/obj/Moves/Hail = 42,/obj/Moves/Blizzard = 53,/obj/Moves/Sheer_Cold = 61)
		EggGroups = list("Fairy","Mineral")
		EggMoves = list(/obj/Moves/Block,/obj/Moves/Spikes)
		Weight = 565.5
		POKEIMAGE = '362.png'
		Number = 362
		Unevolve = /mob/Pokemon/Snorunt
		Abilities = list("Inner Focus","Ice Body","Moody")
	Spheal
		CaptureRate = 255
		Gender = 50
		icon = '363Spheal.dmi'
		Type1 = "Ice"
		Type2 = "Water"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 32" = /mob/Pokemon/Sealeo)
		BaseStats = list("HP" = 70, "ATK" = 40, "DEF" = 50, "SPL ATK" = 55, "SPL DEF" = 50, "SPD" = 25, "EXP" = 75)
		LearnMoves = list(/obj/Moves/Powder_Snow = 1,/obj/Moves/Growl = 1 ,/obj/Moves/Water_Gun = 1,/obj/Moves/Encore = 7,/obj/Moves/Ice_Ball = 13,/obj/Moves/Body_Slam = 19,/obj/Moves/Aurora_Beam = 25,/obj/Moves/Hail = 31,/obj/Moves/Rest = 37,/obj/Moves/Snore = 37,/obj/Moves/Blizzard = 43,/obj/Moves/Sheer_Cold = 49)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Fissure,/obj/Moves/Rock_Slide,/obj/Moves/Spit_Up,/obj/Moves/Stockpile,/obj/Moves/Swallow,/obj/Moves/Water_Sport,/obj/Moves/Yawn)
		Weight = 87.1
		//POKEIMAGE = '363'.png
		Number = 363
		Abilities = list("Thick Fat","Ice Body","Oblivious")
	Sealeo
		CaptureRate = 120
		Gender = 50
		icon = '364Sealeo.dmi'
		Type1 = "Ice"
		Type2 = "Water"
		GrowthRate = "Medium-Fast"
		Evolve = list("Level 40" = /mob/Pokemon/Walrein)
		BaseStats = list("HP" = 90, "ATK" = 60, "DEF" = 70, "SPL ATK" = 75, "SPL DEF" = 70, "SPD" = 45, "EXP" = 127)
		LearnMoves = list(/obj/Moves/Powder_Snow = 1,/obj/Moves/Growl = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Encore = 1,/obj/Moves/Ice_Ball = 13,/obj/Moves/Body_Slam = 19,/obj/Moves/Aurora_Beam = 25,/obj/Moves/Hail = 31,/obj/Moves/Rest = 39,/obj/Moves/Snore = 39,/obj/Moves/Blizzard = 47,/obj/Moves/Sheer_Cold = 55)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Fissure,/obj/Moves/Rock_Slide,/obj/Moves/Spit_Up,/obj/Moves/Stockpile,/obj/Moves/Swallow,/obj/Moves/Water_Sport,/obj/Moves/Yawn)
		Weight = 193.1
		//POKEIMAGE = '364.png'
		Number = 364
		Unevolve = /mob/Pokemon/Spheal
		Abilities = list("Thick Fat","Ice Body","Oblivious")
	Walrein
		CaptureRate = 45
		Gender = 50
		icon = '365Walrein.dmi'
		Type1 = "Ice"
		Type2 = "Water"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 110, "ATK" = 80, "DEF" = 90, "SPL ATK" = 95, "SPL DEF" = 90, "SPD" = 65, "EXP" = 192)
		LearnMoves = list(/obj/Moves/Powder_Snow = 1,/obj/Moves/Growl = 1,/obj/Moves/Water_Gun = 1,/obj/Moves/Encore = 1,/obj/Moves/Ice_Ball = 13,/obj/Moves/Body_Slam = 19,/obj/Moves/Aurora_Beam = 25,/obj/Moves/Hail = 31,/obj/Moves/Rest = 39,/obj/Moves/Snore = 39,/obj/Moves/Blizzard = 50,/obj/Moves/Sheer_Cold = 61)
		EggGroups = list("Water 1","Field")
		EggMoves = list(/obj/Moves/Curse,/obj/Moves/Fissure,/obj/Moves/Rock_Slide,/obj/Moves/Spit_Up,/obj/Moves/Stockpile,/obj/Moves/Swallow,/obj/Moves/Water_Sport,/obj/Moves/Yawn)
		Weight = 332.0
		//POKEIMAGE = '365.png'
		Number = 365
		Unevolve = /mob/Pokemon/Sealeo
		Abilities = list("Thick Fat","Ice Body","Oblivious")
	Clamperl
		CaptureRate = 255
		Gender = 50
		icon = '366Camperl.dmi'
		Type1 = "Water"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 35, "ATK" = 64, "DEF" = 85, "SPL ATK" = 74, "SPL DEF" = 55, "SPD" = 32, "EXP" = 142)
		LearnMoves = list(/obj/Moves/Clamp = 1,/obj/Moves/Iron_Defence = 1,/obj/Moves/Water_Gun = 1,/obj/HMs/Whirlpool = 1)
		EggGroups = list("Water 1")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Body_Slam,/obj/Moves/Confuse_Ray,/obj/Moves/Mud_Sport,/obj/Moves/Refresh,/obj/Moves/Supersonic)
		Weight = 115.7
		//POKEIMAGE = '366.png'
		Number = 366
		Abilities = list("Shell Armour","Rattled")
	Huntail
		CaptureRate = 60
		Gender = 50
		icon = '367Huntail.dmi'
		Type1 = "Water"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 55, "ATK" = 104, "DEF" = 105, "SPL ATK" = 94, "SPL DEF" = 75, "SPD" = 52, "EXP" = 178)
		LearnMoves = list(/obj/HMs/Whirlpool = 1,/obj/Moves/Bite = 8,/obj/Moves/Screech = 15,/obj/Moves/Water_Pulse = 22,/obj/Moves/Scary_Face = 29,/obj/Moves/Crunch = 36,/obj/Moves/Baton_Pass = 43,/obj/Moves/Hydro_Pump = 50)
		EggGroups = list("Water 1")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Body_Slam,/obj/Moves/Confuse_Ray,/obj/Moves/Mud_Sport,/obj/Moves/Refresh,/obj/Moves/Supersonic)
		Weight = 59.5
		//POKEIMAGE = '367.png'
		Number = 367
		Unevolve = /mob/Pokemon/Clamperl
		Abilities = list("Swift Swim","Water Veil")
	Gorebyss
		CaptureRate = 60
		Gender = 50
		icon = '368Gorebyss.dmi'
		Type1 = "Water"
		GrowthRate = "Fast"
		BaseStats = list("HP" = 55, "ATK" = 84, "DEF" = 105, "SPL ATK" = 114, "SPL DEF" = 75, "SPD" = 52, "EXP" = 178)
		LearnMoves = list(/obj/HMs/Whirlpool = 1,/obj/Moves/Confusion = 8,/obj/Moves/Agility = 15,/obj/Moves/Water_Pulse = 22,/obj/Moves/Amnesia = 29,/obj/Moves/Psychic = 36,/obj/Moves/Baton_Pass,/obj/Moves/Hydro_Pump = 50)
		EggGroups = list("Water 1")
		EggMoves = list(/obj/Moves/Barrier,/obj/Moves/Body_Slam,/obj/Moves/Confuse_Ray,/obj/Moves/Mud_Sport,/obj/Moves/Refresh,/obj/Moves/Supersonic)
		Weight = 49.8
		//POKEIMAGE = '368.png'
		Number = 368
		Unevolve = /mob/Pokemon/Clamperl
		Abilities = list("Swift Swim","Hydration")
	Relicanth
		CaptureRate = 25
		Gender = 87.5
		icon = '369Relicanth.dmi'
		Type1 = "Water"
		Type2 = "Rock"
		GrowthRate = "Medium-Slow"
		BaseStats = list("HP" = 100, "ATK" = 90, "DEF" = 130, "SPL ATK" = 45, "SPL DEF" = 65, "SPD" = 55, "EXP" = 198)
		LearnMoves = list(/obj/Moves/Harden = 1,/obj/Moves/Tackle = 1,/obj/Moves/Water_Gun = 8,/obj/Moves/Rock_Tomb = 15,/obj/Moves/Yawn = 22,/obj/Moves/Take_Down = 29,/obj/Moves/Mud_Sport = 36,/obj/Moves/Ancient_Power = 43,/obj/Moves/Rest = 50,/obj/Moves/Double_Edge = 57,/obj/Moves/Hydro_Pump = 64)
		EggGroups = list("Water 1","Water2")
		EggMoves = list(/obj/Moves/Amnesia,/obj/Moves/Magnitude,/obj/Moves/Rock_Slide,/obj/Moves/Skull_Bash,/obj/Moves/Sleep_Talk,/obj/Moves/Snore,/obj/Moves/Water_Sport)
		Weight = 56.1
		//POKEIMAGE = '369.png'
		Number = 369
		Abilities = list("Swift Swim","Rock Head","Sturdy")
	Luvdisc
		CaptureRate = 255
		Gender = 25
		icon = '370Luvdisc.dmi'
		Type1 = "Water"
		GrowthRate = "Medium-Fast"
		BaseStats = list("HP" = 43, "ATK" = 30, "DEF" = 55, "SPL ATK" = 40, "SPL DEF" = 65, "SPD" = 97, "EXP" = 110)
		LearnMoves = list(/obj/Moves/Tackle = 1,/obj/Moves/Charm = 4,/obj/Moves/Water_Gun = 12,/obj/Moves/Agility = 16,/obj/Moves/Take_Down = 24,/obj/Moves/Attract = 28,/obj/Moves/Sweet_Kiss = 36,/obj/Moves/Flail = 40,/obj/Moves/Safeguard = 48)
		EggGroups = list("Water 2")
		EggMoves = list(/obj/Moves/Mud_Sport,/obj/Moves/Splash,/obj/Moves/Supersonic,/obj/Moves/Water_Sport)
		Weight = 19.2
		//POKEIMAGE = '370.png'
		Number = 370
		Abilities = list("Swift Swim","Hydration")
	Bagon
		CaptureRate = 45
		Gender = 50
		icon = '371Bagon.dmi'
		Type1 = "Dragon"
		GrowthRate = "Slow"
		Evolve = list("Level 30" = /mob/Pokemon/Shelgon)
		BaseStats = list("HP" = 45, "ATK" = 75, "DEF" = 60, "SPL ATK" = 40, "SPL DEF" = 30, "SPD" = 50, "EXP" = 89)
		LearnMoves = list(/obj/Moves/Rage = 1,/obj/Moves/Leer = 5,/obj/Moves/Bite = 9,/obj/Moves/Headbutt = 17,/obj/Moves/Focus_Energy = 21,/obj/Moves/Ember = 25,/obj/Moves/Dragon_Breath = 33,/obj/Moves/Scary_Face = 37,/obj/Moves/Crunch = 41,/obj/Moves/Dragon_Claw = 49,/obj/Moves/Double_Edge = 53)
		EggGroups = list("Dragon")
		EggMoves = list(/obj/Moves/Dragon_Dance,/obj/Moves/Dragon_Rage,/obj/Moves/Hydro_Pump,/obj/Moves/Thrash,/obj/Moves/Twister)
		Weight = 92.8
		POKEIMAGE = '371.png'
		Number = 371
		Abilities = list("Rock Head","Sheer Force")
	Shelgon
		CaptureRate = 45
		Gender = 50
		icon = '372Shelgon.dmi'
		Type1 = "Dragon"
		GrowthRate = "Slow"
		Evolve = list("Level 50" = /mob/Pokemon/Salamence)
		BaseStats = list("HP" = 65, "ATK" = 95, "DEF" = 100, "SPL ATK" = 60, "SPL DEF" = 50, "SPD" = 50, "EXP" = 144)
		LearnMoves = list(/obj/Moves/Rage = 1,/obj/Moves/Leer = 1,/obj/Moves/Bite = 1,/obj/Moves/Headbutt = 1,/obj/Moves/Focus_Energy = 21,/obj/Moves/Ember = 25,/obj/Moves/Protect = 30,/obj/Moves/Dragon_Breath = 38,/obj/Moves/Scary_Face = 47,/obj/Moves/Crunch = 56,/obj/Moves/Dragon_Claw = 69,/obj/Moves/Double_Edge = 78)
		EggGroups = list("Dragon")
		EggMoves = list(/obj/Moves/Dragon_Dance,/obj/Moves/Dragon_Rage,/obj/Moves/Hydro_Pump,/obj/Moves/Thrash,/obj/Moves/Twister)
		Weight = 243.6
		POKEIMAGE = '372.png'
		Number = 372
		Unevolve = /mob/Pokemon/Bagon
		Abilities = list("Rock Head","Sheer Force")
	Salamence
		CaptureRate = 45
		Gender = 50
		icon = '373Salamence.dmi'
		Type1 = "Dragon"
		Type2 = "Flying"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 95, "ATK" = 135, "DEF" = 80, "SPL ATK" = 110, "SPL DEF" = 80, "SPD" = 100, "EXP" = 218)
		LearnMoves = list(/obj/Moves/Rage = 1,/obj/Moves/Leer = 1,/obj/Moves/Bite = 1,/obj/Moves/Headbutt = 1,/obj/Moves/Focus_Energy = 21,/obj/Moves/Ember = 25,/obj/Moves/Protect = 30,/obj/Moves/Dragon_Breath = 38,/obj/Moves/Scary_Face = 47,/obj/HMs/Fly = 50,/obj/Moves/Crunch = 61,/obj/Moves/Dragon_Claw = 79,/obj/Moves/Double_Edge = 93)
		EggGroups = list("Dragon")
		EggMoves = list(/obj/Moves/Dragon_Dance,/obj/Moves/Dragon_Rage,/obj/Moves/Hydro_Pump,/obj/Moves/Thrash,/obj/Moves/Twister)
		Weight = 226.2
		POKEIMAGE = '373.png'
		Number = 373
		Unevolve = /mob/Pokemon/Shelgon
		Abilities = list("Intimidate","Moxie")
	Beldum
		CaptureRate = 3
		Gender = "Genderless"
		icon = '374Beldum.dmi'
		Type1 = "Steel"
		Type2 = "Psychic"
		GrowthRate = "Slow"
		Evolve = list("Level 20" = /mob/Pokemon/Metang)
		BaseStats = list("HP" = 40, "ATK" = 55, "DEF" = 80, "SPL ATK" = 35, "SPL DEF" = 60, "SPD" = 30, "EXP" = 103)
		LearnMoves = list(/obj/Moves/Take_Down = 1)
		EggGroups = list("Mineral")
		Weight = 209.9
		//POKEIMAGE = '374.png'
		Number = 374
		Abilities = list("Clear Body")
	Metang
		CaptureRate = 3
		Gender = "Genderless"
		icon = '375Metang.dmi'
		Type1 = "Steel"
		Type2 = "Psychic"
		GrowthRate = "Slow"
		Evolve = list("Level 45" = /mob/Pokemon/Metagross)
		BaseStats = list("HP" = 60, "ATK" = 75, "DEF" = 100, "SPL ATK" = 55, "SPL DEF" = 80, "SPD" = 50, "EXP" = 153)
		LearnMoves = list(/obj/Moves/Take_Down = 1,/obj/Moves/Confusion = 20,/obj/Moves/Metal_Claw = 20,/obj/Moves/Scary_Face = 26,/obj/Moves/Pursuit = 32,/obj/Moves/Psychic = 38,/obj/Moves/Iron_Defence = 44,/obj/Moves/Meteor_Mash = 50,/obj/Moves/Agility = 56,/obj/Moves/Hyper_Beam = 62)
		EggGroups = list("Mineral")
		Weight = 446.4
		//POKEIMAGE = '375.png'
		Number = 375
		Unevolve = /mob/Pokemon/Beldum
		Abilities = list("Clear Body")
	Metagross
		CaptureRate = 3
		Gender = "Genderless"
		icon = '376Metagross.dmi'
		Type1 = "Steel"
		Type2 = "Psychic"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 80, "ATK" = 135, "DEF" = 130, "SPL ATK" = 95, "SPL DEF" = 90, "SPD" = 70, "EXP" = 210)
		LearnMoves = list(/obj/Moves/Take_Down = 1,/obj/Moves/Confusion = 1,/obj/Moves/Metal_Claw = 1,/obj/Moves/Scary_Face = 1,/obj/Moves/Pursuit = 32,/obj/Moves/Psychic = 38,/obj/Moves/Iron_Defence = 44,/obj/Moves/Meteor_Mash = 55,/obj/Moves/Agility = 66,/obj/Moves/Hyper_Beam = 77)
		EggGroups = list("Mineral")
		Weight = 1212.5
		//POKEIMAGE = '376.png'
		Number = 376
		Unevolve = /mob/Pokemon/Metang
		Abilities = list("Clear Body")
	Regirock
		CaptureRate = 3
		Gender = "Genderless"
		icon = '377Regirock.dmi'
		Type1 = "Rock"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 80, "ATK" = 100, "DEF" = 200, "SPL ATK" = 50, "SPL DEF" = 100, "SPD" = 50, "EXP" = 217)
		LearnMoves = list(/obj/Moves/Explosion = 1,/obj/Moves/Rock_Throw = 9,/obj/Moves/Curse = 17,/obj/Moves/Superpower = 25,/obj/Moves/Ancient_Power = 33,/obj/Moves/Iron_Defence = 41,/obj/Moves/Zap_Cannon = 49,/obj/Moves/Lock_On = 57,/obj/Moves/Hyper_Beam = 65)
		EggGroups = list("Undiscovered group")
		Weight = 507.1
		Number = 377
		Abilities = list("Clear Body")
	Regice
		CaptureRate = 3
		Gender = "Genderless"
		icon = '378Regice.dmi'
		Type1 = "Ice"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 80, "ATK" = 50, "DEF" = 100, "SPL ATK" = 100, "SPL DEF" = 200, "SPD" = 50, "EXP" = 216)
		LearnMoves = list(/obj/Moves/Explosion = 1,/obj/Moves/Icy_Wind = 9,/obj/Moves/Curse = 17,/obj/Moves/Superpower = 25,/obj/Moves/Ancient_Power = 33,/obj/Moves/Amnesia = 41,/obj/Moves/Zap_Cannon = 49,/obj/Moves/Lock_On = 57,/obj/Moves/Hyper_Beam = 65)
		EggGroups = list("Undiscovered group")
		Weight = 385.8
		Number = 378
		Abilities = list("Clear Body")
	Registeel
		CaptureRate = 3
		Gender = "Genderless"
		icon = '379Registeel.dmi'
		Type1 = "Steel"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 80, "ATK" = 75, "DEF" = 150, "SPL ATK" = 75, "SPL DEF" = 150, "SPD" = 50, "EXP" = 215)
		LearnMoves = list(/obj/Moves/Explosion = 1,/obj/Moves/Metal_Claw = 9,/obj/Moves/Curse = 17,/obj/Moves/Superpower = 25,/obj/Moves/Ancient_Power = 33,/obj/Moves/Amnesia = 41,/obj/Moves/Iron_Defence = 41,/obj/Moves/Zap_Cannon = 49,/obj/Moves/Lock_On = 57,/obj/Moves/Hyper_Beam = 65)
		EggGroups = list("Undiscovered group")
		Weight = 451.9
		Number = 379
		Abilities = list("Clear Body")
	Latias
		CaptureRate = 3
		Gender = 0
		icon = '380Latias.dmi'
		Type1 = "Dragon"
		Type2 = "Flying"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 80, "ATK" = 80, "DEF" = 90, "SPL ATK" = 110, "SPL DEF" = 130, "SPD" = 110, "EXP" = 211)
		LearnMoves = list(/obj/Moves/Psywave = 1,/obj/Moves/Wish = 5,/obj/Moves/Helping_Hand = 10,/obj/Moves/Safeguard = 15,/obj/Moves/Dragon_Breath = 20,/obj/Moves/Water_Sport = 25,/obj/Moves/Refresh = 30,/obj/Moves/Psychic = 40,/obj/Moves/Recover = 45,/obj/Moves/Charm = 50)///obj/Moves/MistBall = 35
		EggGroups = list("Undiscovered group")
		Weight = 88.2
		Number = 380
		Abilities = list("Levitate")
	Latios
		CaptureRate = 3
		Gender = 100
		icon = '381Latios.dmi'
		Type1 = "Dragon"
		Type2 = "Psychic"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 80, "ATK" = 90, "DEF" = 80, "SPL ATK" = 130, "SPL DEF" = 110, "SPD" = 110, "EXP" = 211)
		LearnMoves = list(/obj/Moves/Psywave = 1,/obj/Moves/Memento = 5,/obj/Moves/Helping_Hand = 10,/obj/Moves/Safeguard = 15,/obj/Moves/Dragon_Breath = 20,/obj/Moves/Protect = 25,/obj/Moves/Refresh = 30,/obj/Moves/Psychic = 40,/obj/Moves/Recover = 45,/obj/Moves/Dragon_Dance = 50) ///obj/Moves/Luster_Purge = 35,
		EggGroups = list("Undiscovered group")
		Weight = 132.3
		Number = 381
		Abilities = list("Levitate")
	Kyogre
		CaptureRate = 3
		Gender = "Genderless"
		icon = '382Kyogre.dmi'
		Type1 = "Water"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 100, "ATK" = 100, "DEF" = 90, "SPL ATK" = 150, "SPL DEF" = 140, "SPD" = 90, "EXP" = 218)
		LearnMoves = list(/obj/Moves/Water_Pulse = 1,/obj/Moves/Scary_Face = 5,/obj/Moves/Ancient_Power = 15,/obj/Moves/Body_Slam = 20,/obj/Moves/Calm_Mind = 30,/obj/Moves/Ice_Beam = 35,/obj/Moves/Hydro_Pump = 45,/obj/Moves/Rest = 50,/obj/Moves/Sheer_Cold = 60,/obj/Moves/Double_Edge = 65,/obj/Moves/Water_Spout = 75)
		EggGroups = list("Undiscovered group")
		Weight = 776.0
		Number = 382
		Abilities = list("Drizzle")
	Groudon
		CaptureRate = 3
		Gender = "Genderless"
		icon = '383Groudon.dmi'
		GrowthRate = "Slow"
		Type1 = "Ground"
		BaseStats = list("HP" = 100, "ATK" = 150, "DEF" = 140, "SPL ATK" = 100, "SPL DEF" = 90, "SPD" = 90, "EXP" = 218)
		LearnMoves = list(/obj/Moves/Mud_Shot = 1,/obj/Moves/Scary_Face = 5,/obj/Moves/Ancient_Power = 15,/obj/Moves/Slash = 20,/obj/Moves/Bulk_Up = 30,/obj/Moves/Earthquake = 35,/obj/Moves/Fire_Blast = 40,/obj/Moves/Rest = 50,/obj/Moves/Fissure = 60,/obj/Moves/SolarBeam = 65,/obj/Moves/Eruption = 75)
		EggGroups = list("Undiscovered group")
		Weight = 2094.4
		Number = 383
		Abilities = list("Drought")
	Rayquaza
		CaptureRate = 3
		Gender = "Genderless"
		icon = '384Rayquaza.dmi'
		Type1 = "Dragon"
		Type2 = "Flying"
		GrowthRate = "Slow"
		BaseStats = list("HP" = 105, "ATK" = 150, "DEF" = 90, "SPL ATK" = 150, "SPL DEF" = 90, "SPD" = 95, "EXP" = 220)
		LearnMoves = list(/obj/Moves/Twister = 1,/obj/Moves/Scary_Face = 5,/obj/Moves/Ancient_Power = 15,/obj/Moves/Dragon_Claw = 20,/obj/Moves/Dragon_Dance = 30,/obj/Moves/Crunch = 35,/obj/HMs/Fly = 40,/obj/Moves/Rest = 50,/obj/Moves/Extremespeed = 60,/obj/Moves/Outrage = 65,/obj/Moves/Hyper_Beam = 75)
		EggGroups = list("Undiscovered group")
		Weight = 455.2
		Number = 384
		Abilities = list("Air Lock")
	Jirachi
		CaptureRate = 3
		Gender = "Genderless"
		icon = '385Jirachi.dmi'
		GrowthRate = "Slow"
		Type1 = "Steel"
		Type2 = "Psychic"
		BaseStats = list("HP" = 100, "ATK" = 100, "DEF" = 100, "SPL ATK" = 100, "SPL DEF" = 100, "SPD" = 100, "EXP" = 215)
		LearnMoves = list(/obj/Moves/Wish = 1,/obj/Moves/Confusion = 1,/obj/Moves/Rest = 5,/obj/Moves/Swift = 10,/obj/Moves/Helping_Hand = 15,/obj/Moves/Psychic = 20,/obj/Moves/Refresh = 25,/obj/Moves/Rest = 30,/obj/Moves/Double_Edge = 35,/obj/Moves/Future_Sight = 40,/obj/Moves/Cosmic_Power = 45,) ///obj/Moves/Doom_Desire = 50)
		EggGroups = list("Undiscovered group")
		Weight = 2.4
		Number = 385
		Abilities = list("Serene Grace")
	Deoxys
		CaptureRate = 3
		Gender = "Genderless"
		icon = '386Deoxys.dmi'
		GrowthRate = "Slow"
		Type1 = "Psychic"
		BaseStats = list("HP" = 50, "ATK" = 150, "DEF" = 50, "SPL ATK" = 150, "SPL DEF" = 50, "SPD" = 150, "EXP" = 215)
		LearnMoves = list(/obj/Moves/Leer = 1, /obj/Moves/Wrap = 1,/obj/Moves/Night_Shade = 5,/obj/HMs/Teleport = 10,/obj/Moves/Knock_Off = 15,/obj/Moves/Pursuit = 20,/obj/Moves/Psychic = 25,/obj/Moves/Snatch = 30,/obj/Moves/Cosmic_Power = 35,/obj/Moves/Recover = 40,/obj/Moves/Hyper_Beam = 50)///obj/Moves/Psycho_Boost = 45,
		EggGroups = list("Undiscovered group")
		Weight = 134.0
		Number = 386
		Abilities = list("Pressure")