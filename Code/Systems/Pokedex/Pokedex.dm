var/PokemonNamesList[500]
var/obj/PokeballImage

world
	New()
		spawn(2)
		//Create the Buttons in the Pokedex List
			var/list/Pokemons = typesof(/mob/Pokemon)

			PokeballImage = new
			PokeballImage.icon_state = "Caught"
			PokeballImage.icon = 'Pokeballs.dmi'
			PokeballImage.name = null

			for(var/i in Pokemons)
				if(i == /mob/Pokemon/Unown) continue
				var/mob/Pokemon/P = new i
				var/list/Pokemon
				Pokemon = new/list //Has the entry been written?


				PokemonNamesList[P.Number] = P.name
				Pokemon["Name"] = P.name
				Pokemon["Weight"] = "[P.Weight] lbs"
				Pokemon["Height"] = P.Height
				Pokemon["Type1"] = P.Type1
				Pokemon["Type2"] = P.Type2
				Pokemon["DexInfo"] = P.DexInfo
				Pokemon["Gender"] = P.Gender
				Pokemon["Moves"] = P.LearnMoves.Copy()

				Pokedex_Entries[P.Number] = Pokemon.Copy()

			for(var/i = 1, i <= 386, i++)
				var/obj/Pokedex/ClickItemPokemon/CIP = new
				PokedexClickingItems[i] = CIP
				CIP.Num = i
				CIP.icon_state = "[i]"
				if(length(num2text(i)) == 1) CIP.name = "00[i]"
				else if(length(num2text(i)) == 2) CIP.name = "0[i]"
				else CIP.name = "[i]"
				CIP.Poke = PokemonNamesList[i]

			PokemonNamesList = null //?? Save Space, duh.


			..()

var/list/Pokedex_Entries[500]

mob/GM/verb/Set_Pokedex()
	set category = "Staff"
	if(istype(usr,/mob/Player))
		var/mob/Player/M = usr
		var/list/PokemonTypes = typesof(/mob/Pokemon)
		var/list/PokemonList = list()
		var/mob/Pokemon/Mother
		var/Poke
		for(var/i in PokemonTypes)
			Poke = copytext("[i]",14)
			PokemonList[Poke] = i
		var/input = input("Mother?") in PokemonList
		Poke = PokemonList[input]
		Mother = new Poke

		var/Percent = input("What Level? (1-10)") as num
		M.PokedexCompletetion[Mother.Number] = Percent
		ToggleC(M.PokedexRegion)
		del Mother

//Player Stats and Verbs//-------------------------------------------------------------------------------------
mob/
	verb/ToggleCompletion()
		set hidden = 1
		switch(PokedexRegion)
			if("Overall")
				PokedexRegion = "Johto"
				return ToggleC(PokedexRegion)
			if("Johto")
				PokedexRegion = "Kanto"
				return ToggleC(PokedexRegion)
			if("Kanto")
				PokedexRegion = "Overall"
				return ToggleC(PokedexRegion)
		ToggleC(PokedexRegion)
	var/PokedexRegion = "Overall"
	proc

		ToggleC(var/Region)
			var/mob/Player/P = usr
			if(!isPlayer(P)) return
			switch(Region)
				if("Overall") winset(P, "Pokedex.OverallC", "text='Overall Completion: [P.OverallCompletion()]%'")
				if("Johto") winset(P, "Pokedex.OverallC", "text='Johto Completion: [P.JohtoCompletion()]%'")
				if("Kanto") winset(P, "Pokedex.OverallC", "text='Kanto Completion: [P.KantoCompletion()]%'")
				if("Hoenn") winset(P, "Pokedex.OverallC", "text='Hoenn Completion: [P.HoennCompletion()]%'")

mob/Player/
	var
		PokedexCompletetion[386] //This will consist of a list of numbers, in which will equal a precentage of completetion.
		list/CaughtPokemon = list()


	proc
		KantoCompletion()
			var/
				Overall = 0
				Of = 0
			for(var/i = 1, i <= 151, i++)
				Overall += 10
				Of += PokedexCompletetion[i]
			if(!Of) return 0

			return round((Of/Overall)*100,0.01)
		JohtoCompletion()
			var/
				Overall = 0
				Of = 0
			for(var/i = 152, i <= 251, i++)
				Overall += 10
				Of += PokedexCompletetion[i]
			if(!Of) return 0
			return round((Of/Overall)*100,0.01)
		HoennCompletion()
			var/
				Overall = 0
				Of = 0
			for(var/i = 252, i <= 386, i++)
				Overall += 10
				Of += PokedexCompletetion[i]
			if(!Of) return 0
			return round((Of/Overall)*100,0.01)
		OverallCompletion()
			return round((JohtoCompletion() + KantoCompletion() + HoennCompletion()) / 3)
		GiveDexInfo(var/NUM, PR) //PR is to overide the probablity calculator.
			var/PROB = min(50,((((PokedexCompletetion[NUM] * 100) /10) * -1) + 100))
			if(PR) PROB = PR
			if(prob(PROB))



				PokedexCompletetion[NUM] = min(10, PokedexCompletetion[NUM] + 1)
				winset(src, "POKEDEXUPDATED", "is-visible=true")
			//Titles
			if(NUM == 31 && PokedexCompletetion[31] >= 10) //They've completed Nidoqueen's
				Titles += "Female Sign"
				src<<System("Female Sign Title awarded!")
			if(NUM == 34 && PokedexCompletetion[34] >= 10) //They've completed Nidoking's
				Titles += "Male Sign"
				src<<System("Male Sign Title awarded!")

			UpdatePokedexPokemonEntry(NUM)
		UpdatePokedexPokemonList()
			var/items = 0
			for(var/i = 1, i <= 386, i++)
				var/obj/Pokedex/ClickItemPokemon/CIP = PokedexClickingItems[i]
				winset(src, "PokedexPokemonList", "current-cell=1,[++items]")
				src << output(CIP, "PokedexPokemonList")
				winset(src, "PokedexPokemonList", "current-cell=2,[items]")
				src << output("[PokedexCompletetion[i] ? "[CIP.Poke]" : "???"]", "PokedexPokemonList")
				winset(src, "PokedexPokemonList", "current-cell=3,[items]")
				if(CaughtPokemon.Find(CIP.Poke)) src << output(PokeballImage, "PokedexPokemonList")
				else src << output("", "PokedexPokemonList")
			winset(src, "Items", "cells=3x[items]")	// cut off any remaining rows


		UpdatePokedexPokemonEntry(var/NUM)
			//Each Pokemon will have 10 points total.
			var/mob/Player/M = src
			var/Complete = PokedexCompletetion[NUM] //How much of the Pokedex Entry have they completed.
			var/list/Pokedex = Pokedex_Entries[NUM]
			var/DexInfo = "<body bgcolor=black><font size = 2 color = white>"
			var/list/DI = Pokedex["DexInfo"]
			var/list/Unvisible = list("DexIMAGE", "Type1", "Type2", "DexNUM", "BLUEBAR", "PINKBAR", "GENDER", "PERCENT", "DexWEIGHT", "DexHEIGHT", "MoveList", "DexINFO")
			for(var/i in Unvisible) winset(M, "Pokedex.[i]", "is-visible=false")
			if(!client) return
			winset(M, "Pokedex.DEXINFO", "is-visible=false")
			winset(M, "Pokedex.EntryC", "is-visible=true")

			winset(M, "Pokedex.EntryC", "text='Entry Completion: [Complete]0%'")
			ToggleC(M.PokedexRegion)
			OverallCompletion()
			for(var/i = 1, i <= min(10,Complete),i++)
				switch(i)
					if(1) //1 will allow them to read the Entries for Type, Number, and the Pokemon's name.

						//Types//======================
						var/Type1 = Pokedex["Type1"]
						var/Type2 = Pokedex["Type2"]
						var/list/Types = list("Normal" = "#A8A878","Fire" ="#F08030","Electric"="#F8D030","Water"="#6890F0","Ice"="#98D8D8","Rock"="#B8A038","Ground"="#E0C068","Flying"="#A890F0","Bug"="#A8B820","Grass"="#78C850","Psychic"="#F85888","Fighting"="#C03028","Steel"="#B8B8D0","Poison"="#A040A0","Ghost"="#705898","Dark"="#705848","Dragon"="#7038F8")
						if(Type1 && Type2)
							winset(M, "Pokedex.Type1", "is-visible=true")
							winset(M, "Pokedex.Type2", "is-visible=true")
							winset(M, "Pokedex.Type1", "size =83x20")
							winset(M, "Pokedex.Type1", "text='[Type1]'")
							winset(M, "Pokedex.Type1", "background-color=[Types[Type1]]")
							winset(M, "Pokedex.Type2", "text='[Type2]'")
							winset(M, "Pokedex.Type2", "background-color=[Types[Type2]]")
						else //Theres only 1 type
							winset(M, "Pokedex.Type1", "is-visible=true")
							winset(M, "Pokedex.Type1", "text='[Type1]'")
							winset(M, "Pokedex.Type1", "background-color=[Types[Type1]]")
							winset(M, "Pokedex.Type1", "size =168x20")
						//Name//=======================
						winset(M, "Pokedex.DexNAME", "is-visible=true")
						winset(M, "Pokedex.DexNAME", "text='[Pokedex["Name"]]'")
						//Number
						var/Number = NUM
						if(length(num2text(NUM)) == 1) Number = "00[NUM]"
						else if(length(num2text(NUM)) == 2) Number = "0[NUM]"
						else Number = "[NUM]"
						winset(M, "Pokedex.DexNUM", "is-visible=true")
						winset(M, "Pokedex.DexNUM", "text='[Number]'")
					if(2) //2 will show the picture of the Pokemon.
						winset(M, "Pokedex.DexIMAGE", "image='[NUM].png'")
						winset(M, "Pokedex.DexIMAGE", "is-visible=true")
					if(3) //3 Will Show Height, Weight, and Gender Ratio.
						var/Length = (Pokedex["Gender"] * 168)/100
						winset(M, "Pokedex.BLUEBAR", "is-visible=true")
						winset(M, "Pokedex.GENDER", "is-visible=true")
						winset(M, "Pokedex.BLUEBAR", "size =[Length]x20")
						winset(M, "Pokedex.PINKBAR", "is-visible=true")
						winset(M, "Pokedex.PERCENT", "is-visible=true")
						winset(M, "Pokedex.PERCENT", "text='[Pokedex["Gender"]] %'")
						winset(M, "Pokedex.DexHEIGHT", "is-visible=true")
						winset(M, "Pokedex.DexHEIGHT", "text='Height:  [Pokedex["Height"]]'")
						winset(M, "Pokedex.DEXWEIGHT", "is-visible=true")
						winset(M, "Pokedex.DexWEIGHT", "text='Weight:  [Pokedex["Weight"]]'")

					if(5) if(DI[1]) DexInfo += DI[1]//First Dex Info
					if(6) if(DI[2]) DexInfo += DI[2]//Second Dex Info
					if(7) if(DI[3]) DexInfo += DI[3]//Third Dex Info
					if(8) if(DI[4]) DexInfo += DI[4]//First Dex Info
					if(9) if(DI[5]) DexInfo += DI[5]//First Dex Info
					if(4) //Learn Moves and what levels they are learned at.
						var/list/Moves = Pokedex["Moves"]
						var/items
						winset(M, "Pokedex.MoveList", "is-visible=true")
						for(var/m in Moves)
							if(!ispath(m)) continue

							var/MoveName = "[m]" // /obj/HMs/
							if(findtext(MoveName,"Move")) MoveName = copytext(MoveName, 12)
							else MoveName = copytext(MoveName, 10)
							winset(src, "Pokedex.MoveList", "current-cell=1,[++items]")
							src << output(MoveName, "Pokedex.MoveList")
							winset(src, "Pokedex.MoveList", "current-cell=2,[items]")
							src << output("[Moves[m]]", "Pokedex.MoveList")
						winset(src, "Items", "cells=2x[items]")	// cut off any remaining rows

			winset(M, "Pokedex.DEXINFO", "is-visible=true")
			M<<output(DexInfo, "Pokedex.DEXINFO")

			//winset(M, "Pokedex.DexINFO", "text='[DexInfo]'")


	verb
		PokedexButton()
			set hidden = 1
			UpdatePokedexPokemonList()

			winset(usr,"PokedexPopup","is-visible=true")
			winset(usr,"PokedexButtonNEW","is-visible=false")
			DisplayHome() //HelpFiles


			ToggleC(usr.PokedexRegion)



var/list/PokedexClickingItems[386]
obj/Pokedex/ClickItemPokemon
	var/
		Num //The Pokemon's Number
		Poke //The Pokemons Name
	icon = 'PokedexIcons.dmi'
	Click()
		if(isPlayer(usr))
			var/mob/Player/P = usr
			P.UpdatePokedexPokemonEntry(src.Num, src.Poke)























