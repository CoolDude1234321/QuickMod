// This is the "on create" field for thief witch. If you want to command it for something else feel free to make a different script for it
// SO. If you want something to have an effect when it is made by Spellcasters Quarterly, you do it here. Follow by example!
var d = args[0]; // Slot of this item
var spellbook = args[1];
var item = args[2];
var self = args[3];
var target = args[4];

trace(item.name);

if(item.name == "Landmine") {
	var x = "";
	if (item.namemodifier == "+") { x = "plus"; }
	target.addstatus("landmine"+x, 1);
}
if(item.name == "Sticky Hand") {
	item.doequipmentaction(self|target|-1|item.assigneddice|0.2);
}