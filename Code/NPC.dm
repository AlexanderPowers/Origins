var/font = "<font color = blue>"
mob
	luminosity = 0
	var/Pointer
	New()
		if(Pointer)
			overlays += image('HUD.dmi',"Pointer")
			mouse_over_pointer = image('Pointer.dmi',"Speak")
		if(length(ClothingOverlays))
			ReAddClothing()
		..()

mob/NPC/
	var/list/DefaultResponses = list()
	var/list/PokedexHelpFiles = list() //"[What you say to get the file" = "The File Topic"]
	var/list/QuestsGiven = list() //"[What you say to get the Quest" = /Type/of/Quest] A response to have a quest added, then runs QuestCheck("Talk to [src")
	var/QuestMarker = 1

	Click()
		//Chat Options
		if(TalkingTo[usr.name]) return
		TalkingTo[usr.name] = 1
		var/mob/Player/P = usr
		if(!isPlayer(P) || get_dist(P,src) > 2)
			TalkingTo -= usr.name
			return

		if(!isPlayer(P)) return 0
		var/list/ChatOptions = list()//Default for each mob
		var/list/GivenResponses = GiveResponses(P)
		for(var/i in GivenResponses) ChatOptions[i] = "Generated"
		for(var/i in DefaultResponses) ChatOptions[i] = "Default"
		for(var/i in PokedexHelpFiles) ChatOptions[i] = "Pokedex"
		for(var/i in QuestsGiven) if(!P.QuestReturn(QuestsGiven[i])) ChatOptions[i] = "QuestGiven"

		var/list/QuestResponses = P.QuestChatResponses("Talk to [name]")
		if(islist(QuestResponses))
			for(var/i in QuestResponses)
				ChatOptions[i] = QuestResponses[i]   //"Response" = /Type/of/Quest

		//Make them turn to face the Player.
		ChatOptions += "Goodbye"
		dir = get_dir(src,P)
		spawn(75) dir = initial(dir)

		var/PR = input(P, "Talk to [name]") in ChatOptions //Player's Response
		//If its a Quest Chat//------------------------------------------
		//See if it adds a Quest first
		if(ispath(QuestsGiven[PR]) && ChatOptions[PR] == "QuestGiven")
			P.QuestAdd(QuestsGiven[PR])
			ChatOptions[PR] = QuestsGiven[PR]
		if(ispath(ChatOptions[PR]))  //This means it is a type, and so far only Quests go through as a type.
			P.SpecificQuestCheck(ChatOptions[PR], "Talk to [name]", src)
		//---------------------------------------------------------------
		//If its a Default Action or PokedexHelpfile
		ChatResponses(PR, P)

		TalkingTo -= usr.name



	proc/ChatResponses(var/Response, var/mob/Player/P)
		//Pokedex Help File given.
		if(PokedexHelpFiles.Find(Response))
			var/Topic = PokedexHelpFiles[Response]
			if(P.UnlockedHelpFiles.Find(Topic))
				if(P) P.ScrollText(src, "You should look at that Pokedex Help File I gave you on [Topic]?",Portrait)
			else
				if(P) P.ScrollText(src, "Here, take a look at this Pokedex Help File.",Portrait)
				P.PokedexUnlock(Topic)

	proc/GiveResponses(var/mob/Player/P)
		//Checks to see if any responses needed to be added to the Diaglouge Options
		//Returns List
		//Will run through Chat Responses




//What you need to Copy and Paste for new NPC//
/*
mob/NPC/
	DefaultResponses = list("Make Small Chat")
	PokedexHelpFiles = list() //"[What you say to get the file" = "The File Topic"]
	QuestsGiven = list() //This changes each time someone talks to them. Just to track Quest responses through procs.


	ChatResponses(var/Response, var/mob/Player/P)
		..()
		switch(Response)

*/

//LIST OF ALL NPCS//-------------------------------------------------------------------------------------------------------------------------
mob/NPC/Nurse_Joy
	icon = 'MaleWhiteBase.dmi'
	var/DieLocYes = 0
	ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Joy Robe", "Hair" = "JoyHairPink","Hood" = "Joy Hat")
	Pointer = 1
	DefaultResponses = list("Can you heal my Pokemon?")
	PokedexHelpFiles = list("Where am I?" = "Pokemon Centers") //"[What you say to get the file" = "The File Topic"]
	QuestsGiven = list() //This changes each time someone talks to them. Just to track Quest responses through procs.

	ChatResponses(var/Response, var/mob/Player/P)
		..()
		switch(Response)
			if("Can you heal my Pokemon?")
				P.ScrollText(src, "We can heal your Pokemon to full health. Let me see your Pokemon.",'Nurse Joy.png')
				if(DieLocYes) P.DieLoc = CoordsToNum(x,y-1,z)
				P << 'Heal.mid'
				sleep(20)
				if(!P) return
				P.HealAll()
				P.frozen = 0


mob/NPC
	icon = 'NPC.dmi'
	Pointer = 1
	ClothingOverlays = 0
	Pokedex_Unlock_NPC //These NPCs stand in the world, and if you speak to them, they give you a help file.
		icon = 'MaleWhiteBase.dmi'
		New()
			set background = 1

			var/list/TrainerSprites = list('Bugcatcher1.png', 'BlackBelt.png', 'Engineer.png', 'Picnicker1.png', 'Scientist.png')

			if(name == TopicGiven) name = "Civilian"
			if(!ClothingOverlays) ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "[pick("Blue", "Pink", "Green", "Red")] Civilian Clothes", "Hair" = "[pick("BrandonHair","LongHair","BirchHair","PonytailHair","ComboverHair","MayHair")][pick("Black","Blonde","Brown")]")
			if(!Portrait) Portrait = pick(TrainerSprites)
			..()
			spawn()
				if(prob(50)) return
				while(src)
					dir = pick(1,2,4,8)
					sleep(rand(1,450))
		var/TopicGiven
		var/Message
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(usr)) return
			if(P.UnlockedHelpFiles.Find(TopicGiven))
				P.ScrollText(src, "Have you read that Pokedex file I gave you?")
			else
				P.ScrollText(src, Message)
				P.PokedexUnlock(TopicGiven)
		//Different Types
		Badges_and_Ribbons
			Message = "Have you ever considered being a Pokemon Trainer or Pokemon Coordinator? Trainers set out accross Joleon collecting Badges so they can compete in the Pokemon League! Check out that poster over there."
			TopicGiven = "Badges and Ribbons"
		Name_Rater
			Message = "I just had my Pokemon's name rated! Apparently the name ''Cruelella'' is a develishly good name. You should visit the name rater. He lives in Ridgeport."
			TopicGiven = "Name Rater"


	Mom// Bank/Teller
		icon = 'NPC.dmi'
		icon_state = "MomWhite"
		invisibility = 1 //This icon is set when the person logs in.
		Pointer = 1
		Click()
			if(TalkingTo["PlayerMom"]) return
			TalkingTo["PlayerMom"] = 1
			var/mob/Player/P = usr
			if(!isPlayer(P) || get_dist(P,src) > 2)
				TalkingTo -= "PlayerMom"
				return
			//Define the skin
			P.QuestCheck("Talk to Banker")
			var/Skin = 'MomWhite.png'
			if(icon == 'MaleBlackBase.dmi' || icon == 'MaleDoubleBlackBase.dmi') Skin = 'MomBlack.png'

			P.ScrollText(src, "[P]! Glad to see you came to visit your mother!",Skin)
			if(P.QuestCheck("Talk to PlayerMom", Skin))
				TalkingTo["PlayerMom"] = 0
				return
			Start
			var/INPUT = input(P,"Mom: What can I do for you today?","Mom the Banker","Bye Mom") in list("Withdraw Money", "Deposit Money", "Change Saving Percentage", "Bye Mom")

			switch(INPUT)
				if("Bye Mom")
					TalkingTo["PlayerMom"] = 0
					return
				if("Withdraw Money")
					var/Withdraw = input(P,"Mom: How much would you like to Withdraw? You currently have [P.MomBank].","Mom the Banker") as num
					if(Withdraw < 1 || Withdraw > P.MomBank)
						P.ScrollText(src, "I am really sorry [P], but I cannot do that!",Skin)
						goto Start
					P.MomBank -= Withdraw
					P.Money += Withdraw
					P<<System("[Withdraw] withdrawn from saved funds.")
					P.ScrollText(src, "Spend wisely!",Skin)
					goto Start
				if("Deposit Money")
					var/Deposit = input(P,"Mom: How much would you like to Deposit? You currently have [P.Money].","Mom the Banker") as num
					if(Deposit < 1 || Deposit > P.Money)
						P.ScrollText(src, "I am really sorry [P], but I cannot do that!",Skin)
						goto Start
					P.MomBank += Deposit
					P.Money -= Deposit
					P<<System("[Deposit] deposited into funds.")
					P.ScrollText(src, "Spend wisely!",Skin)
					goto Start
				if("Change Saving Percentage")
					var/list/Percents = list("0%" = 0,"5%" = 5,"10%"= 10,"15%" = 15,"20%" = 20,"25%" = 25,"30%" = 30)
					P.MomPercent = input(P,"Mom: How much of your money should I save?","Mom the Banker","15%") in list("0%","5%","10%","15%","20%","25%","30%")
					P.MomPercent = Percents[P.MomPercent]
					if(P.MomPercent) P.ScrollText(src, "Alright, I will save [P.MomPercent] percent of your money.",Skin)
					goto Start





			usr.TalkingTo -= "PlayerMom"


	Move_Relearner
		icon = 'NPC.dmi'
		icon_state = "MoveRelearner"
		Click()
			set src in oview(2)
			if(usr.TalkingTo.Find("MoveRelearner")) return
			TalkingTo += "MoveRelearner"
			//usr.ScrollText(src, "Hello! I am the master of Pokemon attacks.")
			//usr.ScrollText(src, "One of my most well known talents though, is reteaching Pokemon attacks they have forgotten or had the chance to learn and did not. For a mere 500 Pokedollars, I can reteach an attack to one of your Pokemon!")

			if(usr.Money < 500)
				usr.ScrollText(src, "However, it seems you do not have enough money to use my services. You should return when you do.")
				return
			else
				var/mob/Pokemon/P = usr.Party_Choose("Which Pokemon should relearn a move?")
				if(!P)
					usr.ScrollText(src, "Come back soon!")
					usr.TalkingTo -= "MoveRelearner"
					return

				var/list/Attacks = list()
				Finding_Attack:
					for(var/m in P.NoMoves)

						for(var/obj/o in P.Moves)
							if(istype(o,m))
								continue Finding_Attack

						var/T = "[m]"
						T = Replace_Character(T,"_"," ")
						Attacks["[copytext(T,12)]"] = m
				if(!length(Attacks))
					usr.ScrollText(src, "Come back soon!")
					usr.TalkingTo -= "MoveRelearner"
					return
				//	usr.ScrollText(src, "Which attack would you like [P] to relearn?")
				var/Attack = input("Which attack would you like to relearn?") in Attacks
				usr.ScrollText(src, "I think I could get [P] to relearn [Attack], but its going to cost you 500 Pokedollars.")
				var/TYPE = Attacks[Attack]
				if(alert("Reteach [Attack] to [P]?","Move Relearner","Yes","No") == "Yes")

					if(P.Moves.len >= 6) //It checks to make sure there is room to add another move, if not we have to delete one.
						if(usr)
							if(usr && usr.client) del input(usr,"Forget which move?") in P.Moves


							if(FindType(P.Moves, TYPE))
								usr.TalkingTo -= "MoveRelearner"
								return 0
							var/obj/Moves/MMM = new TYPE
							P.Moves += MMM
							MMM.Owner = P
						else return
					else
						if(FindType(P.Moves, TYPE))
							usr.TalkingTo -= "MoveRelearner"
							return 0
						var/obj/Moves/MMM = new TYPE
						P.Moves += MMM
						MMM.Owner = P

					usr<<System("[P] has learned [Attack]")


					usr.Money -= 500
					usr.TalkingTo -= "MoveRelearner"
				else
					usr.ScrollText(src, "Come back soon!")
					usr.TalkingTo -= "MoveRelearner"
					return






	HairDresser
		icon = 'MaleWhiteBase.dmi'
		Click()
			if(get_dist(src,usr) >= 3) return
			var/colour
			var/style = input("Hairdresser: I know every Style in the book. Which book is this? Well...I'm not really sure.","Style, You have [usr.Money]")in list("May","Gary","Brandon","Long","Oak","Punk","Flat","Spike","Cassidy","Birch","Combover","Star","Bald","Cancel")
			if(!usr) return
			switch(style)
				if("Cancel") return
				if("Bald")
					if(usr.ClothingOverlays["Hair"])
						usr.RemoveSection("Hair")
					return

				if("May")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde", "Cancel")
				if("Gary")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde", "Cancel")
				if("Oak")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde", "Cancel")
				if("Brandon")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "White","Cancel")
				if("Combover")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde", "Cancel")
				if("Long")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde","Blue","Cancel")
				if("Cassidy")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde","Cancel")

				if("Flat")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?" ,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde", "Cancel")
				if("Birch")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde", "Cancel")
				if("Spike")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Blonde", "Cancel")
				if("Star")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Brown", "Blonde", "Cancel")
				if("Punk")
					colour = input("Hairdresser: Ok, the [style] hairstyle, nice choice. Which Colour?"	,"Colour, You have [usr.Money]") in list("Black", "Brown", "Pink", "Green", "Cancel")

			if(colour == "Cancel" || !colour) return
			usr.overlays -= image('Hair.dmi' , usr.ClothingOverlays["Hair"])
			usr.ClothingOverlays["Hair"] = "[style]Hair[colour]"
			usr.ReAddClothing()
	Shopkeeper
		icon = 'MaleWhiteBase.dmi'
		dir = 4
		ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Blue Civilian Clothes", "Hair" = "ComboverHairBrown", "Hood" = "Apron")

		Bloomsberry_Lake_Shopkeeper
			Selling = list(/obj/Balls/Poke_Ball = 200,/obj/Balls/Net_Ball = 200, /obj/Balls/Great_Ball = 600,/obj/ShopItems/Stackable/Potions/Potion = 300, /obj/ShopItems/Stackable/Potions/Super_Potion = 600, /obj/ShopItems/Stackable/Status_Cleanse/Antidote = 200, /obj/ShopItems/Stackable/Status_Cleanse/Awakening = 250, /obj/ShopItems/Stackable/Status_Cleanse/Parlyz_Heal = 250)
		Net_City_Shopkeeper
			Selling = list(/obj/Balls/Poke_Ball = 200,/obj/Balls/Great_Ball = 600,/obj/ShopItems/Stackable/Potions/Potion = 300, /obj/ShopItems/Stackable/Potions/Super_Potion = 600, /obj/ShopItems/Stackable/Status_Cleanse/Antidote = 200, /obj/ShopItems/Stackable/Status_Cleanse/Awakening = 250, /obj/ShopItems/Stackable/Status_Cleanse/Parlyz_Heal = 250)
		Elkvale_Shopkeeper
			Selling = list(/obj/Balls/Poke_Ball = 200, /obj/Balls/Net_Ball = 200,/obj/Balls/Great_Ball = 600,/obj/ShopItems/Stackable/Potions/Potion = 300, /obj/ShopItems/Stackable/Potions/Super_Potion = 600, /obj/ShopItems/Stackable/Status_Cleanse/Antidote = 200, /obj/ShopItems/Stackable/Status_Cleanse/Awakening = 250, /obj/ShopItems/Stackable/Status_Cleanse/Parlyz_Heal = 250)
		RS_Department_Store_F1
			name = "Shopkeepr"
			Selling = list(/obj/Balls/Poke_Ball = 200, /obj/Balls/Great_Ball = 600,/obj/ShopItems/Stackable/Potions/Potion = 300, /obj/ShopItems/Stackable/Potions/Super_Potion = 600, /obj/ShopItems/Stackable/Status_Cleanse/Antidote = 200, /obj/ShopItems/Stackable/Status_Cleanse/Awakening = 250, /obj/ShopItems/Stackable/Status_Cleanse/Parlyz_Heal = 250)
		RS_Department_Store_F2
			name = "Evolution Stone Shopkeeper"
			Selling = list(\
				/obj/Stones/Firestone = 3000,\
				/obj/Stones/Leafstone = 3000,\
				/obj/Stones/Thunderstone = 3000,\
				/obj/Stones/Waterstone = 3000,\
				)
		RS_Department_Store_F3_1
			name = "TM Shopkeeper"
			Selling = list(\
				/obj/Machine/TM/TM_Fire_Punch = 4500,\
				/obj/Machine/TM/TM_Thunder_Punch = 4500,\
				/obj/Machine/TM/TM_Ice_Punch = 4500,\
				/obj/Machine/TM/TM_Agility = 6000,\
				/obj/Machine/TM/TM_Rock_Slide = 5000,\
				/obj/Machine/TM/TM_Thunderwave = 5000,\
				/obj/Machine/TM/TM_Fire_Blast = 9999,\


			)
		var/list/Selling = list(/obj/Balls/Poke_Ball = 200)
		proc/Buy()
			var/list/ForSale = list("Cancel")
			for(var/i in Selling)
				var/obj/O = new i
				O.Price = Selling[i]
				ForSale["[O.name]   [O.Price]"] = O
			var/obj/O = input("What would you like today?") in ForSale
			if(O == "Cancel") return
			O = ForSale[O]
			var/Boughtamount = 1
			if(O.Stackable)
				Boughtamount = round(max(0,min(99,input(usr, "Buy how Many?") as num)))
				O.Amount = Boughtamount
			if(!usr) return
			if(usr.Money >= O.Price*Boughtamount)
				if(get_dist(src,usr) >= 3)
					return 0
				usr.Money -= O.Price*Boughtamount
				O.take(usr)

			else
				usr<<"You don't have enough money for that!"
			if(get_dist(src,usr) <= 2) Buy()
		Click()
			if(get_dist(src, usr) <= 2)
				Buy()
	Event_Token_Exchange
		icon = 'MaleWhiteBase.dmi'
		Held_Item_Exchange
			dir = 4
			Selling = list(/obj/HeldItems/Stat_Enhance/DeepSeaScale = 90,/obj/HeldItems/Stat_Enhance/DeepSeaTooth = 90,/obj/HeldItems/Evolution/Dragon_Scale = 90,/obj/HeldItems/Evolution/Kings_Rock = 100,/obj/HeldItems/Evolution/Metal_Coat = 100,/obj/HeldItems/Evolution/Prism_Scale = 90,/obj/HeldItems/Evolution/Up_Grade = 90,/obj/HeldItems/Evolution/Everstone = 75)
		Evolution_Stone_Exchange
			dir = 4
			Selling = list(/obj/Stones/Firestone = 50,/obj/Stones/Waterstone = 50,/obj/Stones/Leafstone = 50,/obj/Stones/Thunderstone = 50,/obj/Stones/Sunstone = 75,/obj/Stones/Moonstone = 60)
		TM_Exchange
			dir = 1
			Selling = list(/obj/Machine/TM/TM_Bullet_Seed = 150,/obj/Machine/TM/TM_Dream_Eater = 200,/obj/Machine/TM/TM_Metronome = 150,/obj/Machine/TM/TM_Reflect = 125,/obj/Machine/TM/TM_Selfdestruct = 150,/obj/Machine/TM/TM_Shadow_Ball = 200,/obj/Machine/TM/TM_Softboiled = 100,/obj/Machine/TM/TM_Swords_Dance = 300,/obj/Machine/TM/TM_Take_Down = 175,/obj/Machine/TM/TM_Thunderbolt = 175)
		Other_Exchange
			dir = 1
			Selling = list(/obj/Balls/Poke_Ball = 5,/obj/Balls/Great_Ball = 10,/obj/Balls/Ultra_Ball = 20)
		Clothing_Exchange
			dir = 3
			Selling = list(/obj/Clothing/Jumpsuit/Blue_Jumpsuit = 50,/obj/Clothing/Jumpsuit/Green_Jumpsuit = 50,/obj/Clothing/Jumpsuit/Black_Jumpsuit = 50,/obj/Clothing/Jumpsuit/Female_Blue_Jumpsuit = 50,/obj/Clothing/Jumpsuit/Female_Green_Jumpsuit = 50,/obj/Clothing/Jumpsuit/Female_Black_Jumpsuit = 50,/obj/Clothing/Accesories/Blue_Bandana = 30,/obj/Clothing/Accesories/Green_Bandana = 30,/obj/Clothing/Accesories/Black_Bandana = 30,/obj/Clothing/Accesories/Blue_Headband = 30,/obj/Clothing/Accesories/Green_Headband = 30,/obj/Clothing/Accesories/Black_Headband = 30,/obj/Clothing/Shoes/Blue_Shoes = 25,/obj/Clothing/Shoes/Brown_Shoes = 25,/obj/Clothing/Shoes/Black_Shoes = 25)
		var/list/Selling = list(/obj/Balls/Poke_Ball = 5)
		proc/Token_Buy()
			var/list/ForSale = list("Cancel")
			for(var/i in Selling)
				var/obj/O = new i
				O.Price = Selling[i]
				ForSale["[O.name]   [O.Price]"] = O
			var/obj/O = input("What would you like today?") in ForSale
			if(O == "Cancel") return
			O = ForSale[O]
			var/Boughtamount = 1
			if(!usr) return
			if(usr.Event_Tokens >= O.Price*Boughtamount)
				if(get_dist(src,usr) >= 3)
					return 0
				usr.Event_Tokens -= O.Price*Boughtamount
				O.take(usr)

			else
				usr<<"You don't have enough tokens for that!"
			if(get_dist(src,usr) <= 2) Token_Buy()
		Click()
			if(get_dist(src, usr) <= 2)
				Token_Buy()
	Pokemon_Exchange
		icon = 'MaleWhiteBase.dmi'
		icon_state = "trainer2"
		dir = 3
		Click()
			var/mob/Player/M = usr
			var/Poke
			if(!isPlayer(M)) return
			if(usr) usr.ScrollText(src, "Hello, I am the Event Token Pokemon Exchange Counter.")
			if(usr) usr.ScrollText(src, "What can I help you with today?")
			var/Pokemon = input("Pokemon_Exchange: Which Pokemon do you want?.","Pokemon")in list("Eevee - 350","Mr. Mime - 250","Larvitar - 450","Dratini - 500","Abra - 300","Kangaskhan - 250","Clefairy - 100","Wobbuffet - 100","Snubbull - 150","Feebas - 200","Bagon - 500","Chansey - 150","Smoochum - 200","Beldum - 450","Cancel")
			switch(Pokemon)
				if("Cancel") return
				if("Eevee - 350")
					if(usr.Event_Tokens >= 350)
						Poke = /mob/Pokemon/Eevee
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 350
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Mr. Mime - 250")
					if(usr.Event_Tokens >= 250)
						Poke = /mob/Pokemon/MrMime
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 250
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Larvitar - 450")
					if(usr.Event_Tokens >= 450)
						Poke = /mob/Pokemon/Larvitar
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Gender = "Male"
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 450
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Dratini - 500")
					if(usr.Event_Tokens >= 500)
						Poke = /mob/Pokemon/Dratini
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Gender = "Male"
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 500
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Abra - 300")
					if(usr.Event_Tokens >= 300)
						Poke = /mob/Pokemon/Abra
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 300
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Kangaskhan - 250")
					if(usr.Event_Tokens >= 250)
						Poke = /mob/Pokemon/Kangaskhan
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 250
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Clefairy - 100")
					if(usr.Event_Tokens >= 100)
						Poke = /mob/Pokemon/Clefairy
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 100
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Wobbuffet - 100")
					if(usr.Event_Tokens >= 100)
						Poke = /mob/Pokemon/Wobbuffet
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 100
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Snubbull - 150")
					if(usr.Event_Tokens >= 150)
						Poke = /mob/Pokemon/Snubbull
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 150
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Feebas - 200")
					if(usr.Event_Tokens >= 200)
						Poke = /mob/Pokemon/Feebas
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 200
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Bagon - 500")
					if(usr.Event_Tokens >= 500)
						Poke = /mob/Pokemon/Bagon
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Gender = "Male"
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 500
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Chansey - 150")
					if(usr.Event_Tokens >= 150)
						Poke = /mob/Pokemon/Chansey
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 150
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Smoochum - 200")
					if(usr.Event_Tokens >= 200)
						Poke = /mob/Pokemon/Smoochum
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 200
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return
				if("Beldum - 450")
					if(usr.Event_Tokens >= 450)
						Poke = /mob/Pokemon/Beldum
						if(!M.AddPKMNParty())
							if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
							return
						var/mob/Pokemon/P = new Poke(null)
						M.Party[M.AddPKMNParty()] = P
						P.Owner = M.ckey
						P.Create(10)

						P.Ball = new/obj/Balls/Poke_Ball
						var/obj/Balls/B = P.Ball
						B.name = html_encode(P.name)
						B.Pokemon = P
						M.CaughtPokemon += initial(P.name)
						M.GiveDexInfo(P.Number)
						M.UpdateParty()
						M.Title_Check()
						usr.Event_Tokens -= 450
					else
						if(usr) usr.ScrollText(src, "You dont have enough tokens for that")
						return






	Name_Rater
		icon = 'MaleWhiteBase.dmi'
		Click()
			var/mob/Player/M = usr
			if(!isPlayer(M)) return
			if(usr) usr.ScrollText(src, "Hello, welcome to my house. I am the one and only Name Rater in the Joleon Region. Therefore, I am the best Name Rater in the Joleon Region.")
			if(usr) usr.ScrollText(src, "Shall I rate one of your Pokemons names?")
			if(!usr) return
			var/mob/Pokemon/P = M.Party_Choose("Teach to which Pokemon",M.Party)
			if(usr) usr.ScrollText(src, "[P]? Well, that is an okay name. By all standards, its decent, but so boring and normal. Perhaps you would want to rename it?")
			var/NewName = input(M,"Rename [P]") as text
			if(istype(P.Ball,/obj/Balls/Egg))
				if(usr) usr.ScrollText(src, "Wait.. you want me to rename your egg? What are you, insane?!")
				return
			if(!NewName)
				if(usr) usr.ScrollText(src, "Every Pokemon deserves a name! Come now!")
				return
			if(length(NewName) >= 20)
				if(usr) usr.ScrollText(src, "[NewName]? No no, that name is much to long. You obviously have no talent as a Name Rater.")
				return
			else
				if(usr) usr.ScrollText(src, "[NewName]? Yes! I love it! Its creative and new, whilst showing all the qualities of every name I have heard through my years. From now on [P] will be known as [NewName]!")
				P.name = html_encode(NewName)
				P.Ball.name = html_encode(NewName)


	Fossil_Scientist
		icon = 'NPC.dmi'
		icon_state = "Assistant2"
		Click()
			var/mob/Player/M = usr
			var/Poke
			if(!isPlayer(M)) return
			if(usr) usr.ScrollText(src, "Hello, I am an expert scientist who has found a way to revive fossils.")
			if(usr) usr.ScrollText(src, "Do you have a fossil you would like me to revive for you?")
			var/Fossil = "None"
			for(var/obj/Important_Items/Fossils/F in usr.contents)
				if(istype(F,/obj/Important_Items/Fossils/Dome_Fossil)) Fossil = "Dome Fossil"
				if(istype(F,/obj/Important_Items/Fossils/Helix_Fossil)) Fossil = "Helix Fossil"
				if(istype(F,/obj/Important_Items/Fossils/Root_Fossil)) Fossil = "Root Fossil"
				if(istype(F,/obj/Important_Items/Fossils/Claw_Fossil)) Fossil = "Claw Fossil"
				if(istype(F,/obj/Important_Items/Fossils/Old_Amber)) Fossil = "Old Amber"
			switch(Fossil)
				if("None")
					if(usr) usr.ScrollText(src, "Im sorrey. It does not seem like you have a fossil;")

				if("Dome Fossil")
					if(usr) usr.ScrollText(src, "Very nice...")
					if(usr) usr.ScrollText(src, "I see you have a Dome Fossil. When this is revived, it will turn into the ancient Pokemon Kabuto")
					if(usr) usr.ScrollText(src, "Let me revive this for you.")
					Poke = /mob/Pokemon/Kabuto
					if(!M.AddPKMNParty())
						if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
						return
					var/mob/Pokemon/P = new Poke(null)
					M.Party[M.AddPKMNParty()] = P
					P.Owner = M.ckey
					P.Create(10)

					P.Ball = new/obj/Balls/Poke_Ball
					var/obj/Balls/B = P.Ball
					B.name = html_encode(P.name)
					B.Pokemon = P
					M.CaughtPokemon += initial(P.name)
					M.GiveDexInfo(P.Number)
					M.UpdateParty()
					M.Title_Check()
					for(var/obj/Important_Items/Fossils/Dome_Fossil/F in usr.contents)
						del F
					if(usr) usr.ScrollText(src, "I have successfully revived your Fossil into a Kabuto. Enjoy your new Pokemon.")
					return
				if("Helix Fossil")
					if(usr) usr.ScrollText(src, "Very nice...")
					if(usr) usr.ScrollText(src, "I see you have a Helix Fossil. When this is revived, it will turn into the ancient Pokemon Omanyte")
					if(usr) usr.ScrollText(src, "Let me revive this for you.")
					Poke = /mob/Pokemon/Omanyte
					if(!M.AddPKMNParty())
						if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
						return
					var/mob/Pokemon/P = new Poke(null)
					M.Party[M.AddPKMNParty()] = P
					P.Owner = M.ckey
					P.Create(10)

					P.Ball = new/obj/Balls/Poke_Ball
					var/obj/Balls/B = P.Ball
					B.name = html_encode(P.name)
					B.Pokemon = P
					M.CaughtPokemon += initial(P.name)
					M.GiveDexInfo(P.Number)
					M.UpdateParty()
					M.Title_Check()
					for(var/obj/Important_Items/Fossils/Helix_Fossil/F in usr.contents)
						del F
					if(usr) usr.ScrollText(src, "I have successfully revived your Fossil into an Omanyte. Enjoy your new Pokemon.")
					return
				if("Root Fossil")
					if(usr) usr.ScrollText(src, "Very nice...")
					if(usr) usr.ScrollText(src, "I see you have a Root Fossil. When this is revived, it will turn into the ancient Pokemon Lileep")
					if(usr) usr.ScrollText(src, "Let me revive this for you.")
					Poke = /mob/Pokemon/Lileep
					if(!M.AddPKMNParty())
						if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
						return
					var/mob/Pokemon/P = new Poke(null)
					M.Party[M.AddPKMNParty()] = P
					P.Owner = M.ckey
					P.Create(10)

					P.Ball = new/obj/Balls/Poke_Ball
					var/obj/Balls/B = P.Ball
					B.name = html_encode(P.name)
					B.Pokemon = P
					M.CaughtPokemon += initial(P.name)
					M.GiveDexInfo(P.Number)
					M.UpdateParty()
					M.Title_Check()
					for(var/obj/Important_Items/Fossils/Root_Fossil/F in usr.contents)
						del F
					if(usr) usr.ScrollText(src, "I have successfully revived your Fossil into a Lileep. Enjoy your new Pokemon.")
					return
				if("Claw Fossil")
					if(usr) usr.ScrollText(src, "Very nice...")
					if(usr) usr.ScrollText(src, "I see you have a Claw Fossil. When this is revived, it will turn into the ancient Pokemon Anorith")
					if(usr) usr.ScrollText(src, "Let me revive this for you.")
					Poke = /mob/Pokemon/Anorith
					if(!M.AddPKMNParty())
						if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
						return
					var/mob/Pokemon/P = new Poke(null)
					M.Party[M.AddPKMNParty()] = P
					P.Owner = M.ckey
					P.Create(10)

					P.Ball = new/obj/Balls/Poke_Ball
					var/obj/Balls/B = P.Ball
					B.name = html_encode(P.name)
					B.Pokemon = P
					M.CaughtPokemon += initial(P.name)
					M.GiveDexInfo(P.Number)
					M.UpdateParty()
					M.Title_Check()
					for(var/obj/Important_Items/Fossils/Claw_Fossil/F in usr.contents)
						del F
					if(usr) usr.ScrollText(src, "I have successfully revived your Fossil into an Anorith. Enjoy your new Pokemon.")
					return
				if("Old Amber")
					if(usr) usr.ScrollText(src, "Very nice...")
					if(usr) usr.ScrollText(src, "I see you have a very rare Old Amber. When this is revived, it will turn into the ancient Pokemon Aerodactyl")
					if(usr) usr.ScrollText(src, "Let me revive this for you.")
					Poke = /mob/Pokemon/Aerodactyl
					if(!M.AddPKMNParty())
						if(usr) usr.ScrollText(src, "It does not seem like you have any room for this Pokemon. Come back when you make room.")
						return
					var/mob/Pokemon/P = new Poke(null)
					M.Party[M.AddPKMNParty()] = P
					P.Owner = M.ckey
					P.Create(10)

					P.Ball = new/obj/Balls/Poke_Ball
					var/obj/Balls/B = P.Ball
					B.name = html_encode(P.name)
					B.Pokemon = P
					M.CaughtPokemon += initial(P.name)
					M.GiveDexInfo(P.Number)
					M.UpdateParty()
					M.Title_Check()
					for(var/obj/Important_Items/Fossils/Old_Amber/F in usr.contents)
						del F
					if(usr) usr.ScrollText(src, "I have successfully revived your Fossil into an Aerodactyl. Enjoy your new Pokemon.")
					return

//Kindleheart NPC//
mob/NPC/Kindleheart
	Magmar
		icon = '126Magmar.dmi'
		Pointer = 0
		New()
			..()
			Wander()
		proc/Wander()
			set background = 1
			sleep(rand(1,5))
			while(src)

				if(prob(1))
					for(var/i = 1, i<= 4, i++)
						sleep(50)
						dir = rand(1,10)
						sleep(10)

				if(prob(1))
					if(icon_state == null)
						icon_state = "Sleep"
						sleep(200)
						icon_state = null
						sleep(10)
				var/atom/A = get_step(src, pick(1,2,4,8))
				if(get_dist(A, initial(loc)) <= 2)
					step_towards(src,A)

				sleep(10)


//Bloomsberry NPC//
mob/NPC/Bloomsberry
	//Guru Met // Before they have met. Will give fishing rod and first assignment.
	Fishing_Guru
		Click()
			var/mob/Player/P
			if(isPlayer(usr)) P = usr
			else return

			if(P.Quests["Fishing Guru Met"])
				P.frozen = 1
				dir = get_dir(src,P)
				overlays += /obj/HUD/OMG
				sleep(10)
				overlays -= /obj/HUD/OMG


//Trainers//-------------------------------------------------------------------------------------
obj/HUD/OMG
	icon = 'HUD.dmi'
	icon_state = "OMG"
	pixel_y = 26
	layer = 100
obj/HUD/LOVE
	icon = 'HUD.dmi'
	icon_state = "LOVE"
	pixel_y = 26
	layer = 100
mob/
	New()
		..()
		ReAddClothing()


//NPCS//------------------------------------------------------------------------------------------

mob/NPC
	Talker
		icon = 'MaleWhiteBase.dmi'
		var/WalkPattern = "Still"
		var/Message
		//This is either, "Up/Down","Still","Spin","Circle","Right/Left"
		New()
			Walk()
			..()
		proc/Walk()
			set background = 1
			spawn()
				switch(WalkPattern)
					if("Up/Down")
						while(src)
							sleep(rand(10,85))
							var/DIR = pick(1,2)
							if(get_dist(get_step(src,DIR), initial(loc)) <= 1)
								step(src,DIR)
					if("Still")
						return
					if("Spin")
						while(src)
							sleep(rand(10,85))
							dir = pick(1,2,4,8)









