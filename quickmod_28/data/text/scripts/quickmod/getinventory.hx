self.getequipmentposition(); //forces the game to assign rows & columns to equipment early. this doesn't seem to have any adverse effects
// basically, the order of self.equipment is not stable, and the row and column of the equipment in the inventory ui should not be presumed to match the order implied by self.getequipmentposition() (which is a function that, despite its name, *sets* equipment positions (row and column)). that's a problem when you're creating new equipment that isn't assigned a row/column in the inventory, and then replacing old equipment that *is* with it. getequipmentposition is left to deal with where to position them and misorders things as a result.
var equipmentinorder = [];
	
for(i in 0...3) {
	for(ii in 0...2) {
		for(eq in self.equipment) {
			//trace(eq.name);
			//trace(i + " " + eq.column);
			//trace(ii + " " + eq.row);
			if(eq.column == i && eq.row == ii) {
				if (eq.size == 2) { equipmentinorder.push(eq); }
				equipmentinorder.push(eq);
				break;
			}
		}
	}
}
return equipmentinorder;


//var spellbook = runscript(~quickmod/getinventory~); self.setvar(~spellbook~|spellbook); trace('Final Spellbook: '+spellbook);