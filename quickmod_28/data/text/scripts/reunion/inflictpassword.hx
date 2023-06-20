//Inflict the password status to a random pieces of equipment 
var fighter = args[0];
var amount = args[1];
var targetslot = args[2];
var forcevalue = args[3];
var playsound = args[4];

var coinmode = false;
if(fighter != null){
  if(fighter.name == "Robot") coinmode = true;
}

//Pick the equipment to apply password
var prioritytarget = null;
var passwordlist = [];
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
      passwordlist.push(fighter.equipment[i]);
    }
  }
}

passwordlist = shuffle(passwordlist);

if(targetslot > -1){
  //Always target a specific slot:
  passwordlist.insert(0, prioritytarget);
}

//Actually apply the animation
var shufflevalues = [7, 8];
if(amount >= 2) {
  shufflevalues.push(6);
  shufflevalues.push(9);
}
if(amount >= 3) {
  shufflevalues.push(5);
  shufflevalues.push(10);
}
shufflevalues = shuffle(shufflevalues);

//Use a predictible range
if(targetslot > -1){
  shufflevalues = [7, 8, 6, 9, 5, 10];
}

//Require a specific value
if(forcevalue > -1){
  shufflevalues = [forcevalue, forcevalue, forcevalue, forcevalue, forcevalue, forcevalue];
}

for(i in 0 ... amount){
  if(i < passwordlist.length){
    passwordlist[i].animate("flashandshake");
    passwordlist[i].animation[passwordlist[i].animation.length - 1].addcommand("textparticle", "[password]_Password!", 16777215);
    passwordlist[i].shockedsetting = 2;
    passwordlist[i].shockedcol = 8;
    
    if(coinmode){
      var targetvalue = i;
      if(targetvalue % 3 == 0){
        passwordlist[i].shockedtext = "[95%]Place heads and tails|[95%](both coins will be returned)";
        passwordlist[i].shocked_needstotal = 3;
      }else if(targetvalue % 2 == 0){
        passwordlist[i].shockedtext = "[95%]Place two heads|[95%](both coins will be returned)";
        passwordlist[i].shocked_needstotal = 4;
      }else if(targetvalue % 2 == 1){
        passwordlist[i].shockedtext = "[95%]Place two tails|[95%](both coins will be returned)";
        passwordlist[i].shocked_needstotal = 2;
      }
    }else{
      passwordlist[i].shockedtext = "[95%]Place two dice that sum to " + shufflevalues[i % shufflevalues.length] + "|[95%](both dice will be returned)";
      passwordlist[i].shocked_needstotal = shufflevalues[i % shufflevalues.length];
    }
    passwordlist[i].shocked_returndice = true;
    //To do: figure out how to enforce the value check
		passwordlist[i].positionshockslots();
  }
}

if(amount > 0 && playsound){
  sfx("_passwordapply");
}