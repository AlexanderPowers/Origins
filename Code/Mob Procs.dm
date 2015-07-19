image/
	var
		OBJ
		ID



proc/


mob
	var/
		tmp/obj/HUD/screen_hud/SCREENHUD
		tmp/ScrollingText
		tmp/NetCityGymWaves = 1 //This is for the Electric Traps in the Gym in Net City
		tmp/TextList[50]
		list/ItemsFound = list() //A list of locations..
		tmp/list/SavedImages = list()
		Portrait
	Move(loc,dir)
		if(frozen || ScrollingText) return 0
		return ..()
	verb/PressSpace()
		set hidden = 1
		if(ScrollingText == 2) ScrollingText = 3

	proc
		AddScreenOverlay(var/ICON,var/ICONSTATE,var/LOC,var/NewID,var/LAYER = MOB_LAYER+1)
			var/image/L = image(ICON, LOC ,ICONSTATE,LAYER)
			SavedImages += L
			L.OBJ = LOC
			L.ID = NewID
			L.layer = LAYER
			src << L

		//Screen Overlays//------------------------------------------------------------------------------------------------------------------

		LocationTitle(var/Location)
			spawn()
				if(client)
					if(winget(src,"BlackUnderlay","is-visible") == "true") return
					var/Width1 = winget(src,"BlackUnderlay","size")
					Width1 = copytext(winget(src,"BlackUnderlay","size"),1,findtext(Width1,"x"))
					var/Width2 = winget(src,"LocationTitle","size")
					Width2 = copytext(winget(src,"LocationTitle","size"),1,findtext(Width2,"x"))
					winset(src,"LocationTitle","text='[Location]'")

					winset(src,"BlackUnderlay","is-visible=true")
					winset(src,"LocationTitle","is-visible=true")
					for(var/i = 8, i <=32, i +=8)
						winset(src,"BlackUnderlay","size=[Width1]x[i]")
						winset(src,"LocationTitle","size=[Width2]x[max(1,i-4)]")
						sleep(1)
					sleep(40)
					for(var/i = 32, i >=8, i -=8)
						winset(src,"BlackUnderlay","size=[Width1]x[i]")
						winset(src,"LocationTitle","size=[Width2]x[max(1,i-4)]")
						sleep(1)
					winset(src,"BlackUnderlay","is-visible=false")
					winset(src,"LocationTitle","is-visible=false")

		OverworldObjects()
			for(var/obj/OverworldItems/I in world)
				if(!ItemsFound.Find(CoordsToNum(I.x,I.y,I.z)))
					if(client)
						var/image/L = image('Items.dmi', I ,"ItemBall",MOB_LAYER+1)
						SavedImages += L
						L.OBJ = I
						src << L
		NetCityGymWaves()
			for(var/obj/deco/Gyms/Net_City/Electric_Waves/I in world)
				if(NetCityGymWaves == I.TrapSet)
					if(client)
						var/image/L = image('Indoors.dmi', I ,"Electric Waves",MOB_LAYER+1)
						SavedImages += L
						L.OBJ = I
						L.ID = "ELWAV"
						src << L


		AddAll()
			var/mob/Player/P = src
			if(!isPlayer(P)) return

			P.TimeHUD = new(client) //This is for the Day Night System
			P.TimeHUD.layer = 99
			P.SCREENHUD.layer = 100

			OverworldObjects()
			NetCityGymWaves()
			//The Menu Buttons//--------------------------------------------------------------------------
			winset(src,"QuestButton","is-visible=true")
			winset(src,"OptionsButton","is-visible=true")
			if(P.QuestCheck("PokedexButtonCheck")) winset(src,"PokedexButton","is-visible=true")
			if(P.QuestCheck("PokedexButtonCheck")) winset(src,"BugButton","is-visible=true")

			//--------------------------------------------------------------------------------------------


			//The Doorman Outside Powerplant
			for(var/obj/Quest/The_Egg_Theif/Door_Checker/DC in world)
				var/image/L = image('NPC.dmi', DC ,"Bodybuilder",MOB_LAYER+1)
				SavedImages += L
				L.ID = "DoorGuardJulie"
				src << L
			//Arial, Infront of Shrine of the Skies
			for(var/mob/NPC/Quest/Trapped_Guardian/Arial_1/DC in world)
				var/image/L = image('NPC.dmi', DC ,"Arial",MOB_LAYER+1)
				SavedImages += L
				L.ID = "SkyShrineArial"
				src << L
			//Snorlaxes//
			for(var/obj/Quest/Wake_Up_Snorlax/Snorlax/DC in world)
				var/image/L = image('143Snorlax.dmi', DC ,"QuestSleep",MOB_LAYER+1)
				SavedImages += L
				L.ID = "SleepingSnorlax[CoordsToNum(DC.x,DC.y,DC.z)]"
				src << L
			//Pokeflute Guy Pip//
			for(var/mob/Quest/Wake_Up_Snorlax/Pokeflute_Guy_Pip/DC in world)
				var/image/L = image('NPC.dmi', DC ,"Pokeflute Guy",MOB_LAYER+1)
				SavedImages += L
				L.ID = "Pokeflute Guy Pip"
				src << L
			//Ken the Pidgeotto//---------------------------------------------------------------------------------------------------------------------------------------
			var/Pidges = list()
			for(var/mob/NPC/Quest/Taking_Flight/Hurt_Pidgeotto/DC in world)
				Pidges += DC
			AddScreenOverlay('017Pidgeotto.dmi',"Faint",pick(Pidges),"Taking Flight Hurt Pidgey",MOB_LAYER+1)
			for(var/mob/NPC/Quest/Taking_Flight/Malachi/DC in world) AddScreenOverlay('NPC.dmi',"Malachi",DC,"Whitereach Malachi",MOB_LAYER+1)
			//Mom (the Banker)//----------------------------------------------------------------------------------------------------------------------------------------
			var/Skin = "White"
			if(icon == 'MaleBlackBase.dmi' || icon == 'MaleDoubleBlackBase.dmi') Skin = "Black"
			for(var/mob/NPC/Mom/DC in world) AddScreenOverlay('NPC.dmi',"Mom[Skin]",DC,"Lycus Mom",MOB_LAYER+1)

			for(var/obj/Quest/Q in P.Quests)
				Q.AddOverlays(P)



		RemovebyID(var/IDz)
			for(var/image/I in SavedImages)
				if(IDz == I.ID) del I
		FindbyID(var/IDz)
			for(var/image/I in SavedImages)
				if(IDz == I.ID) return 1
			return 0
		RemoveAll()
		//-----------------------------------------------------------------------------------------------------------------------------------
		FadetoBlack(var/ICON)
			if(!ICON)
				flick("FadeToBlack", SCREENHUD)
				SCREENHUD.icon_state = "Black"
				sleep(6)
			else
				var/obj/P = new
				P.layer = 1100
				client.screen += P
				P.screen_loc = "1,1"
				flick(ICON, P)

				sleep(8)
				SCREENHUD.icon_state = "Black"
				del P

		FadefromBlack()
			flick("FadeFromBlack", SCREENHUD)
			SCREENHUD.icon_state = null
			sleep(6)

		Badges()
			if(isPlayer(src))
				var/mob/Player/P = src
				var/Badge
				if(P.Badges["Whirlpool"]) Badge += 1
				if(P.Badges["Magnet"]) Badge += 1
				if(P.Badges["Tectonic"]) Badge += 1
				if(P.Badges["Pyro"]) Badge += 1
				if(P.Badges["Sky"]) Badge += 1
				if(P.Badges["Herb"]) Badge+= 1
				if(P.Badges["Combat"]) Badge += 1

				if(Badge >= 1) P.PokedexUnlock("Badges and Ribbons")
				return Badge
				//if(P.Badges["Whirlpool"]) Badges += 1
			else
				return 0

		DamageOverlay(var/Dam, var/Type)
			if(!HP) return
			Dam = num2text(round(Dam),12)
			var/obj/HUD/H = new
			for(var/i = 1, i <= length(Dam), i++)
				var/obj/O = new
				O.icon = 'HUD.dmi'

				O.icon_state = "[Type][copytext(Dam,i,i+1)]"

				O.pixel_x = 6 * i - 6
				if(O.icon_state) H.overlays += O
			overlays += H
			spawn(8)
				overlays -= H
				del H
		ScrollText(var/mob/Speaker, var/Text, var/Image)
			set background = 1
			var/mob/Player/P = usr
			if(isPlayer(P)) if(P.Timers["NoScrolling"]) return
			if(!client) return //This is NOT for NPCs
			if(ScrollingText) return
			winset(src,"TalkerName","is-visible=true")
			if(istext(Speaker)) winset(src,"TalkerName","text='[Speaker]'")
			else winset(src,"TalkerName","text='[Speaker.name]'")
			winset(src,"TalkerText","is-visible=true")
			if(istype(Speaker,/mob) && Speaker.Portrait)
				winset(src,"SpeakerPortrait","is-visible=true")
				winset(src,"SpeakerPortrait","image=[Speaker.Portrait]")
			if(Image)
				winset(src,"SpeakerPortrait","is-visible=true")
				winset(src,"SpeakerPortrait","image=[Image]")
			//Sort the Text to the ScrollingText
			while(Text)
				var/NText
				if(length(Text) >= 100)
					NText = copytext(Text,1,100)
					var/Done = 1
					while(Done)
						var/l = copytext(Text,99+Done,100+Done)
						if(l != " ")
							Done += 1
							NText += l
						else
							Text = copytext(Text,100+Done)
							Done = 0

						if(Done >= 10)
							Text = copytext(Text,100+Done)
							Done = 0
					NText += "..."

				else
					NText = Text
					Text = null
				ScrollingText = 1
				var/counter = 1
				while(ScrollingText <= 2)
					if(ScrollingText == 1)
						var/displaytext
						for(var/i = 1, i <= length(NText), i+= 4)
							displaytext += copytext(NText,i,i+4)
							winset(src,"TalkerText","text='[displaytext]'")
							sleep(1)
						ScrollingText = 2
						winset(src,"PressSpace","is-visible=true")
					if(ScrollingText == 2)
						counter += 1
						if(counter >= 50) ScrollingText = 3 //If it has waited a minute.. forget it.
					sleep(10)
			ScrollingText = 0
			winset(src,"TalkerName","is-visible=false")
			winset(src,"TalkerText","is-visible=false")
			winset(src,"PressSpace","is-visible=false")
			winset(src,"SpeakerPortrait","is-visible=false")







		Step_To(atom/destination)
			if(!destination || !loc || !destination.loc || destination.z != src.z) return
			src.PathFinding = 1

			var/Their = src.base_StepTowards(destination,0, 20)
			src.PathFinding = 0
			return Their

		Party_Choose(var/Message = "Which Pokemon", var/list/Pokemon)

			var/mob/Player/P = src
			if(!isPlayer(P)) return
			if(!Pokemon) Pokemon = P.Party
			var/list/Options = list()
			var/list/DUO = Pokemon.Copy() //We don't want to alter the orginal
			var/counter = 0
			for(var/i in DUO)
				counter += 1
				var/mob/Pokemon/p = i
				if(!isPokemon(p)) p = DUO[i]
				DUO -= p
				if(p)
					if(!istype(p.Ball,/obj/Balls/Egg))
						Options["[counter] - [p.name]"] = p
					else
						Options["[counter] - Egg"] = p
			if(length(Options))
				var/Choose = input(usr, "[Message]") in Options
				return Options[Choose]
		DeathCheck(var/mob/Pokemon/Killer)
			if(Killer && isPokemon(Killer)) Killer.AddMeter()
			if(istype(src,/mob/Pokemon))
				var/mob/Pokemon/M = src
				var/mob/Player/O = GetOwner(M.Owner) //A preset for the owner.


				if(O && istype(O,/mob/Player)) //Is there an owner?
					O.UpdateParty() //Update the Party Tab.
				if(!Killer) return //What the hell is doing the Killing!
				if(M.Dummy) return //Are they just a dummy?
				if(M.icon_state == "Faint") return //Are they already dead?
				M.AddMeter()
				M.Attackers[Killer.ID] = Killer

				if(HP<= 0) // If they are certified "FAINTED"

					spawn(200) //For wild Pokemon. If they aren't caught within 20 seconds, they will vanish.
						if(M.Owner) return
						if(!M.Owner && M.loc)
							del src

					M.icon = M.RICON
					M.TemporaryMoves = new/list
					M.icon_state = "Faint" //The pokemon isn't looking so hot..
					M.frozen = 1
					M.density = 1 //For pokemon that can fly or phase.





					if(O) //Is there an owner?
						O<<"[M.name] has fainted!" //A tragic duty.
						if(TotalHealth(O.Party) <= 0)
							if(istype(O,/mob/Player))
								O.loc = LocFromNum(O.DieLoc)
								O.UpdateDayHUD()
								O<<"<font color = red>(System) You are out of usable Pokemon. [O] blacked out."
								//Teams..
								var/area/Routes/R = loc.loc
								if(istype(R) && R.Team1 && R.Team2) //They were in an area while it was being contested, and died.
									if(R.EnteredPlayers.Find(O.ckey))
										R.PlayerRemoved(O, "Died")
								//Quests..
								if(!O.QuestReturnList(/obj/Quest/Pokemon_Emergency)) //Do they have the quest yet? If not, add it.
									if(O.Partner) if(O.Badges() >= 1 && prob(40)) O.QuestAdd(/obj/Quest/Pokemon_Emergency)
								O.QuestCheck("Black Out", Killer)

								spawn(30)
									O.HealAll()

									//Quest - Pokemon Emergency//


							M.ReturntoBall(0)
							if(O.Court)
								// Remove them from the Battle
								if(O.Court.Team1.Find(O))
									O.Court.Team1Defeated += O
								if(O.Court.Team2.Find(O))
									O.Court.Team2Defeated += O
								O.HP = 0
								if(O.Watcher) spawn(15)
									O.HP = 100
									del O.Watcher
								if(O.client)
									O.client.eye = O
									winset(O, "OC", "is-visible=false")
									winset(O, "Forfeit", "is-visible=false")
								O.RemoveSection("WatchingBattle")
								O.Court = null



						else
							if(M == O.ControlingPokemon) M.ReturntoBall(rand(5,10))


					var/TrainerBattle = 1
					if(O && O.Court) //Is the Owner Battling someone?
						TrainerBattle = 1.5
					else
						M.Happiness_Check(-2)

					for(var/i in Killer.StatExp) //Stat points are rewarded for each of Diers Stat Points to the killer.
						if(i == "EXP") continue //Except for base Expereince.
						Killer.StatExp[i] = min(Killer.StatExp[i] + M.BaseStats[i],65355)

					var/ExpGiven = ((M.BaseStats["EXP"] * M.Level)*1*TrainerBattle)/14 //This is the amount of experience given. THIS WAS ORIGINALLY 7 BUT WAS RAISED TO 14(May 22nd, 2011)
					ExpGiven = round(ExpGiven / length(M.Attackers)) //We devide it for however many attackers there are.


					for(var/i in M.Attackers) //Time to reward the EXP.
						var/mob/Pokemon/P = M.Attackers[i]
						if(!P) continue
						var/mob/Player/KillerO = GetOwner(P.Owner)

						if(!KillerO || !isPlayer(KillerO)) continue

						if(!P || P.HP <= 0) continue


						if(O) //If there is an owner of the Killed Pokemon
							//if(P.Owner && !O.Court) continue //If the killer has an owner and their owner is not battling.

							if(istype(O,/mob/NPCTrainer)) //This is for an NPC Battle
								if(KillerO.NPCWins[O.type] >= 1) ExpGiven = round(ExpGiven/6)
								P.Exp += ExpGiven
								KillerO<<"[P] gained [ExpGiven] experience!"
							else
								if(O.Wins[KillerO.ckey] + O.Loses[KillerO.ckey] >= 3)
									if(Tests["GiveBattleExp"]) ExpGiven = round(ExpGiven/8) //This pokemon won't get Exp from this battle..
									//else continue
						if(M.Finder == GetOwner(P.Owner)) //This is for Wild Pokemon you find.

							if(KillerO.Badges()<=0)
								ExpGiven *= pick(2,2,3)
								ExpGiven = round(ExpGiven)
							P.Exp += ExpGiven //This needs to go AFTER the ExpGiven is changed, so that what you are given is the same as what it is said given.
							KillerO<<"[P] gained [ExpGiven] experience!"

						if(isPlayer(KillerO)) KillerO.GiveDexInfo(M.Number)
						spawn() P.Level_Check()

					M.Attackers = new/list()
					M.Target = null





			if(istype(src,/mob/Player))

				var/mob/Player/P = src
				if(!P.client) return
				if(P.HP <= 0)
					if(P.ControlingPokemon) P.ControlingPokemon.ReturntoBall()
					P.loc = LocFromNum(P.DieLoc)
					P<<"<font color = red>(System) [P] blacked out."
					//if(P.Court) //sleep(11)
					HP = MHP
				return
			else return


proc
	TotalHealth(var/list/L = list())
		var/TotalHP
		var/TotalPP
		for(var/mob/Pokemon/P in L)
			if(P)
				var/obj/Balls/B = P.Ball
				if(istype(B,/obj/Balls/Egg)) continue //This Pokemon is in an egg..
				TotalHP += max(P.HP,0)
				for(var/obj/Moves/M in P.Moves)
					TotalPP += max(M.PP,0)
		if(!TotalHP || !TotalPP) return 0
		return TotalHP
obj/Berries
mob/Player/proc
	UpdateHUBStanding()
		var/Win = 0
		for(var/i in Wins)
			Win += Wins[i]
		var/Lose = 0
		for(var/i in Loses)
			Lose += Loses[i]
		var/list/params = list()
		params["Wins"] = "[Win]"
		params["Loses"] = "[Lose]"
		spawn()
			if(Win >= 20) world.SetScores(name, list2params(params))
	HealAll()
		TalkingTo = list()
		for(var/i=1, i<7, i++)
			var/mob/Pokemon/P = Party[i]
			if(P)
				if(P.Level <= 1)
					del P
					continue
				P.HP = P.MHP
				P.icon_state= null
				P.icon = P.RICON
				P.Status = null
				P.SecondaryStatus = new/list() //For Confusion and Wrap

				P.TemporaryMoves = new/list
				P.TempStats = new/list
				for(var/obj/Moves/M in P.Moves)
					M.PP = M.MPP
					M.WaitTime = 0
		UpdateParty()
	UpdateItems()
		spawn()
			var/items = 0
			winset(src, "ItemsLabel", "text='[Bag]'")
			winset(src, "Items", "text-color=black")
			var/list/BagItems = list()
			switch(Bag)
				if("Clothing")
					for(var/obj/Clothing/C in contents)
						BagItems += C
				if("TMs")
					for(var/obj/Machine/TM/M in contents)
						BagItems += M
					for(var/obj/Machine/HM/M in contents)
						BagItems += M
				if("Berries")
					for(var/obj/Berries/B in contents)
						BagItems += B
				if("Balls")
					for(var/obj/Balls/B in contents)
						BagItems += B
				if("Key Items")
					for(var/obj/Important_Items/I in contents)
						BagItems += I
				if("Normal")
					BagItems = contents.Copy()
					for(var/obj/Clothing/C in contents)
						BagItems -= C
					for(var/obj/Machine/M in contents)
						BagItems -= M
					for(var/obj/Berries/B in contents)
						BagItems -= B
					for(var/obj/Balls/B in contents)
						BagItems -= B
					for(var/obj/Important_Items/I in contents)
						BagItems -= I
			for(var/obj/O in BagItems)
				if(O == ItemUsing) winset(src, "Items", "text-color=blue")
				winset(src, "Items", "current-cell=1,[++items]")
				src << output(O, "Items")
				winset(src, "Items", "current-cell=2,[items]")
				if(O.Stackable)
					if(!O.Amount) del O
					else src << output("x[O.Amount]", "Items")
				else src << output("", "Items")
				winset(src, "Items", "text-color=black")
			winset(src, "Items", "cells=2x[items]")	// cut off any remaining rows
	UpdateParty(var/Buttons = 0)
		var/items = 0
		if(!src.client) return
		winset(src, "Party", "text-color=black")
		if(Buttons)
			//Clear all buttons from the screen
			var/list/QWERTY = list("Q" = 1,"W" = 2,"E" = 3,"R" = 4,"T" = 5,"Y" = 6)
			for(var/j=1, j<7, j++)
				winset(src, "default.Attack[j]", "is-visible=false")
			for(var/i in QWERTY)
				winset(src, "default.[i]", "is-visible=false")
			//Remove the attacks from the users list. These are set for the buttons on the Skin.
			Attacks = list(1 = null, 2 = null, 3 = null, 4 = null, 5 = null, 6 = null)

			//for(var/i=1, i<7, i++)
			var/mob/Pokemon/P = ControlingPokemon
			var/Count = 1
			if(P)

				for(var/obj/Moves/M in P.Moves)
					Attacks[Count] = M
					Count += 1

				if(P.TemporaryMoves["Moves"])
					Count = 1
					var/list/TMoves = P.TemporaryMoves["Moves"]
					for(var/obj/Moves/M in TMoves)
						Attacks[Count] = M
						Count += 1
				if(length(Attacks))
					for(var/j=1, j<7, j++)

						var/obj/Moves/m = Attacks[j]


						if(!m) continue
						var/icon/I = new(m.icon, m.icon_state)
						var/iconfile = fcopy_rsc(I)
						winset(src, "default.Attack[j]", "is-visible=true")
						winset(src, "default.Attack[j]", "image=\ref[iconfile]")

		var/QuestChecker = QuestCheck("Update Party")
		if(QuestChecker == "Stop") return //The quest they are doing is taking care of organizing the Pokemon in the Party.

		for(var/i=1, i<7, i++)
			var/mob/Pokemon/P = Party[i]
			if(!P) continue
			P.AddMeter(1) //This updates the Meter, which is also in the Party list.
			winset(src, "Party", "current-cell=1,[++items]")
			if(P.Ball == ItemUsing || P == ControlingPokemon) winset(src, "Party", "text-color=blue")
			src << output(P.Ball, "Party")
			winset(src, "Party", "current-cell=2,[items]")
			src << output(P.Meter, "Party")
			winset(src, "Party", "text-color=black")

		winset(src, "Party", "cells=2x[items]")	// cut off any remaining rows
	ReorganizeParty()
		for(var/i=1, i<7, i++)
			var/mob/Pokemon/P = src.Party[i]
			if(!P && i != 6)
				for(var/p=i, p<6, p++)
					src.Party[p] = src.Party[p+1]
					src.Party[p+1] = null
	RemoveFromParty(var/mob/Pokemon/P)
		for(var/j=1, j<7, j++) //Removes the Pokemon from the Party
			if(Party[j] == P)
				Party[j] = null
				if(ControlingPokemon == P) P.ReturntoBall()
				ReorganizeParty()
		UpdateParty()
	AddMoney(var/Amount, var/Reason) //Used with Mom to store money in safe spot
		if(Reason == "Battle Win")
			var/area/Routes/R = loc.loc
			if(istype(R,/area/Routes))
				if(ClaimedRoutes[R.name] == Team)
					Amount = Amount * 2
					src<<System("<b> Money rewarded has been doubled due to your Team Status.")
		if(Team)
			var/Team/T = Find_Player_Team(Team)
			if(T && istype(T))
				var/ToTeam = round(percent_of(Amount,T.Dues))
				T.Bank += ToTeam

				Amount -= ToTeam
				src<<System("[ToTeam] Pokédollars were collected as dues for [T].")

		if(MomPercent)
			var/ToMom = round(percent_of(Amount,MomPercent))
			MomBank += ToMom

			Money += round(Amount) - ToMom
			src<<System("You receive [Amount] Pokédollars. [ToMom] Pokédollars sent to Mom.")
		else
			Money += round(Amount)
			src<<System("You receive [Amount] Pokédollars.")
	ReturnAll()
		for(var/mob/Pokemon/P in Party)
			spawn()
				for(var/obj/Overworld/O in world)
					if(O.owner == P)
						del O
			P.loc = null
			P.icon = initial(P.icon)
			P.icon_state = null
			var/obj/Balls/B = P.Ball
			if(!istype(B,/obj/Balls/Egg)) B.icon = 'Pokeballs.dmi'
			B.icon_state = initial(B.icon_state)
			P.overlays = null
		ControlingPokemon = null





















































client
	Northeast()
		return
	Northwest()
		return
	Southeast()
		return
	Southwest()
		return