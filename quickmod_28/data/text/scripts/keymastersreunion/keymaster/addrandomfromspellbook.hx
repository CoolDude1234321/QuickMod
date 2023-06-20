var self = args[0];
var a = args[1];

var equipment = self.getvar("equipment");
var modifiers = self.getvar("modifiers");
var tags = self.getvar("tags");
var checkable = [];

var result = [];

for (i in 0...6) {
	if (equipment[i] != "empty" && tags[i].indexOf("keyignore") == -1 ) {
		checkable.push(equipment[i] + modifiers[i]);
	}
}

for (i in 0...a) {

	result.push(rand(checkable));

}

runscript("keymastersreunion/keymaster/addequipment",[self,result]);
