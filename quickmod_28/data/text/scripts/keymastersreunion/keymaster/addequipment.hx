//Jester: Add a particular card to your deck and draw it
var fighter = args[0];
var equipmentnames = args[1];

for(equipmentname in equipmentnames) {
	trace("Attempting to add "+equipmentname);
	var equipment = new elements.Equipment(equipmentname);
	var copy = Deck.createcopyondrawpile(fighter, equipment);
	equipment.dispose();

	self.setvar("unlocks", self.getvar("unlocks") + 1);
}

Deck.advance();
//Script.rungamescript(copy.scriptbeforestartturn, "equipment_scriptbeforestartturn", self, copy);