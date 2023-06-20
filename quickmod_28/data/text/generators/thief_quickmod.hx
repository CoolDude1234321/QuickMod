//trollbreeder didn't want to make a generator so i made a generator

var commonlist_basic = ["Magic Shield", "Flip[hyphen]Flop", "Nudge"];
var commonlist_offensive = [rand(["Life Drain", "Bandage", "Healing Crystal"]), "Slime Ball", "Magic Dagger", "Fury Spell", "Magic Spear","Hex","Catastrophe"];
var commonlist_dicemanipulation = ["Illuminate", "Glass Cauldron", "Gold Cauldron", "Silver Cauldron", "Skeleton Key", "Counter Spell","Rat"];
if(chance(20)){
  commonlist_dicemanipulation.push("Crucible");
}else{
  commonlist_dicemanipulation.push(pick(commonlist_dicemanipulation));
}
var floor2items = ["Hall of Mirrors"];
var floor2shop = ["Magic Key"];

var goodshopcontents = ["Lightning Bolt", "Inferno", "Blizzard", "Shockwave"];
var floor5shop = ["Burning Light", "Ice Shard", "Sonic Wave", "Absolute Zero", "Meteor"];
var vampireitem = ["Wooden Stake"];

shuffle(commonlist_basic);
shuffle(commonlist_offensive);
shuffle(commonlist_dicemanipulation);
shuffle(floor2items);
shuffle(floor2shop);
shuffle(goodshopcontents);
shuffle(floor5shop);
shuffle(vampireitem);

usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
items = [commonlist_basic.pop()];
gooditems = [commonlist_basic.pop()];
otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
commonlist_dicemanipulation = shuffle(commonlist_dicemanipulation);
commonlist_offensive = shuffle(commonlist_offensive);
		
items = [];
		
gooditems = [floor2items.pop()];
otherstuff = [
  health(), 
  health()
];

goodotherstuff = [
  shop(shuffle([commonlist_offensive.pop(), floor2shop.pop(),  commonlist_basic.pop()]))
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  	
//Floor 3:
items = [commonlist_dicemanipulation.pop()];
gooditems = [commonlist_offensive.pop()];
		
otherstuff = [
  health(), 
  health()
];

goodotherstuff = [
  shop(shuffle([commonlist_offensive.pop(), "Health", commonlist_dicemanipulation.pop()]), [2, 3, 4]),
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
items = [];
gooditems = [rand([commonlist_dicemanipulation.pop(), commonlist_offensive.pop()])];
		
shuffle(commonlist_dicemanipulation);
shuffle(commonlist_offensive);
		
otherstuff = [
  health(),
  health(),
  health()
];

goodotherstuff = [
  shop(shuffle([goodshopcontents.pop(), goodshopcontents.pop(), "Health"]), [3, 4, 5])
];
		
addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
items = [];
gooditems = [];
otherstuff = [health(), health(), health()];
goodotherstuff = [
  shop(shuffle(
    [
      rand(floor5shop), 
      commonlist_offensive.pop(), 
      "Health"
    ])),
    upgrade()
];
		
addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 6:
items = [];
gooditems = [];
otherstuff = [];
goodotherstuff = [];

var lastfloor = addfloor("boss");

if (getfinalboss() == "Drake"){
  items.push(vampireitem.pop());
}

lastfloor
  .additems(items, gooditems)
  .setlocation('BOSS')
  .addotherstuff(otherstuff, goodotherstuff);
lastfloor.theme = pick(["music_boss_beatrice", "music_boss_buster", "music_boss_drake"]);
lastfloor.generate();