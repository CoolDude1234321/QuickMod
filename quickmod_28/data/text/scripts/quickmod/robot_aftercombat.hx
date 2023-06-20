//this is basically half of what happens after combat. this is *before* scrapping is done; and the main code within scrapactuator.hx is *after* scrapping is done.

var self = args[0];
var target = args[1];
if(target.hassuper) {
	self.setvar("enemyname","Super " + target.name);
} else {
	self.setvar("enemyname",target.name);
}

Rules.inventor_setgadgets(2);
self.setvar("toscrap",2);
if(target.equipment.length == 1) {
	Rules.inventor_setgadgets(1);
	self.setvar("toscrap",1);
}
if(!self.getvar("quellbloodlust")) {
	self.setvar("myequipment_temp",self.equipment);
	//self.equipment = target.equipment; //crashy
	var enemyequipment = getequipmentlist(target, [], []);
	self.equipment = []; //NOT removeequipment; that actually deletes the equipment that was stored
	_internalgiveequipment(self, enemyequipment, 1, false);
	for(eq in self.equipment)	{
		//eq.resetfornewturn();
		//eq.resetaftercombat();
		if(eq.gadget == "" || eq.gadget == null || eq.gadget == "Broken Gadget") {
			eq.gadget = "Broked Gadgit";
		}
	}
	self.name = "Inventor";
	var gadg = self.createskillcard("Inventor Gadgets", []);
	self.equipment.push(gadg);
}
self.setvar("quellboodlust",false);