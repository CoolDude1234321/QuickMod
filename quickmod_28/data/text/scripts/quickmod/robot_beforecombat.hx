//moved everything to scrapactuator.hx so robot ends up entirely normal when they return to the overworld

/*var self = args[0];
var removeequipment = args[1];
Rules.inventor_setgadgets(1); //fixes skillcard height

removeequipment("Sorry Nothing");

var skills = self.getvar("skills");
if(skills.length % 2 == 1) {
	skills.push("Empty Slot");
}
if(self.name == "Inventor" && self.getskillcard().skillcard == "inventor") {
	trace("transferring inventor skills");
	for(sk in self.getskillcard().skills) {
		if(sk.name != "Broken Gadget[]") {
			skills.unshift(sk.name);
		} else {
			skills.unshift("Broken Gagdet");
		}
	}
	self.setvar("skills",skills);
	self.equipment.remove(self.getskillcard());
	var calc = self.createskillcard("Robot Calculate", []);
	self.equipment.push(calc);
	self.name = "Robot";
}*/