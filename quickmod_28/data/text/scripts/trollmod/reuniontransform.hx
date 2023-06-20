// stolen from reunion, lol
/*
  As an optimisation, this script isn't called by Reunion anymore - instead, it's been hardcoded.
  This speeds things up on low-end mobile devices that were having trouble. This script is left
  here are a reference for modders.
*/


//This is the general purpose "transform" script used for Reunion to activate both the enemy
//transform and player transforms. It's mostly designed to transform for one turn only, so it
//doesn't mess with level up rewards or skillcards. Functionality outside of the scope of Reunion
//(e.g. permanent transforms, being used by player characters other than Thief) is mostly
//incomplete and untested for now.
var f = args[0];
var transforminto = args[1];
var permanenttransform = args[2];
var wantupgrade = args[3];

//Don't allow more than one transform at a time
if (f.hasstatus("revert")) return;

var isplayer = f.isplayer;

var enemylist = getenemy();

//Show the transformation effect
sfx("_thinghappens");
f.symbolparticle("beartransform");
screenshake(0.2);

//Return a limit break that matches the enemy
function getenemylimitbreak(_enemy){
  if(_enemy == "Frog") return "Fury";
  if(_enemy == "Magician") return "Stardust";
  if(_enemy == "Gardener") return "Burrower";
  if(_enemy == "Robobot") return "Megabump";
  if(_enemy == "Wolf Puppy") return "Fury";
  if(_enemy == "Slime") return "Oh No!";
  if(_enemy == "Dryad") return "Poison Arrow";
  if(_enemy == "Sneezy") return "Accelerate";
  if(_enemy == "Baby Squid") return "Power Up";
  if(_enemy == "Pirate") return "Hook";
  if(_enemy == "Cactus") return "Needle";
  if(_enemy == "Fireman") return "Hellfire";
  if(_enemy == "Yeti") return "Flash Freeze";
  if(_enemy == "Snowman") return "Arctic Storm";
  if(_enemy == "Rose") return "Needle";
  if(_enemy == "Wisp") return "Heat Ray";
  if(_enemy == "Dire Wolf") return "Dramatic Pause";
  if(_enemy == "Rat King") return "Overload";
  if(_enemy == "Gargoyle") return "Reroll";
  if(_enemy == "Banshee") return "Scream";
  if(_enemy == "Singer") return "Magic Dice";
  if(_enemy == "Cowboy") return "Magic Six";
  return "Magic Dice";
}

function give(targetfighter, equipname, _permanenttransform){
  var newequipment = [];
  for (j in 0 ... equipname.length){
    var e = new elements.Equipment(equipname[j]);
    newequipment.push(e);
    var placed:Bool = false;
    if(targetfighter.equipment.length > 0){
      for (i in 0 ... targetfighter.equipment.length){
        if(!placed){
          if (targetfighter.equipment[i].skillcard != ""){
            targetfighter.equipment.insert(i, e);
            placed = true;
          }
        }
      }
    }
    if (!placed)	targetfighter.equipment.push(e);
    e.equippedby = targetfighter;
    e.ready = true;
    e.temporary_thisturnonly = !_permanenttransform;
    if (e.countdown > 0) e.remainingcountdown = e.countdown;
    e.usedthisbattle = false;
    e.charge = 0;
    e.timesused = 0;
		if(equipname[j] == "Karaoke Machine") e.timesused = 1;
  }
  
  targetfighter.getequipmentposition();
  
  var dir = 0;
  if (targetfighter.isplayer){
    dir = -1;
  }else{
    dir = 1;
  }
  
  for (newequip in newequipment){
    if (dir == 1){
      //Equipment comes from the monster
      newequip.x = newequip.finalpos.x;
      newequip.y = -newequip.height;
    }else{
      newequip.x = newequip.finalpos.x;
      newequip.y = 2165;
    }
  }
}

function fixinnates(_f){
  var innatematch = false;

  if(_f.innate.length != 0){
    if(_f.template.innate.length > 0){
      if(_f.template.innate.length == _f.innate.length){
        for(i in 0 ... _f.template.innate.length){
          if(_f.template.innate[i] != _f.innate[i]) innatematch = false;
        }
      }
    }else{
      _f.innate = [];
      _f.innateypos = -360;
      innatematch = true;
    }
  }

  //Add the new innates
  if(!innatematch){
    if(_f.template.innate.length > 0){
      for(i in 0 ... _f.template.innate.length){
        _f.addinnate(_f.template.innate[i]);
      }
    }
  }
}

if(!permanenttransform){
  f.addstatus("revert", 1);
  f.setvar("revert", f.name);
}

if(isplayer){
  if(enemylist.indexOf(transforminto) != -1){
    //Player, transforming into an enemy
    f.name = transforminto;
		
		f.template = getfightertemplate(transforminto);
		f.reloadanimation();
    f.shaketime = 0.5;
		
		Rules.inventor_inspiration = false;
		Rules.inventor_equipmentrust = 0;

    f.changelimitbreak(getenemylimitbreak(transforminto));

    //Change voice
		f.voice = f.template.voice;
    f.chatvoice = f.template.chatvoice;
    //This variable is a kludge to help Dicey Dungeons identify which voice sounds to play in certain situations
    f.is_a_transformed_character = true; 
    f.squeak();

    //Change equipment
    for (i in 0 ... f.equipment.length){
      if(permanenttransform){
        f.equipment[i].dispose();
      }else{
        f.equipment[i].ready = false;
        f.equipment[i].y = -1000;
      }
    }

    if(f.hasstolencard){
      if(permanenttransform){
        if (f.stolencard != null) f.stolencard.dispose();
        f.stolencard = null;
        f.finderskeepers = 0;
      }else{
        f.stolencard.ready = false;
        f.stolencard.y = -1000;
      }
    }

    if(permanenttransform){
      f.equipment = [];
    }
    
    var newequipment = f.template.equipment;
    if (Rules.upgradeplayerequipment || wantupgrade){
      for (i in 0 ... newequipment.length){
        if (newequipment[i].substr(newequipment[i].length - 1, 1) != "+") newequipment[i] += "+";
      }
    }

    give(f, newequipment, permanenttransform);

    animateequipmentintoplace(f);
  }else{
    //Player, transforming into another player
    f.name = transforminto;
		
	f.charactertemplate = getcharactertemplate(transforminto);
	f.reloadanimation();
	
	Rules.inventor_inspiration = false; 
	Rules.inventor_equipmentrust = 0;

    f.squeak();

    //Change equipment
    for (i in 0 ... f.equipment.length){
      if(permanenttransform){
        f.equipment[i].dispose();
      }else{
        f.equipment[i].ready = false;
        f.equipment[i].y = -1000;
      }
    }

    if(f.hasstolencard){
      if(permanenttransform){
        if (f.stolencard != null) f.stolencard.dispose();
        f.stolencard = null;
        f.finderskeepers = 0;
      }else{
        f.stolencard.ready = false;
        f.stolencard.y = -1000;
      }
    }

    if(permanenttransform){
      f.equipment = [];
    }

    var newequipment = [];

    //Use starter equipment
    if(transforminto == "Warrior"){
      newequipment = ["Sword", "Combat Roll"];
      f.changelimitbreak("Fury");
    }else if(transforminto == "Thief"){
      newequipment = ["Dagger", "Lockpick"];
      f.changelimitbreak("Unlucky Roll");
    }else if(transforminto == "Robot"){
      newequipment = ["Ray Gun", "Plasma Blaster"];
      f.changelimitbreak("Lucky Shot");
    }else if(transforminto == "Inventor"){
      newequipment = ["Hammer", "Spanner", "Pea Shooter"];
      f.changelimitbreak("Focus");
    }else if(transforminto == "Witch"){
      newequipment = ["Cauldron", "Infliction", "Burning Light", "Ice Shard", "Dice Cannon"];
      f.changelimitbreak("Crystal Ball");
    }else if(transforminto == "Jester"){
      
	  newequipment = ["Boop", "Bop", "Sweets", "Hookshot+", "Hookshot+"];
      f.changelimitbreak("Recycle");
    }
    if (Rules.upgradeplayerequipment || wantupgrade){
      for (i in 0 ... newequipment.length){
        if (newequipment[i].substr(newequipment[i].length - 1, 1) != "+") newequipment[i] += "+";
      }
    } else if (modifier == "-") {
	}
    give(f, newequipment, permanenttransform);

    //To do: skillcards
    animateequipmentintoplace(f);
  }
}else{
  if(enemylist.indexOf(transforminto) != -1){
    //Enemy, transforming into another enemy

    //Change name
    f.name = transforminto;
    f.namelength = -1;
    f.textfield[0].dispose();
    f.textfield[0] = new displayobjects.Print();

    //Change animation
    f.template = getfightertemplate(transforminto);
    f.reloadanimation();
    f.shaketime = 0.5;

    //Change voice
		f.voice = f.template.voice;
    f.chatvoice = f.template.chatvoice;
    f.squeak();

    //Change equipment
    for (i in 0 ... f.equipment.length){
      if(permanenttransform){
        f.equipment[i].dispose();
      }else{
        f.equipment[i].ready = false;
        f.equipment[i].y = -1000;
      }
    }

    if(permanenttransform){
      f.equipment = [];
    }
    
    var newequipment = f.template.equipment;
    if (Rules.upgradeenemyequipment || wantupgrade){
      for (i in 0 ... newequipment.length){
        if (newequipment[i].substr(newequipment[i].length - 1, 1) != "+") newequipment[i] += "+";
      }
    }

    give(f, newequipment, permanenttransform);

    animateequipmentintoplace(f);

    //Fix innates
    fixinnates(f);
  }else{
    //Enemy, transforming into a player

    //Change name
    f.name = transforminto;
    f.namelength = -1;
    f.textfield[0].dispose();
    f.textfield[0] = new displayobjects.Print();

    //Change animation
    f.is_a_transformed_character = true;
    f.reloadanimation();
    f.is_a_transformed_character = false; 
    f.shaketime = 0.5;

    //To do: Change voice

    //Change equipment
    for (i in 0 ... f.equipment.length){
      if(permanenttransform){
        f.equipment[i].dispose();
      }else{
        f.equipment[i].ready = false;
        f.equipment[i].y = -1000;
      }
    }

    if(permanenttransform){
      f.equipment = [];
    }
    
    var newequipment = [];
    
    //Use starter equipment
    if(transforminto == "Warrior"){
      newequipment = ["Sword", "Combat Roll"];
    }else if(transforminto == "Thief"){
      newequipment = ["Dagger", "Lockpick"];
    }else if(transforminto == "Robot"){
      newequipment = ["Ray Gun", "Plasma Blaster"];
    }else if(transforminto == "Inventor"){
      newequipment = ["Hammer", "Spanner", "Pea Shooter"];
    }else if(transforminto == "Witch"){
      newequipment = ["Cauldron", "Infliction", "Burning Light", "Ice Shard", "Dice Cannon"];
    }else if(transforminto == "Jester"){
      newequipment = ["Boop", "Bop", "Sweets", "Hookshot+", "Hookshot+"];
    }else if(transforminto == "Bear"){
	  newequipment = ["Bear Maul", "Bear Maul"];
	}
	

    give(f, newequipment, permanenttransform);

    animateequipmentintoplace(f);

    //Fix innates
    fixinnates(f);
  }
}