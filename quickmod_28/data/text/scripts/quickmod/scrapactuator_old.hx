// copypasted from greendice.hx from tennis which i think was by not mario

var f = args[0];
var t = args[0];

self.resetvar("scrapactuatorstop");

var script = new elements.DiceyScript("
if (self.name == 'Robot') {
	trace('scrapactuator ending late!');
    act._repeat = 0;
    act.stop();
    return;
}
else if(self.gamevar.exists(\"scrapactuatorstop\")){
    act._repeat = 0;self.resetvar(\"scrapactuatorstop\");
} else {
	var skillcard = self.getskillcard();
	if(skillcard.skills.length == self.getvar('toscrap') && skillcard.skills[0].name != 'Replace Me') {
		trace('all scrapped');
		removeequipment('Sorry Nothing');
		act._repeat = 0;
		act.stop();
		return;
	}
}
");
script.set("self",f);
script.set("target",t);
script.set("trace",trace);
script.set("removeequipment",removeequipment);
//script.set("rand",rand);
var act = new motion.actuators.SimpleActuator(null, 0.01, null);
script.set("act",act);
act._repeat = -1;
act.onRepeat(script.execute, []);
act.move();