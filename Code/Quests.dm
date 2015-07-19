
//List of Quest Check Points//

/*

- TitleStep [Location]  // For when Ray is showing you arround. Could be used to signify if someone has entered an area.
- TransportStep [Location Type]  //These are the teleporting tiles used for Buildings. Will tell a Quest one is stepped on/used.


*/





mob/Player
	var/list/Quests = list() // This will store the ATOMS that are the quests


	proc
		QuestReturn(var/obj/Quest/QType) //Returns the Quest Objects
			for(var/obj/Quest/Q in Quests)
				if(QType && QType == Q.type) return Q
			return null
		QuestReturnList(var/obj/Quest/QType) //Returns the progress list.
			for(var/obj/Quest/Q in Quests)
				if(QType && QType == Q.type) return Q.Progress
		QuestCheck(var/String, var/atom/Atom1, var/atom/Atom2)
			for(var/obj/Quest/Q in Quests)
				if(String == "Done?" && Q.Done) return "Done"
				var/Return = Q.Quest_Check(src,String,Atom1,Atom2)
				if(Return)
					return Return
			return 0
		SpecificQuestCheck(var/obj/Quest/Quest, var/String, var/atom/Atom1, var/atom/Atom2)
			for(var/obj/Quest/Q in Quests)
				if(istype(Q, Quest))
					if(String == "Done?" && Q.Done) return "Done"
					var/Return = Q.Quest_Check(src,String,Atom1,Atom2)
					if(Return)
						return Return
			return 0
		QuestChatResponses(var/TalkTo)
			var/list/Responses = list()
			for(var/obj/Quest/Q in Quests)
				var/CC = Q.Chat_Check(src, TalkTo)
				if(CC) Responses[CC] = Q.type
			return Responses

		QuestAdd(var/Quest) //Where Quest is the type to add.
			for(var/obj/Quest/Q in Quests)
				if(istype(Q,Quest)) return //This quest has already been added.
			var/obj/Quest/Q = new Quest
			Quests += Q
			Q.AddOverlays(usr)
			usr<<Quest("''<B>[Q]</B>'' has been added to your list of current quests.")
			if(Q) Q.icon_state = "Quest Dot New"
			winset(src, "NewQuestButton", "is-visible=true")
		UpdateQuestButtonNEW(var/obj/Quest/Q, var/word = "updated")
			usr<<Quest("''<B>[Q]</B>'' has been [word]. Check your Quest tab.")
			if(Q) Q.icon_state = "Quest Dot New"
			winset(src, "NewQuestButton", "is-visible=true")









	verb
		QuestsBrowser()
			set hidden = 1
			winset(usr, "Quests", "is-visible=true")
			winset(usr, "Quests.QuestBrowser", "is-visible=false")
			winset(usr, "Quests.QuestGrid", "is-visible=true")
			winset(src, "NewQuestButton", "is-visible=false")
			var/items = 0
			//Automatically pulls up Quests in Progress
			for(var/obj/Quest/Q in Quests)
				Q.invisibility = 0
				if(Q.Done) continue
				winset(usr, "Quests.QuestGrid", "current-cell=[++items]")
				usr << output(Q, "Quests.QuestGrid")
			winset(usr, "Quests.QuestGrid", "cells=[items]")

		CompletedQuests()
			set hidden = 1
			winset(usr, "Quests.QuestGrid", "is-visible=true")
			winset(usr, "Quests.QuestBrowser", "is-visible=false")
			var/items = 0
			for(var/obj/Quest/Q in Quests)
				Q.invisibility = 0
				if(!Q.Done) continue
				winset(usr, "Quests.QuestGrid", "current-cell=[++items]")
				usr << output(Q, "Quests.QuestGrid")
			winset(usr, "Quests.QuestGrid", "cells=[items]")
		CurrentQuests()
			set hidden = 1
			winset(usr, "Quests.QuestGrid", "is-visible=true")
			winset(usr, "Quests.QuestBrowser", "is-visible=false")
			var/items = 0
			for(var/obj/Quest/Q in Quests)
				Q.invisibility = 0
				if(Q.Done) continue
				winset(usr, "Quests.QuestGrid", "current-cell=[++items]")
				usr << output(Q, "Quests.QuestGrid")
			winset(usr, "Quests.QuestGrid", "cells=[items]")



mob/
	proc/QuestMessage(var/Message)
		return "<font color = green>(Quest) [Message]</font>"
	verb/QUESTS() //This opens the Quests Screen
		set hidden = 1
obj/Quest/Checkpoint //It checks with the quest, to see if they can pass this point.
	var/Checkpoint
	invisibility = 1
	SteppedOn(var/mob/Player/M)
		if(isPlayer(M))
			var/QuestChecker = M.QuestCheck("Checkpoint Check [Checkpoint]", src) //1 to let them pass, 0 to not
			if(QuestChecker == "NotPass") return 0
			return 1



obj/Quest
	icon = 'HUD.dmi'
	icon_state = "Quest Dot"
	var/Done
	var/Progress = list() //This will record what they have done in the quest.

	Click()
		icon_state = "Quest Dot"
		Progress_Report(usr)

	proc/Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
	proc/Chat_Check(var/String)  //Q.Chat_Check(src, TalkTo)


	proc/Progress_Report(var/mob/Player/P)
		winset(usr, "Quests.QuestGrid", "is-visible=false")
		winset(usr, "Quests.QuestBrowser", "is-visible=true")

	proc/AddOverlays(var/mob/Player/P) //This is at Player New

//A New Beginning//--------------------------------------------------------------------------------------------
obj/Quest
	A_New_Beginning
		name = "A New Beginning"

		AddOverlays(var/mob/Player/P)
			for(var/obj/Quest/A_New_Beginning/Starter_Pokemon/SP in world)
				if(SP.name == Progress["Chosen Pokemon"]) continue
				P.AddScreenOverlay('Indoors.dmi',"Pokeball",SP,"Hawthorn's Lab [SP.GivenPokemon]",10)

		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/counter = 1
			Send += "[counter++]. I got a letter saying I had been accepted as a sponsered trainer at NEXUS. I am suppose to meet a professor in Lycus Valley today. When I arrived, a receptionist led me to him on the second floor. I should speak to him about getting my first Pokemon.<BR><BR>"
			if(Progress["Talk to Professor Hawthorn1"])
				Send += "[counter++]. Professor Hawthorn introduced himself as part of NEXUS and is responsible for picking new sponsered trainers. These trainers get a starter Pokemon and have their entry fee payed for the Joleon Pokemon League. He said that I needed to pick my starter Pokemon before we continue.<BR><BR>"
			if(Progress["Chosen Pokemon"])
				Send += "[counter++]. I chose [Progress["Chosen Pokemon"]] as my starter Pokemon.<BR><BR>"
			if(Done)
				Send += "[counter++]. Professor Hawthorn made me battle him to prove my skills. After a relatively easy battle, he said I could set out on my Pokemon Journey. However, I need to speak to my Uncle John on the Third Floor of the NEXUS building before I can start doing tasks for the Scientists of NEXUS."

			if(P.client) P<<output(Send, "QuestBrowser")
		Chat_Check(USR, var/String)
			switch(String)
				if("Talk to PlayerMom")
					if(!Progress["Talk to Mom First Time"])
						return "Mom! I got my first Pokemon!"
					if("Talk to Professor Hawthorn")
						if(!Progress["Talk to Professor Hawthorn1"])
							return "Hello, My name is [USR]"
						else if(Progress["Talk to Professor Hawthorn1"] && !Progress["Chosen Pokemon"])
							return "Um, what am I doing again?"
						else if(Progress["Chosen Pokemon"] && !Done)
							return "I've chosen [Progress["Chosen Pokemon"]] as my first Pokemon"

		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			if(Done && Progress["Talk to Mom First Time"]) //It still needs to check if you've talked to Mom for the first time.
				return 0//This is so the code doesn't have to look over all the options.
			var/mob/Player/P = USR
			if(!isPlayer(P) || !P.client) return 1
			switch(String)
				if("Check Forfeit")
					if(Progress["Chosen Pokemon"])
						if(P) P.ScrollText("Professor Hawthorn", "You expect me to make you a sponsered trainer by forfeiting? Commom, keep battling!",'ProfHawthorn.png')
						return 1 // They can't forfeit the battle..
					return 0 // Otherwise, act normally.
				if("Check Battle Inactive")
					if(Progress["Chosen Pokemon"] && P.Court) return 1 // They don't have to worry about the AFK filter when reading rules
					return 0 // Otherwise, act normally.
				if("Check Press Q")
					if(!Progress["Chosen Pokemon"] && !P.Court) return 0
					if(Progress["Pressed Q"] || Done) return 0
					Progress["Pressed Q"] = 1
					var/html = "Great. Use the arrow keys to move around your Pokemon while its sent out. Using movement and attacks, defeat Professor Hawthorn. "
					winset(P, "ItemInformation", "is-visible=true")
					winset(P, "ItemName", "text='Sending out your Pokemon'")
					P<<output("<center><font size = 2><Body BGCOLOR = #CA0000>[html]","ItemDescription")
					if(P.ControlingPokemon)
						for(var/mob/Pokemon/A in oview(20, P.ControlingPokemon))
							P.AddScreenOverlay('Moves.dmi',"Crosshairs",A,"Attack Teddy",A.layer + 1)
				if("Click Party Tab")
					if(!Progress["Chosen Pokemon"] && !P.Court) return 0
					if(Progress["Click Party Tab"] || Done) return 0
					Progress["Click Party Tab"] = 1
					var/html = "Your party can contain six Pokemon at all times. Pokemon can be sent out just about anywhere, except in towns and buildings. When in a battle, click the Pokeball of the Pokemon you want to send out."
					winset(P, "ItemInformation", "is-visible=true")
					winset(P, "ItemName", "text='Sending out your Pokemon'")
					P<<output("<center><font size = 2><Body BGCOLOR = #CA0000>[html]","ItemDescription")
				if("Check Choose Pokeball")
					if(!Progress["Chosen Pokemon"] && !P.Court) return 0
					if(Done) return 0
					var/html = "Once you select a Pokeball, it's name will turn <font color = blue>BLUE</font> to indicate it is your active Pokemon. To send it out, click anywhere on the battlefield.."
					winset(P, "ItemInformation", "is-visible=true")
					winset(P, "ItemName", "text='Sending out your Pokemon Continued'")
					P<<output("<center><font size = 2><Body BGCOLOR = #CA0000>[html]","ItemDescription")
					if(P.Watcher)
						var/atom/T = Get_Steps(P.Watcher, P.Watcher.dir, 5)
						P.AddScreenOverlay('Moves.dmi',"Crosshairs",T,"Send Out Pokemon Tutorial",T.layer + 1)
				if("Check Sendout Pokemon")
					if(!Progress["Chosen Pokemon"] && !P.Court) return 10
					if(Done) return 0
					P.RemovebyID("Send Out Pokemon Tutorial")
					var/html = "Great, your Pokemon is in the field and ready for combat. To win a battle, you will need to defeat all the other Pokemon on the opposing team. To do that, you will need to execute attacks. The most common way of using attacks is the in-game marcos. These are the QWERTY keys which relate to your Pokemon's six attacks. Try pressing Q.."
					winset(P, "ItemInformation", "is-visible=true")
					winset(P, "ItemName", "text='On the Offense (Attacking)'")
					P<<output("<center><font size = 2><Body BGCOLOR = #CA0000>[html]","ItemDescription")

				if("Checkpoint Check Leave Hawthorns Lab")
					if(!Done)
						P<<System("There are still some things you need to do to be considered a sponsered trainer. You should talk to Professor Hawthorn first.")
						return "NotPass"
					return 1

				if("Choose Starter Pokemon")
					if(!Progress["Talk to Professor Hawthorn1"])
						P<<System("Perhaps you should talk to Professor Hawthorn before you steal his Pokemon?")
						return
					var/obj/Quest/A_New_Beginning/Starter_Pokemon/SP = Atom1


					if(alert(P,"Are you sure you want [SP.name] as a stater Pokemon.",,"No","Yes") == "No") return
					if(P.Party[1] || Progress["Chosen Pokemon"]) return //You can't get two Pokemon.
					var/mob/Pokemon/Poke = new SP.GivenPokemon(null)

					Progress["Chosen Pokemon"] = SP.name
					P.RemovebyID("Hawthorn's Lab [SP.GivenPokemon]") //Removes the Pokeball they choose..
					//Can you close this input? If so, you should put Progress["Chose Pokemon"] after it.
					Poke.name = html_encode(input(P,"Would you like to give [SP.name] a nickname?","Nickname",Poke.name) as text)

					P.Party[1] = Poke
					Poke.Owner = P.ckey
					Poke.Create(9)
					Poke.NonTradable = 1

					Poke.Ball = new/obj/Balls/Poke_Ball
					var/obj/Balls/B = Poke.Ball
					B.name = html_encode(Poke.name)
					B.Pokemon = Poke
					P.CaughtPokemon += initial(Poke.name)
					P.GiveDexInfo(Poke.Number)
					P.UpdateParty()

					P.UpdateQuestButtonNEW(src)
				if("Talk to PlayerMom")
					if(!Progress["Talk to Mom First Time"])
						P.ScrollText(src, "It seems you recieved your first Pokemon. Congradulations.",Atom1)
						P.ScrollText(src, "I guess that means you will be leaving to journy Joleon. Make sure to come back often..",Atom1)
						P.ScrollText(src, "I only wish there was someway I could help you on your journey...",Atom1)
						P.ScrollText(src, "I know! I can save up money for you! As you gain money, you send a percentage back to me and I will guard it and keep it safe for you. Then you can come back and get some if you ever run low.",Atom1)
						var/list/Percents = list("0%" = 0,"5%" = 5,"10%"= 10,"15%" = 15,"20%" = 20,"25%" = 25,"30%" = 30)
						P.MomPercent = input(P,"Mom: How much of your money should I save?","Mom the Banker","15%") in list("0%","5%","10%","15%","20%","25%","30%")
						P.MomPercent = Percents[P.MomPercent]
						if(P.MomPercent) P.ScrollText(src, "Alright, I will save [P.MomPercent] percent of your money.",Atom1)
						P.ScrollText(src, "Honey, have a safe journey! And if you ever need to come back home, I will always be here for you.",Atom1)
						Progress["Talk to Mom First Time"] = 1
						return 1
					return 0
				if("Talk to Professor Hawthorn")
					if(!Progress["Talk to Professor Hawthorn1"])
						if(P) P.ScrollText("Professor Hawthorn", "Ah [P.name], you finally made it. You are the last sponsered trainer to show up. ",'ProfHawthorn.png')
						if(P) P.ScrollText("Professor Hawthorn", "As you know, I am Professor Hawthorn, and I am called each year to evaluate the trainers regiestered to become sponsered trainers.",'ProfHawthorn.png')
						if(P) P.ScrollText("Professor Hawthorn", "As a sponsered trainer, you will be given a starter Pokemon and will be given work by our Scientists through the NEXUS corporation. As well, we will pay your entry fee for the Joleon Pokemon Leauge.",'ProfHawthorn.png')
						if(P) P.ScrollText("Professor Hawthorn", "Well lets get started shall we? Start by choosing your first Pokemon on the tables there. Then I just need to test your battling skills and you will be good to go. ",'ProfHawthorn.png')
						Progress["Talk to Professor Hawthorn1"] = 1
						P.UpdateQuestButtonNEW(src)
					else if(Progress["Talk to Professor Hawthorn1"] && !Progress["Chosen Pokemon"])
						if(P) P.ScrollText("Professor Hawthorn", "Once you pick your Starter Pokemon, I will test your battling skills. Go on, choose. ",'ProfHawthorn.png')
						return
					else if(Progress["Chosen Pokemon"] && !Done)
						if(P) P.ScrollText("Professor Hawthorn", "[Progress["Chosen Pokemon"]]? Interesting choice.",'ProfHawthorn.png')
						if(P) P.ScrollText("Professor Hawthorn", "Alright. Well now I just need to put you through a quick 1 on 1 battle. Once you beat me, I will send you on your way.",'ProfHawthorn.png')
						if(P) P.ScrollText("Professor Hawthorn", "Are you ready for a battle?",'ProfHawthorn.png')


						P.FadetoBlack()
						spawn(15)
							P.FadefromBlack()
							var/html = "Battling on Pokemon Origins can be pretty complex, so we suggest you read through these quick instructions to make your Pokemon Journey a bit easier. To view your Pokemon Party, start by click on your Party Tab. If you are already educated and know how to battle, send out your Pokemon and defeat Hawthorn."

							winset(P, "ItemInformation", "is-visible=true")
							winset(P, "ItemName", "text='Welcome to Battling'")
							P<<output("<center><font size = 2><Body BGCOLOR = #CA0000>[html]","ItemDescription")
						var/mob/NPCTrainer/Quest/A_New_Beginning/Professor_Hawthorn/O = new
						var/list/Q = O.Challenge(P)



						if(!Q.Find(P)) //They lost...? NOTE: PREVIOUS GLITCH: Q Must be a list.
							return
						del O//This needs to go after the battle. It gets rid of the uneeded mob, but if you delete it before the battle ends, the battle ends.
						winset(P, "ItemInformation", "is-visible=false")
						if(P) P.ScrollText("Professor Hawthorn", "Well it seems you and [Progress["Chosen Pokemon"]] are destined partners. You battled extremely well, and therefore I am granting you the offical title of a NEXUS Sponsered Trainer.",'ProfHawthorn.png')
						if(P) P.ScrollText("Professor Hawthorn", "You are free to leave the building and start your journey throughout Joleon to start collecting badges. However, before you start getting work from the scientists here, you need to get your Participation Form signed by your referer to the program.",'ProfHawthorn.png')
						if(P) P.ScrollText("Professor Hawthorn", "It says here.. Your referer is your uncle? Professor Smith, on the 3rd Floor. Right. Well, you will need him to sign this form. You should go talk to him.",'ProfHawthorn.png')

						Done = 1
						P.UpdateQuestButtonNEW(src, "finished")
						P.QuestAdd(/obj/Quest/Hello_Dexter_22)


				if("Play Intro")
					P.AddAll() //This is needed so you see the Pokeballs in the lab later.
					var/obj/Quest/A_New_Beginning/Flying/F = new(P)
					F.invisibility = 1
					if(P) P.ScrollText("Professor Hawthorn", "Welcome to the world of Pokemon, and more specifically the region of Joleon",'ProfHawthorn.png')
					if(P) P.ScrollText("Professor Hawthorn", "Joleon is a new region filled with many types of Pokemon, and even more areas to explore and battle in.",'ProfHawthorn.png')
					if(P) P.ScrollText("Professor Hawthorn", "New mysteries are waiting to be solved. New Pokemon are waiting to be discovered, and trainers are waiting to battle you.",'ProfHawthorn.png')
					//Stop the Cynamatic view of Joleon, go to the battle

					P.FadetoBlack()
					del F


					var/obj/Battling/Court/C = Set_Up_NPC_Battle(/mob/NPCTrainer/Gymleader/Gymleader_Wayne,/mob/NPCTrainer/Gymleader/Gymleader_Arial)
					P.client.eye = C.loc
					P.FadefromBlack()


					if(P) P.ScrollText("Professor Hawthorn", "Some people collect Pokemon, some raise them as pets. I myself have followed in the footsteps of many great scientists, trying to discover as much as I can about Pokemon?",'ProfHawthorn.png')
					if(P) P.ScrollText("Professor Hawthorn", "However, most people raise Pokemon for battle. Battling is a powerful part of Joleons culture, and young trainers from all over the region aspires to be the very best. The question is, do you have what it takes to be a Pokemon Master?",'ProfHawthorn.png')
					P.FadetoBlack()


					P.client.eye = locate(/turf/transporting/Lycus_Valley/NexusEntrance)

					P.FadefromBlack()
					if(P) P.ScrollText("Professor Hawthorn", "NEXUS corporation is a technilogically advanced company, responsible for all Pokemon-themed advances in todays society. At the very heart of Joleon, in Lycus Valley, I call it my home.",'ProfHawthorn.png')//ProfessorHawthorn.png')

					P.FadetoBlack()
					P.loc = locate(/turf/transporting/Lycus_Valley/NexusExit)
					P.client.eye = locate(P.x,P.y +5,P.z)
					P.icon_state = null //So they aren't sleeping
					P.FadefromBlack()

					P.frozen = 0
					sleep(5)
					step(P,NORTH)
					sleep(5)
					step(P,NORTH)

					P.frozen = 1
					P.Money = 1000

					if(P) P.ScrollText("Professor Hawthorn", "Every year, we take one trainer out of hundreds of applicants, and sponser them so that they may journey throughout Joleon and perhaps farther..",'ProfHawthorn.png')//ProfessorHawthorn.png')
					if(P) P.ScrollText("Professor Hawthorn", "However, we only take one applicant, and I am responsible for choosing that one trainer. Through a few tests, and a bit of luck, perhaps it could be you.",'ProfHawthorn.png')//ProfessorHawthorn.png')

					sleep(20)
					var/obj/HUD/OMG/OMG = new(locate(P.x,P.y+2,P.z))
					sleep(20)
					del OMG

					if(P) P.ScrollText("Receptionist", "Oh! Sorry, I think I may have been day dreaming. How did I not notice you? Sorry, what was your name?",'Receptionist.png')//ProfessorHawthorn.png')

					//Naming Process//----------------
					if(!P) return
					P.name = null
					while(!P.name) //Keeps making you input your name, until it meets the specifications.
						if(!P) return
						P.name = input(P, "Name?") as text
						//Your name must be 3-15 Characters long, and the first Character cannot be a space
						if(copytext(P.name,1,2) == " " || length(P.name) <= 2 || length(P.name) >= 16)
							P<<System("Your name must be at least 3 characters long, but shorter than 15 characters long.")
							P.name = null
							continue
						//You can only have one space in your name
						var/Space = findtext(P.name," ")
						if(Space && findtext(P.name," ",Space+1))
							P<<System("You can only have one space in your name.")
							P.name = null
							continue
						sleep(5)
					//This part of the code basically makes all the letters smaller case except for the first letter, which is upper case.
					if(!P) return
					var/New = ""
					var/l = ""
					for(var/i=1,i<=length(P.name),i++)
						l = lowertext(copytext(P.name,i,i+1))
						if(i == 1)
							New += uppertext(l)
							continue
						if(l == " ")
							New += " "
							New += uppertext(copytext(P.name,i+1,i+2))
							i+=1
						else
							if(l) New += lowertext(l)
					P.name = New
					PlayerNames[P.ckey] = P.name //Puts the players name in a list of players names in realtion with their key. This is so people can still find their names when they are logged out.
					world <<System("<B>[P] has logged into Pokemon Origins for the first time!")
					if(P) P.ScrollText("Receptionist", "It says here you are scheduled to meet Professor Hawthorn. Let me take you too him.",'Receptionist.png')//ProfessorHawthorn.png')
					P.frozen = 0
					P.FadetoBlack()
					P.loc = locate(155,153,2)
					P.client.eye = P

					P.FadefromBlack()


					P.UpdateQuestButtonNEW(src, "updated")









mob/NPCTrainer
	Quest/A_New_Beginning
		Professor_Hawthorn
			Tradable
			Pokes = list(\
				list("type" = /mob/Pokemon/Teddiursa, "level" = 4, "moves" = list(/obj/Moves/Growl,/obj/Moves/Charm)))
			icon = 'MaleWhiteBase.dmi'
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Labcoat", "Hair"="OakHairBrown", "Accesories"= "Glasses")
			MoneyGiven = 1000
			Portrait = 'ProfHawthorn.png'




mob/Quest/A_New_Beginning
	Professor_Hawthorn
		icon = 'MaleWhiteBase.dmi'
		Pointer = 1
		ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Labcoat", "Hair"="OakHairBrown", "Accesories"= "Glasses")
		Click()
			if(get_dist(src,usr) >= 2) return
			dir = get_dir(src,usr)
			spawn(100) dir = initial(dir)
			var/mob/Player/P = usr
			P.QuestCheck("Talk to Professor Hawthorn")



obj/Quest/Checkpoint //It checks with the quest, to see if they can pass this point.
	LeaveHawthornsLab
		Checkpoint = "Leave Hawthorns Lab"
obj/Quest/A_New_Beginning
	invisibility = 1
	Starter_Pokemon
		icon = 'Indoors.dmi'
		icon_state = "Pokeball"
		New()
			mouse_over_pointer = image('Pointer.dmi',"Take")
			..()
		Click()
			if(isPlayer(usr))
				var/mob/Player/P = usr
				P.QuestCheck("Choose Starter Pokemon", src)
		var/GivenPokemon
		Chikorita
			GivenPokemon = /mob/Pokemon/Chikorita
			name = "Chikorita"
		Cyndaquil
			GivenPokemon = /mob/Pokemon/Cyndaquil
			name = "Cyndaquil"
		Totodile
			GivenPokemon = /mob/Pokemon/Totodile
			name = "Totodile"
		Bulbasaur
			GivenPokemon = /mob/Pokemon/Bulbasaur
			name = "Bulbasaur"
		Charmander
			GivenPokemon = /mob/Pokemon/Charmander
			name = "Charmander"
		Squirtle
			GivenPokemon = /mob/Pokemon/Squirtle
			name = "Squirtle"
	Fly_Points
		var/Order //This is the order of the sequnce of shots
		var/Side //This is either A or B//
	Flying
		invisibility = 0
		density = 0
		New(var/mob/Player/P)
			set background = 1

			P.client.eye = src
			P.client.perspective = EYE_PERSPECTIVE

			spawn(5)
				while(src)
					for(var/i = 1, i<= 20, i++)
						var/obj/Quest/A_New_Beginning/Fly_Points/Start
						var/obj/Quest/A_New_Beginning/Fly_Points/Finish



						for(var/obj/Quest/A_New_Beginning/Fly_Points/FP in world)
							if(FP.Order == i)
								if(FP.Side == 1) Start = FP
								else Finish = FP
						if(!Start && !Finish) break

						src.loc = Start.loc
						spawn() P.FadefromBlack()
						while(get_dist(src.loc, Finish.loc) >= 1)
							step_to(src,Finish,0,1)
							sleep(2)
							if(get_dist(src.loc, Finish.loc) == 6)
								spawn() P.FadetoBlack()

//THe Revival Rivalry//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/obj/Quest/
	The_Revival_Rivalry

		AddOverlays(var/mob/Player/P)
			var/list/GTFGProgress = P.QuestReturnList(/obj/Quest/Going_for_the_Gold)
			if(Progress["Talk to Evans"] && !GTFGProgress["Given Notebook"])
				for(var/mob/NPC/Quest/Going_for_the_Gold/Gymleader_Corey/GC in world)
					P.AddScreenOverlay('NPC.dmi',"Corey",GC,"GL Corey Cave",MOB_LAYER+1)

			//For Rays Dad


		Chat_Check(src, TalkTo)
			var/mob/Player/P = src
			if(!isPlayer(P)) return 0
			//Find Fossil//------------------------------------------------------
			var/list/Fossils = list()
			for(var/obj/Important_Items/Fossils/F in P.contents)
				Fossils += F
			//Going for the Gold//Progress--------------------------------------
			var/list/GTFGProgress = P.QuestReturnList(/obj/Quest/Going_for_the_Gold)

			switch(TalkTo)
				//If this is running, they have already had the Quest added.
				if("Talk to Professor Evans")
					if(!Progress["Talk to Evans"])
						return "Professor Hawthorn sent me to help you?"
					else if(Progress["Talk to Evans"] && !length(Fossils))
						return "I still haven't found a fossil.."
					else if(Progress["Talk to Evans"] && length(Fossils))
						return "I have found a fossil!"

				if("Talk to Assistant James")
					if(!Progress["Talk to Evans"])
						return "Professor Hawthorn sent me to help Professor Evans."
				if("Talk to Gymleader Corey")
					if(GTFGProgress["Given Notebook"] && !Progress["Corey Gives Fossil"])
						return "Professor Evans sent me to pick up a fossil from you."
		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/counter = 1
			Send += "[counter++]. Professor Hawthorn finally entered me into the system. He sent me to help a Professor Evans on the fourth floor. Apparently she is the Fossil Expert.<BR><BR>"
			if(Progress["Talk to Evans"])
				Send += "[counter++]. Professor Evans introduced herself and her assistant James. They are looking to test their fossil revival machine, however they do not have a fossil yet. They have asked me to investigate multiple reports of fossils in Joleon..<BR><BR>"
			if(Progress["Found Fossil"])
				Send += "[counter++]. I have found a fossil at [Progress["Found Fossil"]] and should return it to NEXUS for Professor Evans to examine.<BR><BR>"


			if(P.client) P<<output(Send, "QuestBrowser")
		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			if(Done)
				if(String == "PokedexButtonCheck") return 1
				return 0//This is so the code doesn't have to look over all the options.
			var/mob/Player/P = USR
			if(!isPlayer(P) || !P.client) return 1
			//Find Fossil//------------------------------------------------------
			var/list/Fossils = list()
			for(var/obj/Important_Items/Fossils/F in P.contents)
				Fossils += F
			switch(String)
				if("Talk to Gymleader Corey")
					if(P) P.ScrollText("Gymleader Corey", "Oh right, you were going to pick up that fossil..",'Corey.png')
					if(P) P.ScrollText("Gymleader Corey", "You see the thing is, Professor Evans only expected me to have one fossil intact.",'Corey.png')
					if(P) P.ScrollText("Gymleader Corey", "However, I have two, and she did not specify which one to give you. I guess it should not matter, as long as you get a sample to test their machine..",'Corey.png')
					if(P) P.ScrollText("Gymleader Corey", "You should pick, after all you have done for me.",'Corey.png')
					var/list/Options = list("Dome Fossil" = /obj/Important_Items/Fossils/Dome_Fossil,"Helix Fossil" = /obj/Important_Items/Fossils/Helix_Fossil)
					var/Input = input(P, "Which fossil would you like?") in Options
					if(P) P.ScrollText("Gymleader Corey", "Alright, take the [Input]. Make sure to get back to me on the results.",'Corey.png')
					var/Type = Options[Input]
					var/obj/D = new Type
					P.contents += D
					Progress["Corey Gives Fossil"] = 1
					P<<System("You were given the [Input]")



				if("Talk to Professor Evans")
					if(!Progress["Talk to Evans"])
						if(P) P.ScrollText(Atom1, "Ah! You must be the trainer that Professor Hawthorn sent up to me. [P], right?",'ScientistFemale.png')
						if(P) P.ScrollText(Atom1, "I am Professor Lily Evans, and I am the Fossil Expert. Me and my assistant James here have been working on a revival machine, so that we may bring back these endangered species of Pokemon.",'ScientistFemale.png')
						if(P) P.ScrollText(Atom1, "The machine is fully operational, and test runs have shown positive results. We are currently just waiting for a sample to test it on.",'ScientistFemale.png')
						if(P) P.ScrollText(Atom1, "There are two locations we have sent teams to revive fossils. The first is in Mirage City in a archelogical dig that the Gymleader is taking part in. If you want to seek this fossil out, you should talk to the Gymleader, Corey.",'ScientistFemale.png')
						if(P) P.ScrollText(Atom1, "The other possible fossil can be found at Bloomsberry Lake. We have sent a team to investigate the small island in the middle of the Lake. You should talk to Remus, another one of my assitants, by the docks around Bloomsberry Lake if you plan to find this fossil.",'ScientistFemale.png')
						if(P) P.ScrollText(Atom1, "Come back here when you have a fossil.",'ScientistFemale.png')

						Progress["Talk to Evans"] = 1
						P.UpdateQuestButtonNEW(src, "updated")
					else if(Progress["Talk to Evans"] && !length(Fossils))
						if(P) P.ScrollText(Atom1, "We do have other projects to work on, but the sooner you return a fossil, the sooner we can proceed with our work.",'ScientistFemale.png')
						return 0
					else if(Progress["Talk to Evans"] && length(Fossils))
						world<<"Found Fossil!"


obj/Important_Items/Fossils
	var/RevivedPokemon
	icon = 'Important Items.dmi'
	Helix_Fossil
		icon_state = "Helix Fossil"
		RevivedPokemon = /mob/Pokemon/Omanyte
	Dome_Fossil
		icon_state = "Dome Fossil"
		RevivedPokemon = /mob/Pokemon/Kabuto
	Old_Amber
		icon_state = "Old Amber"
		RevivedPokemon = /mob/Pokemon/Aerodactyl
	Root_Fossil
		icon_state = "Root Fossil"
		RevivedPokemon = /mob/Pokemon/Lileep
	Claw_Fossil
		icon_state = "Claw Fossil"
		RevivedPokemon = /mob/Pokemon/Anorith
mob/NPC/Quest/A_Revival_Rivalry
	icon = 'MaleWhiteBase.dmi'
	Professor_Evans
		Pointer = 1
		ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Labcoat", "Hair"="LongHairBrown")
		DefaultResponses = list("What do you do here?")
		ChatResponses(var/Response, var/mob/Player/P)
			..()
			if(!P) return
			var/list/Progress = P.QuestReturnList(/obj/Quest/The_Revival_Rivalry)
			switch(Response)
				if("What do you do here?")
					if(P) P.ScrollText(src, "I am the Fossil Expert within the NEXUS Corporation. I study fossils in an attempt to understand the past, so that we may understand our origins.",'ScientistFemale.png')
					if(Progress)
						if(!Progress["Return Fossil"])
							if(P) P.ScrollText(src, "I am still waiting on that fossil, whenever you happen to come accross one..",'ScientistFemale.png')

					else
						if(P) P.ScrollText(src, "Currently I am just waiting on a fossil to test my experiments..",'ScientistFemale.png')


	Assistant_James
		Pointer = 1
		ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Labcoat", "Hair"="GaryHairBlack")
		DefaultResponses = list("What do you do here?")

//Hello Dexter 2.2!//----------------------------------------------------------------------------------------------------------------------

obj/Quest/
	Hello_Dexter_22
		name = "Hello Dexter 2.2!"

		AddOverlays(var/mob/Player/P)
			for(var/mob/Quest/Dexter_22/Professor_Smith/PS in world)
				P.AddScreenOverlay(P.Ricon,null,PS,"Uncle's Skin",30)
				for(var/section in PS.ClothingOverlays)
					var/c = PS.ClothingOverlays[section]
					P.AddScreenOverlay('Clothing.dmi',c,PS,"Uncle's Clothing",101)
					if(section == "Hair") P.AddScreenOverlay('Hair.dmi',c,PS,"Uncle's Hair",30)
			if(!Progress["Found Email"] && Progress["Talk to Smith1"])
				for(var/obj/Quest/Dexter_22/Smiths_Computer/SC in world)
					P.AddScreenOverlay('PKMNCenter.dmi',"ComputerON",SC,"Uncle's Computer",30)

			//For Rays Dad



		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/counter = 1
			Send += "[counter++]. Professor Hawthorn sent me on my way, but said I needed to get a form signed by my uncle, who refered me to the sponsorship program. He is on the 3rd floor of the NEXUS Buidling.<BR><BR>"
			if(Progress["Talk to Smith!"])
				Send += "[counter++]. Uncle Smith was rather happy to see me and explained how he convinced my parents to let me become a Pokemon Trainer. He designed a Pokedex based of Professor Oak's original Pokedex, and it is suppose to help me through my journey. He signed my form, so I should bring it back to Professor Hawthorn.<BR><BR>"

			if(P.client) P<<output(Send, "QuestBrowser")
		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			if(Done)
				if(String == "PokedexButtonCheck") return 1
				return 0//This is so the code doesn't have to look over all the options.
			var/mob/Player/P = USR
			if(!isPlayer(P) || !P.client) return 1
			switch(String)
				//Finding the Helpfiles...

				if("TitleStep")
					var/list/Towns = list("Bloomsberry Lake", "Lycus Valley", "Net City", "Ridgeport", "Elkvale", "Skysight", "Mirage City", "Kindleheart", "Whitereach")
					if(Towns.Find(Atom1))
						P.PokedexUnlock(Atom1)
				if("TransportStep")
					if(findtext(Atom1,"Gym")) P.PokedexUnlock("NPC Gymleaders")
					if(findtext(Atom1,"Player_Gym")) P.PokedexUnlock("Player Gymleaders")
					//if(findtext(Atom1,"Pokemon") && findtext(Atom1,"Center")) P.PokedexUnlock("Pokemon Centers") //Replaced by talking to Nurse Joy NPC
					if(findtext(Atom1,"Poke") && findtext(Atom1,"Mart")) P.PokedexUnlock("Pokemarts")
				if("Examine Item")
					if(istype(Atom1, /obj/Balls))
						P.PokedexUnlock("Catching")
						P.PokedexUnlock("Pokeballs")
					if(istype(Atom1, /obj/Clothing/)) P.PokedexUnlock("Clothing")
					if(istype(Atom1, /obj/Machine)) P.PokedexUnlock("TMs and HMs")
				if("Click Party Tab") P.PokedexUnlock("Party Tab")
				if("Talk to Banker") P.PokedexUnlock("Banker")
				if("Click Items Tab") P.PokedexUnlock("Items Tab")


				//Talking to People
				if("Talk to Professor Hawthorn")
					if(!Progress["Talk to Smith1"])
						if(P) P.ScrollText("Professor Hawthorn", "Talk to me when you have seen your uncle, I am rather busy.",'ProfHawthorn.png')
						return
					else if(Progress["Talk to Smith1"] && !Progress["Talk to Hawthorn"])
						if(P) P.ScrollText("Professor Hawthorn", "Great! Now I can finally get you into the system for trainer work.",'ProfHawthorn.png')
						if(P) P.ScrollText("Professor Hawthorn", "For now, you should head South towards Bloomsberry Lake. There is a 4 hour delay while I put your trainer information into our systems and to find you work. Come back to me at [P.GetTime(world.timeofday,4)].",'ProfHawthorn.png')
						Progress["Talk to Hawthorn"] = world.realtime
					else if(Progress["Talk to Hawthorn"])
						if(world.realtime - Progress["Talk to Hawthorn"] > 144000) //They have waited 4 hours
							if(P) P.ScrollText("Professor Hawthorn", "You have finally been entered into the system, and I have found work with you with Professor Evans, The Fossil Expert. His office is on the third floor.",'ProfHawthorn.png')
							P.QuestAdd(/obj/Quest/The_Revival_Rivalry)
						else
							if(P) P.ScrollText("Professor Hawthorn", "I am still workig on getting your information into our systems. Come back at [P.GetTime(Progress["Talk to Hawthorn"],4)].",'ProfHawthorn.png')


				if("PokedexButtonCheck") //This is for Login, so they know to add it.
					if("Talk to Smith") return 1
					return 0
				if("Talk to Professor Smith")
					if(!Progress["Talk to Smith1"])
						if(P) P.ScrollText("Uncle Smith", "[P.name]! So glad to see you! You must be here for the sponsorship, they must have gotten my letter of reference.")
						if(P) P.ScrollText("Uncle Smith", "I talked this over with your parents, and with a lot of convincing, they said they would let you travel Joleon.")
						if(P) P.ScrollText("Uncle Smith", "There was a catch though... and that was that I had to help you on your journey. Because I cannot be there for you as you plunder through caves and explore the forests, I started a little side project.")
						if(P) P.ScrollText("Uncle Smith", "Recently, the source for Professor Oaks original Dexter Pokedex model was released to the public, and so I have update this model of Pokdex will all Pokemon that you will find in Joleon.")
						if(P) P.ScrollText("Uncle Smith", "It also has some pretty useful help files on Pokemon Training. You do not have to read them, but they will update as you journey through the region. You should take a look if you ever need a bit of help.")
						if(P) P.ScrollText("Uncle Smith", "Oh, you probably need theat form signed. Well, here take the Pokedex and the signed forms, I have a bit of work to do, so I will probably see you later.")
						winset(P,"PokedexButton","is-visible=true")
						if(P) P.ScrollText("Uncle Smith", "Good Luck with your journey.")

						P.UpdateQuestButtonNEW(src, "updated")
						Progress["Talk to Smith1"]= 1
						if(Atom1) Atom1.dir = 1
						for(var/obj/Quest/Dexter_22/Smiths_Computer/SC in world)
							P.AddScreenOverlay('PKMNCenter.dmi',"ComputerON",SC,"Uncle's Computer",30)
						sleep(20)

						if(P) P.ScrollText("Uncle Smith", "Oh? It seems I have an email.")
						sleep(20)
						if(Atom1) Atom1.dir = 2



					else if(Progress["Talk to Smith1"])
						if(P) P.ScrollText("Uncle Smith", "You should bring that form to Professor Hawthorn, so he can get you set up. Come visit sometime!.")

				if("Access Smiths Computer")
					if(Progress["Found Email"]) return 0
					if(Progress["Talk to Smith1"])
						var/INPUT = input(P,"Access Smiths Computer","Uncle Smiths Terminal","Access Smiths Email") in list("Access Smiths Email", "Access Personal Computer")
						if(INPUT == "Access Smiths Email")
							P.QuestAdd(/obj/Quest/A_Boy_With_a_Pair_of_Shoes)
							P.QuestCheck("Found Smith Email")
							Progress["Found Email"] = 1
							P.RemovebyID("Uncle's Computer")
							return 1







mob/Quest/Dexter_22
	Professor_Smith
		invisibility = 1
		Pointer = 1
		ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Labcoat", "Hair"="ComboverHairBlack")
		Click()
			if(get_dist(src,usr) >= 2) return
			dir = get_dir(src,usr)
			spawn(100) dir = initial(dir)
			var/mob/Player/P = usr
			P.QuestCheck("Talk to Professor Smith", src)
obj/Quest/Dexter_22
	Smiths_Computer
		name = "Smith's Computer"
		icon = 'PKMNCenter.dmi'
		icon_state = "Computer"
		pixel_y = 16
		density = 0
		verb/Access()
			set src in view(1)
			var/mob/Player/M = usr
			if(!isPlayer(M)) return
			if(M.QuestCheck("Access Smiths Computer")) return
			winset(usr, "PCBOX", "is-visible=true")
			M.ConstructPC()

		Click()
			Access()
		SteppedOff()
			..()
			winset(usr, "PCBOX", "is-visible=false")


//A Boy With a Pair of Shoes//----------------------------------------------------------------------------------------------------
obj/Quest/
	A_Boy_With_a_Pair_of_Shoes

		AddOverlays(var/mob/Player/P)


		Chat_Check(var/mob/Player/USR, var/String)
			switch(String)
				if("Talk Mr Neikee")
					if(!Progress["Meet Mr Neikee"] && Progress["Read Poster"]) return "I'm sorry to hear your child is missing."
					else if(!Progress["Meet Mr Neikee"] && !Progress["Read Poster"]) return "You and your family seem distraught.."

					else
						if(!Progress["Sherman1"]) return "Hello, I'm looking for the Whitereach Gymleader?"
						else if(Progress["Sherman1"] && !Progress["Sherman2"]) return "I'll help you get your gym back up and running"
						else if(Progress["Sherman2"] && Progress["IceTrainersFound"] <3 && !Progress["Sherman3"]) return "I still haven't found 3 ICE-type trainers."
						else if(Progress["Sherman2"] && Progress["IceTrainersFound"] >=3  && !Progress["Sherman3"]) return "3 ICE-type trainers are on their way here."
						else if(Progress["Sherman3"] && !Progress["Sherman4"] && !USR.AddPKMNParty()) return "I still don't have room in my party."
						else if(Progress["Sherman3"] && !Progress["Sherman4"] && USR.AddPKMNParty()) return "I have made room in my party."
						else if(Progress["Sherman4"] && !Progress["Finish Gym"] != "Sherman") return "I still need to submit the form to Nurse Joy."
						else if(Progress["Sherman3"] && Progress["Finish Gym"] != "Sherman") return "I'm ready for my gym battle!"
		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/counter = 1
			if(Progress["Found Smith Email"])
				Send += "[counter++]. I slyly read my Uncle's email while he wasn't looking. Apparently there is a huge search for a trainer from Net City who has gone missing. My uncle referred this trainer to NEXUS, so the parents are wondering if he has seen him..<BR><BR>"
			if(Progress["Read Poster"])
				Send += "[counter++]. I stumbled upon a poster in Net City about another Pokemon Trainer, recently missing. He was last seen heading towards the Elkvale Woods. If anyone has any details, they are to talk to the parents, a local business owner.<BR><BR>"
			if(P.client) P<<output(Send, "QuestBrowser")
		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			if(Done)
				if(String == "PokedexButtonCheck") return 1
				return 0//This is so the code doesn't have to look over all the options.
			var/mob/Player/P = USR
			switch(String)
				if("Talk to Mr Neikee")
					if(!Progress["Meet Mr Neikee"])
						if(Progress["Read Poster"]) if(P) P.ScrollText("Mr Neikee", "Yes.. I was putting them up around town. I was hoping some trainers might extend their search to the Elkdale Woods.")
						if(P) P.ScrollText("Mr Neikee", "Me and my family just do not know what to do. Our son has been missing for 3 weeks now. He left saying he was going to become a Pokemon trainer, but he is much to young to be out in the wild alone! ")
						if(P) P.ScrollText("Mr Neikee", "We are hoping that any trainers passing through the Elkvale Woods will keep an eye for him.. bring him back home.")
						if(P) P.ScrollText("Mr Neikee", "Yes.. I was putting them up around town. I was hoping some trainers might extend their search to the Elkdale Woods.")
						if(P) P.ScrollText("Mr Neikee", "Of course, as the owner of the Neikee Shoe Factory owner, I will offer a large reward to anyone who can offer up news of my son.")
						Progress["Meet Mr Neikee"] = 1
						if(P) P.UpdateQuestButtonNEW(src)



					else if(!Progress["Meet Mr Neikee"] && !Progress["Read Poster"]) return "You and your family seem distraught.."
				if("Found Smith Email")
					Progress["Found Smith Email"] = 1

				if("Read Poster")
					if(istype(Atom1, /obj/deco/PKMNCenter/Poster/Lost_Child)) //Quest related Poster
						Progress["Read Poster"] = 1
						if(P) P.UpdateQuestButtonNEW(src)



mob/NPC/Quest/A_Boy_With_a_Pair_of_Shoes
	icon = 'NPC.dmi'
	Mr_Neikee
		icon_state = "Ray Dad"
	Ray
		icon_state = "Ray"

mob/NPCTrainer/Quest/A_Boy_With_a_Pair_of_Shoes
	Ursaring1
		name = "Ursaring Body Guard"
		icon = '217Ursaring.dmi'
		Partner = /mob/NPCTrainer/Quest/A_Boy_With_a_Pair_of_Shoes/Ursaring2
		Pokes = list(\
				list("type" = /mob/Pokemon/Ursaring, "level" = 26, "moves" = list(/obj/Moves/Swift,/obj/Moves/Earthquake,/obj/Moves/Leer ,/obj/Moves/Sleep_Talk,/obj/Moves/Rest,/obj/Moves/Snore)))

	Ursaring2
		name = "Ursaring Body Guard"
		icon = '217Ursaring.dmi'
		Partner = /mob/NPCTrainer/Quest/A_Boy_With_a_Pair_of_Shoes/Ursaring1
		Pokes = list(\
				list("type" = /mob/Pokemon/Ursaring, "level" = 26, "moves" = list(/obj/Moves/Roar,/obj/Moves/Slash,/obj/Moves/Screech ,/obj/Moves/Rock_Throw,/obj/Moves/Rest,/obj/Moves/Snore)))





//Fire VS Ice//-------------------------------------------------------------------------------------------------------------------

obj/Quest
	Fire_VS_Ice
		AddOverlays(var/mob/Player/P)
			if(Progress["Watch First Cutscene"])
				for(var/mob/NPC/Quest/Fire_VS_Ice/Felix/F in world)
					if(Progress["Finish Gym"] == "Felix" && F.QuestMarker == 2) P.AddScreenOverlay('NPC.dmi',"Felix",F,"FelixGym",30)
					else if(!Progress["Finish Gym"] && Progress["Finish Gym"] != "Felix" && F.QuestMarker == 1) P.AddScreenOverlay('NPC.dmi',"Felix",F,"FelixGym",30)
				for(var/mob/NPC/Quest/Fire_VS_Ice/Sherman/F in world)
					if(Progress["Finish Gym"] == "Sherman" && F.QuestMarker == 2) P.AddScreenOverlay('NPC.dmi',"Sherman",F,"ShermanGym",30)
					else if(!Progress["Finish Gym"] && Progress["Finish Gym"] != "Sherman" && F.QuestMarker == 1) P.AddScreenOverlay('NPC.dmi',"Sherman",F,"ShermanGym",30)

		Chat_Check(var/mob/Player/USR, var/String)
			switch(String)
				if("Talk to Sherman")
					if(!Progress["Watch First Cutscene"]) return 0
					else
						if(!Progress["Sherman1"]) return "Hello, I'm looking for the Whitereach Gymleader?"
						else if(Progress["Sherman1"] && !Progress["Sherman2"]) return "I'll help you get your gym back up and running"
						else if(Progress["Sherman2"] && Progress["IceTrainersFound"] <3 && !Progress["Sherman3"]) return "I still haven't found 3 ICE-type trainers."
						else if(Progress["Sherman2"] && Progress["IceTrainersFound"] >=3  && !Progress["Sherman3"]) return "3 ICE-type trainers are on their way here."
						else if(Progress["Sherman3"] && !Progress["Sherman4"] && !USR.AddPKMNParty()) return "I still don't have room in my party."
						else if(Progress["Sherman3"] && !Progress["Sherman4"] && USR.AddPKMNParty()) return "I have made room in my party."
						else if(Progress["Sherman4"] && !Progress["Finish Gym"] != "Sherman") return "I still need to submit the form to Nurse Joy."
						else if(Progress["Sherman3"] && Progress["Finish Gym"] != "Sherman") return "I'm ready for my gym battle!"
				if("Talk to Felix")
					if(!Progress["Watch First Cutscene"]) return 0
					else
						if(!Progress["Felix1"]) return "Hello, I'm looking for the Whitereach Gymleader?"
						else if(Progress["Felix1"] && !Progress["Felix2"]) return "I'll help you get your gym back up and running"
						else if(Progress["Felix2"] && Progress["FireTrainersFound"] <3 && !Progress["Felix3"]) return "I still haven't found 3 ICE-type trainers."
						else if(Progress["Felix2"] && Progress["FireTrainersFound"] >=3  && !Progress["Felix3"]) return "3 ICE-type trainers are on their way here."
						else if(Progress["Felix3"] && !Progress["Felix4"] && !USR.AddPKMNParty()) return "I still don't have room in my party."
						else if(Progress["Felix3"] && !Progress["Felix4"] && USR.AddPKMNParty()) return "I have made room in my party."
						else if(Progress["Felix4"] && !Progress["Finish Gym"] != "Felix") return "I still need to submit the form to Nurse Joy."
						else if(Progress["Felix3"] && Progress["Finish Gym"] != "Felix") return "I'm ready for my gym battle!"
		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/c = 1
			if(Progress["Watch First Cutscene"])
				Send += "[c++]. I stumbled upon an argument in the Pokemon Center between Felix and Sherman, potential gymleaders for Kindleheart and Whitereach respectively. They were told that their gyms currently do not meet the requirements to be in the Joleon Pokemon League. Only one of them can become the gymleader though. I should consider helping who I want to challenge for my next badge.<BR><BR>"
			if(P.client) P<<output(Send, "QuestBrowser")

		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			var/mob/Player/P = USR
			if(!isPlayer(P)) return
			switch(String)
				if("Talk to Sherman")
					if(!Progress["Watch First Cutscene"]) return 0
					else
						if(!Progress["Sherman1"])
							if(P) P.ScrollText("Sherman", "You would be talking to him. I am Captain Sherman Axen, of the Johto 22nd Navy Fleet!!")
							if(P) P.ScrollText("Sherman", "Unfortunately, my gym is undergoing some developments.. I need to desperately find some trainers who are willing to train under me. ")
							if(P) P.ScrollText("Sherman", "Perhaps you would join me, helping me rebuild my gym? I promise you a gym battle after the gym is up and running!")


							Progress["Sherman1"] = 1
						else if(Progress["Sherman1"] && !Progress["Sherman2"]) return "I'll help you get your gym back up and running"
						else if(Progress["Sherman2"] && Progress["IceTrainersFound"] <3 && !Progress["Sherman3"]) return "I still haven't found 3 ICE-type trainers."
						else if(Progress["Sherman2"] && Progress["IceTrainersFound"] >=3  && !Progress["Sherman3"]) return "3 ICE-type trainers are on their way here."
						else if(Progress["Sherman3"] && !Progress["Sherman4"] && !P.AddPKMNParty()) return "I still don't have room in my party."
						else if(Progress["Sherman3"] && !Progress["Sherman4"] && P.AddPKMNParty()) return "I have made room in my party."
						else if(Progress["Sherman4"] && !Progress["Finish Gym"] != "Sherman") return "I still need to submit the form to Nurse Joy."
						else if(Progress["Sherman3"] && Progress["Finish Gym"] != "Sherman") return "I'm ready for my gym battle!"
				if("Talk to Felix")
					if(!Progress["Watch First Cutscene"]) return 0
					else
						if(!Progress["Felix1"]) return "Hello, I'm looking for the Whitereach Gymleader?"
						else if(Progress["Felix1"] && !Progress["Felix2"]) return "I'll help you get your gym back up and running"
						else if(Progress["Felix2"] && Progress["FireTrainersFound"] <3 && !Progress["Felix3"]) return "I still haven't found 3 ICE-type trainers."
						else if(Progress["Felix2"] && Progress["FireTrainersFound"] >=3  && !Progress["Felix3"]) return "3 ICE-type trainers are on their way here."
						else if(Progress["Felix3"] && !Progress["Felix4"] && !P.AddPKMNParty()) return "I still don't have room in my party."
						else if(Progress["Felix3"] && !Progress["Felix4"] && P.AddPKMNParty()) return "I have made room in my party."
						else if(Progress["Felix4"] && !Progress["Finish Gym"] != "Felix") return "I still need to submit the form to Nurse Joy."
						else if(Progress["Felix3"] && Progress["Finish Gym"] != "Felix") return "I'm ready for my gym battle!"
				if("TransportStep")
					if(Atom1 == "/turf/transporting/Whitereach/PokemonCenterEntrance" || Atom1 == "/turf/transporting/Kindleheart/PokemonCenterEntrance")
						if(!Progress["Watch First Cutscene"])
							//Set up Scene
							var/obj/Quest/Fire_VS_Ice/F = new(locate(P.x + 1, P.y + 4,P.z)) // Right
							var/obj/Quest/Fire_VS_Ice/S = new(locate(P.x - 1, P.y + 4,P.z)) //Left
							P.AddScreenOverlay('NPC.dmi',"Felix",F)
							P.AddScreenOverlay('NPC.dmi',"Sherman",S)
							F.dir = 8
							S.dir = 4

							//Start Cutscene
							P.overlays += /obj/HUD/OMG
							spawn(10)
								P.overlays -= /obj/HUD/OMG
								if(P) P.ScrollText("????", "Felix, you cannot honestly expect me to step down from my post as Gymleader!")
								if(P) P.ScrollText("Felix", "You have no choice you old geiser. The last badge you gave out was to one of the Trainers funded by Nexus.. and that was last year!")
								if(P) P.ScrollText("Felix", "You are just to dumb to realize people are adapting, and we have all moved onto Kindleheath.")
								if(P) P.ScrollText("Felix", "The Naive stay in Whitereach!")
								if(P) P.ScrollText("????", "You will treat Captain Sherman Axen, of the Johto 22nd Navy Fleet, with a bit of respect. ")
								if(P) P.ScrollText("Sherman", "Also remember that I use to watch you when you were a youngin, back when you enjoyed the peace that Whitereach brings.")
								if(P) P.ScrollText("Felix", "Whatever...")
								if(P) P.ScrollText("Felix", "When Nurse Joy comes for my Gym inspection, she will make me the Gymleader of this region!")
								if(P) P.ScrollText("Nurse Joy", "Felix, it is true that there can only be one gymleader in this region of Joleon.")
								if(P) P.ScrollText("Nurse Joy", "However, from what I have heard, neither you or Shermans Gyms would pass inspection.")
								F.dir = 1
								S.dir = 1
								F.overlays += /obj/HUD/OMG
								S.overlays += /obj/HUD/OMG
								sleep(15)
								F.overlays -= /obj/HUD/OMG
								S.overlays -= /obj/HUD/OMG
								if(P) P.ScrollText("Felix", "What do you mean?!")
								if(P) P.ScrollText("Nurse Joy", "In order for a Gym to pass an inspection, it must have a selection of trainers that train under the Gymleader. Currently you both have none.")
								if(P) P.ScrollText("Nurse Joy", "Second, it costs 10000 for a Gymleaders license. Felix, you have not paid that yet, and Sherman your license is expired.")
								if(P) P.ScrollText("Nurse Joy", "When either of you are ready for an inspection, come see me or my sister.")
								if(P) P.ScrollText("Nurse Joy", "Until then, you both can continue your bickering in private, you are holding up the line.")
								if(P) P.ScrollText("Felix", "Whatever...")
								if(P) P.ScrollText("Sherman", "Very Well...")
								P.FadetoBlack()
								del F
								del S
								P.FadefromBlack()
								if(P) P.UpdateQuestButtonNEW(src)


							//Finish Cutscene
								Progress["Watch First Cutscene"] = 1
								AddOverlays(P)
//NPCS and TRAINERS
mob/NPC/Quest/Fire_VS_Ice
	Felix
		invisibility = 1
		density = 0
	Sherman
		invisibility = 1
		density = 0
//Intro Scene
obj/Quest/Fire_VS_Ice
	OBJ
		Construction_Barrior

	NPC
		invisibility = 99
		Felix
		Sherman
		//These are the NPCs that appear before the gym is built.
		Felix
			invisibility = 1
			density = 0
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/Fire_VS_Ice)
					if(!Progress) return 1
					else if(Progress["FelixGymComplete"] >= 2) return 1 //They can step on him, IF they complete his Gym
					else return 0
		ShermanGym1
			name = "Sherman"
			invisibility = 1
			density = 0
			Click()
				dir = get_dir(src,usr)
				spawn(100) dir = initial(dir)
				var/mob/Player/P = usr
				P.QuestCheck("Talk to Felix")
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/Fire_VS_Ice)
					if(Progress && Progress["FelixGymComplete"] >= 2) return 1 //They can step on him, IF they complete his Gym
					else return 0
//Wake Up, Snorlax!//-------------------------------------------------------------------------------------------------------------

obj/Quest
	Wake_Up_Snorlax
		name = "Wake Up, Snorlax!"
		var/SnorlaxWoken = 0
		AddOverlays(var/mob/Player/P)
			for(var/obj/Quest/Wake_Up_Snorlax/Snorlax/DC in world)
				if(Progress["WakeSnorlax[CoordsToNum(DC.x,DC.y,DC.z)]"])
					P.RemovebyID("SleepingSnorlax[CoordsToNum(DC.x,DC.y,DC.z)]")

		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/c = 1
			Send += "[c++]. Snorlax Valley was blocked by a sleeping Snorlax. Typical. I will have to wake it up to proceed.<BR><BR>"
			if(Progress["Talk to Camper Will"])
				Send += "[c++]. I met with a Camper named will at the entrance to Snorlax Valley. He suggested I find a Pokeflute to wake the slumbering Pokemon...<BR><BR>"
			if(Progress["Meet Pip"])
				Send += "[c++]. I met Pip in Elkvale. He says that he has a Pokeflute and can play it quite well. I should ask him to come along, his services may be useful.<BR><BR>"
			if(SnorlaxWoken)
				Send += "[c++]. Pip's Pokeflute worked! The Snorlax wasn't too happy about being awaken, but it was a great battle. I have awoken [SnorlaxWoken] Snorlax with Pip's assistance.<BR><BR>"
			if(SnorlaxWoken >= 3)
				Send += "[c++]. I cleared the Snorlax Valley of all sleeping Snorlax. Pip said he was going to head home, so I will see him again if I ever need his help.<BR><BR>"
			if(P.client) P<<output(Send, "QuestBrowser")

		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			var/mob/Player/P = USR
			if(!isPlayer(P)) return
			switch(String)
				if("Logout")
					var/mob/M = P.Following[1]
					if(istype(M, /mob/Quest/Wake_Up_Snorlax/Pokeflute_Guy_Pip))
						del M
					M = P.Following[2]
					if(istype(M, /mob/Quest/Wake_Up_Snorlax/Pokeflute_Guy_Pip))
						del M
				if("Initiate Snorlax Battle")
					if(P) P.ScrollText("Snorlax", "A wild Snorlax wants to battle.",'143.png')
					if(P) P.ScrollText("Snorlax", "(This Pokemon can be caught in battle).",'143.png')
					if(P)
						var/mob/NPCTrainer/Quest/Wake_Up_Snorlax/SnorlaxWILD/O = new //Make a new mob
						var/PartnerX
						SnorlaxWoken += 1
						if(P.Partner && ispath(P.Partner))
							PartnerX = P.Partner
							P.Partner = null
						O.Challenge(P)
						if(SnorlaxWoken <= 1)
							if(P) P.UpdateQuestButtonNEW(src)
						else if(SnorlaxWoken >= 3)
							if(P) P.UpdateQuestButtonNEW(src, "finished")
						AddOverlays(P)
						del O
						if(PartnerX) P.Partner = PartnerX


				if("Wake Snorlax")
					var/obj/Quest/Wake_Up_Snorlax/Snorlax/S = Atom1
					if(!Progress["WakeSnorlax[CoordsToNum(S.x,S.y,S.z)]"])
						Progress["WakeSnorlax[CoordsToNum(S.x,S.y,S.z)]"] = 1
						P.QuestCheck("Initiate Snorlax Battle")
				if("Click Set Partner")
					var/mob/Quest/Wake_Up_Snorlax/Pokeflute_Guy_Pip/F = P.Following[1]
					if(istype(F,/mob/Quest/Wake_Up_Snorlax/Pokeflute_Guy_Pip))
						if(P) P.ScrollText("Pokeflute Guy Pip", "Do you want me to head out? You still have [F.SongsLeft] songs to be played.",'Gentleman2.png')
						if(P) if(alert(usr,"Leave Pip?",,"Yes","No") == "Yes")
							P.ScrollText("Pokeflute Guy Pip", "I think I am gonna head back to Elkvale. Come see me if you need my services again! Bye.",'Gentleman2.png')
							P.FadetoBlack()
							del F
							for(var/mob/Quest/Wake_Up_Snorlax/Pokeflute_Guy_Pip/DC in world)
								var/image/L = image('NPC.dmi', DC ,"Pokeflute Guy",MOB_LAYER+1)
								P.SavedImages += L
								L.ID = "Pokeflute Guy Pip"
								P << L
							P.FadefromBlack()

				if("Talk to Snorlax Camper")
					if(SnorlaxWoken < 3)
						if(P) P.ScrollText("Camper Will", "Some of my friends headed farther down the trail yesterday, but when I came along this Snorlax was here. Is there any way around?.. Someone mentioned something about a Pokeflute, but I have no idea where to find one.",'Gentleman2.png')
						if(P) if(!Progress["Talk to Camper Will"])
							Progress["Talk to Camper Will"] = 1
							if(P) P.UpdateQuestButtonNEW(src)

					else
						if(P) P.ScrollText("Camper Will", "I actually dont know where my friends headed, I think I may be a little lost..",'Gentleman2.png')

				if("Talk to Pip")
					if(!Progress["Meet Pip"])
						Progress["Meet Pip"] = 1
						if(P) P.ScrollText("???", "Whoa, hey there youngster. My name is Pip, and I am a certified Pokeflute player. Not to toot my own work, but I might be the best Pokeflute player in all of Joleon!.",'Gentleman2.png')
						if(P) P.ScrollText("Pokeflute Guy Pip", "And what you ask is a Pokeflute? A Pokeflute is a magical instrument that can awaken any Pokemon, no matter how deeply they slumber..",'Gentleman2.png')
						if(P) P.ScrollText("Pokeflute Guy Pip", "I am also a huge hit at birthday parties!",'Gentleman2.png')











obj/Quest/
	Wake_Up_Snorlax
		Snorlax
			icon = '143Snorlax.dmi'
			icon_state = "QuestSleep"
			invisibility = 1
			SteppedOn(var/mob/M)

				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/Wake_Up_Snorlax)
					for(var/mob/Player/p in loc)
						return 0
					if(Progress && Progress["WakeSnorlax[CoordsToNum(x,y,z)]"]) return 1
					else
						P.QuestAdd(/obj/Quest/Wake_Up_Snorlax)
						if(P) P.ScrollText("Snorlax", "A sleeping Snorlax blocks your path.",'143.png')
						return 0


				else return 1
		Snorlax_Camper
			icon = 'NPC.dmi'
			icon_state = "Camper"
			Click()
				var/mob/Player/P = usr
				P.QuestAdd(/obj/Quest/Wake_Up_Snorlax)
				P.QuestCheck("Talk to Snorlax Camper")

mob/Quest/Wake_Up_Snorlax
	Pokeflute_Guy_Pip
		icon = 'NPC.dmi'
		icon_state = "Pokeflute Guy"
		invisibility = 1
		var/SongsLeft
		var/Owner
		Click()
			var/mob/Player/P = usr
			P.TalkingTo += "Pip"
			P.QuestAdd(/obj/Quest/Wake_Up_Snorlax)
			P.QuestCheck("Talk to Pip")


			//If he is following you?
			if(src == P.Following[1] && Owner == P.ckey) //He is following you and belongs to you
				if(P) P.ScrollText("Pokeflute Guy Pip", "Do you want me to play a song?",'Gentleman2.png')
				if(P) if(alert(usr,"Have Pip play a song? He can play [SongsLeft] more songs",,"Yes","No") == "Yes")
					P.frozen = 1
					P<<System("Pokeflute Guy Pip pulls out his Pokeflute and plays!")
					dir = 2
					overlays += image('Moves.dmi',"PokeflutePlay")
					overlays += image('Clothing.dmi',"Pokeflute")
					sleep(50)
					overlays -= image('Moves.dmi',"PokeflutePlay")
					overlays -= image('Clothing.dmi',"Pokeflute")
					P.frozen = 0
					SongsLeft -= 1
					for(var/obj/Quest/Wake_Up_Snorlax/Snorlax/S in range(2,src))
						P.QuestCheck("Wake Snorlax", S)
						break //You can only wake ONE snorlax
					if(SongsLeft <= 0) //No more songs
						P.ScrollText("Pokeflute Guy Pip", "I have played my 5 songs, I think I am gonna head back to Elkvale. Come see me if you need my services again! Bye.",'Gentleman2.png')
						P.FadetoBlack()

						for(var/mob/Quest/Wake_Up_Snorlax/Pokeflute_Guy_Pip/DC in world)
							var/image/L = image('NPC.dmi', DC ,"Pokeflute Guy",MOB_LAYER+1)
							P.SavedImages += L
							L.ID = "Pokeflute Guy Pip"
							P << L
						loc = null
						P.FadefromBlack()
						del src
			else if(!Owner)
				if(P) P.ScrollText("Pokeflute Guy Pip", "For my services, I will follow you around and play my flute whenever you want. The cost is 1000 Pokedollars",'Gentleman2.png')
				if(P)
					if(P.Money <= 999)
						if(P) P.ScrollText("Pokeflute Guy Pip", "However, I see you are a little short on change. Come back when you have some money",'Gentleman2.png')
						P.TalkingTo -= "Pip"
						return
					if(P.Following[1])
						if(P) P.ScrollText("Pokeflute Guy Pip", "It seems you already have someone acompanying you on your journey. Come back when you have less company.",'Gentleman2.png')
						P.TalkingTo -= "Pip"
						return
				if(P) if(alert(usr,"Hire Pip for 1000 Pokedollars?",,"Yes","No") == "Yes")
					P.FadetoBlack()
					var/mob/Quest/Wake_Up_Snorlax/Pokeflute_Guy_Pip/Pip = new(get_step(P, turn(P.dir,180)))
					P.RemovebyID("Pokeflute Guy Pip")
					Pip.SongsLeft = 5
					Pip.invisibility = 0
					P.Money -= 1000
					P.FadefromBlack()
					P.Following[1] = Pip
					Pip.Owner = P.ckey
					if(P) P.ScrollText("Pokeflute Guy Pip", "I will play 5 songs for you, just talk to me if you would like me to play.",'Gentleman2.png')
			P.TalkingTo -= "Pip"

		BumpedInto(var/atom/A)
			if(isPlayer(A))
				var/mob/Player/M = A
				var/turf/T = get_step(M,M.dir)
				if(T.contents.Find(src)) M.loc = loc //Weird.. for some reason Bump activates when not facing Pip

mob/NPCTrainer
	Quest/Wake_Up_Snorlax
		Pokeflute_Guy_Pip
			Tradable = 0
			icon = 'NPC.dmi'
			icon_state = "Pokeflute Guy"
			ClothingOverlays = list()
			Pokes = list(\
				list("catchable" = 1, "type" = /mob/Pokemon/Snorlax, "set level" = 25, "moves" = list(/obj/Moves/Rest,/obj/Moves/Snore,/obj/Moves/Sleep_Talk,/obj/Moves/Rollout ,/obj/Moves/Body_Slam,/obj/Moves/Rollout)))

		SnorlaxWILD
			invisibility = 1
			Tradable = 0
			Pokes = list(\
				list("catchable" = 1, "type" = /mob/Pokemon/Snorlax, "set level" = 25, "moves" = list(/obj/Moves/Rest,/obj/Moves/Snore,/obj/Moves/Sleep_Talk,/obj/Moves/Rollout ,/obj/Moves/Body_Slam,/obj/Moves/Rollout)))



//Going for the Gold//------------------------------------------------------------------------------------------------------------------------------------------------------------------------
obj/Quest
	Going_for_the_Gold
		var/list/Parts = list() //These are parts of the scene that must be deleted when completed and at loggout.
		var/
			obj/Cassidy
			obj/Butch
			obj/Quest/Going_for_the_Gold/Player_Loc/PL


			var/UpdateCheck = 0



		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/c = 1
			if(Progress["Meet Gym Assistant Tyler"])
				Send += "[c++]. I met the Gym Assistant, Tyler. He said that the Gymleader, Corey, is currently at his archelogical dig. It is conviently placed beside the gym.<BR><BR>"
			if(Progress["Meet Gymleader Corey"])
				Send += "[c++]. I found Gymleader Corey in the Sand Cavern. He's been on an archelogical dig, looking for fossils and such. Just as we were about to leave for the gym, he noticed his Notebook is missing. He won't leave until we find it....What a drag..<BR><BR>"
			if(Progress["Found Book"])
				Send += "[c++]. I finally found Corey's Notebook. It seems to detail some information about the fossiled Pokemon he found.. I should get it back to him as soon as possible.<BR><BR>"
			if(Progress["Meet ButchCassidy"])
				Send += "[c++]. There was a pair of Rockets, Butch and Cassidy, roaming the Sand Cavern. They seem to be looking for gold, but as far as I can tell, there is only fossils in this cave..<BR><BR>"
			if(Progress["Beat Rockets"])
				Send += "[c++]. I defeated the two rockets, hopefully I won't see them in this maze anymore. I should get back to Corey.<BR><BR>"
			if(Progress["Given Notebook"])
				Send += "[c++]. Corey was relieved to see his Notebook. We decided to head to the Gym.<BR><BR>"
			if(P.Badges["Tectonic"])
				Send += "[c++]. I challenged Corey to a Gym Battle once we returned to the Gym. It was a feirce battle, but I finally got my <b>Tectonic Badge</b><BR><BR>"
			if(P.client) P<<output(Send, "QuestBrowser")

		AddOverlays(var/mob/Player/P)
			if(!Done && !Progress["Given Notebook"])  //Rocket Result determines if you win or loose against Butch or Cassidy
				//Footsteps, while Quest is acitve.
				for(var/obj/Quest/Going_for_the_Gold/Footprints/F in world)
					P.AddScreenOverlay('Cave.dmi',"Footprints",F,"Sand Footprints",MOB_LAYER+1)
			if(Progress["Meet Gym Assistant Tyler"] && !Progress["Given Notebook"])
				for(var/mob/NPC/Quest/Going_for_the_Gold/Gymleader_Corey/GC in world)
					P.AddScreenOverlay('NPC.dmi',"Corey",GC,"GL Corey Cave",MOB_LAYER+1)
			if(Progress["Meet Gymleader Corey"])
				for(var/obj/Quest/Going_for_the_Gold/Coreys_Notebook/N in world)
					P.AddScreenOverlay('Important Items.dmi',"Coreys Notebook",N,"Notebook GFTG",MOB_LAYER+1)
			if(Progress["Given Notebook"])
				for(var/mob/NPC/Quest/Going_for_the_Gold/Gymleader_Corey2/GC in world)
					P.AddScreenOverlay('NPC.dmi',"Corey",GC,"GL Corey Gym",MOB_LAYER+1)



		Chat_Check(src, TalkTo)
			var/mob/Player/P = src
			if(!isPlayer(P)) return 0
			//Find Fossil//------------------------------------------------------
			var/Notebook = null //Do they have the notebook on them?
			for(var/obj/Important_Items/Coreys_Notebook/N in usr.contents) Notebook = N

			switch(TalkTo)
				//If this is running, they have already had the Quest added.
				if("Talk to Gym Assistant Tyler")
					if(!Progress["Meet Gym Assistant Tyler"])
						return "I am looking for the Gymleader, Corey"
					if(!Progress["Corey Return"])
						return "I still haven't found Corey..."
					else if(Progress["Corey Return"])
						return "How has the Gym been doing?"
				if("Talk to Gymleader Corey")
					if(!Progress["Meet Gymleader Corey"])
						return "Are you the Gymleader?"
					if(Progress["Meet Gymleader Corey"] && !Progress["Given Notebook"] && !Notebook)
						return "I still haven't found your Notebook..."
					if(Progress["Meet Gymleader Corey"] && !Progress["Given Notebook"] && Notebook)
						return "Here! I found your notebook."
					if(Progress["Given Notebook"])
						return


		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			var/mob/Player/P = USR
			if(!isPlayer(P)) return
			//These are CHECKPOINTs not TRANSPORTERS. This means the objects have been placed where you step on them.
			if(String == "Checkpoint Check Exit Notebook Room" || String == "Checkpoint Check Enter Sand Maze")
				if(!Progress["Found Book"] || Progress["Beat Rockets"] || Progress["Given Notebook"] )
					return 1
				else if(Progress["Found Book"] && !Progress["Beat Rockets"]) //Once they return to the maze, they will hit this Checkpoint.
					//Atom1 is where they have stepped
					var/atom/CL = Atom1.loc //Camera Location
					if(P.TalkingTo["CassidyandButch"]) return 1
					P.TalkingTo["CassidyandButch"] = 1
					if(String == "Checkpoint Check Exit Notebook Room") //They come from the right
						Cassidy = new(locate(CL.x+9,CL.y,CL.z))
						Butch = new(locate(CL.x+10,CL.y,CL.z))
						P.AddScreenOverlay('NPC.dmi',"Cassidy Rocket",Cassidy,"Cassidy GFTG",MOB_LAYER+1)
						P.AddScreenOverlay('NPC.dmi',"Butch Rocket",Butch,"Butch GFTG",MOB_LAYER+1)
						for(var/i = 1, i <= 8, i++)
							step(Cassidy, WEST)
							step(Butch, WEST)
							sleep(2)
					if(String == "Checkpoint Check Enter Sand Maze")
						Cassidy = new(locate(CL.x,CL.y+9,CL.z))
						Butch = new(locate(CL.x,CL.y+10,CL.z))
						P.AddScreenOverlay('NPC.dmi',"Cassidy Rocket",Cassidy,"Cassidy GFTG",MOB_LAYER+1)
						P.AddScreenOverlay('NPC.dmi',"Butch Rocket",Butch,"Butch GFTG",MOB_LAYER+1)
						for(var/i = 1, i <= 8, i++)
							step(Cassidy, SOUTH)
							step(Butch, SOUTH)
							sleep(2)

					Cassidy.dir = get_dir(Cassidy, Butch)
					Cassidy.dir = get_dir(Butch, Cassidy)
					if(P) P.ScrollText("???", "Look! Another human being!", 'Cassidy.png')
					if(P) P.ScrollText("???", "Good Grief, I thought we would be stuck in this Maze forever!", 'Butch.png')
					if(!Progress["Meet ButchCassidy"])
						if(P) P.ScrollText("???", "Oh shoot! The motto!", 'Cassidy.png')
						sleep(15)
						if(P) P.ScrollText("???", "Prepare for trouble.", 'Cassidy.png')
						if(P) P.ScrollText("???", "And make it double", 'Butch.png')
						if(P) P.ScrollText("???", "To infect the world with devistation.", 'Cassidy.png')
						if(P) P.ScrollText("???", "To blight all people in every nation.", 'Butch.png')
						if(P) P.ScrollText("???", "To denounce the goodness of truth and love!", 'Cassidy.png')
						if(P) P.ScrollText("???", "To extend our reach to the stars above!", 'Butch.png')
						if(P) P.ScrollText("Cassidy", "Cassidy!", 'Cassidy.png')
						if(P) P.ScrollText("Butch", "And Butch of course!", 'Butch.png')
						if(P) P.ScrollText("Cassidy", "We are team rocket, circling Earth all day and night.", 'Cassidy.png')
						if(P) P.ScrollText("Butch", "Surrender to us now or youll surely lose the fight.", 'Butch.png')
						Progress["Meet ButchCassidy"] = 1

					if(P) P.ScrollText("Cassidy", "We heard there was gold in these ruins.", 'Cassidy.png')
					if(P) P.ScrollText("Cassidy","Hand over all your gold or else we attack.", 'Butch.png')

					if(!P.Partner)
						if(alert(usr,"The following battle is an 'Event Battle'. This means that if you have a partner with you, you will both gain Event Tokens for winning. If you accept this battle now, you will not get Event Tokens. If you Decline, you will be transported to a Pokemon Center without loosing any Pokedollars.","System","Accept","Decline") == "Decline") //They will find the Egg.
							P.loc = LocFromNum(P.DieLoc)
							P<<"<font color = red>(System) [P] blacked out."
							del Butch
							del Cassidy
							P.TalkingTo -= "CassidyandButch"
							return 1

					var/mob/NPCTrainer/Quests/Going_for_the_Gold/Team_Rocket_Executive_Cassidy/C = new //Make a new mob
					var/list/Q = C.Challenge(P)
					if(Q.Find(P)) //They won.
						if(P.Partner)
							P<<System("You and [P.Partner] have been awarded 15 tokens each for completing an 'Event Battle'!")
							P.Event_Tokens += 15
							P.Partner.Event_Tokens += 15
						Progress["Beat Rockets"] = 1
						sleep(20)
						if(P) P.ScrollText("Butch", "Looks like were blasting off like those other guys!",)
						P.FadetoBlack()
						del Cassidy; del Butch
						P.TalkingTo -= "CassidyandButch"
						P.FadefromBlack()
						if(P) P.UpdateQuestButtonNEW(src)
					else return 1
			switch(String)
				if("Find Coreys Notebook")
					Progress["Found Book"] = 1
					P<<System("You have found Corey's Notebook. <i> Added too Important Items</i>.")
					P.contents += new/obj/Important_Items/Coreys_Notebook/
					P.RemovebyID("Notebook GFTG")
					if(P) P.UpdateQuestButtonNEW(src)



				if("Talk to Gym Assistant Tyler")
					if(!Progress["Meet Gym Assistant Tyler"])
						if(P) P.ScrollText("Gym Assistant Tyler", "Hi there. I am Tyler, the Gymleaders assistant and legal guardian.")
						UpdateCheck = 1 //This is for the update. To know that the quest was started after it was updated.
						Progress["Meet Gym Assistant Tyler"] = 1
						for(var/mob/NPC/Quest/Going_for_the_Gold/Gymleader_Corey/GC in world)
							P.AddScreenOverlay('NPC.dmi',"Corey",GC,"GL Corey Cave",MOB_LAYER+1)
						if(P) P.UpdateQuestButtonNEW(src)
					if(!Progress["Corey Return"])
						if(P) P.ScrollText("Gym Assistant Tyler", "Corey currently is at the Excavation Site. The entrance is located in his home, which is right beside the Gym.")
					else if(Progress["Corey Return"])
						if(P) P.ScrollText("Gym Assistant Tyler", "Its a good thing you found Corey. Gym challenges are starting to pile up.")

				if("Win Tectonic Badge")
					Done = 1
					P.UpdateQuestButtonNEW(src)
				if("Talk to Gymleader Corey")
					var/Notebook = null //Do they have the notebook on them?
					for(var/obj/Important_Items/Coreys_Notebook/N in usr.contents) Notebook = N

					//They meet him for the first time, and he tells them he needs his notebook.
					if(!Progress["Meet Gymleader Corey"])
						if(usr) usr.ScrollText("Gymleader Corey", "Oh. Hi!",'Corey.png')
						if(usr) usr.ScrollText("Gymleader Corey", "Yes, I am the Gymleader of Mirage City, Corey. I hope you did not come looking for me down here. I know a lot of trainers get lost in this maze.",'Corey.png')
						if(usr) usr.ScrollText("Gymleader Corey", "We can go back to the Gym in just a second, I am just going to take down a final sketch of this fossil before we leave.",'Corey.png')
						if(usr) usr.ScrollText("Gymleader Corey", "Oh no... I cannot find my notebook! I need to find it before we leave, all my work is recorded there!",'Corey.png')
						UpdateCheck = 1 //This is for the update. To know that the quest was started after it was updated.
						Progress["Meet Gymleader Corey"] = 1
						P.UpdateQuestButtonNEW(src)
						for(var/obj/Quest/Going_for_the_Gold/Coreys_Notebook/N in world)
							P.AddScreenOverlay('Important Items.dmi',"Coreys Notebook",N,"Notebook GFTG",MOB_LAYER+1)
					if(Progress["Meet Gymleader Corey"] && !Progress["Given Notebook"] && !Notebook)
						if(usr) usr.ScrollText("Gymleader Corey", "I have been looking everywhere! I still cannot find my notebook!",'Corey.png')
					if(Progress["Meet Gymleader Corey"] && Notebook)
						Progress["Given Notebook"] = 1
						del Notebook
						usr.ScrollText("Gymleader Corey", "Oh thanks, you found it!",'Corey.png')

						usr.ScrollText("Gymleader Corey", "I have been in these tunnels for so long, I wonder if its worth it. I really have learned a lot.",'Corey.png')
						if(Progress["Beat Rockets"]) usr.ScrollText("Gymleader Corey", "What Team Rocket is here?!That is alarming.. I wonder what they wanted.",'Corey.png')

						var/list/TRRProgress = P.QuestReturnList(/obj/Quest/The_Revival_Rivalry)
						if(TRRProgress)
							usr.ScrollText("Gymleader Corey", "So you are here to retrieve one of my fossils? Yes, Professor Evans had sent message by pidgey that you were coming.",'Corey.png')
						else
							usr.ScrollText("Gymleader Corey", "You must be here to have a gym battle, am I right?!",'Corey.png')

						usr.ScrollText("Gymleader Corey", "Lets go to the Gym first, then we can talk. I dont want those Rockets showing up again.",'Corey.png')
						P.FadetoBlack()
						for(var/mob/NPC/Quest/Going_for_the_Gold/Gymleader_Corey2/GC in world)
							P.AddScreenOverlay('NPC.dmi',"Corey",GC,"GL Corey Gym",MOB_LAYER+1)
							P.loc = locate(GC.x, GC.y -1, GC.z)
						P.RemovebyID("GL Corey Cave")


						P.FadefromBlack()



obj/Quest/Going_for_the_Gold
	Camera_Spawn; invisibility = 1

	Footprints
		invisibility = 1
		icon = 'Cave.dmi'
		icon_state = "Footprints"

	Coreys_Notebook
		icon = 'Important Items.dmi'
		icon_state = "Coreys Notebook"
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P) || get_dist(P, src) >= 2) return
			P.QuestCheck("Find Coreys Notebook")

obj/Quest/Checkpoint //It checks with the quest, to see if they can pass this point.
	ExitNotebookRoom
		Checkpoint = "Exit Notebook Room"
	EnterSandMaze
		Checkpoint = "Enter Sand Maze"










mob/NPC/Quest
	Going_for_the_Gold
		Gym_Assistant_Tyler
			icon = 'MaleWhiteBase.dmi'
			Pointer = 1
			ClothingOverlays = list("Shoes"= "Black Shoes", "Robe"= "Brown Gentleman Suit", "Hair"="BirchHairBlack")
			DefaultResponses = list("What do you do here?")
			QuestsGiven = list("I am looking for the Gymleader, Corey." = /obj/Quest/Going_for_the_Gold)
			ChatResponses(var/Response, var/mob/Player/P)
				..()

		Gymleader_Corey
			invisibility = 1
			density = 0
			icon = 'NPC.dmi'
			icon_state = "Corey"
			Portrait = 'Corey.png'
			QuestsGiven = list("Are you the gymleader, Corey?" = /obj/Quest/Going_for_the_Gold)
			Pointer = 1
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					if(P.FindbyID("GL Corey Cave")) return 0 //They cannot step through the NPC
					else return 1

		Gymleader_Corey2
			icon = 'MaleWhiteBase.dmi'
			name = "Gymleader Corey"
			Portrait = 'Corey.png'
			invisibility = 1
			density = 0
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					if(P.FindbyID("GL Corey Gym")) return 0 //They cannot step through the NPC
					else return 1
			//This is the NPC you can challenge to get the gym badge..
			GiveResponses(var/mob/Player/P)
				var/list/RETURNS = list()
				if(P.Badges["Tectonic"]) RETURNS += "Would you ever want to have a rematch?"
				else RETURNS += "I challenge you to a Gym Match!"
				return RETURNS
			ChatResponses(var/Response, var/mob/Player/P)
				switch(Response)
					if("I challenge you to a Gym Match!")
						if(P) P.ScrollText("Gymleader Corey", "Now that I am back at the gym, I am ready to battle! Lets do this.",'Corey.png')
						var/mob/NPCTrainer/Gymleader/Gymleader_Corey/O = new //Make a new mob
						if(P.Partner)
							if(!ispath(P.Partner)) P.Partner.Partner = null
							P.Partner = null
						var/list/Q = O.Challenge(P)
						del O
						if(Q.Find(P)) //They won.
							P.Titles += "Tectonic Badge"
							usr<<System("You beat Corey. You have been awarded the Tectonic Badge.")
							if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Win.mid')
							if(usr) usr.ScrollText(src, "Wow. You sure are strong. Hopefully with some time you can help me dig for fossils.")
							if(usr) usr.ScrollText(src, "Here, take this. It is the Tectonic Badge, a symbol that you beat the Mirage City Gymleader.")
							if(usr)
								P.Badges["Tectonic"] += 1
								P.QuestCheck("Win Tectonic Badge")
										//Badge Accuiring Sound?
							if(usr) usr.ScrollText(src, "Alright, now back to digging for fossils.")





mob/NPCTrainer/Quests/Going_for_the_Gold
	Team_Rocket_Executive_Cassidy
		icon = 'NPC.dmi'
		icon_state = "Cassidy Rocket"
		ClothingOverlays = null
		Pokes = list(\
				list("type" = /mob/Pokemon/Raticate, "level" = 19, "moves" = list(/obj/Moves/Bite,/obj/Moves/Quick_Attack,/obj/Moves/Hyper_Fang,/obj/Moves/Toxic,/obj/Moves/Thunder,/obj/Moves/Scary_Face)),
				list("type" = /mob/Pokemon/Drowzee, "level" = 18, "moves" = list(/obj/Moves/Hypnosis,/obj/Moves/Confusion,/obj/Moves/Headbutt,/obj/Moves/Psychic,/obj/Moves/Poison_Gas,/obj/Moves/Disable)),
				list("type" = /mob/Pokemon/Houndour, "level" = 18, "moves" = list(/obj/Moves/Bite,/obj/Moves/Crunch,/obj/Moves/Flamethrower,/obj/Moves/Howl,/obj/Moves/Shadow_Ball,/obj/Moves/Ember)),
				list("type" = /mob/Pokemon/Sableye, "level" = 17, "moves" = list(/obj/Moves/Scratch,/obj/Moves/Mean_Look,/obj/Moves/Fury_Swipes,/obj/Moves/Night_Shade,/obj/Moves/Confuse_Ray,/obj/Moves/Shadow_Ball)),
				list("type" = /mob/Pokemon/Tentacruel, "level" = 19, "moves" = list(/obj/Moves/Poison_Sting,/obj/Moves/Wrap,/obj/Moves/Water_Gun,/obj/Moves/Bubblebeam,/obj/Moves/Acid,/obj/Moves/Water_Pulse)),
				list("type" = /mob/Pokemon/Granbull, "level" = 19, "moves" = list(/obj/Moves/Bite,/obj/Moves/Take_Down,/obj/Moves/Crunch,/obj/Moves/Charm,/obj/Moves/Metronome,/obj/Moves/Lick)),
				)

		TextAfterWin = "We are blasting off like those other fools."
	//	Portrait = 'Jesse.dmi'
		Partner = /mob/NPCTrainer/Quests/Going_for_the_Gold/Team_Rocket_Executive_Butch
		BattleSound = 'Villian Battle.mid'
	Team_Rocket_Executive_Butch
		icon = 'NPC.dmi'
		icon_state = "Butch Rocket"
		ClothingOverlays = null
		Pokes = list(\
				list("type" = /mob/Pokemon/Primeape, "level" = 19, "moves" = list(/obj/Moves/Low_Kick,/obj/Moves/Karate_Chop,/obj/Moves/Cross_Chop,/obj/Moves/Thunder_Punch,/obj/Moves/Thrash,/obj/Moves/Agility)),
				list("type" = /mob/Pokemon/Hitmontop, "level" = 21, "moves" = list(/obj/Moves/Rolling_Kick,/obj/Moves/Quick_Attack,/obj/Moves/Agility,/obj/Moves/Mach_Punch,/obj/Moves/Rapid_Spin,/obj/Moves/Triple_Kick)),
				list("type" = /mob/Pokemon/Mightyena, "level" = 19, "moves" = list(/obj/Moves/Bite,/obj/Moves/Taunt,/obj/Moves/Crunch,/obj/Moves/Take_Down,/obj/Moves/Leer,/obj/Moves/Scary_Face)),
				list("type" = /mob/Pokemon/Cloyster, "level" = 18, "moves" = list(/obj/Moves/Water_Gun,/obj/Moves/Ice_Beam,/obj/Moves/Water_Pulse,/obj/Moves/Take_Down,/obj/Moves/Barrier,/obj/Moves/Bubblebeam)),
				list("type" = /mob/Pokemon/Shuckle, "level" = 17, "moves" = list(/obj/Moves/Wrap,/obj/Moves/Toxic,/obj/Moves/Withdraw,/obj/Moves/Sludge_Bomb,/obj/Moves/Rest,/obj/Moves/Constrict)),
				)
		TextAfterWin = "We are blasting off like those other fools."
	//	Portrait = 'James.dmi'









//The Ridgetown Route Debate//
obj/Quest/The_Ridgetown_Route_Debate
	Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
		var/mob/Player/P = USR
		if(!isPlayer(P)) return
	//	switch(String)



//The Egg Theif//------------------------------------------------------------------------------------------------------------------

obj/Quest
	The_Egg_Theif
		AddOverlays(var/mob/Player/P)
			if(Progress["Beat Julie Info"])
				P.RemovebyID("DoorGuardJulie")
			if(Progress["Beat Julie Info"] && Progress["Beat Electabuzz"] < 2) //Not beaten the Electabuzz.
				for(var/mob/NPC/Quest/The_Egg_Theif/Omar/O in world)
					var/image/L = image('NPC.dmi', O ,"Omar",MOB_LAYER+1)
					P.SavedImages += L
					L.OBJ = O
					L.ID = "OmarEggTheifPowerPlant"
					P << L
				for(var/mob/NPC/Quest/The_Egg_Theif/ElectabuzzWILD/O in world)
					var/image/L = image('125Electabuzz.dmi', O ,"Walking",MOB_LAYER+1)
					P.SavedImages += L
					L.OBJ = O
					L.ID = "ElectabuzzEggTheif"
					P << L
			if(Progress["Beat Electabuzz"] >= 2)
				P.RemovebyID("ElectabuzzEggTheif")
				for(var/mob/NPC/Quest/The_Egg_Theif/Omar2/O in world)
					var/image/L = image('NPC.dmi', O ,"Omar",MOB_LAYER+1)
					P.SavedImages += L
					L.OBJ = O
					L.ID = "OmarEggTheifGym"
					P << L
			if(Progress["Do Quest"] && Progress["GotEgg"] && !Progress["GotMagnet"] && !Done)
				for(var/mob/NPC/Quest/The_Egg_Theif/ElectabuzzMom/O in world)
					P.AddScreenOverlay('125Electabuzz.dmi',"",O,"Egg Theif Electabuzz Mom",MOB_LAYER+1)

		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			var/mob/Player/P = USR
			if(!isPlayer(P)) return
			switch(String)
				if("Talk to PowerPlant Staff")
					if(Progress["Beat Electabuzz"] == 2 && Progress["Do Quest"] == 2) //They are able to do this part of the quest
						if(!Progress["JulieisEvil"])
							if(Atom1.name == Progress["RightEngineer"]) //They found the right engineer
								if(usr) usr.ScrollText(Atom1, "Ya, I saw their egg a few days ago actually. I saw Julie, Omars sister, gazing at it from behind the corner. She might know where it is.")
								P.UpdateQuestButtonNEW(src)
								Progress["JulieisEvil"] = 1
							else
								var/list/Say = list("No, I have not noticed anything relating to the Electabuzzs egg...", "Scram! I have to much work to do!","Egg? What Egg?...","Eh, sorry kid, I cant help you. I hasnt seen no egg in the power plant.")
								if(usr) usr.ScrollText(Atom1, "[pick(Say)]")


				if("DefeatElectabuzz") //This is called from this very proc after they defeat electabuzz
					Progress["Beat Electabuzz"] = 2
					AddOverlays(P)

					if(usr.TalkingTo.Find("OmarGL")) return 1
					usr.TalkingTo += "OmarGL"
					if(usr) usr.ScrollText("Omar", "Thank Arceus you were here to help, as much as I train my Pokemon I may have not been able to deal with them.",'Engineer1.png')
					if(usr) usr.ScrollText("Omar", "I did notice something while were battling though...",'Engineer1.png')
					if(usr) usr.ScrollText("Omar", "Some of those Electabuzz were female, and as much as the species loves to battle, the females generally will protect their eggs before taking the oppurtunity to battle. Hmmm!",'Engineer1.png')
					if(usr) usr.ScrollText("Omar", "One of their eggs must be missing!",'Engineer1.png')
					if(usr) usr.ScrollText("Omar", "Yes, that explains everything. The only problem is now I have another problem to deal with at the Gym. I could loose my liscense as a Gym Leader for allowing Julie to watch over the gym while I am away, I have to get back there right away.",'Engineer1.png')
					if(usr) usr.ScrollText("Omar", "If you help me, I will reward you, and then we will battle right away, I promise.",'Engineer1.png')
					if(alert(usr,"Help Omar?",,"Yes","No") == "Yes") //They will find the Egg.
						if(usr) usr.ScrollText("Omar", "Great! Start by talking to all the engineers and scientists in the building. They know this place better than anyone, and would have seen an egg being taken or moved.",'Engineer1.png')
						Progress["RightEngineer"] = pick("Engineer Bill","Engineer Dill","Engineer Hill","Engineer Nill","Engineer Will","Head Engineer Darwin","Scientist Mike","Scientist Ike")
						//This will define the right engineer to talk to complete this part of the quest.
						Progress["Do Quest"] = 2
					else // They don't want to find the Egg.
						if(usr) usr.ScrollText("Omar", "Oh, well thats fine..",'Engineer1.png')
						if(usr) usr.ScrollText("Omar", "I guess you're not really obligated to fufil such a duty anyways, your just a begginer trainer.",'Engineer1.png')
						Progress["Do Quest"] = 1
					P.UpdateQuestButtonNEW(src)

					if(usr) usr.ScrollText("Omar", "Anyways, I will be in the gym dealing with Julie.",'Engineer1.png')
					if(usr) usr.ScrollText("Omar", "Come see me when you are ready.",'Engineer1.png')
					var/mob/OMAR
					for(var/mob/NPC/Quest/The_Egg_Theif/Omar/O in world) //Find OMAR
						OMAR = O
					var/obj/Omar = new(OMAR.loc)
					var/image/L = image('NPC.dmi', Omar ,"Omar",MOB_LAYER+1)
					P << L
					Omar.dir = OMAR.dir
					Omar.invisibility = 1
					P.RemovebyID("OmarEggTheifPowerPlant") //Remove the original
					step(Omar, 8)
					sleep(3)
					for(var/i = 1, i <= 15, i++)
						step(Omar, 2)
						sleep(3)
					del Omar
					usr.TalkingTo -= "OmarGL"




				if("Talk to Omar2")
					if(P.Badges["Magnet"]) //They've won the match
						if(usr) usr.ScrollText("Omar", "Hi [P.name]",'Engineer1.png')
					else
						if(!Progress["See Fight"]) //They haven't seen the fight yet.
							if(Atom1) Atom1.dir = 1
							if(usr) usr.ScrollText("Omar", "Julie! Why are you pretending to be the gymleader!?! You KNOW I could get in some serious trouble for letting a minor and unskilled trainer act in my place!",'Engineer1.png')
							if(usr) usr.ScrollText("Julie", "Your just jealous because I am a better trainer than you! I beat plenty of trainers, and I was unstoppable!",'YoungGirl.png')
							if(usr) usr.ScrollText("Omar", "I had trainers coming to the powerplant demanding I give them a badge because you LOST to them!",'Engineer1.png')
							if(usr) usr.ScrollText("Julie", "Okay, well I only lost a couple times. And most times they cheated anyways.",'YoungGirl.png')
							if(usr) usr.ScrollText("Omar", "How did they cheat?",'Engineer1.png')
							if(usr) usr.ScrollText("Julie", "They had really strong Pokemon!",'YoungGirl.png')
							if(usr) usr.ScrollText("Omar", "GAHHHH!",'Engineer1.png')
							if(usr) usr.ScrollText("Omar", ".... .... .... .... .... .... .... .... ....",'Engineer1.png')
							if(usr) usr.ScrollText("Omar", "Oh... Hey [P.name]..",'Engineer1.png')
							Progress["See Fight"] = 1
						if(Atom1) Atom1.dir = get_dir(Atom1, usr)
						if(!Progress["GotEgg"]) //They haven't received the egg yet.
							if(Progress["Do Quest"] == 2) //They accepted the quest
								if(usr) usr.ScrollText("Omar", "So how is the case of the missing egg going?",'Engineer1.png')
								if(usr) usr.ScrollText("Omar", ".... ... .... .... .... .... .... ... ... ... ...",'Engineer1.png')

								if(Progress["JulieisEvil"]) //They've found out that Julie has the egg.
									if(Progress["JulieisEvil"] != 2) //They haven't seen Julie's confession
										Progress["JulieisEvil"] = 2
										if(usr) usr.ScrollText("Omar", "So they think Julie took the egg?..",'Engineer1.png')
										dir = 1
										if(usr) usr.ScrollText("Omar", "Julie did you take an egg from an Electabuzz next?..",'Engineer1.png')
										if(usr) usr.ScrollText("Julie", "Ya, Why?",'YoungGirl.png')
										if(usr) usr.ScrollText("Omar", "JULIE! That is stealing! Do you know how upset the mother of that egg is?",'Engineer1.png')
										if(usr) usr.ScrollText("Julie", "It looked like it needed someone to take care of it.. so I took it..",'YoungGirl.png')
										if(usr) usr.ScrollText("Omar", "*sighs* Well at least we know why the Electabuzz are angry. I know how they feel, Julie takes my things all the time.",'Engineer1.png')
										if(Atom1 && usr) Atom1.dir = get_dir(Atom1, usr)
										P.UpdateQuestButtonNEW(src)
									if(usr) usr.ScrollText("Omar", "[P.name], can you take this egg back to the Electabuzz, then I promise we will have our Gym Battle.",'Engineer1.png')

									if(!P.AddPKMNParty())
										if(usr) usr.ScrollText("Omar", "You already have 6 Pokemon with you, in order to take the egg, you need to deposit one in your PC. Come back when you have 5 or less Pokemon.",'Engineer1.png')

									else
										var/mob/Pokemon/Electabuzz/Mother = new
										var/mob/Pokemon/Machamp/Father = new
										Mother.Create(50)
										Father.Create(50)
										var/mob/Pokemon/Egg = Create_Egg(Mother, Father)
										if(istext(P)) world <<P
										else
											P.Party[P.AddPKMNParty()] = Egg
											Egg.Owner = P.ckey
										del Mother
										del Father
										P.UpdateQuestButtonNEW(src)
										Progress["GotEgg"] = 1
										P.UpdateParty()
										for(var/mob/NPC/Quest/The_Egg_Theif/ElectabuzzMom/O in world)
											P.AddScreenOverlay('125Electabuzz.dmi',"",O,"Egg Theif Electabuzz Mom",MOB_LAYER+1)




								else
									if(usr) usr.ScrollText("Omar", "So how is the case of the missing egg going?",'Engineer1.png')

							else if(Progress["Do Quest"] == 1) //They didn't accept the quest, they just want to gym battle.
								if(usr) usr.ScrollText("Omar", "So are you ready for our offical gym battle? I promise you I will be a lot harder than Julie was! ",'Engineer1.png')
								if(!usr) return
								var/mob/NPCTrainer/Gymleader/Gymleader_Omar/O = new //Make a new mob
								if(P.Partner)
									if(!ispath(P.Partner)) P.Partner.Partner = null
									P.Partner = null
								var/list/Q = O.Challenge(P)
								del O
								if(Q.Find(P)) //They won.
									P.Titles += "Magnet Badge"
									usr<<System("You beat Omar. You have been awarded the Magnet Badge Title.")
									P.UpdateQuestButtonNEW(src)
									if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Win.mid')
									if(usr) usr.ScrollText(src, "Wow. Julie was right when she said you were strong, but I guess I already knew that from the battle we had against the Electabuzz.")
									if(usr) usr.ScrollText(src, "Here, take this. It is the Magnet Badge, a symbol that you beat the Net City Gymleader.")
									if(usr)
										P.Badges["Magnet"] += 1
										Done = 1
										P.QuestCheck("Win Badge")
										//Badge Accuiring Sound?
									if(usr) usr.ScrollText(src, "Alright, now I must return to the Powerplant and find that egg.")

								usr.BackgroundMusic()

							else //He shouldn't be here...
								return 1
						else //They have recieved the egg
							//Check to see if the egg is no longer in the inventory.
							var/Egg
							for(var/mob/Pokemon/Poke in P.Party)
								//The Pokemon is an Elekid and is an Egg.
								if(istype(Poke,/mob/Pokemon/Elekid) && istype(Poke.Ball, /obj/Balls/Egg)) Egg = 1

							if(Egg) //They have the egg.
								if(usr) usr.ScrollText(src, "I see you still have that Electabuzz egg. The sooner you return it, the sooner we can have our gym battle.")
							else
								if(usr) usr.ScrollText(src, "So you returned the egg back to the Electabuzz? Thats great, I dont have to worry about that problem in the Power Plant anymore!.")
								if(usr) usr.ScrollText(src, "Now we can finally get to having our gym battle, but I warn you, I am not as easy as Julie!")
								if(usr)
									var/mob/NPCTrainer/Gymleader/Gymleader_Omar/O = new //Make a new mob
									if(P.Partner)
										if(!ispath(P.Partner)) P.Partner.Partner = null
										P.Partner = null
									var/list/Q = O.Challenge(P)
									del O
									if(Q.Find(P)) //They won.
										P.Titles += "Magnet Badge"
										usr<<System("You beat Omar. You have been awarded the Magnet Badge Title.")
										P.UpdateQuestButtonNEW(src)
										if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Win.mid')
										if(usr) usr.ScrollText(src, "Wow. Julie was right when she said you were strong, but I guess I already knew that from the battle we had against the Electabuzz.")
										if(usr) usr.ScrollText(src, "Here, take this. It is the Magnet Badge, a symbol that you beat the Net City Gymleader.")
										if(usr)
											P.Badges["Magnet"] += 1
											Done = 1
											P.QuestCheck("Win Badge")
											//Badge Accuiring Sound?


				if("Talk to Omar")
					if(!Progress["Beat Julie Info"]) return //They shouldn't be able to see him.
					if(Progress["Beat Electabuzz"] <= 2)
						if(!Progress["Beat Electabuzz"])
							if(usr.TalkingTo.Find("OmarGL")) return 1
							usr.TalkingTo += "OmarGL"
							if(usr) usr.ScrollText("Omar", "Who are you? Why are you in the Power Plant?",'Engineer1.png')
							if(usr) usr.ScrollText("Omar", "..... ..... ..... ..... ..... ..... ..... ..... ..... ..... ",'Engineer1.png')
							if(usr) usr.ScrollText("Omar", "WHAT?! Julie is posing as the Gymleader again? She always does this!",'Engineer1.png')
							if(usr) usr.ScrollText("Omar", "Okay, we will battle. But first I need to take care of this problem. The Electabuzz who live in and around the Power Plant have been really aggressive lately. They normally take out their anger by battling people, but our Engineers and Scientists do not have the time to deal with them or figure out why they are enraged. Will you quickly battle them with me, and then we will battle back at the gym?",'Engineer1.png')
							Progress["Beat Electabuzz"] = 1
							if(alert(usr,"Help Omar?",,"Yes","No") == "Yes")
								var/mob/NPCTrainer/Quest/The_Egg_Theif/ElectabuzzWILD/EE = new
								usr.Partner = /mob/NPCTrainer/Quest/The_Egg_Theif/OmarBattlePartner
								var/list/Q = EE.Challenge(usr)
								usr.Partner = null
								if(Q.Find(usr)) //They won.
									P.TalkingTo -= "OmarGL"
									P.QuestCheck("DefeatElectabuzz")
									return
								del EE

							usr.TalkingTo -= "OmarGL"
						else if(Progress["Beat Electabuzz"])// == 1)
							if(usr.TalkingTo.Find("OmarGL")) return 1
							usr.TalkingTo += "OmarGL"
							if(usr) usr.ScrollText("Omar", "Oh, you are back! Are you here to help me?",'Engineer1.png')
							if(alert(usr,"Help Omar?",,"Yes","No") == "Yes")
								var/mob/NPCTrainer/Quest/The_Egg_Theif/ElectabuzzWILD/EE = new
								usr.Partner = /mob/NPCTrainer/Quest/The_Egg_Theif/OmarBattlePartner
								var/list/Q = EE.Challenge(usr)
								usr.Partner = null
								if(Q.Find(usr)) //They won.
									P.TalkingTo -= "OmarGL"
									P.QuestCheck("DefeatElectabuzz")
									return
							usr.TalkingTo -= "OmarGL"



				if("Talk to ElectabuzzMom")
					if(Progress["Do Quest"] == 2 && Progress["GotEgg"])
						if(usr.TalkingTo.Find("ElectabuzzMom")) return 1
						usr.TalkingTo += "ElectabuzzMom"
						if(usr) usr.ScrollText("Electabuzz Mother", "The Electabuzz mother notices you approaching her nest.",'125.png')
						var/atom/Egg
						for(var/mob/Pokemon/Poke in P.Party)
							//The Pokemon is an Elekid and is an Egg.
							if(istype(Poke,/mob/Pokemon/Elekid) && istype(Poke.Ball, /obj/Balls/Egg)) Egg = Poke
						if(Egg) //They have returned the egg.
							if(usr) usr.ScrollText("Electabuzz Mother", "The Electabuzz notices you have her egg and you graciously return it to her.",'125.png')
							if(usr) usr.ScrollText("Electabuzz Mother", "As thanks, she rumages through her nest and finds an item. You take it calmly and then leave.",'125.png')
							P.contents += new /obj/HeldItems/Type_Enhance/Magnet
							del Egg
							P.UpdateParty()
							P<<System("You recieved a Magnet!")
							Progress["GotMagnet"] = 1
							P.FadetoBlack()
							P.RemovebyID("Egg Theif Electabuzz Mom")
							P.FadefromBlack()
						usr.TalkingTo -= "ElectabuzzMom"
				if("Talk to Julie")
					if(!Progress["Talked to Julie"])
						Progress["Talked to Julie"] = 1
						P.UpdateQuestButtonNEW(src)
						if(usr.TalkingTo.Find("JulieGL")) return 1
						usr.TalkingTo += "JulieGL"
						if(usr) usr.ScrollText("Julie", "Hey there! My name is Julie and I am the Net City Gymleader, also known as the best gymleader in the world! Nobody dares to challenge me, for I am the master of electric Pokemon. Oh, and my Pokemon are pretty cute too. So you have come here to challenge me? Ha, so be it. Watch a 10-year-old wipe the floor with you!",'YoungGirl.png')
						var/mob/NPCTrainer/Gymleader/Gymleader_Julie/GJ = new
						if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Battle.mid')
						var/list/Q = GJ.Challenge(usr)
						if(Q.Find(usr)) //They won.
							usr.BackgroundMusic()
							if(usr) usr.ScrollText("Julie", "You are just a big bully!",'YoungGirl.png')
							Progress["Beat Julie"] = 1
						usr.TalkingTo -= "JulieGL"


					else if(Progress["Talked to Julie"] && !Progress["Beat Julie"])
						if(usr.TalkingTo.Find("JulieGL")) return 1
						usr.TalkingTo += "JulieGL"
						if(usr) usr.ScrollText("Julie", "HAHAHA! Your here to challenge me again! Well, let the world see that I, the youngest Pokemon Gymleader ever, will beat the snot out of you!",'YoungGirl.png')
						if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Battle.mid')
						var/mob/NPCTrainer/Gymleader/Gymleader_Julie/GJ = new
						var/list/Q = GJ.Challenge(usr)
						if(Q.Find(usr)) //They won.
							usr.BackgroundMusic()
							if(usr) usr.ScrollText("Julie", "You are just a big bully!",'YoungGirl.png')
							Progress["Beat Julie"] = 1
							usr.TalkingTo -= "JulieGL"
					else if(Progress["Beat Julie"] && !Progress["Do Quest"])
						Progress["Beat Julie Info"] = 1
						AddOverlays(usr)
						if(usr) usr.ScrollText("Julie", "You deffinately cheated!",'YoungGirl.png')
						if(usr) usr.ScrollText("Julie", "Hmmf!",'YoungGirl.png')
						if(usr) usr.ScrollText("Julie", "Well you dont get a badge...",'YoungGirl.png')
						if(usr) usr.ScrollText("Julie", "Because I am not the Gymleader, by brother Omar is. He asked me to watch over the gym while he helps out at the Power Plant.",'YoungGirl.png')
						if(usr) usr.ScrollText("Julie", "Our parents own the Power Plant, and he is been helping them deal with some problems lately. SO he left me in charge! If you want your badge though, you will need to go find him. He is the one you really want to battle. He is probaly on the second floor of the Power Plant.",'YoungGirl.png')

						P.UpdateQuestButtonNEW(src)
					else if(Progress["Do Quest"])
						if(Progress["See Fight"])
							if(usr) usr.ScrollText("Julie", "Omar is so stupid! He should be thanking me for looking after the gym!",'YoungGirl.png')
							else P.QuestCheck("Talk to Omar2")

		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/c = 0
			if(Progress["Talked to Julie"])
				c += 1
				Send += "[c]. I've met Julie, the Gymleader of the Net City Gym. She seems rather young to be the gymleader, but I will have to defeat her if I want a Magnet Badge..<BR><BR>"
			if(Progress["Beat Julie"])
				c += 1
				Send += "[c]. I beat Julie, but she informed me she is not the Gymleader. Her brother, Omar, is the real gymleader and he is attending to a problem in the powerplant. Apparently their parents own the powerplant. I should go find Omar in the Powerplant if I intend to battle him.<BR><BR>"
			if(Progress["Beat Electabuzz"])
				c += 1
				Send += "[c]. I found Omar on the second floor of the powerplant desperately battling some Electabuzz. Apparently the Electabuzz's that live in the powerplant have been outraged lately, and no one seems to know why. Omar asked for my help in battling them.<BR><BR>"
			if(Progress["Beat Electabuzz"] == 2)
				c += 1
				Send += "[c]. With Omar's help, we were able to calm the Electabuzz down for the time being. Omar deducted that because the female Electabuzz, who normally guard there eggs were battling, one of their eggs must be missing."
				if(Progress["Do Quest"] == 2)
					Send += "Omar asked me to help by asking the employees of the powerplant if they had seen the egg and I agreed to do so. He said he has to deal with Julie posing as the Gymleader, and has asked me to come back to the gym when I have found out any information.<BR><BR>"
					 //They will find the egg
				if(Progress["Do Quest"] == 1) //They just want to battle
					Send += "Omar asked me to help find the egg, but I did not feel it was my business to go looking for the lost egg. He said if I wanted my gym battle with him, I would have to meet him at the Gym. He headed there to deal with the problem of Julie posing as the Gymleader.<BR><BR>"
			if(Progress["JulieisEvil"])
				c += 1
				Send += "[c]. I talked to [Progress["RightEngineer"]] and it seems he had seen the egg a few days ago, but also saw Julie watching the egg with a passion. I suspect that Julie perhaps took the egg in fascination. I should report back to Omar at the Gym.<BR><BR>"
			if(Progress["GotEgg"])
				c += 1
				Send += "[c]. When confronted about the stolen egg, Julie admited to the theft and returned the egg. Omar has requested that I take the egg back to the Electabuzz mother, but I am half tempted to hatch the egg myself. Omar, in all honesty, seems rather dull and I don't think he would notice if I trained the Elekid... Regardless of what my decision is, I should return to Omar when I no longer have the egg.<BR><BR>"
			if(P.Badges["Magnet"])
				c += 1
				Send += "[c].  When I returned, me and Omar finally had our Gym Battle. I won and earned the Magnet Badge."

			if(P.client) P<<output(Send, "QuestBrowser")

obj/Quest
	The_Egg_Theif

		Door_Checker
			invisibility = 1
			icon = 'NPC.dmi'
			icon_state = "Bodybuilder"
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/The_Egg_Theif)
					for(var/mob/Player/p in loc)
						return 0
					if(Progress && Progress["Beat Julie Info"]) return 1
					else
						dir = get_dir(src,usr)
						if(P) P.ScrollText("Security Guard", "Sorry. The Power Plant is currently closed to civilians due to the current crisis.")
						if(P) P.ScrollText("Security Guard", "I do not know the exact details of the situation, but please be patient while we sort it out.")
						dir = 2
						return 0


				else return 1



mob/NPC
	Quest/The_Egg_Theif

		Julie
			icon = 'NPC.dmi'
			icon_state = "Julie"
			Click()
				dir = get_dir(src,usr)
				spawn(100) dir = initial(dir)
				var/mob/Player/P = usr
				P.QuestAdd(/obj/Quest/The_Egg_Theif)
				P.QuestCheck("Talk to Julie")
		Omar
			invisibility = 1
			density = 0
			Click()
				dir = get_dir(src,usr)
				spawn(100) dir = initial(dir)
				var/mob/Player/P = usr
				P.QuestCheck("Talk to Omar")
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/The_Egg_Theif)
					if(Progress && Progress["Beat Electabuzz"] >= 2) return 1
					else return 0
		Omar2
			invisibility = 1
			density = 0
			Click()
				dir = get_dir(src,usr)
				spawn(100) dir = initial(dir)
				var/mob/Player/P = usr
				P.QuestCheck("Talk to Omar2", src)
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/The_Egg_Theif)
					if(Progress && Progress["Beat Electabuzz"] >= 2) return 0
					else return 1

		ElectabuzzWILD
			invisibility = 1
			density = 0
			dir = 4
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/The_Egg_Theif)
					if(Progress && Progress["Beat Electabuzz"] >= 2) return 1
					else return 0
		ElectabuzzMom
			invisibility = 1
			density = 0
			dir = 4
			Click()
				dir = get_dir(src,usr)
				spawn(100) dir = initial(dir)
				var/mob/Player/P = usr
				P.QuestCheck("Talk to ElectabuzzMom", src)
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/The_Egg_Theif)
					if(Progress && Progress["Do Quest"] >= 2 && Progress["GotEgg"]) return 0
					else return 1
mob/NPCTrainer
	PowerPlant
		Pointer = 1
		Click()
			dir = get_dir(src,usr)
			spawn(100) dir = initial(dir)
			var/mob/Player/P = usr
			if(!P.NPCWins.Find(type)) if(!P.Court && !Battlers.Find(P))
				Battlers += P
				Challenge(P,Partner)

			P.QuestCheck("Talk to PowerPlant Staff", src)

	Quest/The_Egg_Theif
		OmarBattlePartner
			name = "Omar"
			ClothingOverlays = list()
			icon_state = "Omar"
			icon = 'NPC.dmi'
			Pokes = list(\
				list("type" = /mob/Pokemon/Elekid, "level" = 13, "moves" = list(/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)),
				list("type" = /mob/Pokemon/Jolteon, "level" = 13, "moves" = list(/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)),
				list("type" = /mob/Pokemon/Magneton, "level" = 13, "moves" = list(/obj/Moves/Thunderbolt,/obj/Moves/Sonicboom,/obj/Moves/Thunder_Wave ,/obj/Moves/Supersonic,/obj/Moves/Thundershock)),
				list("type" = /mob/Pokemon/Ampharos, "level" = 13, "moves" = list(/obj/Moves/Thunder,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)))

		ElectabuzzWILD
			invisibility = 1
			Partner = /mob/NPCTrainer/Quest/The_Egg_Theif/ElectabuzzWILD
			Pokes = list(\
				list("type" = /mob/Pokemon/Electabuzz, "level" = 13, "moves" = list(/obj/Moves/Thunder,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)),
				list("type" = /mob/Pokemon/Electabuzz, "level" = 13, "moves" = list(/obj/Moves/Thunder,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)),
				list("type" = /mob/Pokemon/Electabuzz, "level" = 13, "moves" = list(/obj/Moves/Thunder,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)),
				list("type" = /mob/Pokemon/Electabuzz, "level" = 13, "moves" = list(/obj/Moves/Thunder,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)),
				list("type" = /mob/Pokemon/Electabuzz, "level" = 13, "moves" = list(/obj/Moves/Thunder,/obj/Moves/Thunderbolt,/obj/Moves/Thunder_Punch,/obj/Moves/Low_Kick ,/obj/Moves/Swift,/obj/Moves/Quick_Attack)))

//Hook, Line, and Sinker!//------------------------------------------------------------------------------------------------------------------------------

obj/Quest
	Fishermans
		/*
			Wayne Suggestion
			Fishing Guru First Talk
			Caught 20 Pokemon
			Fishing Guru Second Talk
			Caught 20 Non-Magikarp
		*/
		dir = 4
		name = "Hook, Line, and Sinker!"
		var/list/FishCaught = list()
		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			var/mob/Player/P = USR
			switch(String)
				if("Fish Pokemon")
					if(Progress["Fishing Guru First Talk"])
						if(length(FishCaught) >= 10) return 0
						if(Progress["Fishing Guru Second Talk"])
							if(!istype(Atom1, /mob/Pokemon/Magikarp)) FishCaught += Atom1.type
						else FishCaught += Atom1.type

						if(length(FishCaught) >= 10)
							if(!Progress["Caught 10 Pokemon"]) Progress["Caught 10 Pokemon"] = 1
							else if(!Progress["Caught 10 Non-Magikarp"]) Progress["Caught 10 Non-Magikarp"] = 1
							P.UpdateQuestButtonNEW(src)
						src.Progress_Report(usr)
						return 0
				if("Talk to Wayne")
					Progress["Wayne Suggestion"] = 1
					return 0
				if("Talk to Fishing Guru")
					if(Done) return 0
					if(!Progress["Fishing Guru First Talk"])
						Progress["Fishing Guru First Talk"] = 1
						if(usr) usr.ScrollText("Fishing Guru", "Well who might you be? [usr]? Well thats a fine name?")
						if(usr) usr.ScrollText("Fishing Guru", "Well [usr], why have you stumbled on my doorstep? You want to be a Fisherman eh? Well let me tell you, its quite a journey to become an expert such as myself. I have traveled all over Joleon searching for the best fishing spots, bringing some fish bigger than you. I have lived an amazing life.")
						if(usr) usr.ScrollText("Fishing Guru", "But now, I live here. Its a quiet life, but I help out youngster like embark their journey to find Water Pokemon. Here have this.")
						if(!Progress["Got Fishing Rod123"])
							usr.contents += new /obj/Important_Items/Rods/Old_Rod
							Progress["Got Fishing Rod123"] = 1

						usr<<System("You have recieved the Old Rod!")
						if(usr) usr.ScrollText("Fishing Guru", "Go enjoy the expereience that is fishing. You may not be an acceptable fisherman yet, but perhaps you will be. Come back to me when you catch 10 pokemon by fishing rod..")
						Progress["Fishing Guru First Talk"] = 1
						P.UpdateQuestButtonNEW(src)
						return 0
					if(Progress["Fishing Guru First Talk"]  && length(FishCaught) < 10)
						if(usr) usr.ScrollText("Fishing Guru", "You have only caught [length(FishCaught)] fish.. I said come talk to me when you catch 10.")
						return
					if(Progress["Fishing Guru First Talk"] && length(FishCaught) >= 10)
						if(usr) usr.ScrollText("Fishing Guru", "Well well well. You do not disappoint, do you [usr]. Thats quite the hall you have there.")
						for(var/i in FishCaught)
							if(i == /mob/Pokemon/Magikarp) FishCaught -= i
						if(length(FishCaught)  == 10 && !Done)
							if(usr) usr.ScrollText("Fishing Guru", "Well I must admit you are quite the fisher. Let me reward you with this, a Good Rod!")
							usr.contents += new /obj/Important_Items/Rods/Good_Rod
							usr<<System("You have recieved the Good Rod!")
							P.UpdateQuestButtonNEW(src, "finished")
							Done = 1
						else
							if(usr) usr.ScrollText("Fishing Guru", "Wait a minute, some of the Pokemon you fished were Magikarp. See, Magikarp are the worst enemy of the fisherman because they are so... useless. They do not count, go back and catch [10-length(FishCaught)] Pokemon.")
							P.UpdateQuestButtonNEW(src)
							Progress["Fishing Guru Second Talk"] = 1




		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/count = 0
			if(Progress["Wayne Suggestion"])
				count += 1
				Send += "[count]. I've talked to Wayne, the Gymleader of Bloomsberry Lake's Gym. He was quite boastful about his fishing ability and said that no Novice Fisherman can challenge him. He expects me to have a Good Rod or better in order to battle me, and suggest I meet his friend, the Fishing Guru.<BR><BR>"
			if(Progress["Fishing Guru First Talk"])
				count += 1
				Send += "[count]. I've talked to the Fishing Guru, and he gave me an Old Rod. He says that the path to becoming a Fishing Expert takes practice and expects me to catch 10 Pokemon with the Old Rod. I don't have to capture them with a Pokeball luckily. Once I have done this, I will be an Acceptable Fisherman apparently.<BR><BR>"
				if(Progress["Caught 10 Pokemon"])
					count += 1
					Send += "[count]. I caught 10 Pokemon with the Old Rod as the Fishing Guru reuqested, I should go back and tell him of my success in the waters.<BR><BR>"

				if(Progress["Fishing Guru Second Talk"])
					count += 1
					Send += "[count]. I caught 10 Pokemon, but the the Fishing Guru stated that Magikarp do not count as offical catches. I am to go back and catch more Pokemon that are not Magikarps if I am to be considered an acceptable fisher.<BR><BR>"

				if(Progress["Caught 10 Non-Magikarp"])
					count += 1
					Send += "[count]. I have fished 10 Pokemon from the waters, and non of them were Magikarp. I should go talk to the Fishing Guru.<BR><BR>"
				if(Done)
					count += 1
					Send += "[count]. The Fishing Guru has claimed that I'm an acceptable fisher and has given me the Good Rod as a gift."


				if(!Done) Send += "<ul><li> Fish Caught: [length(FishCaught)]/10 </ul><BR>"
			if(P.client) P<<output(Send, "QuestBrowser")

mob/NPC/Quest/HookLineSinker/Fishing_Guru
	icon = 'NPC.dmi'
	icon_state = "Fishing Guru"
	Click()
		dir = get_dir(src,usr)
		spawn(100) dir = initial(dir)
		var/mob/Player/P = usr
		P.QuestAdd(/obj/Quest/Fishermans)
		P.QuestCheck("Talk to Fishing Guru")


/


//A Pokemon Emergency//------------------------------------------------------------------------------------------------------------
/*
mob/NPCTrainer/Quests/Pokemon_Emergency
	Team_Rocket_Grunt_Jessie
		ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="JesseHairRed")
		Pokes = list(\
				list("type" = /mob/Pokemon/Ekans, "set level" = 13),
				list("type" = /mob/Pokemon/Meowth, "set level" = 13),
				)

		TextAfterWin = "We are blasting off againnnnnnnnnn."
		Portrait = 'Jesse.dmi'
		Partner = /mob/NPCTrainer/Quests/Pokemon_Emergency/Team_Rocket_Grunt_James
		BattleSound = 'Villian Battle.mid'
	Team_Rocket_Grunt_James
		ClothingOverlays = list("Shoes"= "Black shoes", "Robe"= "TeamRocket overall", "Hair"="MayHairBlue")
		Pokes = list(\
				list("type" = /mob/Pokemon/Koffing, "set level" = 13),
				)
		TextAfterWin = "We are blasting off againnnnnnnnnnn."
		Portrait = 'James.dmi'

obj/Quest
	Pokemon_Emergency
		var/TempParty[6]
		var/list/Parts = list() //These are parts of the scene that must be deleted when completed and at loggout.
		var/
			obj/Jesse
			obj/James
			obj/Ekans
			obj/Quest/Pokemon_Emergency/Player_Loc/PL

		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			Send += "<font color = red>(WARNING) If you logout during this quest, it will end!<font color = black><BR><BR>"
			Send += "1. Nurse Joy pulled me aside after a vist to the Pokemon Center to explain I was working my Pokemon to hard. She also explained a feature added to Pokeballs by the Pokemon Protection Agency in 2028, that allows them to permenatly leave me if they don't think I'm a suitable trainer. I said I would try my hardest to repsect my Pokemon and keep them happy.<BR><BR>"
			if(Progress["BattleTeamRocket"])
				Send += "2. A duo from Team Rocket named Jesse and James attacked the Pokemon Center. They attempted to steal Pokeballs located within the Pokemon Center,"
			if(Progress["BattleTeamRocket"] == "Win")
				Send += "and I luckily stopped them by collecting the pokeballs first and then battling them with the Pokemon I found. Nurse Joy was very confused as to why Team Rocket would attack the Pokemon Center, but she thanked me and told me she would give a recomondation to the Pokemon League on my behalf."
			if(Progress["BattleTeamRocket"] == "Loose")
				Send += "and I was not able to stop them. After a quick battle that they were able to win, I blacked out in the commotion. Nurse Joy explained that they got away with most of the Pokemon residing at the Pokemon Center, but luckily mine had not been stolen. The PPA are following up the incident with an investigation."
			if(Progress["BattleTeamRocket"] == "Logout")
				Send += "and in the commotion, I blacked out completely, unable to do anything to stop them."
			if(P.client) P<<output(Send, "QuestBrowser")
		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			if(Done) return //This is so the code doesn't have to look over all the options.
			var/mob/Player/P = USR

			if(String == "Logout") //We check this here, because if there is no mob or client, it won't get this far//
				for(var/atom/A in Parts) del A //Get rid of the objects that are no longer needed
				P.loc = LocFromNum(P.DieLoc) //Return them to the Pokemon Center they should have died at.
				if(Progress["BattleTeamRocket"] != "Win" || Progress["BattleTeamRocket"] != "Loose") Progress["BattleTeamRocket"] = "Logout"
				Done = 1 //This will promptly end the quest

			if(!isPlayer(P) || !P.client) return 1
			switch(String)
				if("BattleJesseandJames")
					if(P) P.ScrollText("Jesse", "Stop right there, hand over thost Pokeballs twerp!",'Jesse.dmi')
					if(P) P.ScrollText("James", "I guess you did not hear us the first time...",'James.dmi')
					if(P) P.ScrollText("Jesse", "Surrender now....",'Jesse.dmi')
					if(P) P.ScrollText("James", "Or prepare to fight!",'James.dmi')

					var/mob/NPCTrainer/Quests/Pokemon_Emergency/Team_Rocket_Grunt_Jessie/J = new //Make a new mob
					var/list/Q = J.Challenge(P)


					P.UpdateQuestButtonNEW(src)

					if(Q.Find(P)) //They won.
						Progress["BattleTeamRocket"] = "Win"
						P.FadetoBlack()
						P.client.eye = locate(/obj/Quest/Pokemon_Emergency/Camera_Spawn)
						P.FadefromBlack()

						sleep(20)
						if(P) P.ScrollText("James", "Looks like were blasting off!",'James.dmi')
						P.FadetoBlack()
						del Jesse; del James; del Ekans
						P.BackgroundMusic('Pokemon Center.mid')
						P.FadefromBlack()

						if(P) P.ScrollText("Nurse Joy", "[P], you have done this Pokemon Center a great favour! You can be assured that the officals at the Pokemon League will hear about this.",'NurseJoy.dmi')
						if(P) P.ScrollText("Nurse Joy", "The only question now is: Why would Team Rocket attack a Pokemon Center? Like I said before, there are only weak and injured Pokemon here. Nothing really of value for theives like them...",'NurseJoy.dmi')
						if(P) P.ScrollText("Nurse Joy", "Regardless, thank you! Your Pokemon should be fully healed by now. I will contact the PPA and have them investigate the incident. Your free to go.",'NurseJoy.dmi')

						P.Titles += "Heal Sign"
						P<<System("Nurse Joy Title awarded!")

						Done = 1

						P.FadetoBlack()
						for(var/atom/A in Parts) del A
						P.loc = LocFromNum(P.DieLoc)
						P.client.eye = P
						P.FadefromBlack()


					else
						Progress["BattleTeamRocket"] = "Loose"
						P.FadetoBlack()
						P.BackgroundMusic('Pokemon Center.mid')
						P.loc = LocFromNum(P.DieLoc)
						Done = 1

						P.client.eye = P
						for(var/atom/A in Parts) del A

						P.FadefromBlack()
						if(P) P.ScrollText("Nurse Joy", "Oh [P], your awake.",'NurseJoy.dmi')
						if(P) P.ScrollText("Nurse Joy", "Team Rocket took close to all the Pokemon that were residing here at the Pokemon Center. The PPA has already been called to investigate the situation, but as of now there are no leads.",'NurseJoy.dmi')
						if(P) P.ScrollText("Nurse Joy", "Luckily, it seems they did not steal your Pokemon though. You are one of the lucky few, a lot of trainers are grieving at the loss of their Pokemon...",'NurseJoy.dmi')
						if(P) P.ScrollText("Nurse Joy", "You should be fine to leave when your ready.",'NurseJoy.dmi')


				if("PickupPokeballPokemonEmergency")
					Progress["Picked up Pokemon"] += 1
					del Atom1

					var/list/Injured = list(/mob/Pokemon/Bulbasaur,/mob/Pokemon/Charmander,/mob/Pokemon/Squirtle,/mob/Pokemon/Caterpie,/mob/Pokemon/Magikarp,/mob/Pokemon/Pidgey,/mob/Pokemon/Goldeen,/mob/Pokemon/Vulpix,/mob/Pokemon/Venonat,/mob/Pokemon/Sandshrew,/mob/Pokemon/Spearow)
					var/Type = pick(Injured)
					var/mob/Pokemon/Poke = new Type
					TempParty[Progress["Picked up Pokemon"]] = Poke
					Poke.Owner = P.ckey
					Poke.Create(pick(9,10,11)*max(P.Badges(),1))
					Parts += Poke
					Poke.Ball = new/obj/Balls/Poke_Ball
					Poke.Ball.name = "???"
					var/obj/Balls/B = Poke.Ball
					B.Pokemon = Poke
					P.UpdateParty()

					if(Progress["Picked up Pokemon"] >= 4)
						spawn() src.Quest_Check(P,"BattleJesseandJames")
						return



				if("Battle Check") //This returns a list of Pokemon for the Player to use temporarily.
					if(Progress["BattleTeamRocket"] == 1 && !Done)
						return TempParty


				if("Update Party") //This is for when she removes the Party.
					if(!Done) //Continue showing the temp part till the Quest is done, which is either when the battle is finished or the player logs out.
						var/items = 0
						for(var/i=1, i<7, i++)

							var/mob/Pokemon/Poke = TempParty[i]
							if(!Poke) continue
							Poke.AddMeter(1) //This updates the Meter, which is also in the Party list.
							winset(P, "Party", "current-cell=1,[++items]")
							if(Poke.Ball == P.ItemUsing || Poke == P.ControlingPokemon) winset(P, "Party", "text-color=blue")
							P << output(Poke.Ball, "Party")
							winset(P, "Party", "current-cell=2,[items]")
							P << output(Poke.Meter, "Party")
							winset(P, "Party", "text-color=black")

						winset(P, "Party", "cells=2x[items]")	// cut off any remaining rows
						return 1 //Stops the actuall proc from working.
					else return 0
				if("Black Out")
					if(!Progress["Talk to Joy"])
						sleep(10)
						if(P.TalkingTo["Nurse Joy"]) return
						P.TalkingTo["Nurse Joy"] = 1
						P.UpdateParty()
						P.ScrollText("Nurse Joy", "[P], you are working your Pokemon much to hard. I have seen you in this Pokemon Center almost more than any other trainer. This time, you have almost pushed them to their limit.",'NurseJoy.dmi')
						if(P) P.ScrollText("Nurse Joy", "Come with me. Your Pokemon are resting in the back..",'NurseJoy.dmi')
						if(!P) return

						P.FadetoBlack()
						P.loc = null
						//Set up the scene
						P.client.perspective = EYE_PERSPECTIVE
						P.client.eye = locate(/obj/Quest/Pokemon_Emergency/Camera_Spawn)


						//Add the first Pokemon in their Party to the Bed Sleeping.
						var/mob/Pokemon/S1 = P.Party[1]
						if(!S1) return
						var/atom/CL = locate(/obj/Quest/Pokemon_Emergency/Camera_Spawn) //Camera Location
						var/image/L = image(S1.icon, CL ,"Sleep",MOB_LAYER+1)
						P << L
						//Add the Pokemon Nurse Joy
						var/obj/Quest/Pokemon_Emergency/Nurse_Joy_Loc/NJL = new(locate(CL.x+1,CL.y,CL.z))
						Parts += NJL
						sleep(20)
						NJL.dir = 8
						L = image('NPC.dmi', NJL ,"Nurse Joy",MOB_LAYER+1)
						P.BackgroundMusic('Sad Music.mid')
						P << L
						//Add the Player
						PL = new(locate(CL.x-1,CL.y,CL.z))
						Parts += PL
						PL.dir = 4
						PL.Description = P
						L = image(P.Ricon, PL, "Male Base",MOB_LAYER+1)
						P<<L
						for(var/i in P.ClothingOverlays)
							if(i == "Hair") L = image('Hair.dmi', PL, P.ClothingOverlays[i],MOB_LAYER+1)
							else L = image('Clothing.dmi', PL, P.ClothingOverlays[i],MOB_LAYER+1)
							P<<L
						P.FadefromBlack()
						P.ScrollText("Nurse Joy", "Look here at your poor [S1],  [S1.ReturnGender()] has been working so hard for you [S1.ReturnGender()] is completely out of energy.",'NurseJoy.dmi')
						var/Done = 0
						while(!Done)
							if(P) P.ScrollText("Nurse Joy", "Did you know a Pokemon can leave its trainer if it is not satisfied with the trainers ability to train it? Its a feature added to all Pokeballs after the PPA passed the legislation in 2028.",'NurseJoy.dmi')
							if(P) P.ScrollText("Nurse Joy", "If you do not keep your Pokemons happiness up past a certain level, it has every right to leave you. Do you really want [S1] to leave you? Do you understand what I am trying to tell you?",'NurseJoy.dmi')
							if(P) if(alert(P, "Do you understand what Nurse Joy is trying to say?","Nurse Joy","Yes","No") == "Yes")
								Done = 1
							if(!P) return
						if(P) P.ScrollText("Nurse Joy", "Good..",'NurseJoy.dmi')
						NJL.dir = 4
						sleep(20)
						if(P) P.ScrollText("Nurse Joy", "The first step to becoming a great Pokemon Master is respecting your Pokemon fully.",'NurseJoy.dmi')
						NJL.dir = 8
						sleep(20)
						if(P) P.ScrollText("Nurse Joy", "[S1] will be fine, but [S1.ReturnGender()] will need a good bit of rest before [S1.ReturnGender()] is able to do anything, let alone battle.",'NurseJoy.dmi')
						Progress["Talk to Joy"] = 1
						//P.client.sound_system.MusicFade(null, 0)
						sleep(30)
						P.SoundEffect('Explosion.ogg')
						if(P) P.ScrollText("","BOOM!")
						//OMG
						var/atom/OMG1 = locate(NJL.x,NJL.y+1,NJL.z)
						L = image('HUD.dmi', OMG1 ,"OMG",MOB_LAYER+1)
						P.SavedImages += L
						L.OBJ = OMG1
						L.ID = "OMGNurseJoyPokemonEmergency"
						P << L
						var/atom/OMG2 = locate(PL.x,PL.y+1,PL.z)
						L = image('HUD.dmi', OMG2 ,"OMG",MOB_LAYER+1)
						P.SavedImages += L
						L.OBJ = OMG2
						L.ID = "OMGPlayerPokemonEmergency"
						P << L
						PL.dir = 2
						NJL.dir = 2
						sleep(15)
						for(L in P.SavedImages)
							if(L.OBJ == OMG2 || L.OBJ == OMG1) del L
						for(var/obj/Quest/Pokemon_Emergency/Smokescreen/SS in world)
							L = image(SS.icon, SS ,SS.icon_state,MOB_LAYER+1,SS.dir)
							P<<L
						if(P) P.ScrollText("Nurse Joy", "What in heavens name was that?!",'NurseJoy.dmi')
						P.BackgroundMusic('Villian Encounter.mid')
						Jesse = new(locate(CL.x,CL.y-3,CL.z))
						Parts += Jesse
						L = image('NPC.dmi', Jesse ,"Jesse",MOB_LAYER+1)
						P<<L
						sleep(5); Jesse.dir = 1; step(Jesse, 1); sleep(3);Jesse.dir = 4; step(Jesse, 4); sleep(5);Jesse.dir = 1
						James = new(locate(CL.x,CL.y-3,CL.z))
						Parts += James
						L = image('NPC.dmi', James ,"James",MOB_LAYER+1)
						P<<L
						sleep(5); James.dir = 1; step(James, 1); sleep(3);James.dir = 8; step(James, 8); sleep(5);James.dir = 1
						if(P) P.ScrollText("???", "To protect the world from devastation!",'Jesse.dmi')
						if(P) P.ScrollText("???", "To unite all peoples within our nation!",'James.dmi')
						if(P) P.ScrollText("???", "To denounce the evils of truth and love!",'Jesse.dmi')
						if(P) P.ScrollText("???", "To extend our reach to the stars above!",'James.dmi')
						if(P) P.ScrollText("Jesse", "Jesse!",'Jesse.dmi')
						if(P) P.ScrollText("James", "James!",'James.dmi')
						if(P) P.ScrollText("Jesse", "Team Rocket blast off at the speed of light!",'Jesse.dmi')
						if(P) P.ScrollText("James", "Surrender now or prepare to fight!",'James.dmi')
						if(P) P.ScrollText("Nurse Joy", "What are you criminals doing here?! This is a place for weak and injured Pokemon, there is nothing to steal here!",'NurseJoy.dmi')
						if(P) P.ScrollText("Jesse", "Even strong Pokemon become injured every once in a while. GO! Ekans!",'Jesse.dmi')

						Ekans = new(locate(CL.x+1,CL.y+1,CL.z))
						Parts += Ekans
						var/image/Send = image('023Ekans.dmi', Ekans ,"Send",MOB_LAYER+1)
						P<<Send
						L = image('023Ekans.dmi', Ekans ,null,MOB_LAYER+1)
						sleep(8)
						del Send
						P<<L

						Ekans.dir = 1; sleep(5); step(Ekans,1); sleep(5)
						for(var/obj/Quest/Pokemon_Emergency/Pokeball_Shelf/PS in view(15,P.client.eye))
							L = image('Indoors.dmi', PS ,"Pokeball Shelf Empty",MOB_LAYER+1)
							P<<L
							var/obj/Quest/Pokemon_Emergency/Pokeball/PB = new(locate(PS.x,PS.y-1,PS.z))
							PB.OWNER = P.ckey
							L = image('Pokeballs.dmi', PB ,"overworld Pokeball",MOB_LAYER+1)
							P<<L
							Parts += PB

						if(P) P.ScrollText("Nurse Joy", "Ah! The Pokeballs! Quick, [P] grab as many Pokeballs as you can! Do not let Team Rocket steal them!",'NurseJoy.dmi')
						if(!P) return

						P.Watcher = PL







*/




obj/Quest/Pokemon_Emergency

	Camera_Spawn; invisibility = 1
	Nurse_Joy_Loc; density = 1; invisibility = 1
	Player_Loc
		density = 1;invisibility = 1
		Bump(D)

			if(istype(D,/obj/Quest/Pokemon_Emergency/Player_Loc))
				var/obj/d = D
				src.loc = d.loc
				for(var/obj/P in loc)
					P.SteppedOn(src)
			return ..()

	Smokescreen
		icon = 'Smokescreen.dmi'
		invisibility = 1
	Pokeball_Shelf
		invisibility = 0
		icon = 'Indoors.dmi'
		icon_state = "Pokeball Shelf Full"
	Pokeball
		density = 0
		invisibility = 1
		var/SteppedON
		var/OWNER
		SteppedOn(var/obj/Quest/Pokemon_Emergency/Player_Loc/PL)
			var/mob/Player/P = PL.Description
			if(istype(PL) && P.ckey == OWNER)

				P.QuestCheck("PickupPokeballPokemonEmergency", src)

			return ..()


//Daycare Roulette//------------------------------------------------------------------------------------------------

/*

obj/Quest
	Daycare_Roulette
		//GetEevee1
		//DepositEevee1
		//GetMail1
		//GetEevee2
		//DepositEevee2
		//GetMail2
		//GetEevee3
		//DepositEevee3
		//GetMail3
		//GetEevee4
		//DepositEevee4
		var/
			DaycareMax
		AddOverlays(var/mob/Player/P)
			if(Progress["GetEevee1"] && !Progress["GetMail3"])
				P.RemovebyID("MadameMuchMoneySkysight")






		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			if(Progress["GetEevee1"])
				Send += "1. I met with Madame Muchmoney and she complained about her home in Skysight. She wants to travel but needs her Eevee to be taken to the Daycare on Route 303. I offered to take Fluffy and in return, she said she would pay me when she returns from her travels.<BR><BR>"
			if(Progress["DepositEevee1"])
				Send += "2. I brought Fluffy to the Daycare on Route 303. I should wait for Madame Muchmoney to contact me.<BR><BR>"
			if(Progress["GetMail1"])
				Send += "3. Madame Muchmoney wants me to transfer Fluffy from the Daycare on Route 303, to the Daycare in Elkvale. She says all costs are going to be covered.<BR><BR>"
			if(Progress["GetEevee2"])
				Send += "4. I retrieved Fluffy from Daycare Lady Andrea. I should take Fluffy to the Dayecare in Elkvale. Andrea told me that Fluffy was quite shy and did not mix well with the male Pokemon.<BR><BR>"
			if(Progress["DepositEevee2"])
				Send += "5. I brought Fluffy to the Daycare in Elkvale. I should wait for Madame Muchmoney to contact me.<BR><BR>"
			if(Progress["GetMail2"])
				Send += "6. Madame Muchmoney wants me to transfer Fluffy from the Daycare in Elkvale, to the Daycare in Mirage City. She says all costs are going to be covered and that she should be back soon.<BR><BR>"
			if(Progress["GetEevee3"])
				Send += "7. I retrieved Fluffy from Daycare Lady Jessica. I should take Fluffy to the Dayecare in Mirage City. Jessica told me that Fluffy was much more accepting of male Pokemon. She said that Fluffy may be ready for a mate?!<BR><BR>"
			if(Progress["DepositEevee3"])
				Send += "8. I brought Fluffy to the Daycare in Mirage City. I should wait for Madame Muchmoney to contact me.<BR><BR>"
			if(Progress["GetMail3"])
				Send += "9. Madame Muchmoney wants me to bring Fluffy back to her home in Skysight. She says all costs are going to be covered.<BR><BR>"
			if(Done)
				Send += "10. Madame Muchmoney was very happy to see Fluffy. She gave me 20000 Pokedollars for all my work. Much needed money is appreciated.<BR><BR>"
			if(P.client) P<<output(Send, "QuestBrowser")
		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			if(Done) return //This is so the code doesn't have to look over all the options.
			var/mob/Player/P = USR

			if(!isPlayer(P) || !P.client) return 1
			switch(String)
				if("Login")
					//Temp Fix: Remove June 25th, 2013
					//This is just a temporary switch over var thing. Basically, Eevee is saved in the Quest instead of the Players Daycare1 and Daycare2
					if(P.Daycare1 && P.Daycare1.OriginalTrainer == "Madame Muchmoney")
						Progress["EeveeInDaycare"] = P.Daycare1
						P.Daycare1 = null
					if(P.Daycare2 && P.Daycare2.OriginalTrainer == "Madame Muchmoney")
						Progress["EeveeInDaycare"] = P.Daycare2
						P.Daycare2 = null

					if(Progress["EeveeInDaycare"])
						var/mob/Pokemon/EV = Progress["EeveeInDaycare"]
						for(var/mob/NPC/Daycare_Ladys/DL in world)
							if(DL.name == EV.DayCareLady)
								var/list/Pen = DayCarePens[DL.name]
								var/list/List = DayCareLists[DL.name]

								if(length(Pen) >= DL.PenMax) //Not enough room in pen
									List += EV
								else
									DL.AddPokemontoPen(EV)

				if("BadgeDaycareCheck")
					return 1 //While doing this quest, the Daycares are available to any number of badges..
				if("DaycareLogout")
					if(Progress["EeveeInDaycare"])
						for(var/mob/DaycarePokemon/DD in world)
							if(!DD.Pokemon) del DD //Useless, delete.
							if(DD.Pokemon == Progress["EeveeInDaycare"])
								var/list/Pen = DayCarePens[DD.Pokemon.DayCareLady]
								var/list/List = DayCareLists[DD.Pokemon.DayCareLady]
								var/mob/NPC/Daycare_Ladys/DL = ReturnDayCareLady(DD.Pokemon.DayCareLady)
								Pen -= DD.Pokemon
								List -= DD.Pokemon
								del DD

								for(var/i = max(1,length(Pen)), i <= DL.PenMax,i++)
									var/mob/Pokemon/p
									if(length(List)) p = pick(List)

									if(p)
										List -= p
										DL.AddPokemontoPen(p)
				if("Trade Check")
					var/mob/Pokemon/EV = Atom1
					if(isPokemon(EV))
						if(EV.OriginalTrainer == "Madame Muchmoney")
							P<<System("Madame Muchmoney requested that you take Fluffy straight to the Daycare.")
							return 1
					return 0
				if("Send Out Check")
					var/mob/Pokemon/EV = Atom1
					if(isPokemon(EV))
						if(EV.OriginalTrainer == "Madame Muchmoney")
							P<<System("Madame Muchmoney requested that you take Fluffy straight to the Daycare.")
							return 1
					return 0
				if("Evolve Check")
					var/mob/Pokemon/EV = Atom1
					if(isPokemon(EV))
						if(EV.OriginalTrainer == "Madame Muchmoney")
							P<<System("Madame Muchmoney requested that you take Fluffy straight to the Daycare.")
							return 1
					return 0
				if("Release Check")
					var/mob/Pokemon/EV = Atom1
					if(isPokemon(EV))
						if(EV.OriginalTrainer == "Madame Muchmoney")
							P<<System("Madame Muchmoney requested that you take Fluffy straight to the Daycare.")
							return 1
					return 0
				if("Deposit Check")
					var/mob/Pokemon/EV = Atom1
					if(isPokemon(EV))
						if(EV.OriginalTrainer == "Madame Muchmoney")
							P<<System("Madame Muchmoney requested that you take Fluffy straight to the Daycare.")
							return 1
					return 0
				if("Move Check")
					var/mob/Pokemon/EV = Atom1
					if(isPokemon(EV))
						if(EV.OriginalTrainer == "Madame Muchmoney")
							P<<System("Madame Muchmoney requested that you take Fluffy straight to the Daycare.")
							return 1
					return 0
				if("PidgeyReachLocation")
					P.UpdateQuestButtonNEW(src)
					spawn()
						if(!Progress["GetMail1"])
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "Greetings from Kanto. I have finished here and I am moving onto Johto. How is Fluffy?",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "I am going to be a bit longer away from Joleon. So I would like if Fluffy could be moved to a more suitable Daycare.",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "This time, retrieve her from Daycare Lady Andrea, and then take her to Daycare Lady Jessica who runs the Daycare in Elkvale?",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "Of course the costs are already managed. Say HI to Fluffy for me!",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "-Madame Muchmoney",'16.png')
							Progress["GetMail1"] = 1
							P.UpdateQuestButtonNEW(src)
						else if(!Progress["GetMail2"])
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "Aloha from Hawaii. Do not ask how I ended up here, but my travels are just about over.",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "However, I am not quite done here. So I want you to move Fluffy once more to the best Daycare I know of.",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "Take Fluffy from Daycare Lady Jessica to Daycare Lady Zana in Mirage City.",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "Of course the costs are already managed. Say HI to Fluffy for me!",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "-Madame Muchmoney",'16.png')
							Progress["GetMail2"] = 1
							P.UpdateQuestButtonNEW(src)
						else if(!Progress["GetMail3"])
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "I am on my way home! The traveling has been great, but it is sincerely tiring me out.",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "I can not wait to see Fluffy! Fetch her from the Daycare and bring her back to my home in Skysight.",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "Of course the costs are already managed. Say HI to Fluffy for me!",'16.png')
							if(P) P.ScrollText("Pidgey Mail(Madame Muchmoney)", "-Madame Muchmoney",'16.png')
							Progress["GetMail3"] = 1
							P.UpdateQuestButtonNEW(src)
							for(var/mob/NPC/Quest/Daycare_Roulette/Madame_Muchmoney/DC in world)
								var/image/L = image('NPC.dmi', DC ,"MadameMuchmoney",MOB_LAYER+1)
								P.SavedImages += L
								L.ID = "MadameMuchMoneySkysight"
								P << L

				if("PokemonLevel")
					var/mob/Pokemon/EV = Atom1
					spawn()
						if(isPokemon(EV))
							if(EV.Level >= DaycareMax && EV.OriginalTrainer == "Madame Muchmoney")
								var/obj/deco/Town/PidgeyDeliver/PD = new(locate(P.x,P.y+20,P.z))
								PD.Destination = P
								PD.SRC = locate(200,200,P.z)
								PD.Mail()

				if("DepositDaycare")
					var/mob/Pokemon/EV = Atom2
					var/mob/NPC/Daycare_Ladys/DL = Atom1
					if(!isPokemon(EV) || EV.OriginalTrainer != "Madame Muchmoney") return

					if(!Progress["DepositEevee1"])
						Progress["DepositEevee1"] = 1
						DaycareMax = 25
						P.UpdateQuestButtonNEW(src)
						Progress["EeveeInDaycare"] = EV
						return "Deposit Pokemon"
					else if(!Progress["DepositEevee2"] && DL.PokemonLevelMax == 45)
						Progress["DepositEevee2"] = 1
						DaycareMax = 45
						P.UpdateQuestButtonNEW(src)
						if(P.Daycare1.OriginalTrainer == "Madame Muchmoney") P.Daycare1 = null
						if(P.Daycare2.OriginalTrainer == "Madame Muchmoney") P.Daycare2 = null
						Progress["EeveeInDaycare"] = EV
						return "Deposit Pokemon"
					else if(!Progress["DepositEevee3"] && DL.PokemonLevelMax == 60)
						EV.HoldingPokemonEgg = 0
						Progress["DepositEevee3"] = 1
						P.UpdateQuestButtonNEW(src)
						DaycareMax = 60
						if(P.Daycare1.OriginalTrainer == "Madame Muchmoney") P.Daycare1 = null
						if(P.Daycare2.OriginalTrainer == "Madame Muchmoney") P.Daycare2 = null
						Progress["EeveeInDaycare"] = EV
						return "Deposit Pokemon"


				if("DaycareWithdrawList")
					var/list/Pokes = list()
					if(Progress["EeveeInDaycare"]) Pokes += Progress["EeveeInDaycare"]

					return Pokes
				if("DaycareCost")
					var/mob/Pokemon/EV = Atom2
					var/mob/NPC/Daycare_Ladys/DL = Atom1
					if(!isPokemon(EV) || EV.OriginalTrainer != "Madame Muchmoney") return

					if(!Progress["GetEevee2"])
						if(!Progress["GetMail1"])
							if(P) P.ScrollText(DL, "Madame Muchmoney has not contacted me about picking up Eevee yet. I will keep Fluffy here until she does.")
							return "NoWithdraw"
						else return "NoCost"
					if(!Progress["GetEevee3"])
						if(!Progress["GetMail2"])
							if(P) P.ScrollText(DL, "Madame Muchmoney has not contacted me about picking up Eevee yet. I will keep Fluffy here until she does.")
							return "NoWithdraw"
						else return "NoCost"
					if(!Progress["GetEevee4"])
						if(!Progress["GetMail3"])
							if(P) P.ScrollText(DL, "Madame Muchmoney has not contacted me about picking up Eevee yet. I will keep Fluffy here until she does.")
							return "NoWithdraw"
						else return "NoCost"
				if("WithdrawDaycare")
					var/mob/Pokemon/EV = Atom2
					var/mob/NPC/Daycare_Ladys/DL = Atom1
					if(!isPokemon(EV) || EV.OriginalTrainer != "Madame Muchmoney") return

					if(!Progress["GetEevee2"])
						if(Progress["GetMail1"])
							if(P) P.ScrollText(DL, "Fluffy was very shy amoungst other Pokemon. It especially stayed away from the male Pokemon.")
							P.UpdateQuestButtonNEW(src)
							Progress["GetEevee2"] = 1
							Progress["EeveeInDaycare"] = null
					if(!Progress["GetEevee3"])
						if(Progress["GetMail2"])
							if(P) P.ScrollText(DL, "Fluffy was learning to get along with the other Pokemon quite well. There was even another Eevee that she fancied. She may be ready for love or even breeding.")
							P.UpdateQuestButtonNEW(src)
							Progress["GetEevee3"] = 1
							Progress["EeveeInDaycare"] = null
					if(!Progress["GetEevee4"])
						if(!Progress["GetMail3"])

							Progress["GetEevee4"] = 1
							P.UpdateQuestButtonNEW(src)
							Progress["EeveeInDaycare"] = null
							return "NoCost"


				if("Talk to Madame Muchmoney")
					if(P.TalkingTo["Madame Muchmoney"]) return
					P.TalkingTo += "Madame Muchmoney"
					if(!Progress["GetEevee1"]) //They haven't picked up eevee yet
						if(P) P.ScrollText("Madame Muchmoney", "Thats it! I can not stand being here for another second.")
						if(P) P.ScrollText("Madame Muchmoney", "I settled down here so that I could satisfy my Pokemons needs, so they could have a free and open enviroment.")
						if(P) P.ScrollText("Madame Muchmoney", "However, I want to travel. Board the S.S. Anne in Kanto, see Sprout Tower in Johto. Maybe even stop by Hoenn to see my sister..")
						if(P) P.ScrollText("Madame Muchmoney", "I have booked a plane to take me around the globe, but I need to drop my Eevee off at the Daycare while I am away.")
						if(P) P.ScrollText("Madame Muchmoney", "You seem like a capable trainer, would you mind bringing my Eevee to the Route 303 Daycare? I know Andrea personally, she will take care of Fluffy while I am away.")
						if(P)
							if(alert(usr,"Bring Fluffy to the Route 303 Daycare?","Madame Muchmoney","Yes","No") == "Yes")
								if(P) P.ScrollText("Madame Muchmoney", "Thats wonderful!.")
								if(P)
									var/PartyOpenSlot = P.AddPKMNParty()
									if(!PartyOpenSlot)
										if(P) P.ScrollText("Madame Muchmoney", "However, it seems you do not have enough space in your party to accomodate Fluffy. You should come back when you do.")
										P.TalkingTo -= "Madame Muchmoney"
										return
									Progress["GetEevee1"] = 1

									var/mob/Pokemon/Eevee/EV = new
									EV.Create(10)
									EV.name = "Fluffy"
									EV.Ball = new/obj/Balls/Luxury_Ball
									EV.Ball.name = "Fluffy"
									EV.Gender = "Female"
									EV.Ball.Pokemon = EV
									P.Party[PartyOpenSlot] = EV
									P.UpdateParty()
									EV.Owner = P.ckey
									EV.HoldingPokemonEgg = 1
									DaycareMax = 25
									EV.OriginalTrainer = "Madame Muchmoney"
									if(P) P.ScrollText("Madame Muchmoney", "I have already called ahead and taken care of all the costs. Once I return, I will reward you if you bring Fluffy back home.")
									if(P) P.ScrollText("Madame Muchmoney", "Take good care of Fluffy!")
									if(!P) return
									P.FadetoBlack()
									AddOverlays(P)
									P.FadefromBlack()
									P.UpdateQuestButtonNEW(src)
									P.TalkingTo -= "Madame Muchmoney"
					else if(Progress["GetMail3"])
						var/mob/Pokemon/Eevee/EV
						for(var/mob/Pokemon/p in P.Party)
							if(p.OriginalTrainer == "Madame Muchmoney")
								EV = p
						if(P) P.ScrollText("Madame Muchmoney", "Hello! So nice to see you again! My vacation was a blast!.")
						if(EV)

							if(P) P.ScrollText("Madame Muchmoney", "There is my cutie-patutie! Fluffy, you look so refreshed. Even stronger maybe?.")
							if(EV.HoldingPokemonEgg)
								if(P) P.ScrollText("Madame Muchmoney", "Zana called and said that Eevee had an egg? Is that true?! She has never really been the one to be.. so social with others. Well, if you took the egg, keep it. Raise it, and treat it as well as you treated Fluffy here..")
							if(P) P.ScrollText("Madame Muchmoney", "Here, take this as a reward for all of your work. You make a wonderful courier.")

							P.UpdateQuestButtonNEW(src)
							del EV
							P.AddMoney(20000)
							Done = 1



						else
							if(P) P.ScrollText("Madame Muchmoney", "Where is my little Fluffy-wuffy? Is she still at the Daycare?.")
							if(P) P.ScrollText("Madame Muchmoney", "Go fetch her for me.. I am wating!.")
						P.TalkingTo -= "Madame Muchmoney"





mob/NPC/Quest
	Daycare_Roulettea
		Madame_Muchmoney
			invisibility = 1
			icon = 'NPC.dmi'
			icon_state = "MadameMuchmoney"
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/Daycare_Roulette)
					for(var/mob/Player/p in loc)
						return 0
					if(Progress && !Progress["GetEevee1"]) return 1
					else return 0
				else return 1
			Click()
				var/mob/Player/P = usr
				if(!isPlayer(P)) return
				if(P.TalkingTo.Find("Madame Muchmoney")) return
				P.TalkingTo += "Madame Muchmoney"
				if(P)
					P.QuestAdd(/obj/Quest/Daycare_Roulette)
					P.QuestCheck("Talk to Madame Muchmoney", src)
				P.TalkingTo -= "Madame Muchmoney"
*/
//Taking Flight//---------------------------------------------------------------------------------------------------
obj/Quest
	Taking_Flight
		name = "Taking Flight"
		//StartedQuest = Use PidgeyExpressEntrance


		AddOverlays(var/mob/Player/P)
			if(Progress["Have Ken"])
				P.RemovebyID("Taking Flight Hurt Pidgey")
			if(Progress["Malachi at Pokecenter"] && Progress["Malachi at Pokecenter"] + 9000 >= world.realtime)
				//They haven't waited 15 minutes, and Malachi should appear in the Pokemon Center
				P.RemovebyID("Whitereach Malachi")
				for(var/obj/Quest/Taking_Flight/Malachi2/DC in world) P.AddScreenOverlay('NPC.dmi',"Malachi",DC,"Whitereach Malachi",MOB_LAYER+1)
			for(var/obj/Quest/Taking_Flight/OutsidePidgey/OP in world)
				if(OP.Number <= Progress["Pidgey's Given"])
					P.AddScreenOverlay('016Pidgey.dmi',"Sit[OP.Number]",OP,"OutsidePidgey[OP.Number]",80)



		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/counter = 1 //This needs to be 1, otherwise the first number is 0
			if(Progress["Malachi FirstTalk"] == 1)
				Send += "[counter++]. I met a man named Malachi who has started a Pidgey Delivery Service in Whitereach. He currently only has his Pidgeotto to make deliveries. Malachi is concerned about his Pidgeotto, as it hasn't returned from its latest delivery to Ridgeport. He asked if I am travelling Route 309, to keep an eye out for it.<BR><BR>"
			if(Progress["Malachi FirstTalk"] != 1 && Progress["Have Ken"])
				Send += "[counter++]. I found a fainted Pidgeotto on Route 307. It had a collar saying its owner is named Malachi and lives in Whitereach. I took Ken, the Pidgeotto with me. <BR><BR>"
			if(Progress["Malachi FirstTalk"] == 1 && Progress["Have Ken"])
				Send += "[counter++]. I found Ken the Pidgeotto passed out on Route 307. I brought him with me, and should return to Whitereach to return him to Malachi. <BR><BR>"
			if(Progress["Malachi FirstTalk"] == 2 && Progress["Have Ken"])
				Send += "[counter++]. I walked into the Pidgey Delivery Service in Whitereach, and I was enthusiastically greated by the owner of the Pidgeotto I found. Malachi went to the Pokemon Center to take care of his Pokemon, but said he wants to talk to me later about a reward. <BR><BR>"
			if(Progress["Malachi FirstTalk"] != 2 && Progress["Have Ken"] && Progress["Malachi at Pokecenter"])
				Send += "[counter++]. Malachi was excited to see his Pidgeotto, Ken, to be relatively unharmed. However, he went to the Pokemon Center to let Nurse Joy take a look. He said he wants to talk about a reward later. <BR><BR>"
			if(Progress["Turn down Malachi"] == 1)
				Send += "[counter++]. Malachi asked me to help him, but I decided I had focus on my Pokemon Journey. I may come back when I have time from training, hopefully his business can last that long.<BR><BR>"
			if(Progress["Turn down Malachi"] == 1 && Progress["Is Helping Malachi"] == 1)
				Send += "[counter++]. I've taken a break from my training to help Malachi in Whitereach. He needs me to go to the warmer climates of Joleon, and catch Pidgey for him. He will then train them to deliver mail, as his Grandfather taught him. He also rewarded me HM FLY, so that I could easily return back to Whitereach to return the Pidgey.<BR><BR>"
			if(Progress["Turn down Malachi"] == 0 && Progress["Is Helping Malachi"] == 1)
				Send += "[counter++]. Malachi asked for my help rebuilding his business. He needs me to go to the warmer climates of Joleon, and catch Pidgey for him. He will then train them to deliver mail, as his Grandfather taught him.He also rewarded me HM FLY, so that I could easily return back to Whitereach to return the Pidgey.<BR><BR>"
			if(Progress["Pidgey's Given"] && Progress["Pidgey's Given"] != 8)
				Send += "[counter++]. I've returned [Progress["Pidgey's Given"]] Pidgey(s) to Malachi. He says he's already started training them.<BR><BR>"
			if(Progress["Pidgey's Given"] == 8)
				Send += "[counter++]. Malachi says this should be enough Pidgeys to deliver to the North of Joleon. He thanked me with a Steel Wing TM, and a substantial amount of money (7500)<BR><BR>"
			if(P.client) P<<output(Send, "QuestBrowser")
		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			if(Done) return 0//This is so the code doesn't have to look over all the options.
			var/mob/Player/P = USR

			if(!isPlayer(P) || !P.client) return 1
			switch(String)
				if("Trade Check")
					var/mob/Pokemon/EV = Atom1
					if(isPokemon(EV))
						if(EV.OriginalTrainer == "Malachi")
							P<<System("This is not your Pokemon to trade.")
							return 1
					return 0
				if("Evolve Check")
					var/mob/Pokemon/EV = Atom1
					if(isPokemon(EV))
						if(EV.OriginalTrainer == "Malachi")
							return 1
					return 0
				if("Talk to Malachi")
					if(!Progress["Malachi FirstTalk"])
						if(P) P.ScrollText("Malachi", "Welcome to Pidgey Express Mail, a pidgey mail delivery service dedicated to serving Joleon.",'Malachi.png')
						if(P) P.ScrollText("Malachi", "My name is Malachi, and I have been training pidgey since I was just a little kid. My grandfather taught me everything he knew.",'Malachi.png')
						if(P) P.ScrollText("Malachi", "Unfortunately, my only carrior, my Pidgeotto Ken is out on delivery to Ridgeport. So I cannot send any mail for you. Sorry...",'Malachi.png')
						if(P) P.ScrollText("Malachi", "Come back later perhaps, but if you see Ken along Route 307, can you let me know?.",'Malachi.png')
						Progress["Malachi FirstTalk"] = 1

					else if(Progress["Malachi FirstTalk"] && !Progress["Malachi at Pokecenter"])
						var/mob/Pokemon/Ken = Progress["Have Ken"]
						if(Ken && P.Party.Find(Ken)) //Just in case they missed the check at door..
							var/obj/HUD/OMG/OMG = new(locate(Atom1.x,Atom1.y+1,Atom1.z))
							sleep(20)
							del OMG
							if(P) P.ScrollText("Malachi", "Hey! Is that my Pidgeotto, Ken?!",'Malachi.png')
							if(P) P.ScrollText("Malachi", "Poor Ken, it seems he passed out from exhaustion. I am going to take him to Nurse Joy to get checked out quickly. You should come back later though, I still need to repay you for helping me.",'Malachi.png')
							P.FadetoBlack()
							Progress["Malachi at Pokecenter"] = world.realtime
							del Ken
							P.UpdateParty()
							P.RemovebyID("Whitereach Malachi")
							for(var/obj/Quest/Taking_Flight/Malachi2/DC in world) P.AddScreenOverlay('NPC.dmi',"Malachi",DC,"Whitereach Malachi",MOB_LAYER+1)
							P.FadefromBlack()
							P.UpdateQuestButtonNEW(src)
							P.frozen = 0
						else if(P) P.ScrollText("Malachi", "Ken still has not come back from delivery.. I hope he is okay..",'Malachi.png')
					else if(Progress["Malachi at Pokecenter"] && !Progress["Is Helping Malachi"])
						if(istype(Atom1, /obj/Quest/Taking_Flight/Malachi2)) //At Pokemon Center
							if(P) P.ScrollText("Malachi", "Oh, hey [P], didnt expect to see you here.",'Malachi.png')
						else if(istype(Atom1, /mob/NPC/Quest/Taking_Flight/Malachi)) //At Pidgey Delivery
							if(P) P.ScrollText("Malachi", "Oh, hey [P], I am glad you stoped by.",'Malachi.png')
						if(!Progress["Malachi given Money"])
							P.AddMoney(1000)
						Progress["Malachi given Money"] = 1
						if(!Progress["Turn down Malachi"])
							if(P) P.ScrollText("Malachi", "Here is a bit of money I had saved up. I want you to have it for finding Ken. Nurse Joy said he fainted from pure exhaustion..",'Malachi.png')
							if(P) P.ScrollText("Malachi", "She said that he is going to stop making so many deliveries, but if I stop deliveries, my business will fail.",'Malachi.png')
							if(P) P.ScrollText("Malachi", "My grandfather may have taught me how to train Pidgey, but I do not know the first thing about catching Pokemon. Back when I worked out of Johto, we had an entire fleet of Pidgey to make deliveries.",'Malachi.png')
							if(P) P.ScrollText("Malachi", "I know you have already helped me so much by saving Ken, but do you think you could help me once more?..",'Malachi.png')
						else
							if(P) P.ScrollText("Malachi", "Think you can take a break from your journey to help me?..",'Malachi.png')

						if(alert(P,"Help Malachi?","Taking Flight", "Yes", "No") == "Yes")
							if(P) P.ScrollText("Malachi", "Great!",'Malachi.png')
							if(P) P.ScrollText("Malachi", "Basically, I need you to go and catch Pidgey for me in the warmer climate of Joleon. Its pretty cold for them here, so its rare to find them in the wild here..",'Malachi.png')
							if(P) P.ScrollText("Malachi", "Oh and take this.",'Malachi.png')
							var/obj/Machine/HM/HM_Fly/HM02 = new
							HM02.Move(P)
							P<<System("You received HM FLY!")
							if(P) P.ScrollText("Malachi", "HM FLY is great for any Pokemon with Wings. It allows you to fly to cities and towns you have already been to. Once you catch a Pidgey, bring it to me in Whitereach. I will probably need about 8 to have the business fully functional.",'Malachi.png')
							Progress["Is Helping Malachi"] = 1
							P.UpdateQuestButtonNEW(src)
						else
							if(P) P.ScrollText("Malachi", "I understand. You must be a busy Pokemon Trainer, you have things to do. Let me know if you change your mind.",'Malachi.png')
							Progress["Turn down Malachi"] = 1
							P.UpdateQuestButtonNEW(src)
					else if(Progress["Is Helping Malachi"] && Progress["Pidgey's Given"] < 8)
						if(P) P.ScrollText("Malachi", "Hey, do you have a Pidgey for me?",'Malachi.png')
						var/mob/Pokemon/Pidgey = P.Party_Choose("Give Malachi which Pidgey?", P.Party)
						if(!P.Party[2])
							if(P) P.ScrollText("Malachi", "I dont want to take your last Pokemon. Come back when you have more in your party.",'Malachi.png')
							return
						if(Pidgey && istype(Pidgey,/mob/Pokemon/Pidgey))
							if(P) P.ScrollText("Malachi", "Awww! Look at this little guy. I will have to find him a good name, and start training right away. Thanks!",'Malachi.png')
							if(!Progress["Pidgey's Given"]) P.UpdateQuestButtonNEW(src)
							Progress["Pidgey's Given"] += 1
							for(var/obj/Quest/Taking_Flight/OutsidePidgey/OP in world)
								if(OP.Number == Progress["Pidgey's Given"])
									P.AddScreenOverlay('016Pidgey.dmi',"Sit[OP.Number]",OP,"OutsidePidgey[OP.Number]",80)
							del Pidgey
							P.ReorganizeParty()
							P.UpdateParty()

						else
							if(P) P.ScrollText("Malachi", "Let me know when you have a Pidgey!",'Malachi.png')

					if(Progress["Pidgey's Given"] >= 8 && !Progress["Collect TM Steel Wing"])
						if(P) P.ScrollText("Malachi", "Wonderful! Now the Pidgey-coup is all filled! I really need to start getting to training them, but before I do here, take this.",'Malachi.png')
						if(P) P.ScrollText("Malachi", "Come see me later sometime. Ken seems to like you, and I might need some help in the future.",'Malachi.png')
						Progress["Collect TM Steel Wing"] = 1
						var/obj/Machine/TM/TM_Steel_Wing/TMSW = new
						TMSW.Move(P)
						P<<System("You received TM Steel Wing!")
						P.AddMoney(7500)
						P.UpdateQuestButtonNEW(src)
						Done = 1 //This has to be removed if you want to add onto this quest. Just put here so the quest appears in "Finised Quests"

					if(Progress["Collect TM Steel Wing"])
						if(P) P.ScrollText("Malachi", "Hey! Hows everything going [P]?",'Malachi.png')










				if("TransportStep")
					if(Atom1 == "/turf/transporting/Whitereach/PidgeyExpressEntrance")
						if(Progress["Malachi at Pokecenter"] && Progress["Malachi at Pokecenter"] + 9000 <= world.realtime)
						//Malachi is done in the Pokemon Center and should be in the building
							P.RemovebyID("Whitereach Malachi")
							for(var/mob/NPC/Quest/Taking_Flight/Malachi/DC in world) P.AddScreenOverlay('NPC.dmi',"Malachi",DC,"Whitereach Malachi",MOB_LAYER+1)

						var/mob/Pokemon/Ken = Progress["Have Ken"]
						if(isPokemon(Ken) && P.Party.Find(Ken))
							P.TalkingTo["Malachi"] = 1
							spawn(1)
								var/obj/HUD/OMG/OMG = new(locate(P.x-4,P.y+3,P.z))
								sleep(20)
								del OMG
								if(P) P.ScrollText("Malachi", "Hey! Is that my Pidgeotto, Ken?!")
								P.TalkingTo -= "Malachi"
								for(var/i = 1, i<= 5,i++)
									P.frozen = 0
									if(i <=3) step(P,1)
									else step(P,8)
									P.frozen = 1
									sleep(3)
								if(!Progress["Malachi FirstTalk"]) //The player hasn't met Malachi yet
									if(P) P.ScrollText("Malachi", "I am sorry, but I have bene looking for Ken for days! He went on a delivery to Ridgeport and never came back.",'Malachi.png')
									if(P) P.ScrollText("Malachi", "My name is Malachi, and I run the Pidgey Express Mail here in Joleon.. Although currently it is just me and Ken.",'Malachi.png')
									Progress["Malachi FirstTalk"] = 2
								if(P) P.ScrollText("Malachi", "Poor Ken, it seems he passed out from exhaustion. I am going to take him to Nurse Joy to get checked out quickly. You should come back later though, I still need to repay you for helping me.",'Malachi.png')
								P.FadetoBlack()
								Progress["Malachi at Pokecenter"] = world.realtime
								del Ken
								Progress["Have Ken"] = world.realtime
								P.UpdateParty()
								P.RemovebyID("Whitereach Malachi")
								for(var/obj/Quest/Taking_Flight/Malachi2/DC in world) P.AddScreenOverlay('NPC.dmi',"Malachi",DC,"Whitereach Malachi",MOB_LAYER+1)
								P.FadefromBlack()
								P.UpdateQuestButtonNEW(src)
								P.frozen = 0





				if("Find Ken Pidgeotto")
					if(P && !Progress["Have Ken"]) P.ScrollText("Ken the Pidgeotto", "In front of you is an injured Pidgeotto. It has a collar around its neck, with its name on one side: KEN.",'17.png')
					if(P && !Progress["Have Ken"]) P.ScrollText("Ken the Pidgeotto", "On the back of the tag reads the following text: Malachi, Pidgey Mail Delivery, Whitereach",'17.png')
					var/PartyOpenSlot = P.AddPKMNParty()
					if(PartyOpenSlot)
						if(!Progress["Have Ken"] && alert(P,"Take injured Pidgeotto with you?","Taking Flight","No","Yes") == "Yes")
							if(!Progress["Have Ken"])

								var/mob/Pokemon/Pidgeotto/EV = new
								EV.LearnMoves = list(/obj/Moves/Quick_Attack = 1, /obj/Moves/Aerial_Ace = 4,/obj/Moves/Agility = 7,/obj/Moves/Wing_Attack = 10,/obj/Moves/FeatherDance = 1, /obj/Moves/Steel_Wing = 1)
								EV.Create(38)
								EV.name = "Ken"
								EV.Ball = new/obj/Balls/Poke_Ball
								EV.Ball.name = "Ken"
								EV.Gender = "Male"
								EV.NonTradable = 1
								EV.HP = 0
								EV.Ball.Pokemon = EV
								P.Party[PartyOpenSlot] = EV
								P.UpdateParty()
								EV.Owner = P.ckey
								EV.OriginalTrainer = "Malachi"
								Progress["Have Ken"] = EV
								P.RemovebyID("Taking Flight Hurt Pidgey")
								P.UpdateQuestButtonNEW(src)
		Malachi2
			icon = 'MaleWhiteBase.dmi'
			dir = 4
			invisibility = 99
			density = 0
			SteppedOn(var/mob/M)
				var/mob/Player/P = M
				if(isPlayer(M))
					var/list/Progress = P.QuestReturnList(/obj/Quest/Taking_Flight)
					if(!Progress) return 1
					for(var/mob/Player/p in loc)
						return 0
					if(Progress["Malachi at Pokecenter"] && Progress["Malachi at Pokecenter"] + 9000 > world.realtime) return 0
					else return 1


				else return 1
			Click()
				dir = get_dir(src,usr)
				spawn(100) dir = initial(dir)
				var/mob/Player/P = usr
				if(!P.TalkingTo["Malachi"])
					P.TalkingTo["Malachi"] = 1
					P.QuestCheck("Talk to Malachi",src)
					P.TalkingTo -= "Malachi"
mob/NPC
	Quest/Taking_Flight
		Hurt_Pidgeotto
			icon = '017Pidgeotto.dmi'
			icon_state = "Faint"
			invisibility = 99
			density = 0
			Click()
				var/mob/Player/P = usr
				P.QuestAdd(/obj/Quest/Taking_Flight, src)
				P.QuestCheck("Find Ken Pidgeotto")
		Malachi
			icon = 'MaleWhiteBase.dmi'
			Pointer = 1
			dir = 4
			invisibility = 99
			Click()
				dir = get_dir(src,usr)
				spawn(100) dir = initial(dir)
				var/mob/Player/P = usr
				if(!TalkingTo["Malachi"])
					P.TalkingTo["Malachi"] = 1
					P.QuestAdd(/obj/Quest/Taking_Flight, src)
					P.QuestCheck("Talk to Malachi",src)
					P.TalkingTo -= "Malachi"
obj/Quest/Taking_Flight/OutsidePidgey
	invisibility = 1
	icon = '016Pidgey.dmi'
	layer = 80
	var/Number


//The Trapped Guardian//--------------------------------------------------------------------------------------------
obj/Quest
	Trapped_Guardian
		name = "The Trapped Guardian"
		//StartedQuest = Arial or Zachary


		AddOverlays(var/mob/Player/P)
			if(Progress["StartedQuestArial"])
				P.RemovebyID("SkyShrineArial")

				for(var/mob/NPC/Quest/Trapped_Guardian/Arial_2/DC in world)
					var/image/L = image('NPC.dmi', DC ,"Arial",MOB_LAYER+1)
					P.SavedImages += L
					L.ID = "InsideGymArial"
					P << L




		Progress_Report(var/mob/Player/P)
			..()
			var/Send = "<font size = 2>"
			var/counter = 1
			if(Progress["StartedQuestZachary"])
				Send += "[counter++]. I met with the Gym Assistant named Zachary. He informed me that Arial is out studying a 'Shrine of the Skies' in town. If I want to battle her, I have to find her.<BR><BR>"
			if(Progress["StartedQuestArial"])
				Send += "[counter++]. I met Arial at a shrine in Skysight. She was very distraught, and mention something about dreams that lead her to the shrine. The shrine is one of seven shrines located around Joleon. Ariel returned to the gym, but told me if I wanted to learn more I should talk to a Lady Banko in town. <BR><BR>"

			if(P.client) P<<output(Send, "QuestBrowser")
		Quest_Check(USR,var/String, var/atom/Atom1, var/atom/Atom2)
			if(Done) return 0 //This is so the code doesn't have to look over all the options.
			var/mob/Player/P = USR

			if(!isPlayer(P) || !P.client) return 1
			switch(String)
				if("Talk to GymAssistantZachary")
					if(!Progress["StartedQuestZachary"]) //Make this until Arial returns to the gym.
						if(P) P.ScrollText("Gym Assistant Zachary", "Hello, my name is Zachary and I am Arials Gym Assistant. Are you looking for a Gym battle?.",'Gentleman2.png')
						if(alert(usr,"Would you like a Gym Battle","Gym Assistant Zachary","Yes","No") == "Yes")
							if(P) P.ScrollText("Gym Assistant Zachary", "Unfortunately, Arial is not in at the moment. She is the Leader of the Skysight Gym.",'Gentleman2.png')
							if(P) P.ScrollText("Gym Assistant Zachary", "Arial is once again studying the Shrine of the Skies that resides in Skysight. If you want to battle her, you will need to go find her in town.",'Gentleman2.png')
							if(!Progress["StartedQuestZachary"])
								P.UpdateQuestButtonNEW(src)
								Progress["StartedQuestZachary"] = 1
						return


				if("Talk to GymleaderArial2")
					if(Progress["StartedQuestArial"] && !P.Badges["Sky"]) //They have talked to Arial outside, and they have not won the match yet.

						if(P) P.ScrollText("Arial", "Now that I am back in the gym, I feel more in the mood to battle.",'May1.png')
						if(P) P.ScrollText("Arial", "Think you can take on Flying-Pokemon expert?!",'May1.png')
						var/mob/NPCTrainer/Gymleader/Gymleader_Arial/O = new //Make a new mob
						if(P.Partner)
							if(!ispath(P.Partner)) P.Partner.Partner = null
							P.Partner = null
						var/list/Q = O.Challenge(P)
						del O
						if(Q.Find(P)) //They won.
							P.Titles += "Sky Badge"
							usr<<System("You beat Arial. You have been awarded the Sky Badge Title.")
							P.UpdateQuestButtonNEW(src)
							if(winget(usr, "SOUNDS ON", "is-checked") == "true") usr.BackgroundMusic('Gymleader Win.mid')

							if(P) P.ScrollText("Arial", "That battle was amazing!",'May1.png')
							if(P) P.ScrollText("Arial", "Ever since those dreams started, I have not been on my game. You got me back into the battling spirit. Take this, the Sky Badge, you have earned it.",'May1.png')
							if(P)
								P.Badges["Sky"] += 1
								Done = 1
								//Badge Accuiring Sound?
							if(P) P.ScrollText("Arial", "I also want you to have this",'May1.png')
							if(P)
								P.contents += new /obj/Machine/TM/TM_Aerial_Ace
								P<<System("You recieved TM Aerial Ace!")
							if(P) P.ScrollText("Arial", "Aerial Ace is a rare move that I learned while traveling. Not many Pokemon know it, but it is feircly powerful.",'May1.png')
							P.QuestCheck("Win Badge")
						usr.BackgroundMusic()



				if("Talk to GymleaderArial1")
					if(!Progress["StartedQuestArial"])
						if(P) P.ScrollText("????", ".....",'May1.png')
						Atom1.dir = get_dir(Atom1, P)
						if(P) P.ScrollText("????", "Oh Sorry! I didnt notice you there.",'May1.png')


						if(Progress["StartedQuestZachary"])
							if(P) P.ScrollText("????", "Oh. Zachary sent you? I must have been here for a while",'May1.png')
						if(P) P.ScrollText("Arial", "My name is Arial, and I am the Leader of the Skysight Gym.",'May1.png')
						Atom1.dir = 1
						sleep(30)
						Atom1.dir = get_dir(Atom1, P)
						if(P) P.ScrollText("Arial", "However, recently, I have been distracted.",'May1.png')
						if(P) P.ScrollText("Arial", "About two weeks ago, I started having these dreams about a strange Pokemon. I could not reconize its species, but it was blue and looked to have clouds for wings. Ever since the dreams started, I have been drawn to the Shrine of the Skies.",'May1.png')
						if(P) P.ScrollText("Arial", "Zachary thinks I am crazy....",'May1.png')
						if(P) P.ScrollText("Arial", "The Shrine of the Skies is one of seven shrines built around Joleon to empower trainers who visit them.",'May1.png')
						if(P) P.ScrollText("Arial", "The Shrine of the Skies is also the only one that is publicly available. The other shrines have become lost in time, only told in Legends now.",'May1.png')
						if(P) P.ScrollText("Arial", "If you want to learn more about the history of the Shrine, you should talk to Lady Banko in town. She can normally be found in her house in Skysight.",'May1.png')
						if(P) P.ScrollText("Arial", "Anyway, I will head back to the gym now, and then we can have our Gym Match.",'May1.png')
						P.FadetoBlack()
						Progress["StartedQuestArial"] = 1
						P.UpdateQuestButtonNEW(src)
						AddOverlays(P)
						P.FadefromBlack()










mob/NPC/Quest/Trapped_Guardian
	Gym_Assistant_Zachary
		icon = 'NPC.dmi'
		icon_state = "Zachary"
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P)) return
			if(P)
				P.QuestAdd(/obj/Quest/Trapped_Guardian)
				P.QuestCheck("Talk to GymAssistantZachary", src)

	Arial_1
		name = "Arial"
		icon = 'NPC.dmi'
		icon_state = "Arial"
		invisibility = 2
		density = 0
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P)) return
			if(P)
				P.QuestAdd(/obj/Quest/Trapped_Guardian)
				P.QuestCheck("Talk to GymleaderArial1", src)
		SteppedOn(var/mob/M)
			var/mob/Player/P = M
			if(isPlayer(M))
				var/list/Progress = P.QuestReturnList(/obj/Quest/Trapped_Guardian)
				for(var/mob/Player/p in loc)
					return 0
				if(Progress && Progress["StartedQuestArial"]) return 1
			else return 0

	Arial_2 //This one sits at Gym
		name = "Arial"
		icon = 'NPC.dmi'
		icon_state = "Arial"
		invisibility = 2
		density = 0
		Click()
			var/mob/Player/P = usr
			if(!isPlayer(P)) return
			if(P)
				P.QuestAdd(/obj/Quest/Trapped_Guardian)
				P.QuestCheck("Talk to GymleaderArial2", src)
		SteppedOn(var/mob/M)
			var/mob/Player/P = M
			if(isPlayer(M))
				var/list/Progress = P.QuestReturnList(/obj/Quest/Trapped_Guardian)
				for(var/mob/Player/p in loc)
					return 0
				if(Progress && !Progress["StartedQuestArial"]) return 1
			else return 0


