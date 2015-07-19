area
	var/
		//For DayPokemon and NightPokemon, depending on which list you put the Pokemon on depends on how many badges the Player must have when finding this Pokemon.
		list/DayPokemon
		list/NightPokemon
	Routes

		Route301 // South of Lycus Valley
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Rattata, /mob/Pokemon/Pidgey, /mob/Pokemon/Caterpie, /mob/Pokemon/Taillow = 78),\
				2 = list(/mob/Pokemon/Sentret, /mob/Pokemon/Wurmple, /mob/Pokemon/Spearow, /mob/Pokemon/Weedle),\
				3 = list(/mob/Pokemon/NidoranM,/mob/Pokemon/NidoranF, /mob/Pokemon/Beautifly)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Rattata, /mob/Pokemon/Hoothoot, /mob/Pokemon/Caterpie),\
				2 = list(/mob/Pokemon/Drowzee, /mob/Pokemon/Wurmple, /mob/Pokemon/Spearow),\
				3 = list(/mob/Pokemon/Pineco,/mob/Pokemon/NidoranM, /mob/Pokemon/Dustox)
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'
		Bloomsberry_Lake //Route 302//------------------------------------------------------------------------------------------------------
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Krabby, /mob/Pokemon/Wurmple, /mob/Pokemon/Caterpie, /mob/Pokemon/Psyduck),\
				2 = list(/mob/Pokemon/Wooper, /mob/Pokemon/Zigzagoon, /mob/Pokemon/Poochyena, /mob/Pokemon/Poliwag, /mob/Pokemon/Goldeen, /mob/Pokemon/Slowpoke),\
				3 = list(/mob/Pokemon/Marill, /mob/Pokemon/Lotad = 50, /mob/Pokemon/Surskit),\
				4 = list(/mob/Pokemon/Ralts = 60, /mob/Pokemon/Wingull, /mob/Pokemon/Beautifly)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Rattata, /mob/Pokemon/Poochyena,/mob/Pokemon/Psyduck, /mob/Pokemon/Caterpie),\
				2 = list(/mob/Pokemon/Wooper, /mob/Pokemon/Slowpoke),\
				3 = list(/mob/Pokemon/Venonat, /mob/Pokemon/Surskit),\
				4 = list(/mob/Pokemon/Ralts = 60, /mob/Pokemon/Wingull, /mob/Pokemon/Dustox)
			)
			WaterPokemon = list(/mob/Pokemon/Magikarp = 10,/mob/Pokemon/Poliwag = 15,/mob/Pokemon/Horsea = 5)
			ArenaType = "Lake" //Court Set Up
			Sounds = 'Route BL.mid'
		Route_303 // West of Lycus Valley
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Rattata, /mob/Pokemon/Zigzagoon, /mob/Pokemon/Pidgey, /mob/Pokemon/Caterpie),\
				2 = list(/mob/Pokemon/Sentret, /mob/Pokemon/Spearow, /mob/Pokemon/Weedle),\
				3 = list(/mob/Pokemon/NidoranM,/mob/Pokemon/NidoranF, /mob/Pokemon/Silcoon),\
				4 = list(/mob/Pokemon/Beautifly)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Rattata, /mob/Pokemon/Hoothoot, /mob/Pokemon/Caterpie),\
				2 = list(/mob/Pokemon/Drowzee, /mob/Pokemon/Spearow),\
				3 = list(/mob/Pokemon/Pineco,/mob/Pokemon/NidoranM, /mob/Pokemon/Cascoon),\
				4 = list(/mob/Pokemon/Dustox)
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'
		Elkvale_Woods
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Paras, /mob/Pokemon/Oddish, /mob/Pokemon/Caterpie, /mob/Pokemon/Weedle),\
				2 = list(/mob/Pokemon/Scyther, /mob/Pokemon/NidoranM, /mob/Pokemon/NidoranF),\
				3 = list(/mob/Pokemon/Heracross,/mob/Pokemon/NidoranF,/mob/Pokemon/Vulpix),\
				4 = list(/mob/Pokemon/Stantler,/mob/Pokemon/Pinsir)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Bellsprout, /mob/Pokemon/Hoothoot, /mob/Pokemon/Gastly, /mob/Pokemon/Paras),\
				2 = list(/mob/Pokemon/Heracross, /mob/Pokemon/Exeggcute, /mob/Pokemon/Zubat),\
				3 = list(/mob/Pokemon/Pineco,/mob/Pokemon/NidoranM,/mob/Pokemon/Vulpix),\
				4 = list(/mob/Pokemon/Pinsir,/mob/Pokemon/Misdreavus)
			)
			WaterPokemon = list()
			icon = 'HUD Overlays.dmi'
			icon_state = "3"
			layer = 100
			mouse_opacity = 0
			Sounds = 'Cave Forest.mid'
		Route_305//Above Elkvale
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Bellsprout, /mob/Pokemon/Paras, /mob/Pokemon/Hoppip),\
				2 = list(/mob/Pokemon/Exeggcute, /mob/Pokemon/Shroomish = 35),\
				3 = list(/mob/Pokemon/Tangela),\
				4 = list(/mob/Pokemon/Stantler)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Bellsprout,/mob/Pokemon/Oddish, /mob/Pokemon/Rattata, /mob/Pokemon/Gastly),\
				2 = list(/mob/Pokemon/Exeggcute,/mob/Pokemon/Spinarak),\
				3 = list(/mob/Pokemon/Venonat),\
				4 = list(/mob/Pokemon/Stantler,/mob/Pokemon/Misdreavus)
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'
		Salems_Path
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Zubat, /mob/Pokemon/Diglett, /mob/Pokemon/Paras),\
				2 = list(/mob/Pokemon/Sandshrew),\
				3 = list(/mob/Pokemon/Venonat,/mob/Pokemon/Sableye)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Zubat, /mob/Pokemon/Diglett, /mob/Pokemon/Paras),\
				2 = list(/mob/Pokemon/Sandshrew),\
				3 = list(/mob/Pokemon/Venonat,/mob/Pokemon/Sableye)
			)
			WaterPokemon = list(/mob/Pokemon/Magikarp = 10,/mob/Pokemon/Poliwag = 10,/mob/Pokemon/Barboach = 5,/mob/Pokemon/Corsola)
			Sounds = 'Cave Forest.mid'
		Route306//Above Lycus
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Geodude, /mob/Pokemon/Sentret, /mob/Pokemon/Ledyba),\
				2 = list(/mob/Pokemon/Jigglypuff,/mob/Pokemon/Machop),\
				3 = list(/mob/Pokemon/Noctowl, /mob/Pokemon/Gligar),\
				4 = list(/mob/Pokemon/Stantler)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Geodude,/mob/Pokemon/Sandshrew),\
				2 = list(/mob/Pokemon/Golbat,/mob/Pokemon/Cubone/,/mob/Pokemon/Meowth),\
				3 = list(/mob/Pokemon/Murkrow),\
				4 = list()
			)
			WaterPokemon = list()
			Sounds = 'Mountain.mid'

			Smeargle
				DayPokemon = list(1 = list(/mob/Pokemon/Smeargle))
				NightPokemon = list(1 = list(/mob/Pokemon/Smeargle))
				WaterPokemon = list()

		Route307//East of Lycus
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Sunkern, /mob/Pokemon/Sentret, /mob/Pokemon/Ledyba),\
				2 = list(/mob/Pokemon/Stantler,/mob/Pokemon/Mareep, /mob/Pokemon/Taillow = 20),\
				3 = list(/mob/Pokemon/Shroomish),\
				4 = list(/mob/Pokemon/Electrike = 50)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Spinarak,/mob/Pokemon/Oddish, /mob/Pokemon/Rattata),\
				2 = list(/mob/Pokemon/Murkrow,/mob/Pokemon/Stantler),\
				3 = list(/mob/Pokemon/Venonat),\
				4 = list()
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'


		Power_Plant
			luminosity = 1
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Grimer, /mob/Pokemon/Magnemite, /mob/Pokemon/Voltorb),\
				2 = list(/mob/Pokemon/Pikachu, /mob/Pokemon/Pichu),\
				3 = list(/mob/Pokemon/Electabuzz)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Grimer, /mob/Pokemon/Magnemite, /mob/Pokemon/Voltorb),\
				2 = list(/mob/Pokemon/Pikachu, /mob/Pokemon/Pichu),\
				3 = list(/mob/Pokemon/Electabuzz),\
				4 = list(/mob/Pokemon/Electrike)
			)

			WaterPokemon = list()
			Sounds = 'Mountain.mid'
			luminosity = 1
			ArenaType = "PowerPlant"
		Mt_Lunar //Route 302//------------------------------------------------------------------------------------------------------
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Geodude, /mob/Pokemon/Zubat, /mob/Pokemon/Paras),\
				2 = list(/mob/Pokemon/Diglett, /mob/Pokemon/Cubone, /mob/Pokemon/Onix),\
				3 = list(/mob/Pokemon/Phanpy,/mob/Pokemon/Houndour),\
				4 = list(/mob/Pokemon/Rhyhorn),\
				5 = list(/mob/Pokemon/Shuckle,/mob/Pokemon/Aron),\
				6 = null,\
				7 = null,\
				8 = list(/mob/Pokemon/Larvitar, /mob/Pokemon/Nidoking, /mob/Pokemon/Nidoqueen)
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Geodude, /mob/Pokemon/Zubat, /mob/Pokemon/Paras),\
				2 = list(/mob/Pokemon/Diglett, /mob/Pokemon/Cubone, /mob/Pokemon/Onix),\
				3 = list(/mob/Pokemon/Phanpy,/mob/Pokemon/Houndour),\
				4 = list(/mob/Pokemon/Rhyhorn),\
				5 = list(/mob/Pokemon/Shuckle,/mob/Pokemon/Aron),\
				6 = null,\
				7 = null,\
				8 = list(/mob/Pokemon/Larvitar, /mob/Pokemon/Nidoking, /mob/Pokemon/Nidoqueen)
			)
			WaterPokemon = list(/mob/Pokemon/Magikarp = 10,/mob/Pokemon/Wooper = 10)
			ArenaType = "MountainCave"
			Sounds = 'Route BL.mid'
			luminosity = 1
		Route308//South of Skysight
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Ekans, /mob/Pokemon/Zigzagoon, /mob/Pokemon/Poochyena, /mob/Pokemon/Mankey, /mob/Pokemon/Ledyba),\
				2 = list(/mob/Pokemon/Pidgey, /mob/Pokemon/Taillow = 20),\
				3 = list(/mob/Pokemon/Butterfree, /mob/Pokemon/Seedot),\
				4 = list(/mob/Pokemon/Tangela,/mob/Pokemon/Lickitung, /mob/Pokemon/Ralts = 50,/mob/Pokemon/Zangoose,/mob/Pokemon/Seviper),\
				5 = list(/mob/Pokemon/Shuckle,/mob/Pokemon/Bedrill),\
				6 = null,\
				7 = null,\
				8 = list(/mob/Pokemon/Larvitar, /mob/Pokemon/Nidoking, /mob/Pokemon/Nidoqueen)\
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Ekans, /mob/Pokemon/Zigzagoon, /mob/Pokemon/Poochyena, /mob/Pokemon/Mankey, /mob/Pokemon/Ledyba),\
				2 = list(/mob/Pokemon/Pidgey),\
				3 = list(/mob/Pokemon/Butterfree),\
				4 = list(/mob/Pokemon/Tangela,/mob/Pokemon/Lickitung, /mob/Pokemon/Golbat,/mob/Pokemon/Zangoose,/mob/Pokemon/Seviper),\
				5 = list(/mob/Pokemon/Persian),\
				6 = null,\
				7 = null,\
				8 = list(/mob/Pokemon/Larvitar, /mob/Pokemon/Nidoking, /mob/Pokemon/Nidoqueen)
			)
			WaterPokemon = list(/mob/Pokemon/Tentacool,/mob/Pokemon/Magikarp,/mob/Pokemon/Wooper,/mob/Pokemon/Wailmer)
			Sounds = 'Route 1.mid'
		Acconna_Desert
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Sandshrew, /mob/Pokemon/Cubone, /mob/Pokemon/Cacnea, /mob/Pokemon/Paras),\
				2 = list(/mob/Pokemon/Doduo, /mob/Pokemon/Yanma),\
				3 = list(/mob/Pokemon/Vibrava, /mob/Pokemon/Shuckle, /mob/Pokemon/Bedrill),\
				4 = list(/mob/Pokemon/Trapinch,/mob/Pokemon/Makuhita),\
				5 = list(/mob/Pokemon/Shuckle,/mob/Pokemon/Bedrill,/mob/Pokemon/Baltoy),\
				6 = null,\
				7 = null,\
				8 = list(/mob/Pokemon/Larvitar, /mob/Pokemon/Nidoking, /mob/Pokemon/Nidoqueen)\
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Sandshrew, /mob/Pokemon/Cubone, /mob/Pokemon/Cacnea, /mob/Pokemon/Paras),\
				2 = list(/mob/Pokemon/Doduo, /mob/Pokemon/Yanma),\
				3 = list(/mob/Pokemon/Vibrava, /mob/Pokemon/Shuckle, /mob/Pokemon/Bedrill),\
				4 = list(/mob/Pokemon/Trapinch,/mob/Pokemon/Makuhita),\
				5 = list(/mob/Pokemon/Shuckle,/mob/Pokemon/Bedrill,/mob/Pokemon/Baltoy),\
				6 = null,\
				7 = null,\
				8 = list(/mob/Pokemon/Larvitar, /mob/Pokemon/Nidoking, /mob/Pokemon/Nidoqueen)\
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'
		Ninja_Pass//by Valley of the Hidden Ninja
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Sandshrew, /mob/Pokemon/Cubone, /mob/Pokemon/Machop, /mob/Pokemon/Mankey),\
				2 = list(/mob/Pokemon/Spoink, /mob/Pokemon/Numel,/mob/Pokemon/Meowth,/mob/Pokemon/Meditite),\
				3 = list(/mob/Pokemon/Nincada, /mob/Pokemon/Growlithe, /mob/Pokemon/Bedrill),\
				4 = list(/mob/Pokemon/Farfetchd,/mob/Pokemon/Makuhita,/mob/Pokemon/Solrock),\
				5 = list(/mob/Pokemon/Shuckle,/mob/Pokemon/Bedrill),\
				6 = null,\
				7 = null,\
				8 = null,\
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Sandshrew, /mob/Pokemon/Cubone, /mob/Pokemon/Machop, /mob/Pokemon/Mankey),\
				2 = list(/mob/Pokemon/Spoink, /mob/Pokemon/Numel,/mob/Pokemon/Meowth,/mob/Pokemon/Meditite),\
				3 = list(/mob/Pokemon/Nincada, /mob/Pokemon/Growlithe, /mob/Pokemon/Bedrill),\
				4 = list(/mob/Pokemon/Farfetchd,/mob/Pokemon/Makuhita,/mob/Pokemon/Lunatone),\
				5 = list(/mob/Pokemon/Shuckle,/mob/Pokemon/Bedrill),\
				6 = null,\
				7 = null,\
				8 = null,\
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'
		Burning_Path
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Vulpix,/mob/Pokemon/Slugma),\
				2 = list(/mob/Pokemon/Numel,/mob/Pokemon/Koffing,/mob/Pokemon/Grimer),\
				3 = list(/mob/Pokemon/Ponyta, /mob/Pokemon/Growlithe, /mob/Pokemon/Houndour),\
				4 = list(/mob/Pokemon/Torkoal,/mob/Pokemon/Solrock),\
				5 = list(/mob/Pokemon/Magby),\
				6 = null,\
				7 = null,\
				8 = null,\
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Vulpix,/mob/Pokemon/Slugma),\
				2 = list(/mob/Pokemon/Numel,/mob/Pokemon/Koffing,/mob/Pokemon/Grimer),\
				3 = list(/mob/Pokemon/Ponyta, /mob/Pokemon/Growlithe, /mob/Pokemon/Houndour),\
				4 = list(/mob/Pokemon/Torkoal,/mob/Pokemon/Lunatone),\
				5 = list(/mob/Pokemon/Magby),\
				6 = null,\
				7 = null,\
				8 = null,\
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'
		Polar_Ice_Path
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Swinub,/mob/Pokemon/Zubat),\
				2 = list(/mob/Pokemon/Sneasel,/mob/Pokemon/Golbat),\
				3 = list(/mob/Pokemon/Smoochum = 50,/mob/Pokemon/Dunsparce),\
				4 = list(/mob/Pokemon/Snorunt,/mob/Pokemon/Piloswine = 30),\
				5 = list(/mob/Pokemon/Misdreavus),\
				6 = list(/mob/Pokemon/Sableye = 50),\
				7 = list(/mob/Pokemon/Mawile = 50),\
				8 = list(/mob/Pokemon/Nosepass = 25),\
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Swinub,/mob/Pokemon/Zubat),\
				2 = list(/mob/Pokemon/Sneasel,/mob/Pokemon/Golbat),\
				3 = list(/mob/Pokemon/Smoochum = 50,/mob/Pokemon/Dunsparce),\
				4 = list(/mob/Pokemon/Snorunt,/mob/Pokemon/Piloswine = 30),\
				5 = list(/mob/Pokemon/Misdreavus),\
				6 = list(/mob/Pokemon/Sableye = 50),\
				7 = list(/mob/Pokemon/Mawile = 50),\
				8 = list(/mob/Pokemon/Nosepass = 25),\
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'
		Route309 //Below Whitereach (Ice Town)
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Swinub,/mob/Pokemon/Zigzagoon),\
				2 = list(/mob/Pokemon/Sneasel,/mob/Pokemon/Golbat),\
				3 = list(/mob/Pokemon/Smoochum = 50,/mob/Pokemon/Dunsparce),\
				4 = list(/mob/Pokemon/Snorunt,/mob/Pokemon/Piloswine = 30),\
				5 = list(/mob/Pokemon/Misdreavus),\
				6 = list(/mob/Pokemon/Sableye = 50),\
				7 = list(/mob/Pokemon/Mawile = 50),\
				8 = list(/mob/Pokemon/Nosepass = 25),\
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Swinub,/mob/Pokemon/Zubat),\
				2 = list(/mob/Pokemon/Sneasel,/mob/Pokemon/Golbat),\
				3 = list(/mob/Pokemon/Smoochum = 50,/mob/Pokemon/Dunsparce),\
				4 = list(/mob/Pokemon/Snorunt,/mob/Pokemon/Piloswine = 30),\
				5 = list(/mob/Pokemon/Misdreavus),\
				6 = list(/mob/Pokemon/Sableye = 50),\
				7 = list(/mob/Pokemon/Mawile = 50),\
				8 = list(/mob/Pokemon/Nosepass = 25),\
			)
			WaterPokemon = list()
			Sounds = 'Route 1.mid'
		Route310 //Above Fighting City
			DayPokemon = list(\
				1 = list(/mob/Pokemon/Machop),\
				2 = list(/mob/Pokemon/Meditite, /mob/Pokemon/Breloom),\
				3 = list(/mob/Pokemon/Tyrogue = 50,/mob/Pokemon/Mankey,/mob/Pokemon/Heracross),\
				4 = list(/mob/Pokemon/Makuhita),\
				5 = list(),\
				6 = list(),\
				7 = list(),\
				8 = list(),\
			)
			NightPokemon = list(\
				1 = list(/mob/Pokemon/Machop),\
				2 = list(/mob/Pokemon/Meditite, /mob/Pokemon/Breloom),\
				3 = list(/mob/Pokemon/Tyrogue = 50,/mob/Pokemon/Mankey,/mob/Pokemon/Heracross),\
				4 = list(/mob/Pokemon/Makuhita),\
				5 = list(),\
				6 = list(),\
				7 = list(),\
				8 = list(),\
			)
			WaterPokemon = list(/mob/Pokemon/Poliwag,/mob/Pokemon/Tentacool,/mob/Pokemon/Poliwrath)
			Sounds = 'Route 1.mid'
		Orange_Bay //Route 302//------------------------------------------------------------------------------------------------------
			probability = 30
		/*	DayPokemon = list()
			NightPokemon = list()
			WaterPokemon = list(\
				1 = list(/mob/Pokemon/Magikarp,/mob/Pokemon/Poliwag = 15),\
				2 = list(/mob/Pokemon/Tentacool = 15,/mob/Pokemon/Tentacruel = 25),\
				4 = list(/mob/Pokemon/Staryu = 15, /mob/Pokemon/Chinchou = 20, /mob/Pokemon/Remoraid = 15),\
				5 = list(/mob/Pokemon/Shellder = 20, /mob/Pokemon/Qwilfish = 20, /mob/Pokemon/Carvanha = 15 ),\
			)
			CSU = /obj/Battling/Court_Set_Up/Lake
			Sounds = 'Route BL.mid'*/
