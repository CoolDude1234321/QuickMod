//This script controls the "Cantrips" equipment from Reunion - passive equipment that automatically activates when you roll
//a certain number. The thing that makes this all work is the new status.scriptonrolldice hook on status effects - the
//rest of the actual implementation here is fairly arbitrary.
var self = args[0];
var target = args[1];

//status.scriptonrolldice hooks contain an array of the just-rolled dice in "actualdice", which is a little kludy, but it works!
var dicepool = args[2];
//The string name of the equipment that performs the cantrips action. As currently written, only one copy of a cantrips equipment can run
//per turn, which is fine for Reunion. Making this work with multiple copies is left as an exercise for the modder
var equipmentname = args[3]; 
//This is an array of values that will trigger the cantrips effect. e.g. [1] is on 1s only, [1, 3, 5] would be on any odd dice
var dicerange = args[4];

var dicevalues = [];
if(dicepool != null){
  if(dicepool.length > 0){
    for(d in dicepool){
      if(d != null){
        dicevalues.push(d.basevalue);
      }
    }
  }
}

var e = null;
for(eq in self.equipment){
  if(eq.name == equipmentname){
    e = eq;
  }
}

if(e != null){
  if(e.shockedsetting == 0){
    var delay = 0;
    if(dicevalues.length > 0 && dicerange.length > 0){
      for(i in 0 ... dicerange.length){
        for(j in 0 ... dicevalues.length){
          if(dicerange[i] == dicevalues[j]){
            //trace("cantrips triggered! You rolled a " + dicevalues[j] + ".");
            if(e.script != ""){ 
              e.doequipmentaction(self, target, 1, [], delay, false, false); //terry why did you pass null you knew you needed to pass an array. terry why
              //to do: make delay work
              delay += 0.05;
            }
          }
        }
      }
    }
  }
}
