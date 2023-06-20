//Jester: Add a particular card to your deck and draw it
var fighter = args[0];
var target = args[1];

var result = 0;

var s = new elements.Skill("Against All Odds_old");

var eqlist = [];
var offset = 0;

for (i in 0...2) {
	var e = Deck.getcard(i + offset);
	while (e == null && i + offset < Deck.getcardlist("all").length) {
		offset++;
		e = Deck.getcard(i + offset);
	}
	if (e != null) {
		eqlist.push(e.equipment);
		trace(e);
	}
}

for(e in eqlist) {
	if (e.ready) {

		for (t in e.tags) {
			var res = t.indexOf("scrapscript:");
			if (res != -1) {
				s.script = t.substr("scrapscript:".length).split("[;]").join(",").split("~").join("\"");
				s.execute(fighter,target);
			}
		}

		e.onceperbattle = true;
		e.usedthisbattle = true;
		e.animate("error");
		e.ready = false;
		e.active = false;
		result++;
	}
}

s.dispose();

Deck.advance();

return result;
//Script.rungamescript(copy.scriptbeforestartturn, "equipment_scriptbeforestartturn", self, copy);