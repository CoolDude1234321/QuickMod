var self = args[0];
var target = args[1];
var shuffle = args[2];
Rules.inventor_setgadgets(2);
self.setvar("toscrap",2);
if(!self.getvar("quellbloodlust")) {
	//this could be supported for Wacky Fun Times but i don't feel like properly implementing it right now (e.g. making sure it shows up over enemy equipment)
	for(eq in self.equipment) {
		if(eq.hastag("appearsforparts")) {
			eq.removetag("appearsforparts");
		}
	}
	self.name = "Inventor";
	self.equipment.remove(self.getskillcard());
	var gadg = self.createskillcard("Inventor Gadgets", ["Replace Me"]);
	self.equipment.push(gadg);
	
	//get enemy items
	var enemyequipment = getequipmentlist(target, [], []);
	if(enemyequipment.length > 4) {
		shuffle(enemyequipment);
		while(enemyequipment.length > 4) {
			enemyequipment.pop();
		}
	}
	if(enemyequipment.length == 1) {
		Rules.inventor_setgadgets(1);
		self.setvar("toscrap",1);
		while(enemyequipment.length < 3) {
			enemyequipment.unshift("Sorry Nothing");
		}
	}
	else {
		while(enemyequipment.length < 4) {
			enemyequipment.unshift("Sorry Nothing");
		}
	}
	for(e in enemyequipment) {
		var eq = new elements.Equipment("Sorry Nothing");
		if(e != "Sorry Nothing") {
			var ref = new elements.Equipment(e);
			eq.displayname = ref.displayname;
			eq.resize(ref.size);
			eq.changeslots(ref.getslots());
			eq.equipmentcol = ref.equipmentcol;
			eq.gadget = ref.gadget;
		}
		eq.fulldescription = "(Ephemeral.)";
		eq.addtag("appearsforparts");
		eq.addtag("hidereusable");
		self.equipment.push(eq);
	}
}
self.setvar("quellboodlust",false);