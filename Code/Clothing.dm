mob/var/list/ClothingOverlays = list("Shirt"= null, "Pants"= null, "Shoes"= null, "Robe"= null, "Tie"= null,"Hair"=null,"Hood"= null,"Accesories"= null,"WatchingBattle" = null,"Pointer")


mob/proc
	RemoveAllClothing()
		for(var/C in src.ClothingOverlays)
			var/c = src.ClothingOverlays[C]
			if(C == "Hair") src.overlays -= image('Hair.dmi',"[c]")
			else src.overlays -= image('Clothing.dmi',"[c]")

	RemoveSection(var/section)
		var/c = src.ClothingOverlays[section]
		if(section == "Hair") src.overlays -= image('Hair.dmi',"[c]")
		src.overlays -= image('Clothing.dmi',"[c]")
		src.ClothingOverlays -= section

	AddSection(var/section, var/iconstate)
		RemoveSection(section)
		src.ClothingOverlays[section] = "[iconstate]"
		var/c = src.ClothingOverlays[section]
		if(section == "Hair") src.overlays += image('Hair.dmi',icon_state = "[c]")
		else src.overlays += image('Clothing.dmi',icon_state = "[c]")
	ReAddClothing()
		overlays = list()
		for(var/i in ClothingOverlays)
			if(ClothingOverlays[i]) AddSection(i, src.ClothingOverlays[i])


obj/Clothing/
	var/section
	var/overlay
	Description = "An article of clothing."
	icon = 'Clothing.dmi'
	New()
		if(!overlay)
			overlay = name
		if(!icon_state)
			icon_state = overlay
			icon = 'Clothing.dmi'
		..()
	Click()
		if(src in usr.contents)
			if(usr.ClothingOverlays[section])
				if(usr.ClothingOverlays[section] == src.overlay)
					if(!istype(src,/obj/Clothing/Jumpsuit)) usr.RemoveSection(section)
					return
				else usr.RemoveSection(section)
			usr.ClothingOverlays[src.section] = "[overlay]"
			usr.ReAddClothing()



	verb/

		Take()
			set src in oview(1)
			view()<<"[usr] picks up [src]."
			Move(usr)
		Drop()
			if(usr.ClothingOverlays[section] != src.overlay)
				view()<<"[usr] drops [src]."
				Move(usr.loc)
	Jumpsuit
		section = "Robe"
		Red_Jumpsuit
		Blue_Jumpsuit
		Green_Jumpsuit
		Black_Jumpsuit
		Female_Red_Jumpsuit
		Female_Blue_Jumpsuit
		Female_Green_Jumpsuit
		Female_Black_Jumpsuit
		Prisoner
		Karate
		Lab_Coat
		Red_Track_Suit
		Brown_Gentleman_Suit
		Black_Gentleman_Suit
		Blue_Gentleman_Suit
		White_Gentleman_Suit
		Yellow_Sundress
		Black_Sundress
		Tan_Sundress
		Orange_Sundress
		Picnic_Outfit

	Running_Shoes
		section = "Shoes"
		icon = 'ClothingOverworld.dmi'
		Red_Running_Shoes
		Blue_Running_Shoes
		Green_Running_Shoes
		Black_Running_Shoes
	Accesories
		section = "Accesories"
		Blue_Bandana
		Green_Bandana
		Red_Bandana
		Black_Bandana
		Blue_Headband
		Green_Headband
		Red_Headband
		Black_Headband
		Sunglases
		Pokestaff
		Glasses
		Net
		Black_Reverse_Cap
		Brown_Gentleman_Hat
		Black_Gentleman_Hat
		Blue_Gentleman_Hat
		Picnic_Hat
		Apron

	Shoes
		section = "Shoes"
		Red_Shoes
		Blue_Shoes
		Black_Shoes
		Brown_Shoes
		Sandals
		greyfillshoes
		brownfillshoes
		redfillshoes
		pinkfillshoes
		purplefillshoes
		lightbluefillshoes
		bluefillshoes

