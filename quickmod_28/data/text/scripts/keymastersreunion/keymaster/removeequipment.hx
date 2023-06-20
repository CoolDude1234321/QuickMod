var self = args[0];

self.getequipmentposition();

var equipment = ["empty","empty","empty","empty","empty","empty"];
var modifiers = ["", "", "", "", "", ""];
var tags = [[],[],[],[],[],[]];

//Spellbook.reset();
for (e in self.equipment){
	
	var position = (e.column * 2) + e.row;

	if (e.name != "empty" && e.skillcard == "") {
		equipment[position] = e.name;
		modifiers[position] = e.namemodifier;
		tags[position] = e.tags;
	}
}

Spellbook.setto(equipment,[],0);
self.setvar("equipment", equipment);
self.setvar("modifiers", modifiers);
self.setvar("tags", tags);
self.setvar("unlocks", 0);

self.changetodecklayout([]);

var skillcard = self.createskillcard("Torn Spellbook", []);
skillcard.skillcard = "witch";
skillcard.skillcard_special = true;
skillcard.width = (132 + 20) * 6;
skillcard.height = 980 + 49 * 3;
self.equipment.push(skillcard);
skillcard.x = -5000;

//var inv = self.createskillcard("Sword", []);
//inv.x = skillcard.x;
//inv.y = skillcard.y;
//inv.width = skillcard.width;
//inv.height = skillcard.height;
//self.equipment.push(inv);

animateequipmentintoplace(self);

//self.setvar("inv",inv);

/*var act = new motion.actuators.SimpleActuator(null,1/60,null); 
var s = new elements.Skill("Against all odds_old"); 
s.script="

for (d in self.dicepool) {

	if (d.assigned != null && d.assigned.name == \"Torn Spellbook\") {

		sfx(\"openchest\");

		runscript(\"keymastersreunion/keymaster/addfromspellbook\",[self,d.basevalue + d.modifier]);

		d.assigned.destroydice();

	}

}

";
act._repeat = -1;
act.onRepeat(s.execute,[self,target]);
act.move();
self.setvar("actuator", act);*/
