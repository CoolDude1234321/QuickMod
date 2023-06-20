var commonlist_basic = ["Healing Crystal", "Small Shield", "Nudge", "Fixed Payout"];
var commonlist_advanced = ["Juggling Ball", "Spanner", "Spiked Shield", "Doppeldice", "Short Circuit"];
var floor2basic = ["Bumpblade", "Ray Gun"];
var floor2advanced = ["Forcefield", "Midnight Charm"];
var floor2items = ["Mechanical Arm"];
var floor3basic = ["Page Down", "Spatula"];
var floor3advanced = ["Counter Spell", "Chocolate Cookie"];
var tradeoffer = ["Heat Sink","Increment","any"];
var traderesult = ["Fixed Payout","Spatula","Juggling Ball","Headbutt"];
var vampireitem = ["Wooden Stake"];

shuffle(commonlist_basic);
shuffle(commonlist_advanced);
shuffle(floor2basic);
shuffle(floor2advanced);
shuffle(floor2items);
shuffle(floor3basic);
shuffle(floor3advanced);
shuffle(tradeoffer);
shuffle(traderesult);
shuffle(vampireitem);

usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
items = [];
gooditems = [commonlist_basic.pop()];
otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
commonlist_basic = commonlist_basic.concat(floor2basic);
shuffle(commonlist_basic);

commonlist_advanced = commonlist_advanced.concat(floor2advanced);
shuffle(commonlist_advanced);

items = [];

gooditems = [pick(floor2items)];
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([commonlist_advanced.pop(), commonlist_basic.pop(), commonlist_advanced.pop()]))
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 3:
commonlist_basic = commonlist_basic.concat(floor3basic);
shuffle(commonlist_basic);

commonlist_advanced = commonlist_advanced.concat(floor3advanced);
shuffle(commonlist_advanced);

items = [commonlist_basic.pop()];
gooditems = [];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop([commonlist_basic.pop(), commonlist_basic.pop(), commonlist_advanced.pop()]), 
  upgrade()
];

var floor3 = addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff);
if(chance(10)) { floor3.style.atmos = "atmos_secret"; } //this might actually overwrite the dungeonstyle's atmos across episodes once the player encounters it. eh. easter eggs can have a little breach of containment as a treat
floor3.generate();
  
//Floor 4:
items = [];
gooditems = [pick([commonlist_advanced.pop(), commonlist_advanced.pop()])];

otherstuff = [health(), health()];
goodotherstuff = [
  trade(tradeoffer,traderesult)
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
items = [];
gooditems = [commonlist_basic.pop()];

otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle(["health", commonlist_advanced.pop(), commonlist_advanced.pop()])), 
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