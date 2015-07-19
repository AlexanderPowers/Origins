var/list/Badwords = list(\
	"fag","bastard","fuck","fucker","f u c k",
	"cock","cunt","pussy","bitch","nigger","chink",
	"slut","fucking",
	"fking","fag","b!tch",
	"cum","f@g","nigga"," ass ","homo","penis","dick","douche","crap",
	"ñ","¿","\n")

mob/Player/var
	Title = 'Poke Ball.png'
	tmp/Headset = 0

mob/Player/verb




	Options()
		if(client) winset(src, "Options", "is-visible=true")
		UpdateOptions()



	OOC(var/T as text)

		//winset(src, "default.Question", "image=\ref[iconfile]")
		if(!name || name == "????")
			usr<<System("You must first get a name to use OOC. Sorry")
			return
		if(!T) return
		if(AFK) //They have been marked Active!
			AFK = 0
			icon_state = "Male Base"
			DaycareLogin()
		if(ClothingOverlays["Mute"])
			usr<<System("You have been muted.")
			return
/*		if(winget(src, "OOC ON", "is-checked") == "false")
			usr<<System("OOC must be turned on to use it. You can change this in the Options tab.")
			return*/
		if(length(T) > 300)
			usr << System("Your message exceeded 300 characters (Length was: [length(T)])<br>Your message was:<i> [T]</i>")
			return
		T = filter(T)
		for(var/mob/Player/P in world)
			spawn(0)
				if(P.IgnoredKeys.Find(ckey)) continue //Don't send if they are ignoring the talker
				/*if(P.client) if(winget(P, "OOC ON", "is-checked") == "false") continue*/ //Don't send if they have OOC OFF
				P<<"<font color=red>OOC| \icon[Title] [name]: <font color = white> [html_encode(T)]"
		ChatLog+="<font color=red>OOC| [name](<font size = 1>[ckey]<font size = 2>): <font color = white>[T]</font><br>"

	Say(var/msg as text)
		if(AFK)
			AFK = 0
			icon_state = "Male Base"
			DaycareLogin()
		ChatLog+="<font color=blue>SAY| [name](<font size = 1>[ckey]<font size = 2>): <font color = white>[html_encode(html_decode(msg))]</font><br>"
		//GM verbal Verbs
		if(src.GMVerbalVerbs(msg)) return

		if(usr.ScrollingText) return
		var/area/A = loc.loc
		if(A.type == /area) loc = locate(155,153,2)
		if(!msg || !client) return
		if(ClothingOverlays["Mute"])
			usr<<System("You have been muted.")
			return
		//Team verbal Verbs.
		for(var/Team/T in Teams)
			if(T.Team_VerbalVerbs(msg, usr)) return

		//Send to Mobs
		//Are they wearing a headset?
		if(Headset && usr.ClothingOverlays["Accesories"] == "Headset")
			var/Title = 'Headset.png'
			for(var/mob/Player/P in world)
				if(P.HeadsetFrequency == usr.HeadsetFrequency && P.ClothingOverlays["Accesories"] == "Headset")
					P<<"<B><font color=white>\icon[Title] \[Headset ([usr.HeadsetFrequency])] [name]: </b><font color = white> [html_encode(msg)]"

		else
			for(var/mob/Player/P in range(9))
				if(!P.IgnoredKeys.Find(ckey))
					P<<Dialog(src, filter(html_encode(html_decode(msg))))



	Rules()
		usr <<browse_rsc('WildPokemon.jpg',"Wild.jpg")
		usr <<browse_rsc('OwnedPokemon.jpg',"Owned.jpg")
		usr <<browse_rsc('Rules.png',"Rules.png")
		usr <<browse_rsc('asking.jpg',"ASK.jpg")
		usr <<browse_rsc('BlockingDoor.jpg',"Move.jpg")
		winset(usr, "browser", "is-visible=true")
		usr <<browse({"
<BODY BGCOLOR="black" TEXT="black">

<TABLE Border=1 BGCOLOR="maroon" Bordercolor="maroon" Align=center width = 400>
<TR>
<TD>
<center>
<IMG SRC="Rules.png"></center>
<br>
<BR>
These rules are pretty simple to follow, so if you are unable too, there is a punishment of
course if the police or a GM catch up to you. As of now these are the only rules, as these have
come to the attention of the current players. There will be rule changes over time though.
So make sure you check back every once in a while.
<BR><BR>
<b><u>Rule 1:</u> Don't spam in OOC<BR><BR></B>
Nobody likes a spammer. If you feel the need to spam, don't spam on our game. Spamming also includes typing in 1 word at a time.
<BR><BR>

<b><u>Rule 2:</u> Don't ask for things.<BR><BR></B>
Do not ask for things from me, such as Gym Leader, Police, Items, Pokemon, GM, etc. If you deserve them, you will get them, but by asking..not only will you NOT get them, but your chances will be lowered. This includes wishful thinking (ex 'I really wish I was a cop!') or joking around (ex. 'Hey! You should give me Gym Leader!.. JK!')
<center>
<TABLE BGCOLOR="black">
<TR><TD>
<center><IMG SRC="ASK.jpg">
</TR>
</TABLE></center>
<BR><BR>

<b><u>Rule 3:</u> Don't start inappropriate conversations.<BR><BR></B>
This is a Pokemon game, so try to keep conversations PG, PG-13 at best.
<BR><BR>

<b><u>Rule 4:</u> Don't have arguements over OOC..<BR><BR></B>
Nobody likes hearing 2 people argueing. Usually when people argue over OOC, it causes other people to get involved. If you really need to have an arguement, have it in say or over MSN.
<BR><BR>

<b><u>Rule 5:</u> Don't harrass GMs or other players.<BR><BR></B>
Show respect to others. If you wouldn't want someone harrassing you, you shouldn't harrass others.

</TD>
</TR>
</TABLE>
<br>
<font color = white><center>Pokemon Image from: <a href="http://www.arkeis.com"><img src="http://img.photobucket.com/albums/v362/aragornbird/Banners%20and%20Avatars/arkeis_button.jpg" border="0" alt="Image hosted by Photobucket.com"><br></a>

"})



















//Skin Buttons//-----------------------------------------------------------------------------------
mob/Player/verb
	Set_Partner()
		if(QuestCheck("Click Set Partner")) return 1
		if(Partner)

			if(alert("You already have [Partner] as your partner. Abandon them for someone else?",,"Yes","No") == "Yes")
				Partner = null
			else return
		var/mob/Player/P = GetPlayer("Who will be your partner?",oview())
		if(!P) return
		if(P.Court)
			usr<<System("[P] is currently in a battle. Ask again afterwards.")
			return
		if(alert(P,"[src] would like you to be their battling partner. Do you accept?",,"Yes","No") == "Yes")
			Partner = P
			if(src) src.ScrollText("System", "[P] has been made your partner. They will no longer be your partner if you or they log out.")
			if(P) P.ScrollText("System", "[src] has been made your partner. They will no longer be your partner if you or they log out.")

	TurnSound()
		set hidden = 1
		if(winget(src, "SOUNDS ON", "is-checked") == "true")
			src.BackgroundMusic(null)
		else
			usr<<sound(null)
	HeldItem()
		set hidden = 1
		var/mob/Pokemon/P = ControlingPokemon
		if(!P || !isPokemon(P) || !P.loc) return

		if(P.HeldItem)
			if(TalkingTo["Hold Item"]) return
			TalkingTo["Hold Item"] = 1
			if(alert("[P] is already holding [P.HeldItem]. Take this item from [P]?","[P]'s Held Item","Yes","No") == "Yes")
				contents += P.HeldItem
				P.HeldItem = null
		else
			var/obj/O = input("What should [P] hold?") in src.contents
			P.HeldItem = O
			contents -= P.HeldItem
		P.PokemonInformation(usr)
		TalkingTo -= "Hold Item"

	Items()
		set hidden = 1
		winset(usr, "Party", "is-visible=false")
		winset(usr, "Items", "is-visible=true")
		winset(usr, "ItemsLabel", "is-visible=true")
		winset(usr, "RightArrow", "is-visible=true")
		winset(usr, "LeftArrow", "is-visible=true")
		UpdateItems()
		QuestCheck("Check Items Tab Button")
	Party()
		set hidden = 1
		winset(usr, "default.Party", "is-visible=true")
		winset(usr, "default.Items", "is-visible=false")
		winset(usr, "default.ItemsLabel", "is-visible=false")
		winset(usr, "default.RightArrow", "is-visible=false")
		winset(usr, "default.LeftArrow", "is-visible=false")
		UpdateParty()
		QuestCheck("Click Party Tab")
	LeftArrow()
		set hidden = 1
		var/list/Switch = list("Normal" = "Key Items", "Balls" = "Normal", "Berries" = "Balls", "TMs" = "Berries", "Clothing" = "TMs", "Key Items" = "Clothing")
		Bag = Switch[Bag]
		UpdateItems()
	RightArrow()
		set hidden = 1
		var/list/Switch = list("Normal" = "Balls", "Balls" = "Berries", "Berries" = "TMs", "TMs" = "Clothing", "Clothing" = "Key Items", "Key Items" = "Normal")
		Bag = Switch[Bag]
		UpdateItems()
	Attack1()
		set hidden = 1
		var/obj/Moves/M = Attacks[1]
		QuestCheck("Check Press Q")
		if(M)
			M.Attack()
	Attack2()
		set hidden = 1
		var/obj/Moves/M = Attacks[2]
		if(M)
			M.Attack()
	Attack3()
		set hidden = 1
		var/obj/Moves/M = Attacks[3]
		if(M)
			M.Attack()
	Attack4()
		set hidden = 1
		var/obj/Moves/M = Attacks[4]
		if(M)
			M.Attack()
	Attack5()
		set hidden = 1
		var/obj/Moves/M = Attacks[5]
		if(M)
			M.Attack()
	Attack6()
		set hidden = 1
		var/obj/Moves/M = Attacks[6]
		if(M)
			M.Attack()
	Headset() //Press Tab
		set hidden = 1
		if(Headset)
			winset(usr, "default.SAY", "image = ''")
			winset(usr, "default.SAY", "text = 'Say:'")
			Headset = 0
		else
			winset(usr, "default.SAY", "image = 'Headset.png'")
			winset(usr, "default.SAY", "text = ''")
			Headset = 1
	BugButton()
		set hidden = 1
		winset(usr, "BugSubmit", "is-visible=true")
		winset(usr,"BugSubmit.BugSubmitInput", "text='(Enter Bug Report Here)'")
	BugSubmit(var/t as text)
		set hidden = 1
		if(!t) t = winget(usr,"BugSubmit.BugSubmitInput", "text") //They probably hit the submit button.
		winset(usr, "BugSubmit", "is-visible=false")
		winset(usr,"BugSubmit.BugSubmitInput", "text='(Enter Bug Report Here)'")

		BugLog += "([time2text(world.realtime)]) - [usr] submitted: [t].<BR><BR><BR>"

		usr<<System("Your bug report has been submitted. Thank you for the input!")

	ClosePokemonInformation()
		set hidden = 1
		winset(usr, "PokemonInformation", "is-visible=false")
	PlayerRun()
		set hidden = 1
		if(findtext(ClothingOverlays["Shoes"],"Running Shoes"))
			if(z != 5)
				usr<<System("You cannot use Running Shoes in buildings or caves.")
				return
			RunningShoes = 1

	PlayerRunRelease()
		set hidden = 1
		RunningShoes = 0
	UseHM()
		set hidden = 1
		var/mob/Player/P
		if(isPlayer(usr)) P = usr
		else return

		if(P.ControlingPokemon)
			var/mob/Pokemon/M = P.ControlingPokemon
			if(P.Watcher || P.Court) return //No flying or teleporting away from trainer battles.
			if(M.HM)
				winset(usr, "PokemonInformation", "is-visible=false")
				M.HM.Use(M)



//Titles



var/list/TitleInfo = list("Pokeball" = 'Poke Ball.png',\
						"Bug Emblem" = 'Symbol - Bug.png',\
						"Dark Emblem" = 'Symbol - Dark.png',\
						"Dragon Emblem" = 'Symbol - Dragon.png',\
						"Electric Emblem" = 'Symbol - Electric.png',\
						"Fairy Emblem" = 'Symbol - Fairy.png',\
						"Fighting Emblem" = 'Symbol - Fighting.png',\
						"Fire Emblem" = 'Symbol - Fire.png',\
						"Flying Emblem" = 'Symbol - Flying.png',\
						"Ghost Emblem" = 'Symbol - Ghost.png',\
						"Grass Emblem" = 'Symbol - Grass.png',\
						"Ground Emblem" = 'Symbol - Ground.png',\
						"Ice Emblem" = 'Symbol - Ice.png',\
						"Normal Emblem" = 'Symbol - Normal.png',\
						"Poison Emblem" = 'Symbol - Poison.png',\
						"Psychic Emblem" = 'Symbol - Psychic.png',\
						"Rock Emblem" = 'Symbol - Rock.png',\
						"Steel Emblem" = 'Symbol - Steel.png',\
						"Water Emblem" = 'Symbol - Water.png',\
						"Female Sign" = 'Female.png',\
						"Male Sign" = 'Male.png',\
						"Herb Badge" = 'Herb.png',\
						"Whirlpool Badge" = 'Whirlpool.png',\
						"Magnet Badge" = 'Magnet.png',\
						"Sky Badge" = 'Sky.png',\
						"Tectonic Badge" = 'Tectonic.png',\
						"Breeder Egg" = 'Egg.png',\
						"Heal Sign" = 'Heal.png',\
						"Repeat Ball" = 'Repeat Ball.png',\
						"Birthday Cake" = 'Birthday.png')







mob/Player/
	proc/Title_Check(var/Tag)
		PortraitCheck() //Might as well check Portraits at the same time.
		//Repeat Ball----------------------------------------------------------
		var/mob/Pokemon/RB
		var/Counter1
		for(var/mob/Pokemon/p in Party)
			Counter1 += 1
			if(!RB) RB = p
			if(p.type == RB.type) continue
			else
				RB = null
				break
		if(RB && Counter1 == 6)
			Titles += "Repeat Ball"
			src<<System("Repeat Ball Title awarded!")

		//Type Emblems----------------------------------------------------------
		var/SameType1
		var/SameType2
		Counter1 = 0
		for(var/mob/Pokemon/p in Party)
			Counter1 += 1
			if(!SameType1)
				SameType1 = p.Type1
				SameType2 = p.Type2
			else if(SameType1 != p.Type1 && SameType1 != p.Type2 && SameType2 != p.Type2 && SameType2 != p.Type2)
				SameType1 = 1 //They won't get the title then.
				SameType2 = 1
		if(istext(SameType1) ||istext(SameType2))
			if(SameType1 && Counter1 == 6 && !Titles["[SameType1] Emblem"])
				Titles += "[SameType1] Emblem"
				src<<System("[SameType1] Emblem Title awarded!")
			if(SameType2 && Counter1 == 6 && !Titles["[SameType2] Emblem"])
				Titles += "[SameType2] Emblem"
				src<<System("[SameType2] Emblem Title awarded!")
		//Egg//-----------------------------------------------------------------
		if(Tag == "Egg Hatch")
			Titles += "Breeder Egg"
			src<<System("Breeder Egg Title awarded!")

	var/Titles = list("Pokeball")
	verb/Change_Title()

		var/NEW = input("Which Medal would you like to use on OOC?") in Titles
		if(!NEW) return
		Title = TitleInfo[NEW]
		if(!Title)
			Title = "Pokeball"

