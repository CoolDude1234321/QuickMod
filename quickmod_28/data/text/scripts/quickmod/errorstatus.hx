// put equipment names for error to change items into in errorstatusreplacements.txt

// self and target jank! ^w^
if (args[0] != null) {
	self = args[0];
	//trace("Manual self!");
}
if (args[1] != null) {
	target = args[1];
	//trace("Manual target!");
}

//  0 script
//  1 scriptbeforestartturn
//  2 scriptbeforeexecute
//  3 scriptonstartturn
//  4 scriptendturn
//  5 scriptbeforecombat
//  6 scriptaftercombat
//  7 scriptonanyequipmentuse
//  8 scriptonanycountdownreduce
//  9 scriptiffury
// 10 scriptonsnap
// 11 scriptondodge

var replacementscript = "if(simulation){bonus(400);}else{var newThing = rand(loadtext('quickmod/errorstatusreplacements')); var newEq = new elements.Equipment(newThing); newEq.x = e.x; newEq.y = e.y; newEq.temporary_thisturnonly = true; newEq.equippedby = self; newEq.resize(2); self.equipment.push(newEq); runscript('ncrmod/snap',[newEq,true,0,self,target]); sfx('jester_snap'); target.textparticle('Null Object Reference'); newEq.show = false; newEq.ready = false;delay(2);}";
var possibleeq = [];
var eq = null;
for (equi in self.equipment) {
	if(equi.ready) {
		possibleeq.push(equi);
	}
}
trace(possibleeq);
possibleeq = shuffle(possibleeq);
eq = possibleeq[0];


trace("Doing error on "+eq.name);
eq.scriptrunner = null; // Shut the fuck up dicey dungeons
//eq.animate("flashandshake");
eq.changecolour(rand(["gray","red","green","yellow","purple","brightcyan","orange","black","pink"]));
var scripts = [];
if (eq.script != "") {
	scripts.push(0);
}
if (eq.scriptbeforestartturn != "") {
	scripts.push(1);
}
if (eq.scriptbeforeexecute != "") {
	scripts.push(2);
}
if (eq.scriptonstartturn != "") {
	scripts.push(3);
}
if (eq.scriptendturn != "") {
	scripts.push(4);
}

if (eq.scriptbeforecombat != "") {
	scripts.push(5);
}

if (eq.scriptaftercombat != "") {
	scripts.push(6);
}

if (eq.scriptonanyequipmentuse != "") {
	scripts.push(7);
}

if (eq.scriptonanycountdownreduce != "") {
	scripts.push(8);
}

if (eq.scriptiffury != "") {
	scripts.push(9);
}

if (eq.scriptonsnap != "") {
	scripts.push(10);
}

if (eq.scriptondodge != "") {
	scripts.push(11);
}
// Fallback if the item is literally useless
if (scripts.length == 0) {
	scripts.push(0);
}

var chosenscript = rand(scripts);
if (chosenscript ==  0) { eq.script = replacementscript;}
if (chosenscript ==  1) { eq.scriptbeforestartturn = replacementscript;}
if (chosenscript ==  2) { eq.scriptbeforeexecute = replacementscript;}
if (chosenscript ==  3) { eq.scriptonstartturn = replacementscript;}
if (chosenscript ==  4) { eq.scriptendturn = replacementscript;}
if (chosenscript ==  5) { eq.scriptbeforecombat = replacementscript;}
if (chosenscript ==  6) { eq.scriptaftercombat = replacementscript;}
if (chosenscript ==  7) { eq.scriptonanyequipmentuse = replacementscript;}
if (chosenscript ==  8) { eq.scriptonanycountdownreduce = replacementscript;}
if (chosenscript ==  9) { eq.scriptiffury = replacementscript;}
if (chosenscript == 10) { eq.scriptonsnap = replacementscript;}
if (chosenscript == 11) { eq.scriptondodge = replacementscript;}
trace("Did error on "+eq.name+" (script type "+chosenscript+")");