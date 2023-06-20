// copypasted from greendice.hx from tennis which i think was by not mario

var f = args[0];
var t = args[0];

self.resetvar("scrapactuatorstop");

var script = new elements.DiceyScript("
if (self.name == 'Robot') {
	trace('still robot? scrapactuator bailing!');
    act._repeat = 0;
    act.stop();
    return;
}
else if(self.gamevar.exists(\"scrapactuatorstop\")){
    act._repeat = 0;self.resetvar(\"scrapactuatorstop\");
} else {
	var skillcard = self.getskillcard();
	if(skillcard.skills.length == self.getvar('toscrap')) {
		trace('all scrapped');
		var inventorgadgets = self.getskillcard();
		self.equipment = self.getvar('myequipment_temp');
		self.resetvar('myequipment_temp');
		var skills = self.getvar('skills');
		/*if(skills[skills.length - 1] == 'Empty Slot') {
			skills.pop();
		}*/
		var autopsy = [self.getvar('enemyname')];
		if(inventorgadgets.skills.length == 1) {
			skills.unshift('Empty Slot');
			autopsy.unshift('lol');
			autopsy.unshift('Empty Slot');
		}
		for(sk in inventorgadgets.skills) {
			skills.unshift(sk.name);
			autopsy.unshift(sk.description);
			autopsy.unshift(sk.name);
		}
		autopsy.unshift(self.getvar('enemyname'));
		runscript('quickmod/robot_updaterulescreen.hx',[autopsy]);
		/*if(skills.length % 2 == 1) {
			skills.push('Empty Slot');
		}*/
		self.setvar('skills',skills);
		self.getskillcard().height = 1080;
		self.name = 'Robot';
		act._repeat = 0;
		act.stop();
		return;
	}
}
");
script.set("self",f);
script.set("target",t);
script.set("trace",trace);
script.set("Rules",Rules);
script.set("runscript",runscript);
//script.set("rand",rand);
var act = new motion.actuators.SimpleActuator(null, 0.01, null);
script.set("act",act);
act._repeat = -1;
act.onRepeat(script.execute, []);
act.move();