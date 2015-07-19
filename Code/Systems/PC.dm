//The MOB Stuff//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
mob/Player/
	var
		//20 Boxes are created when the player first starts the game. Each Box contains 32 Pokemon,
		//and if the box is filled, Pokemon can not be sent here when captured.
		list/Boxes = list()
		CurrentBox //This should be assigned at random at the character creation.

	proc
		AddPKMNParty() // Returns the slot that is open, returns 0 if there are no spots.
			for(var/i=1, i<7, i++)
				var/mob/Pokemon/P = src.Party[i]
				if(!P) return i
			return 0
		Find_Box(var/Look)
			for(var/BOX/i in Boxes)
				if(!Look)
					if(i.name == CurrentBox) return i
				else
					if(i.name == Look) return i



		ConstructPC()
			for(var/i = 1, i<= 32, i++)
				winset(src, "PCBOX.BOX[i]", "is-visible=false")
			for(var/i = 1, i<= 6, i++)
				winset(src, "PCBOX.PARTY[i]", "is-visible=false")

			var/BOX/CB = Find_Box()
			CB.ReorganizeBox()
			winset(src, "PCBOX.BOXLabel", "text='[CB.name] - [CB.IsRoom() - 1] Pokemon")

			for(var/i = 1, i<=32, i++)
				var/mob/Pokemon/P = CB.Pokemon[i]
				if(!P) continue
				//Give the buttons a picture.
				var/icon/I = new('PokedexIcons.dmi', "[P.Number]")
				if(istype(P.Ball, /obj/Balls/Egg)) I = new(P.Ball.icon, P.Ball.icon_state)
				var/iconfile = fcopy_rsc(I)
				winset(src, "PCBOX.BOX[i]", "is-visible=true")
				winset(src, "PCBOX.BOX[i]", "image=\ref[iconfile]")
				//Give the buttons a verb\"
			for(var/j = 1, j<=6, j++)
				var/mob/Pokemon/P = Party[j]
				if(!P) continue

				//Give the buttons a picture.
				var/icon/I = new('PokedexIcons.dmi', "[P.Number]")
				if(istype(P.Ball, /obj/Balls/Egg)) I = new(P.Ball.icon, P.Ball.icon_state)
				var/iconfile = fcopy_rsc(I)
				winset(src, "PCBOX.PARTY[j]", "is-visible=true")
				winset(src, "PCBOX.PARTY[j]", "image=\ref[iconfile]")
				//Give the buttons a verb\"




	verb
		PCLogout()
			set hidden = 1
			if(TalkingTo["PCinUSE"]) return
			winset(usr, "PCBOX", "is-visible=false")

		ChangeBox()
			set hidden = 1
			var/BOX/B =input("Which box should be your current box?") in Boxes
			CurrentBox = B.name
			ConstructPC()
		PCRename()
			set hidden = 1
			var/NewName = input("What do you want to name this box?")
			if(!NewName) return
			var/BOX/B = Find_Box()
			B.name = NewName
			CurrentBox = NewName
			ConstructPC()
		ClickPCPokemon(var/N as num)
			set hidden = 1
			var/mob/Pokemon/P
			var/mob/Player/M = usr
			var/BOX/CB = Find_Box()
			if(!isPlayer(M)) return
			var/list/Options
			if(TalkingTo.Find("PCinUSE")) return
			TalkingTo += "PCinUSE"
			if(N > 36)
				N -= 100
				P = Party[N]
				Options = list("Deposit", "Move", "Stats", "Release", "Cancel")
				var/Pokes
				for(var/mob/Pokemon/P2 in Party)
					if(!istype(P2.Ball,/obj/Balls/Egg)) Pokes += 1
				if(Pokes <= 1)
					Options = list("Stats", "Cancel")

			else
				P = CB.Pokemon[N]
				Options = list("Withdraw", "Move", "Stats", "Release", "Cancel")


			var/input = input("What would you like to do?","[istype(P.Ball, /obj/Balls/Egg)?"Egg":P.name]") in Options
			if(winget(src, "PCBOX", "is-visible") == "false")
				TalkingTo -= "PCinUSE"
				return
			switch(input)
				if("Withdraw")
					var/PartyOpenSlot = M.AddPKMNParty()

					if(!PartyOpenSlot)
						M<<System("There is currently no room in your party to withdraw [P]. Deposit a Pokemon from your party first.")

					else
						M.Party[PartyOpenSlot] = P
						CB.RemovePokemon(P)
						M<<System("[P] has joined your Party!")
						M.UpdateParty()
					M.ConstructPC()
					TalkingTo -= "PCinUSE"
				if("Deposit")
					var/BoxOpenSlot = CB.IsRoom()

					if(M.QuestCheck("Deposit Check", P)) return //This is for quests.
					if(!BoxOpenSlot)
						M<<System("There is currently no room in your box to deposit [P]. Change your current box, then try again.")
					if(!M.Party[2])
						M<<System("You must always have 1 Pokemon in your Party.")
					else
						CB.AddPokemon(P,M)
						M<<System("[P] deposited in [CB]")
						M.UpdateParty()
					M.ConstructPC()
					TalkingTo -= "PCinUSE"
				if("Stats")
					TalkingTo -= "PCinUSE"
					P.PokemonInformation(M)
					M<<"<B><U>[P]'s Moveset</b></u><BR>"
					for(var/obj/Moves/MO in P.Moves)
						var/html = "--"
						if(MO.Type == "Unprogramed") html += "<i>"
						else html += "<font color = [TypesColours[MO.Type]]>"
						html += " <b>([MO.Type])</B></font>"
						html += " [MO]"
						M<<html

				if("Move")
					if(M.QuestCheck("Move Check", P)) return //This is for quests.
					var/BOX/NewBox = input(M,"Move to which box") in M.Boxes
					NewBox = NewBox.name
					CB.MovePokemon(P,NewBox)
					M.ConstructPC()
					TalkingTo -= "PCinUSE"
				if("Release")
					if(M.QuestCheck("Release Check", P)) return //This is for quests.
					if(alert(M,"Are you sure you want to release [P]","Release","No","Yes") == "Yes")
						M<<System("You wave goodbye to [P] as it leave for the wild.")
						del P
						M.ReorganizeParty()
						M.ConstructPC()
						M.UpdateParty()
					TalkingTo -= "PCinUSE"
				if("Cancel")
					TalkingTo -= "PCinUSE"
















//The BOX//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BOX //This the Box Datum
	var
		Pokemon[36] //This is a list of Pokemon within the Pokemon Box.
	proc/
		IsRoom() //This checks to see if there is room for one Pokemon in the Box.
			//usr.list_view(Pokemon,"Pokemon")
			for(var/i = 1, i<=32, i++)
				if(!Pokemon[i]) return i
				if(isPokemon(Pokemon[i])) continue
				else return i
			return 0
		ReorganizeBox()
			for(var/i=1, i<32, i++)
				var/mob/Pokemon/P = Pokemon[i]
				if(!isPokemon(P) && i != 32)
					for(var/p=i, p<32, p++)
						Pokemon[p] = Pokemon[p+1]
						Pokemon[p+1] = null
		AddPokemon(var/mob/Pokemon/Add, var/mob/Player/P) //Add is the Pokemon being added to the Box. If P is provided, it searches this list and removes "Add" from it.
			Pokemon[IsRoom()] = Add
			if(P && isPlayer(P)) //It is asking us to remove the Pokemon from the Party.
				for(var/j=1, j<7, j++) //Removes the Pokemon from the Party
					if(P.Party[j] == Add)
						P.Party[j] = null
						P.ReorganizeParty()
		RemovePokemon(var/mob/Pokemon/Remove)
			for(var/j=1, j<36, j++) //Removes the Pokemon from the Party
				if(Pokemon[j] == Remove)
					Pokemon[j] = null
					ReorganizeBox()
		MovePokemon(var/mob/Pokemon/Move, var/NewBox)
			var/mob/Player/P = GetOwner(Move.Owner)
			if(!P) return
			var/BOX/NB = P.Find_Box(NewBox)
			if(!NB) return
			RemovePokemon(Move)
			NB.AddPokemon(Move, P)
		FindPokemon(var/mob/Pokemon/Poke) //Returns 1 if it finds the Pokemon in the box
			for(var/i=1, i<32, i++)
				var/mob/Pokemon/P = Pokemon[i]
				if(P == Poke) return 1
			return 0


obj/deco/PKMNCenter/Computer
	icon_state = "Computer"
	pixel_y = 16
	density = 0
	verb/Access()
		set src in view(1)
		var/mob/Player/M = usr
		if(!isPlayer(M)) return
		winset(usr, "PCBOX", "is-visible=true")
		M.ConstructPC()

	Click()
		if(loc == usr.loc)
			Access()
	SteppedOff()
		..()
		winset(usr, "PCBOX", "is-visible=false")




/*obj/PKMNBox
	var/
		number
		Box[] = list(1 = null, 2 = null, 3 = null, 4 = null, 5 = null, 6 = null, 7 = null, 8 = null, 9 = null, 10 = null, 11 = null, 12 = null, 13 = null, 14 = null, 15 = null, 16 = null, 17 = null, 18 = null , 19 = null, 20 = null)

	proc/BoxSpace() //1 if space, 0 if not
		for(var/i = 1, i<=20,i++)
			if(!Box[i]) return i
		return 0

	proc/Withdraw_Pokemon(var/mob/Player/M, var/mob/Pokemon/P)
		if(!M || !P) return //These two variables must be true.

	proc/Deposit_Pokemon(var/mob/Player/M, var/mob/Pokemon/P)
		if(!M || !P) return //These two variables must be true.
		if(!BoxSpace()) return //Theres no room in this box.
		for(var/i = 1, i<= 20, i++)
			if(!Box[i])
				Box[i] = P
				for(var/j=1, j<7, j++) //Removes the Pokemon from the Party
					if(M.Party[j] == P)
						M.Party[j] = null
						M.ReorganizeParty()
				M<<System("[P] was deposited in Box [M.CurrentBox]")
				M.UpdateParty()
				break




obj/deco
	PKMNCenter
		Computer
			icon_state = "Computer"
			pixel_y = 16
			density = 0
			verb/Access()
				set src in view(1)
				winset(usr, "browser", "is-visible=true")
				MainMenu(usr)


			proc/MainMenu(mob/Player/M)
				if(!M) return
				M.PortraitCheck() //Calls System(Nothing)
				if(M.loc != src.loc) M<<browse(null)
				var/html = "<body bgcolor=#000000 text=#FFFF00><B><U><font color = red><font size=1><font face=Verdana>Welcome [M]!</U><BR><BR><HR><BR>"
				html += "<BR><BR><BR>Current Box Number: [M.CurrentBox]<BR><BR>"
				html += "<a href=?src=\ref[src];action=Withdraw>Withdraw Pokemon</a><BR>"
				html += "<a href=?src=\ref[src];action=Deposit>Deposit Pokemon</a><BR>"
				html += "<a href=?src=\ref[src];action=BoxChange>Change Box Number</a><BR>"

				html += "<BR><BR><HR><BR><BR>"

				M<<browse(html)
			proc/WithdrawPokemon(mob/Player/M)
				M.PortraitCheck() //Calls System(Nothing)
				if(M.loc != src.loc) M<<browse(null)
				var/html = "<body bgcolor=#000000 text=white><B><U><font color = red><font size=1><font face=Verdana>Welcome [usr]!</U><BR><BR><HR>"
				html += "<BR><BR><BR>Current Box Number: [M.CurrentBox]<BR><BR>"
				html += "<TABLE Border=0 Bordercolor=white><font color = white>"

				var/obj/PKMNBox/OpenBox = M.Boxes[M.CurrentBox]
				if(!OpenBox)
					MainMenu(M)
					return
				for(var/mob/Pokemon/P in OpenBox.Box)
					var/obj/Balls/B = P.Ball
					if(istype(B,/obj/Balls/Egg))
						//M << browse_rsc(icon(B.icon,"[B.icon_state]"), "Egg.png")
						html += "<TR><TD width = 161><img src= Egg.png> Egg</TD>"
					else
						//M << browse_rsc(icon('PokedexIcons.dmi',"[P.Number]"), "[P.Number].png")
						html += "<TR><TD width = 161><img src= [P.Number].png> [P.name]</TD>"
					html += "<TD><a href=?src=\ref[src];action=GetPokemon;Poke=\ref[P]>Withdraw</a><BR>"
					html += "<a href=?src=\ref[src];action=Stats;Poke=\ref[P]>Stats</a><BR>"
					html += "<a href=?src=\ref[src];action=ReleasePokemon;Poke=\ref[P]>Release</a></TD></TR>"
				html += "<BR><BR><a href=?src=\ref[src];action=MainMenu>Back</a><BR><BR>"
				M<<browse(html)
			proc/DepositPokemon(mob/Player/M)
				M.PortraitCheck()
				var/html = "<body bgcolor=#000000 text=white><B><U><font color = red><font size=1><font face=Verdana>Welcome [usr]!</U><BR><BR><HR><BR><BR>"
				html += "<BR><BR><BR>Current Box Number: [M.CurrentBox]<BR><BR>"
				html += "<TABLE Border=0 Bordercolor=white><font color = white>"


				for(var/mob/Pokemon/P in M.Party)
					var/obj/Balls/B = P.Ball
					if(istype(B,/obj/Balls/Egg))
						//M << browse_rsc(icon(B.icon,"[B.icon_state]"), "Egg.png")
						html += "<TR><TD width = 161><img src= Egg.png> Egg</TD>"
					else
						//M << browse_rsc(icon('PokedexIcons.dmi',"[P.Number]"), "[P.Number].png")
						html += "<TR><TD width = 161><img src= [P.Number].png> [P.name]</TD>"


					html += "<TD width = 161><a href=?src=\ref[src];action=LeavePokemon;Poke=\ref[P]>Deposit</a><BR>"
					html += "<a href=?src=\ref[src];action=Stats;Poke=\ref[P]>Stats</a><BR>"
					html += "<a href=?src=\ref[src];action=ReleasePokemon;Poke=\ref[P]>Release</a></TD></TR>"
				html += "<BR><BR><a href=?src=\ref[src];action=MainMenu>Back</a><BR><BR>"
				M<<browse(html)
			proc/ChangeBox(mob/Player/M)
				var/html = "<body bgcolor=#000000 text=white><B><U><font color = red><font size=1><font face=Verdana>Welcome [usr]!</U><BR><BR><HR><BR><BR>"
				html += "<BR><BR><BR>Current Box Number: [M.CurrentBox]<BR><BR>"
				html += "<TABLE Border=0 Bordercolor=white><font color = white>"
				for(var/obj/PKMNBox/B in M.Boxes)
					var/OpenSpot
					for(var/i=1, i<41, i++) //???
						var/mob/Pokemon/P = B.Box[i]
						if(!P)
							OpenSpot = i - 1
							i = 100
					if(OpenSpot == null) OpenSpot = 20
					html += "<TR><TD><a href=?src=\ref[src];action=ChangeBox;num=[B.number]>Box [B.number]</a>([length(B.Box)]/20)</TD></TR>"
				html += "<BR><BR><a href=?src=\ref[src];action=MainMenu>Back</a><BR><BR>"
				M<<browse(html)
obj/deco/PKMNCenter/Computer/Topic(href,href_list[])
	..()
	var/mob/Player/G
	if(istype(usr,/mob/Player))
		G = usr
	if(!G) return
	if(G.loc != src.loc)
		G<<"Connection Error: Please log back in!"
		src.MainMenu(G)
		return
	switch(href_list["action"])
		if("MainMenu")
			src.MainMenu(G)

		if("Withdraw")
			if(!G.AddPKMNParty())
				G<<"You already have 6 pokemon in your party. Please deposit one first to use this function."
				return
			else
				src.WithdrawPokemon(G)
		if("Deposit")

			if(!G.Party[2])
				G<<"You only have 1 pokemon in your party. Please withdraw one first to use this function."
				return
			else
				src.DepositPokemon(G)
		if("GetPokemon")
			var/mob/Pokemon/P = locate(href_list["Poke"])
			var/obj/PKMNBox/OpenBox = G.Boxes[G.CurrentBox]
			var/Continue
			//Checks for the Pokemon in the Box. If its not there..it can't be withdrawn again..
			for(var/i=1, i<21, i++)
				if(OpenBox.Box[i] == P)
					Continue = 1
			if(!Continue) return

			var/OpenSlot = G.AddPKMNParty()
			if(OpenSlot)
				G.Party[OpenSlot] = P
				for(var/i=1, i<21, i++)
					if(OpenBox.Box[i] == P)
						OpenBox.Box[i] = null
				G<<"[P] has joined your party!"
				G.UpdateParty()
				G.Title_Check()
			if(!G.AddPKMNParty())
				src.MainMenu(G)
			else WithdrawPokemon(G)

		if("LeavePokemon")
			var/mob/Pokemon/P = locate(href_list["Poke"])
			var/obj/PKMNBox/OpenBox = G.Boxes[G.CurrentBox]
			OpenBox.Deposit_Pokemon(G, P)
			if(istype(G.Party[2],/mob/Pokemon)) src.DepositPokemon(G)
			else src.MainMenu(G)
		if("ReleasePokemon")
			var/mob/Pokemon/P = locate(href_list["Poke"])
			if(alert("Release [P]?","Release","No","Yes") == "Yes")
				G<<"You wave goodbye to [P]."
				del P
				G.ReorganizeParty()

			src.MainMenu(G)
		if("Stats")
			var/mob/Pokemon/P = locate(href_list["Poke"])
			P.PokemonInformation(usr)
		if("BoxChange")
			ChangeBox(G)
		if("ChangeBox")
			G.CurrentBox =  text2num(href_list["num"])
			src.MainMenu(G)*/