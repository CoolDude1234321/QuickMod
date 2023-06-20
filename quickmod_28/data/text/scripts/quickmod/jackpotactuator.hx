// copypasted from greendice.hx from tennis which i think was by not mario

var f = args[0];
var t = args[0];

self.resetvar("jackpotactuatorstop");

var script = new elements.DiceyScript("
if (self == null || self.doendturnnow || target.hp <= 0 || self.hp <= 0) {
    act._repeat = 0;
    act.stop();
    return;
}
else if(self.gamevar.exists(\"jackpotactuatorstop\")){
    act._repeat = 0;self.resetvar(\"jackpotactuatorstop\");
} else {

	if(!self.getvar('jackpotchecked')) {
		if(self.roll_jackpot > 0) {
			if(self.getskillcard().skills.length == 3 && self.getskillcard().skills[0].name == \"Replace Me\") {
				trace('found jackpot');
				var skills = self.getvar('skills');
				var page = self.getvar('skillpage');
				var offset = (page - 1) * 2;
				var eq = self.getskillcard();
				eq.skills[0] = new elements.Skill(skills[offset]);
				eq.skills[1] = new elements.Skill(skills[offset + 1]);
				if(eq.skills[0].name == 'Empty Slot') eq.skillsavailable[0] = false;
				if(eq.skills[1].name == 'Empty Slot') eq.skillsavailable[1] = false;
				if(eq.skills[0].script.indexOf('Gadget.changegadget(') != -1) runscript('quickmod/changegadget_robotfix',[self,eq.skills[0],0]);
				if(eq.skills[1].script.indexOf('Gadget.changegadget(') != -1) runscript('quickmod/changegadget_robotfix',[self,eq.skills[1],1]);
				eq.skills[2] = new elements.Skill('Next Page');
				eq.skills[2].name = 'Next Page (' + page + '/' + (skills.length / 2) + ')';
				eq.skills[2].description = 'Get older skills, -[heart]' + page;
				if(page == skills.length / 2) {
					eq.skillsavailable[2] = false;
				}
				else {
					eq.skills[2].script = \"
						var amt = \" + page + \";
						sfxdamage(self,amt);
						sfx('_drain');
						pierceattackself(amt);
						resetjackpot(self);
						self.roll_jackpotbonus += 1;
						self.setvar('jackpotchecked',false);
						self.setvar('skillpage',self.getvar('skillpage') + 1);
					\";
				}
				self.setvar('jackpotchecked', true);
			}
		}
	}

}
");
script.set("self",f);
script.set("target",t);
script.set("trace",trace);
script.set("runscript",runscript);
//script.set("rand",rand);
var act = new motion.actuators.SimpleActuator(null, 0.01, null);
script.set("act",act);
act._repeat = -1;
act.onRepeat(script.execute, []);
act.move();