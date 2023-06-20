var self = args[0];
var d = args[1];
trace("Add "+d+" from spellbook...");
if (self.hasstatus("cursed_key")) {

	d = (d - 1) % 6;

	if (d < 0) {
		d += 6;
	}

	if (self.getvar("equipment")[d] != "empty") {
		trace("Cursed Equipment: "+self.getvar("equipment")[d]);
		runscript("keymastersreunion/keymaster/addequipment",[self,[self.getvar("equipment")[d] + self.getvar("modifiers")[d]]]);
	}

} else {
	if (d > 6) {
		runscript("keymastersreunion/keymaster/addequipment",[self,["Cursed Key"]]);
	}

	if (self.getvar("equipment")[d-1] != "empty") {
		trace("Equipment: "+self.getvar("equipment")[d-1]);
		runscript("keymastersreunion/keymaster/addequipment",[self,[self.getvar("equipment")[d-1] + self.getvar("modifiers")[d-1]]]);

	}
}