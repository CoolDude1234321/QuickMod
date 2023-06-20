var self = args[0];
var skill = args[1];
var i = args[2];

var prepend = "
	function Gadget_changegadget(f, gadget, newgadget) {
		if(gadget != \"" + skill.name + "\") { print('robot changegadget doesnt support changing other gadgets rn'); return; }
		if(!f.varexists('skills')) { return; }
		var skills = f.getvar('skills');
		skills[((f.getvar('skillpage') - 1) * 3) + " + i + "] = newgadget;
		f.setvar('skills',skills);
		
		var skillcard = f.getskillcard();
		skillcard.skills[" + i + "] = new elements.Skill(newgadget);
		skillcard.skillsavailable[" + i + "] = true;
		skillcard.animate('flashandshake');
	}
";

skill.script = (prepend + skill.script.split("Gadget.changegadget(").join("Gadget_changegadget("));
/*
var skills = self.getvar('skills');
skills[self.getvar('skillpage') + i] = newgadget;
self.setvar('skills',skills);

var skillcard = self.getskillcard();
skillcard.skills[i] = new elements.Skill(newgadget);
skillcard.skillsavailable[i] = true;
*/