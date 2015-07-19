//Variables

var/list/PlayerLoginTimes = list()  //Ckey == Login Time[World.Realtime]

//SetUp-Customization//
mob/Player/proc
	Set_Up_Titlescreen()
		if(!client) return
		client.eye = locate(94,7,2)
		client.perspective = EYE_PERSPECTIVE
		frozen = 1
		Refresh_Custom()


	Refresh_Custom()
		var/turf/T = locate(/turf/transporting/Custom)
		var/list/Hairstyles = icon_states('Hair.dmi')


		RemovebyID("Cannot Hair")
		for(var/obj/Titlescreen/Custimization/Hair_Colour/H in world)
			if(!Hairstyles.Find("[HairStyle]Hair[H.name]"))
				AddScreenOverlay('HUD.dmi',"NoColour",H,"Cannot Hair",102)

		RemovebyID("Custom Hair")
		for(var/section in ClothingOverlays)
			var/c = src.ClothingOverlays[section]
			AddScreenOverlay('Clothing.dmi',c,T,"Custom Clothing",101)
			if(section == "Hair") AddScreenOverlay('Hair.dmi',c,T,"Custom Hair",101)
		AddScreenOverlay(Ricon,null,T,"Custom Skin",100)






//Titlescreen Mob Login//----------------------------------------------------------------------------------------------------------------
/mob/Titlescreen/
	frozen = 1
	Login()
		loc = locate(pick(9,26,43,60,77),7,2)
		winset(src, "default", "size=887x651")
		src << 'Login Screen.mid'
		src << output("<center><a href = http://pokeorigins.forumotion.com/forum>Forums</a><br><a href = http://pokeorigins.forumotion.com/f1-updates>Update Notes</br></a>", "output2")
		verbs -= verbs //No verbs

		for(var/mob/Player/P in world)
			if(P.client && client)
				if(P.client.computer_id == client.computer_id)
					P<<"Another connection has been made using your network address.  Please terminate this session befre attempting to log in with another key. "
					src<<"Another connection has been made using your network address."
					del src


	Logout()



//Titlescreen Buttons//--------------------------------------------------------------------------------------------------------------------------
obj/Titlescreen

	NEW
		layer = 102
		pixel_y = -16
		icon = 'HUD.dmi'
		icon_state = "Login Button"
		Click()
			if(istype(usr,/mob/Titlescreen))
				usr.New_Character()
				spawn(20) if(!usr.ckey) del usr
				return ..()

	LOAD
		layer = 102
		pixel_y = 8
		icon = 'HUD.dmi'
		icon_state = "Login Button"
		Click()
			if(istype(usr,/mob/Titlescreen))
				usr.Load_Character()
				spawn(20) if(!usr.ckey) del usr
				return ..()
obj/Titlescreen
	NEXT
		layer = 102
		pixel_y = -8
		icon = 'HUD.dmi'
		icon_state = "Login Button"
		Click()
			if(istype(usr,/mob/Player))
				var/mob/Player/P = usr

				P.ReAddClothing()

				P.QuestAdd(/obj/Quest/A_New_Beginning)
				P.QuestCheck("Play Intro")

	Custimization
		Hair_Colour
			icon = 'HUD.dmi'
			layer = 101
			pixel_y = -24
			pixel_x = 8
			Click()
				if(isPlayer(usr))
					var/mob/Player/P = usr
					var/list/Hairstyles = icon_states('Hair.dmi')

					if(!Hairstyles.Find("[P.HairStyle]Hair[name]"))
						P<<System("The [P.HairStyle] hairstyle is not available in [name].")
						return

					P.HairColour = name
					P.ClothingOverlays["Hair"] = "[P.HairStyle]Hair[P.HairColour]"

					P.Refresh_Custom()
			Brown
				icon_state = "BrownHair"
			Black
				icon_state = "BlackHair"
			White
				icon_state = "WhiteHair"
			Blonde
				icon_state = "BlondeHair"
			Blue
				icon_state = "BlueHair"


		Hair
			icon = 'Hair.dmi'

			Click()
				if(isPlayer(usr))
					var/mob/Player/P = usr

					P.HairStyle = name
					P.ClothingOverlays["Hair"] = "[P.HairStyle]Hair[P.HairColour]"

					P.Refresh_Custom()


			layer = 102
			pixel_y = 8
			Brandon
				icon_state = "BrandonHairWhite"
			Long
				icon_state = "LongHairBlue"
			Oak
				icon_state = "OakHairBrown"
			Birch
				icon_state = "BirchHairBrown"
			Punk
				icon_state = "PunkHairPink"
			Gary
				icon_state = "GaryHairBrown"
			May
				icon_state = "MayHairBrown"
			Electric
				icon_state = "ElectricHairBlonde"
			Combover
				icon_state = "ComboverHairBrown"



		Skin
			icon = 'HUD.dmi'
			pixel_x = 8
			pixel_y = 8
			layer = 120
			Click()
				if(isPlayer(usr))
					var/mob/Player/P = usr
					var/list/CCC = list("White" = 'MaleWhiteBase.dmi', "Tan" = 'MaleTanBase.dmi',"Black" = 'MaleBlackBase.dmi',"DoubleBlack" = 'MaleDoubleBlackBase.dmi')
					P.Skin = name

					P.icon = CCC[name]
					P.Ricon = P.icon
					P.RemovebyID("Custom Skin")
					P.Refresh_Custom()



			White
				icon_state = "WhiteSkin"
			Black
				icon_state = "BlackSkin"
			DoubleBlack
				icon_state = "DoubleBlackSkin"
			Tan
				icon_state = "TanSkin"


//Button Functions//--------------------------------------------------------------------------------------------------------------------------
mob/proc
	Save_Character(var/mob/Player/P)
		if(!P) P = src //I think I introduced P as a var because I wanted to be able to save players that were not online..

		if(!P.Party[1]) return //People cannot saved unless they have 1 Pokemon.
		var/savefile/S = new("Players/[copytext(ckey,1,2)]/[ckey].sav")

		if(P.x) P.SavedX = P.x
		if(P.y) P.SavedY = P.y
		if(P.z) P.SavedZ = P.z

		if(length(P.RentalStorage)) //Rentals are returned at logout.
			P.Party = P.RentalStorage
			P.RentalStorage = list()
		P.overlays -= P.overlays
		P.underlays -= P.underlays
		P.invisibility = 0
		P.density = 1
		P.icon_state = null
		P.icon = P.Ricon

		if(P && P.ckey) P.Write(S)

	Load_Character()
		if(BanCheck()) return //Checks to see if they are banned.
		if(!fexists("Players/[copytext(ckey,1,2)]/[ckey].sav"))
			src<<System("No Savefile Found. Redirecting to <i>New Character</i> sequence.")
			src.New_Character() //Runs them through character creation
			return
		var/savefile/S = new("Players/[copytext(ckey,1,2)]/[ckey].sav")
		var/mob/Player/P = new
		P.Read(S)

		P.loc = locate(P.SavedX, P.SavedY, P.SavedZ)
		P.SCREENHUD = new(P.client)
		world <<System("<B>[P] has logged into Pokemon Origins!")

		var/sound/So = new
		P<<So //Stops any music in the background


		//Checks//-----------------------------------------------------------------------------------------------------------------------------
		if(!P.StartTime) P.StartTime = world.realtime
		PlayerLoginTimes[P.ckey] = world.realtime
		P.UpdateHUBStanding() //Updates Wins and Loses, on Standings of HUB.
		P.GiveVerbs() //Give GM Verbs for those who need them.
		P.GLCheck() //Give Gymleader Verbs to those who need them.
		P.DaycareLogin() //Adds any Pokemon to the Daycare that need to be there.
		if(P.Team) //To get Team verbs, they must go through login.
			var/Team/T = Find_Player_Team(P.Team)
			spawn() T.Team_Login(P)
		spawn() P.QuestCheck("Login") //Checks all Quests, see if something is done at Login.
		PlayerNames[P.ckey] = P.name //This is to update the worlds Database.
		if(P.MuteTime) P.MuteTimer() //If the person was muted before loging out, the mute timer restarts.
		P.ReAddClothing() //Readds the clothing
		P.AddAll() //Adds all overlays and images, including those used in quests
		//M.BackgroundMusic()
		//Fade in
		P.SCREENHUD.icon_state = "Black"
		P.UpdateDayHUD()
		P.FadefromBlack()


		//Tell the user that a News Update has been made since they last logged in.
		if(P.LastNews != NewsDate[1]) P<<System("There has been a news update!")

	New_Character()
		if(BanCheck()) return //Checks to see if they are banned.
		//Checks for excisting Savefile. If it excists, check to see if they want to continue.
		if(fexists("Players/[copytext(ckey,1,2)]/[ckey].sav"))
			if(alert(src,"An already excisting savefile has been detected. To prevent accidental deletion of your savefile, please confirm, would you like to start a New Character?.","Character Creation","No","Yes") == "No") return

		var/mob/Player/P = new ()
		var/turf/T = locate(/turf/transporting/Custom)

		P.frozen = 1
		P.icon_state = null


		P.SCREENHUD = new(client)

		P.client = client
		P.StartTime = world.realtime

		//Give them some clothing//-------------------------------------------------------------------------------------------------------------------
		//Must go after because it uses ScreenOverlays
		if(P.gender == "female")
			new /obj/Clothing/Jumpsuit/Female_Red_Jumpsuit(P)
			new /obj/Clothing/Accesories/Red_Bandana(P)
			P.AvailablePortraits['May1.png'] = Date(world.realtime)
			P.ClothingOverlays["Hair"] = "MayHairBrown"
			P.ClothingOverlays["Robe"] = "Female Red Jumpsuit"
			P.ClothingOverlays["Accesories"] = "Red Bandana"
			P.Portrait = 'May1.png'

			P.AddScreenOverlay('Clothing.dmi',"Female Red Jumpsuit",T,"Custom Clothing",101)
		if(P.gender == "neuter") P.gender = "male"
		if(P.gender == "male")
			new/obj/Clothing/Jumpsuit/Red_Jumpsuit(P)
			new/obj/Clothing/Accesories/Red_Headband(P)
			P.AvailablePortraits['Brendan1.png'] = Date(world.realtime,0,0,1,1,1)
			P.Portrait = 'Brendan1.png'
			P.HairStyle = "Brandon"
			P.HairColour = "White"
			P.ClothingOverlays["Hair"] = "[P.HairStyle]Hair[P.HairColour]"
			P.ClothingOverlays["Robe"] = "Red Jumpsuit"
			P.ClothingOverlays["Accesories"] = "Red Headband"
		//Both Genders wear these shoes
		new/obj/Clothing/Shoes/Red_Shoes(P)
		P.ClothingOverlays["Shoes"] = "Red Shoes"

		//Checks//---------------------------------------------------------------------------------------------------------------------------
		P.GiveVerbs()
		//Create BOXs for PC//-------------------
		//Create the PC Storage
		for(var/i = 1, i<=20, i++)
			var/BOX/B = new
			P.Boxes += B
			B.name = "BOX [i]"
		P.CurrentBox = "BOX 1"
		//Put them at the Customization Screen//--------------------------------------------------------------------------------------------------------------
		P.Set_Up_Titlescreen()




mob/Player/Logout()
	RemoveSection("WatchingBattle") //Ya... overlays stack

	Save_Character(src)
	if(name && name != "????")
		if(Tests["Logout"]) world << System("<b>[src.name] [pick(LogoutMessages)] (Connection Terminated)")
		else world << System("<b>[src.name] has logged off Pokemon Origins.")

	//Checks// Things that need to be done when someone logs out
	DaycareLogout() //Has to go before you delete the Pokemon
	for(var/mob/Pokemon/P in world)
		if(GetOwner(P.Owner) == src)
			P.ReturntoBall(0)
			del P //This line of code deletes all the Players Pokemon from the world, because they are saved in the players mob and do not need to be present while they are offline.
	if(Court) Court.Battle_Logout(src) //When you log out, battles don't reconize this. This is to solve this.


	del src


mob/proc/BanCheck()
	if(Banned_IDs.Find(client.computer_id) || Banned_Keys.Find(ckey))
		var/list/Blist = Banned_IDs[client.computer_id]
		if(!Blist) Blist = Banned_Keys[ckey]
		if(!Blist)
			Banned_Keys -= ckey
			Banned_IDs -= client.computer_id
			return 0
		if(Blist["time"] == "Forever" || world.realtime < Blist["time"]) //They are still banned
			src<<System("You have been banned from the game.")
			return 1 //For now, till Jail is in?
		else //They are unbanned I suppose..
			Banned_Keys -= ckey
			Banned_IDs -= client.computer_id
			return 0







/turf/transporting/Custom
	layer = 102
