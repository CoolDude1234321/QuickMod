var warriorshops = ["Overwedge", "Iron Shield", "Nunchuck Eyes", "Clocktower", "Target Shield", "Cawtastrophe", "Unbalanced Item", "Midnight Charm", "Disgusting Exit", "Law", "R[dash]R[dash]Freezerator", "Boomerang", "Rap", "Jam Cannon", "Tennis Dungeons Mod"];
var strangeshop = ["Spannaargh", "Larry Bash", "Sidegrade Hammer", "Juggling Discoball", "What's For Dinner?"];
var awesomelist = ["Whip", "Grammar", "Law", "Rude Staff", "Wrench@lol", "Bongo", "Butthead"];
var floor2gooditem = ["Triple Clothesline"];
var floor3item = ["Wacky Dice Manipulator", "Director's Cut", "Crystal Sword", "Filler Item", "Bad Idea"];
var floor5item = ["Larrying Dagger", "Empty Slot@large", "Prototype", "Exotic Zoo", "Unimplemented Item"];
var vampireitem = ["Wooden Stake"];

shuffle(warriorshops);
shuffle(strangeshop);
shuffle(awesomelist);
shuffle(floor2gooditem);
shuffle(floor3item);
shuffle(floor5item);
shuffle(vampireitem); //lol



usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
items = [];
gooditems = [awesomelist.pop()];
otherstuff = [];
goodotherstuff = [];

addfloor("tiny")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 2:
items = [];
gooditems = [floor2gooditem.pop()];
otherstuff = [health()];
goodotherstuff = [shop([warriorshops.pop(), warriorshops.pop(), warriorshops.pop()])];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 3:
items = [];
items.push(floor3item.pop());
gooditems = [];

otherstuff = [health(), health()];

goodotherstuff = [
  shop([warriorshops.pop(), warriorshops.pop(), warriorshops.pop()]),
  upgrade()
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
items = [];
gooditems = [awesomelist.pop()];

otherstuff = [health()];
goodotherstuff = [
  trade(["any"], [awesomelist.pop()])
];

addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
items = [];
items.push(floor5item.pop());
gooditems = [];

otherstuff = [health(), health()];
goodotherstuff = [
  upgrade(),
  shop(["upgrade", strangeshop.pop(), "health"], [4, 4, 4])
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