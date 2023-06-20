//oobee doo, I wanna be like you oooh oooh
var _self = args[0];
var _target = args[1];
var upgradeequipment = args[2];
function getequippedwith(f, eqlist, upgradeequipment){
  f.destroyallequipment(); 
  for(e in eqlist){
    var neweq = new elements.Equipment(e, upgradeequipment);
    f.equipment.push(neweq);
  }
}

if(_target.name == "Warrior"){
  getequippedwith(_self, ["Dragonsword", "Combat Pot"], upgradeequipment);
}else if(_target.name == "Thief"){
  getequippedwith(_self, ["Enchanted Dagger", "Enchanted Lockpick"], upgradeequipment);
}else if(_target.name == "Robot"){
  getequippedwith(_self, ["Mana Blaster", "Repeater"], upgradeequipment);
}else if(_target.name == "Inventor"){
  getequippedwith(_self, ["Dragonsword", "Enchanted Spanner", "Repeater"], upgradeequipment);
}else if(_target.name == "Witch"){
  getequippedwith(_self, ["Vegetable Stew", "Snapdragon"], upgradeequipment);
}else if(_target.name == "Jester"){
  //To do: randomise this on each turn to better mirror the Jester? i will do this if i'll decide to test quickmod but if i won't this'll remain the same unless you want to fix it yourself
  getequippedwith(_self, ["Snap", "Snaap", "Snap"], upgradeequipment);
}else{
  getequippedwith(_self, ["Magic Missile", "Magic Shield"], upgradeequipment);
}