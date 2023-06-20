//Inflict the 1 status to a random pieces of equipment 
var fighter = args[0];
var amount = args[1];
var targetslot = args[2];
var forcevalue = args[3];
var playsound = args[4];

var coinmode = false;
if(fighter != null){
  if(fighter.name == "Robot") coinmode = true;
}

//Pick the equipment to apply one
var prioritytarget = null;
var onelist = [];
for (i in 0 ... fighter.equipment.length){
  if (fighter.equipment[i].skillcard != ""){
  }else if (fighter.equipment[i].onceperbattle && fighter.equipment[i].usedthisbattle){
  }else if (!fighter.equipment[i].availablethisturn){
	}else if (fighter.equipment[i].shockedsetting >= 1){
	}else if (fighter.equipment[i].hastag("shockavoid")){
  }else if (fighter.equipment[i].currentlyreducingcountdown()){
  }else if (fighter.equipment[i].containsadicealready()){
  }else{
    if(targetslot > -1 && targetslot == (i + 1)){
      prioritytarget = fighter.equipment[i];
    }else{
      onelist.push(fighter.equipment[i]);
    }
  }
}

onelist = shuffle(onelist);

if(targetslot > -1){
  //Always target a specific slot:
  onelist.insert(0, prioritytarget);
}

//Actually apply the animation

for(i in 0 ... amount){
  if(i < onelist.length){
    onelist[i].animate("flashandshake");
    onelist[i].shockedsetting = 1;
    onelist[i].shockedcol = 8;
    
    onelist[i].shockedtext = "|1";
    onelist[i].shockedtype = "REQUIRE1";
    onelist[i].positionshockslots();
  }
}

if(amount > 0 && playsound){
  sfx("_dicefreeze");
}