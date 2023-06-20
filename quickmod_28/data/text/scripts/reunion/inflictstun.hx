//Inflict the stun status
var fighter = args[0];
var amount = args[1];

//Get an entire list of eligible equipment
var disarmlist = [];
for (i in 0 ... fighter.equipment.length){
  if (fighter.equipment[i].skillcard != ""){
  }else if (fighter.equipment[i].onceperbattle && fighter.equipment[i].usedthisbattle){
  }else if (!fighter.equipment[i].availablethisturn){
	}else if (fighter.equipment[i].shockedsetting >= 1){
	}else if (fighter.equipment[i].hastag("shockavoid")){
  }else if (fighter.equipment[i].currentlyreducingcountdown()){
  //}else if (fighter.equipment[i].containsadicealready()){
  }else{
    disarmlist.push(fighter.equipment[i]);
  }
}

disarmlist = shuffle(disarmlist);
var stunlist = [];
//Now we get equipment from that list which actually deals damage
for (i in 0 ... disarmlist.length){
  if(disarmlist[i].script.indexOf('attack(') > -1){
    stunlist.push(disarmlist[i]);
  }else if(disarmlist[i].script.indexOf('inflict(POISON') > -1){
    stunlist.push(disarmlist[i]);
  }else if(disarmlist[i].script.indexOf('inflict("toxic"') > -1){
    stunlist.push(disarmlist[i]);
  }else if(disarmlist[i].script.indexOf('drain(') > -1){
    stunlist.push(disarmlist[i]);
  }
}

var playedsound = false;
//Apply the stun!
for(i in 0 ... amount){
  if(i < stunlist.length){
    if(stunlist[i].containsadicealready()) stunlist[i].destroydice();
    stunlist[i].animate("flashandshake");
    stunlist[i].availablethisturn = false;
    stunlist[i].unavailabletext = stunlist[i].displayname;
		stunlist[i].unavailablemodifier = stunlist[i].namemodifier;
    stunlist[i].unavailabledetails = ["Unavailable (Stunned)"];
    stunlist[i].animation[stunlist[i].animation.length - 1].addcommand("textparticle", "[stun]_Stunned!", 16777215);

    if(!playedsound){
      sfx("_lock");
      playedsound = true;
    }
  }
}