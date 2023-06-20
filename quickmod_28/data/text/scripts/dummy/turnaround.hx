//directly ripped from reunion transform script
var f = args[0];
var target = args[2];
var permanenttransform = args[1];
var transforminto = "Warrior";

//Don't allow more than one transform at a time
var isplayer = f.isplayer;
sfx("_recycle");
f.symbolparticle("recycle");
screenshake(0.2);

    //only works on player so far
    var targetgraph = target.graphic;
    var oldname = target.name;
    target.name = transforminto;
    //Change animation
    target.is_a_transformed_character = true;
    target.reloadanimation();
    target.is_a_transformed_character = false; 
    f.is_a_transformed_character = true;
    f.graphic = target.graphic;
    target.name = oldname;
    target.template = getcharactertemplate(oldname);
    target.is_a_transformed_character = true;
    //adding this line crashes the game lmao
    //target.reloadanimation();
    
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
    
    //Use familar backstage layouts
    if(transforminto == "Warrior"){
      newequipment = ["Rusty Sword", "Iron Shield", "Combat Roll"];
    }else if(transforminto == "Thief"){
      newequipment = ["Pocket Knife", "Hacksaw"];
    }else if(transforminto == "Robot"){
      newequipment = ["Missing Score", "Capacitor"];
    }else if(transforminto == "Inventor"){
      newequipment = ["Hammer", "Spanner", "Pea Shooter"];
    }else if(transforminto == "Witch"){
      newequipment = ["Cauldron", "Magic Missile", "Magic Missile", "Hex"];
    }else if(transforminto == "Jester"){
      newequipment = ["Juggling Ball", "Juggling Ball", "Wind up Fist"];
    }

    animateequipmentintoplace(f);
