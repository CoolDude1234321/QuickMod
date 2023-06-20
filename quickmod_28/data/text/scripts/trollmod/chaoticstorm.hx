//A single file for controling Shifting Storm, Aurora's new equipment in Reunion
var _e = args[0];
var _self = args[1];
var _target = args[2];
var _command = args[3];
var _damage = args[4];

function getcurrentstatus(_e){
	var currentstatus = _e.getvar("currentstatus");

	//This fallback should never happen, but just in case:
	if(currentstatus == 0){
		if(_e.fulldescription.indexOf('[fire]') > -1) currentstatus = "fire";
		if(_e.fulldescription.indexOf('[ice]') > -1) currentstatus = "ice";
		if(_e.fulldescription.indexOf('[shock]') > -1) currentstatus = "shock";
		if(_e.fulldescription.indexOf('[weaken]') > -1) currentstatus = "weaken";
		if(_e.fulldescription.indexOf('[curse]') > -1) currentstatus = "curse";
		if(_e.fulldescription.indexOf('[lock]') > -1) currentstatus = "lock";
		if(_e.fulldescription.indexOf('[poison]') > -1) currentstatus = "poison";
		if(_e.fulldescription.indexOf('[blind]') > -1) currentstatus = "blind";
	}

	return currentstatus;
}

if(_command == "execute"){
	var currentstatus = getcurrentstatus(_e);
	_target.addstatus(currentstatus, 1);
	sfxdamage(_target, _damage); 
	sfx("_" + currentstatus,"",0.2);
}
if(_command == "startturn" || _command == "execute"){
	_e.sourceequipment.animate("flashandshake");
	sfx("_thinghappens");
	var laststatus = getcurrentstatus(_e);
	var randstatus = laststatus; 
	while(laststatus == randstatus){ 
		if(_self.isplayer){ 
			//Player doesn't inflict blind
			randstatus = pick(["fire","ice","shock","fire","ice","shock",pick(["weaken","poison","lock","curse"])]); 
		}else{
			if(_target.name == "Jester"){
				//Exclude Lock and Blind from Jester version!
				randstatus = pick(["fire","ice","shock","fire","ice","shock",pick(["weaken","weaken","poison","curse"])]); 
			}else{
				randstatus = pick(["fire","ice","shock","fire","ice","shock",pick(["weaken","weaken","poison","lock","curse","blind"])]); 
			}
		}
	} 
	_e.setvar("currentstatus", randstatus);

	if(randstatus == "fire"){ 
		_e.sourceequipment.changecolour("red");
		_e.sourceequipment.fulldescription = "Do [fire]" + _damage + "[comma] inflict [fire]1 burn[newline](changes each use...)[newline][gray](Reuseable)";
	}else if(randstatus == "ice"){ 
		_e.sourceequipment.changecolour("brightcyan");
		_e.sourceequipment.fulldescription = "Do [ice]" + _damage + "[comma] inflict [ice]1 freeze[newline](changes each use...)[newline][gray](Reuseable)";
	}else if(randstatus == "shock"){ 
		_e.sourceequipment.changecolour("yellow");
		_e.sourceequipment.fulldescription = "Do [shock]" + _damage + "[comma] inflict [shock]1 shock[newline](changes each use...)[newline][gray](Reuseable)";
	}else if(randstatus == "weaken"){ 
		_e.sourceequipment.changecolour("orange");
		_e.sourceequipment.fulldescription = "Do [weaken]" + _damage + "[comma] inflict [weaken]1 weaken[newline](changes each use...)[newline][gray](Reuseable)";
	}else if(randstatus == "poison"){ 
		_e.sourceequipment.changecolour("purple");
		_e.sourceequipment.fulldescription = "Do [sword]" + _damage + "[comma] inflict [poison]1 poison[newline](changes each use...)[newline][gray](Reuseable)";
	}else if(randstatus == "blind"){ 
		_e.sourceequipment.changecolour("purple");
		_e.sourceequipment.fulldescription = "Do [sword]" + _damage + "[comma] inflict [blind]1 blind[newline](changes each use...)[newline][gray](Reuseable)";
	}else if(randstatus == "curse"){ 
		_e.sourceequipment.changecolour("purple");
		_e.sourceequipment.fulldescription = "Do [sword]" + _damage + "[comma] inflict [curse]1 curse[newline](changes each use...)[newline][gray](Reuseable)";
	}else if(randstatus == "lock"){ 
		_e.sourceequipment.changecolour("purple");
		_e.sourceequipment.fulldescription = "Do [sword]" + _damage + "[comma] lock [lock]1 dice[newline](changes each use...)[newline][gray](Reuseable)";
	}
} else if(_command == "aftercombat"){
	_e.changecolour("red");
	_e.fulldescription = "Do [fire]" + _damage + "[comma] inflict [fire]1 burn[newline](changes each use...)[newline][gray](Reuseable)";
}