obj/Berries
	icon = 'Berrys.dmi'
	TakeDrop = 1
	Discard = 1
	var/tmp/Inuse
	Click()
		var/mob/Player/M = usr
		if(!isPlayer(M)) return
		if(Inuse) return
		Inuse = 1
		var/mob/Pokemon/P = usr.Party_Choose("Which Pokemon do you want to evolve?", M.Party)
		if(P)
			if(P.Evolve[name]) //It can evolve using this stone.
				P.Evolve(name, src)
				M.UpdateItems()
		Inuse = 0

	Red_Apricorn
		icon_state = ""
		Description = "A special apricorn that can be made into a Level Ball."
	Yellow_Apricorn
		icon_state = ""
		Description = "A special apricorn that can be made into a Moon Ball."
	Blue_Apricorn
		icon_state = ""
		Description = "A special apricorn that can be made into a Lure Ball."
	Green_Apricorn
		icon_state = ""
		Description = "A special apricorn that can be made into a Friend Ball."
	Pink_Apricorn
		icon_state = ""
		Description = "A special apricorn that can be made into a Love Ball."
	White_Apricorn
		icon_state = ""
		Description = "A special apricorn that can be made into a Fast Ball."
	Black_Apricorn
		icon_state = ""
		Description = "A special apricorn that can be made into a Heavy Ball."


//Trees//-----------------------------------------

obj/deco/Routes/Tree
	Berry_Tree
		var/obj/Berries/BerryGiven


