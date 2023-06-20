var self = args[0];

if(self.equipment.length > 0) {
	var eqtosilence = null;
	var eqstosort = [];
	var exceptions = loaddata("ncrmod/silenceexceptions");
	for(enemy in exceptions) {
		trace(self.name);
		trace(enemy.enemyname);
		if(self.name == enemy.enemyname) {
			for(eq in self.equipment) {
				trace(enemy.importantcard);
				trace(eq.name);
				if(eq.name == enemy.importantcard) {
					eqstosort.push(eq);
					eqtosilence = eq;
					break;
				}
			}
		}
		if(eqtosilence == null) {
			for(eq in self.equipment) {
				if(eq.name == enemy.importantcard2) {
					eqstosort.push(eq);
					eqtosilence = eq;
					break;
				}
			}
		}
	}
	if(eqtosilence == null) {
	 var never = [for(card in loaddata("ncrmod/silencecardexceptions")) if(card.priority == "never") card.cardname];
	 var always = [for(card in loaddata("ncrmod/silencecardexceptions")) if(card.priority == "always") card.cardname];
	 eqstosort = [for(eq in self.equipment) if(eq.isready() && never.indexOf(eq.name) == -1 && eq.shockedsetting != 2) eq];
	 var eqstosort2 = [];
	 if(eqstosort.length > 0) for(eq in eqstosort) if(always.indexOf(eq.name) != -1) eqstosort2.push(eq);
	 if(eqstosort2.length > 0) eqstosort = eqstosort2;
	 if(eqstosort.length == 1) eqtosilence = eqstosort[0];
	 if(eqtosilence == null && eqstosort.length > 0) {
		var largeeqs = [for(eq in eqstosort) if(eq.size == 2) eq];
		if(largeeqs.length > 0) eqstosort = largeeqs;
		if(eqstosort.length == 1) eqtosilence = eqstosort[0];
		if(eqtosilence == null) {
		 var sorton = "";
		 for(eq in eqstosort) {
			if(eq.usesleft > 0 || (eq.usesleft == -1 && !eq.hastag("hidereuseable"))) {
			 sorton = "uses"; break;
			}
		 }
		 if(sorton == "") for(eq in eqstosort) {
			if(eq.countdown > 0) {
			 sorton = "cd"; break;
			}
		 }
		 if(sorton == "") for(eq in eqstosort) {
			if(eq.getslots().length > 0 && eq.getslots()[0].substr(0,7) != "REQUIRE") {
			 sorton = "normal"; break;
			}
		 }
		 if(sorton == "") sorton = "needsx";
		 trace(sorton);
		 var max = null;
		 if(sorton == "normal") max = eqstosort[0];
		 for(eq in eqstosort) {
			if(sorton == "uses") {
			 if(eq.usesleft == -1) {
				max = eq; break;
			 }
			 else if(max == null || eq.usesleft > max.usesleft) {
				max = eq;
			 }
			}
			if(sorton == "cd") {
			 if(max == null || eq.countdown > max.countdown) {
				max = eq;
			 }
			}
			if(sorton == "needsx") {
			 if(max == null || (eq.getslots().length > 0 && eq.getslots()[0].substr(0,7) == "REQUIRE" && (max.getslots.length == 0) || (max.getslots()[0].substr(0,7) != "REQUIRE")) || (eq.getslots().length > 0 && eq.getslots()[0].substr(0,7) == "REQUIRE" && (eq.getslots()[0].substr(7,0) - 0) > (max.getslots()[0].substr(7,0) - 0))) {
				max = eq;
			 }
			}
		 }
		 if(max != null) eqtosilence = max;
		}
	 }
	}
	
	if(eqtosilence == null && eqstosort.length > 0) { trace("what the fuck"); eqtosilence = eqstosort[0]; }
	if(eqtosilence == null && eqstosort.length == 0) { trace("what went on here"); eqtosilence = self.equipment[0]; }
	
	if(self.hasstatus("alternate_ncr_silence")) {
		eqtosilence.downgrade();
		eqtosilence.animate("flashandshake");
		eqtosilence.animation[eqtosilence.animation.length - 1].addcommand("textparticle", "[silence] Silenced!", 16777215);
		sfx("apply_silence_to_equipment");
	} else {
		if(self.hasstatus("ncr_silence")) {
			trace("ok here's what equipment i'm going to silence: ");
			trace(eqtosilence.name);
			trace(eqtosilence.getslots());
			eqtosilence.animate("silence");
			
			//This part's by Titku. It's a workaround for https://github.com/TerryCavanagh/diceydungeons.com/issues/2573.
			var silenceanim = eqtosilence.animation[eqtosilence.animation.length - 1];
			//The last command run was "applyvariable", so remove the last element of every array it pushed something onto, effectively undoing that command.
			silenceanim.command.pop();
			silenceanim.parameter.pop();
			silenceanim.p1.pop();
			silenceanim.p2.pop();
			silenceanim.p3.pop();
			silenceanim.p4.pop();
			silenceanim.executed.pop();
			silenceanim.timestamp.pop();
			//Now manually do everything silence does!
			eqtosilence.shockedtype = new elements.Equipment("Equipment That Does Nothing").slots[0]; //We can't just write out DiceSlotType.NORMAL, so we need to borrow it from an equipment that we know has a normal slot.
			eqtosilence.shockedsetting = 2;
			eqtosilence.shockedtext = "Place two dice|to break silence";
			eqtosilence.shockedcol = 10;
			eqtosilence.shocked_showtitle = false;
			eqtosilence.positionshockslots();
			//End Titku's part.
			
		}
	}
}