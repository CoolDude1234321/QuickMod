var allenemies = [
"Magician",
"Space Marine",
"Gardener",
"Hothead",
"Robobot",
"Slime",
"Frog",
"Wolf Puppy",
"Rose",
"Dryad",
"Baby Squid",
"Sticky Hands",
"Alchemist",
"Marshmallow",
"Mimic",
"Stereohead",
"Wizard",
"Sneezy",
"Pirate",
"Sorceress",
"Copycat",
"Keymaster",
"Bully",
"Handyman",
"Fireman",
"Yeti",
"Haunted Jar",
"Cactus",
"Vacuum",
"Drain Monster",
"Aurora",
"Rhino Beetle",
"Dire Wolf",
"Kraken",
"Crystalina",
"Wicker Man",
"Snowman",
"Loud Bird",
"Rotten Apple",
"Wisp",
"Cowboy",
"Rat King",
"Warlock",
"Banshee",
"Cornelius",
"Paper Knight",
"Skeleton",
"Singer",
"Gargoyle",
"Bounty Hunter",
"Madison",
"Buster",
"Audrey",
"Aoife",
"Drake",
"Scathach",
"Beatrice"];

var checkedequipment = new elements.Equipment("Sword").gamevar;
trace("MISSING GADGETS FOR ENEMY EQUIPMENT (includes Broken Gadgets):");
var missinggadgetfound = false;
for(f in allenemies) {
	var enemy = new elements.Fighter(f);
	for(e in enemy.template.equipment) {
		if(!checkedequipment.exists(e)) {
			checkedequipment.set(e, true);
			var eq = new elements.Equipment(e);
			if(eq == null) { //doesn't ever actually happen; dicey just throws an error if it tries to create nonexistant equipment. and there's no try/catch
				trace(enemy.name + ": " + e + " DOESN'T EXIST...");
			}
			else if(eq.gadget == "Broken Gadget") {
				missinggadgetfound = true;
				trace(enemy.name + ": " + eq.name);
			}
		}
	}
	for(e in enemy.template.superequipment) {
		var eq = new elements.Equipment(e);
		if(!checkedequipment.exists(e)) {
			checkedequipment.set(e, true);
			var eq = new elements.Equipment(e);
			if(eq == null) {
				trace("Super " + enemy.name + ": " + e + " DOESN'T EXIST...");
			}
			else if(eq.gadget == "Broken Gadget") {
				missinggadgetfound = true;
				trace("Super " + enemy.name + ": " + eq.name);
			}
		}
	}
}
if(!missinggadgetfound) {
	trace("None! Hooray.");
}
trace("~~~");