//Simple general use "inflict random status" script that works the same way everywhere
//Returns the status as a string in case you need to use it for attacks
var _target = args[0];
var _amount = args[1];
var adddelay = args[2]; //Add a 0.2 second delay for cases where we're also inflicting damage

var randstatus = "";

if(_target.isplayer){
  //If we're targeting the player we can consider some extra stuff
  if(_target.name == "Jester"){
    //Exclude Lock and Haunted
    randstatus = rand(["curse", "fire", "ice", "weaken", "shock", "poison", "blind"]);
  }else{
    randstatus = rand(["curse", "lock", "fire", "ice", "weaken", "shock", "poison", "blind", "haunted"]);
  }
}else{
  randstatus = rand(["curse", "lock", "fire", "ice", "weaken", "shock", "poison"]);
}

_target.addstatus(randstatus, _amount); 
if(randstatus == "haunted"){
  if(adddelay){
    sfx("_curse", "", 0.2);
  }else{
    sfx("_curse");
  }
	
  _target.symbolparticle("curse");
}else{
  if(adddelay){
    sfx("_" + randstatus.toLowerCase(), "", 0.2);
  }else{
    sfx("_" + randstatus.toLowerCase());
  }

	_target.symbolparticle(randstatus.toLowerCase());
}

return randstatus;