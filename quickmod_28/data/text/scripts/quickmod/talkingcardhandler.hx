var self = args[0];
var target = args[1];
var e = args[2];
var name = args[3];

var monologuetable = loaddata("quickmod/talkingcards");
var myMonologues = [];
//trace("Trying to get "+name+" to talk");
for (i in 0...(monologuetable.length)) {
	if (monologuetable[i].Name == name) {
		myMonologues.push(monologuetable[i].Description);
	}
}
e.fulldescription = rand(myMonologues);
//trace(name+" has talked!");