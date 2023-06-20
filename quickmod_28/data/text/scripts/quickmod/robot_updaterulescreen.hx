if(!self.varexists("victims")) {
	var victims = [];
	var starter = [
		"Starter",
		"Lucky Shot",
		"Do [sword]5 damage",
		"Regenerate",
		"Heal [heal]3 health"
	];
	victims.push(starter);
	self.setvar("victims",victims);
}

var victims = self.getvar("victims");
if(args[0] != null) victims.push(args[0]);
self.setvar("victims",victims);

//wish i could use a stringbuffer
var text = ["h1|Your victims, what you took from them, and","h1|the total cost in health to access your spoils:",""];
var cost = 0;
var linear = 1;
//for(data in victims) {
var i = victims.length;
while(i > 0) {
	i = i - 1;
	var data = victims[i];
	var line = "[80%][yellow]" + data[0] + "[]: ";
	if(data[3] == "Empty Slot") {
		line = line + data[1] + "[] (" + data[2] + "[]). Cost: [heart]" + cost;
	} else {
		line = line + data[1] + "[] (" + data[2] + "[]), " + data[3] + " (" + data[4] + "[]). Cost: [heart]" + cost;
	}
	text.push(line);
	
	cost = cost + linear;
	linear = linear + 1;
}
Rules.rulescreen_text = text;