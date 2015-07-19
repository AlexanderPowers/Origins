


mob/Player/
	var
		NewHelpTopics = list()
		UnlockedHelpTopics = list("People and Places" = list(), "Battling" = list())
	proc
		UpdatePokemonHelpList()
			if(!length(HelpTopicButtons)) //First person to access the list
				var/list/T = typesof(/obj/HUD/HelpButton)
				for(var/i in T) HelpTopicButtons += new i
			var/items
			for(var/obj/HUD/HelpButton/HB in HelpTopicButtons)

				winset(src, "PokedexHelpList", "current-cell=[++items]")
				src << output(HB, "PokedexHelpList")






var/list/HelpTopicButtons = list()


var/list/HelpTopics = list(\
"People and Places" = list(\
	"The Pokemon Center" = "At the Pokemon Center, you can do quite a few things. Most importantly you can heal your Pokemon by talking to Nurse Joy. When you talk to a Nurse Joy, it automatically sets your spawn point to the Pokemon Center you are in. <BR><BR><B>Trading Machines</B><BR>The Trading Machine is available to all trainers and is to the right as you enter the Pokemon Center. Once both players have used the machine, a pop-up will appear, allowing both players to choose a Pokemon for Trade. Once both Pokemon are confirmed, the trade will commence. <BR><BR><I>Note: Some Pokemon are not tradable, but their offspring are. Starter Pokemon for example, are not able to be traded.<BR><BR>Note2: Some Pokemon evolve during a trade. Remember, you are responsible for your trades. If it doesn't got the way you planned, it is not a Game Moderator's fault. <BR><BR></i>",\
	"The Pokemart" = "The Pokemart is available to all trainers to supply the basic needs, such as Pokeballs, Potions, Status Healing Items, Repels, and many more items. Each store is funded by NEXUS corp, and generally offers different items exclusive to their location, so check around. West of Lycus Valley is a town called Ridgeport, which contains a department store. This store will offer much more variety in items, including Clothing, Evolution Items, and TMs.",\
	"Contest Halls",\
	"Gyms" = "In most towns in Joleon, a Pokemon Gym is present. These are gyms set up by the Joleon Pokemon League. Once you defeat the leader of a Gym, they will present you with a Gym Badge. If you collect 8 of these, you will be eligable for the Pokemon League conference. This involves a tournament of other trainers with 8 badges. If you win this tournament, you will be able to battle the Elite Four and the current Champion. Badges you have won will be visible in the Achievements part of your Player Information.",\
	"Player Gyms" = "Player Gyms operate on a different League than the Joleon Pokemon League.",\

	)
)








obj/HUD/HelpButton
	icon = 'HUD.dmi'
	Items_and_Inventory
		icon_state = "Items and Inventory"
	Trainers_and_People
		icon_state = "Trainers and People"
	Pokemon
		icon_state = "Pokemon"
	Battling_and_Tactics
		icon_state = "Battle Versus"


