obj/
	HUD
		Pokedex_Help_File
			var/HTML_icon
			Pokemon
				HTML_icon = "http://imageshack.us/scaled/landing/6/zzpk.png"
			People_and_Places
				HTML_icon = "http://imageshack.us/a/img541/854/2iwc.png"
			Items_and_Inventory
				HTML_icon = "http://imageshack.us/a/img35/119a6/6tt4.png"
			Battling
				HTML_icon = "http://imageshack.us/a/img845/802/luxi.png"

mob/Player/
	var
		list/UnlockedHelpFiles = list()
		//Each persons list has to be different, because the first time they come accross the topic, it'll pop up.
		//To stop it from popping up each time, they need to keep track of what they've stumbled accross
		//The four object categories keep track of what's been unlocked.
		HelpFileEditor = 0 //When this is set to 1, they are given the "Edit" option for Help Files.
	proc
		DisplayHome()
			spawn(1)
				var/html = "<body bgcolor = black><font color = white><centre><h1>Pokedex Help Files</h><hr>"
				for(var/i in HelpFileCategories)
					var/list/Topics = HelpFileCategories[i]
					Topics = Topics.Copy()

					html += "<h2><img src = [HelpFileCategoryImages[i]]>[i]</h><br><ul>"
					for(var/j in Topics)
						if(src.UnlockedHelpFiles.Find(j))
							html += {"<li><i><a href="byond://?src=\ref[src];action=LoadPokedexHelpFile;topic=[Replace_Character(j, " ", "*")]">[j]</a></i></li>"}

					html += "</ul><BR>"


				usr << output(html, "PokedexBrowser")




		DisplayTopic(var/Topic)
			winset(src, "PokedexPopup.TheTab", "current-tab='PokedexHelp'")
			winset(src, "PokedexPopup", "is-visible = true")
			var/String = Replace_Character(Topic, "*", " ")
			//usr<<String
			//usr<<HelpFilesHTML[String]
			//for(var/i in HelpFilesHTML)
			//	usr<<"[i] = [HelpFilesHTML[i]]"
			var/html = "<body bgcolor = black><font color = white><a href=byond://?src=\ref[src];action=PokedexHome><h2>Home</h></a><HR><h3>[String]</h><br><br>[HelpFilesHTML[String]]"
			if(MasterGMCheck() || GMCheck() || HelpFileEditor)
				if(!findtext(Topic, "Temp"))
					html += {"<HR><a href="byond://?src=\ref[src];action=EditPokedexHelpFile;topic=[Topic]">Edit</a>"}

			usr << output(html, "PokedexBrowser")

		PokedexUnlock(var/Topic)
			if(!UnlockedHelpFiles.Find(Topic))
				UnlockedHelpFiles += Topic
				if(QuestReturnList(/obj/Quest/Hello_Dexter_22)) 	usr<<"<B><font color=red>\icon['Pokedex.png'] Dexter: You have unlocked a Pokedex Entry (<font color=white>[Topic]<font color=red>) Click <a href=byond://?src=\ref[src];action=LoadPokedexHelpFile;topic=[Topic]>here</a> to read it."
		EditHelpFile(var/Topic)
			if(!MasterGMCheck() && !GMCheck() && !HelpFileEditor)
				usr<<System("You are not a GM. You do not have clearance to edit Pokedex Files.")
				return 0
			if(!Topic)
				Topic = input("Edit which Help File?") in HelpFilesHTML

			var/NewHTML = HelpFilesHTML[Topic]
			var/Approve = null
			while(!Approve)
				NewHTML = input("Please enter the HTML for this Pokedex Help File. ","Pokedex Help File Editor", NewHTML) as message

				HelpFilesHTML["Temp[Topic]"] = NewHTML
				DisplayTopic("Temp[Topic]")
				//HelpFilesHTML -= "Temp[Topic]" //This is just temporary. To show the edited copy. Remove it from the offical list or it gets saved

				if(alert("Do you accept this new version of [Topic]","Pokedex Help File Editor","Yes","No") == "Yes") Approve = 1
				else continue

			HelpFilesHTML[Topic] = NewHTML


var/list/HelpFileCategoryImages = list(\
				"Pokemon" = "http://imageshack.us/scaled/landing/6/zzpk.png",
				"People and Places" = "http://imageshack.us/a/img541/854/2iwc.png",
				"Items and Inventory" = "http://imageshack.us/a/img35/119a6/6tt4.png",
				"Battling" = "http://imageshack.us/a/img845/802/luxi.png")
var/list/HelpFileCategories	=  list(\
				"Pokemon" = list("Catching", "Moves", "Breeding", "Trading", "Evolution", "Levels and Spawning", "Status", "Types"),
				"People and Places" = list("Joleon", "Bloomsberry Lake", "Lycus Valley", "Net City", "Ridgeport", "Elkvale", "Skysight", "Mirage City", "Kindleheart", "Whitereach", "Nurse Joy", "NPC Gymleaders", "Player Gymleaders", "Followers", "Name Rater", "Move Relearner", "Banker", "Daycare Ladys", "Daycares", "Pokemon Centers", "PokeMarts"),
				"Items and Inventory" = list("Party Tab", "Items Tab", "Pokeballs", "TMs and HMs", "Clothing", "Event Tokens", "Badges and Ribbons", "Running Shoes"),
				"Battling" = list())

var/list/HelpFilesHTML = list(\
				"Badges and Ribbons" = "",
				"Banker" = "The Banker is also known as your mother. She resides in your hometown of Lycus Valley. She sits in the house in the bottom left corner of the valley. She will save your money, in the same fashion that the mom from Generation 2 games does.<BR><BR><B>Withdraw Money</b>Your mother will have a reserve of your saved money in which you can access at anytime.<BR><BR><B>Deposit Money</b>You can leave money with your mother. When you black out, you will a percentage of your money, so it is best not to have large amounts on you (unless you plan on making a purchase).<BR><BR><B>Change Saving Percentage</B><BR>You can adjust how much money you want sent to your mother, from 5% to 35%, of your battle winnings. If you are trying to save money, put the percentage higher.",
				"Bloomsberry Lake" = "",
				"Breeding" = "",
				"Catching" = "",
				"Clothing" = "",
				"Daycares" = "",
				"Daycare Ladys" = "",
				"Elkvale" = "",
				"Event Tokens" = "",
				"Evolution" = "",
				"Followers",
				"Joleon" = "Joleon is a vast Region that spreads over many different types of climates and cultures. At the heart of the region is Lycus Valley, where NEXUS opporates. <BR><BR>This company is responsible for any technological themed advanced related to Pokemon. They proudly support and encourage Pokemon trainers to journey throughout the region of Joleon, in an effort to not only better themselves, but the community as well. <BR><BR>Joleon houses 2 Pokemon Leagues. The first, run by NEXUS, requires a trainer to travel from town to town to defeat the designated NPC gymleader. Once any 8 badges have been acquired, you are eligable to challenge the Elite 4 and possibly the Champion. The second is a community based league, where Players may be hired to set up a gym and hand out badges to victors. Every month there is a tournament held for all players with the set amount of badges. The winner then has the chance to challenge the currently reigning Champion, if one is currently active. ",
				"Kindleheart" = "",
				"Levels and Spawning" = "",
				"Lycus Valley" = "",
				"Mirage City" = "",
				"Move Relearner" = "",
				"Moves" = "",
				"Name Rater" = "",
				"Net City" = "",
				"NPC Gymleaders" = "",
				"Nurse Joy" = "",
				"Party Tab" = "",
				"Player Gymleaders" = "",
				"Pokeballs" = "",
				"Pokemon Centers" = "",
				"Pokemarts" = "",
				"Ridgeport" = "",
				"Running Shoes" = "",
				"Status" = "",
				"Skysight" = "",
				"TMs and HMs" = "",
				"Types" = "",
				"Trading" = "",
				"Whitereach" = "")


/*
[8:35:01 PM] Alexander Powers: People and Places, Pokemon, Battling, and Items and Inventory.
[8:35:46 PM] Alexander Powers: Places would include information on: Joleon, All the Towns, All the Buildings (Pokemon Center, Poke Mart, Gym, Player Gym).
[8:36:28 PM] Alexander Powers: People would include NPCs such as Nurse Joy, the Gymleaders, the Player Gymleaders, and Followers (ex. Pip)
[8:37:19 PM] Alexander Powers: Pokemon would include: Catching, Leveling, Evolving, Breeding.
[8:37:28 PM] Alexander Powers: Level Spawning.
[8:38:01 PM] Ryan Drife: o.o
[8:38:04 PM] Alexander Powers: Battling would include both types of battles (NPC vs other), Partnering, Tournaments.
[8:38:50 PM] Alexander Powers: And Items and Inventory would cover the Party and Items tabs, Pokeballs and Catch Rates, Evolutionary Stones, TMs, Clothing, and Event Tokens.

PokedexHelpBrowser
*/





