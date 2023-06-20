//Restore the Keymaster's Limit break and Curse on load, if he's been cursed
var self = args[0];

if(self.varexists("supercursed")){
	self.changelimitbreak("Cursed Ball");
	Rules.addplayerinnatestatus("cursed_key");
}
