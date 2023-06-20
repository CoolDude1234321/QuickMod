var floor1countdowns = ["Rude Staff", "Plasma Blaster"];
var floor1spanner = ["Spannersword"];
var floor1crap = ["Stack", "Law"];
var commonlist1 = ["Hi Vis Jacket", "New Moon Charm", "Elastic Heart", "Oddeven Dicemanip", "Samethrower", "Blast Chiller", "Filler Item"];
var shoplist1 = ["Shotgun", "Scalpel", "Rubber Mallet", "The Stars", "Giant Spatula", pick(["Gold Dagger", "Silver Dagger"]), "Twoey@2"];
if (chance(30)) shoplist1.push("Damocles");
var scrapitems = ["Scrap Nettle", "Tennis Dungeons Mod", "Scrap Club", "Scrap Book", "Scrap Spear", "Scrap Kettle"];
var midtierdrops = ["Befuddle", pick(["Shove", "Ham"]), "Stack"];
var floor3items = ["Robot's Lost Coin", "Slamgun", "Spannersword", "F[hyphen]Tilt", "Down with the Quickness", "Shell Game", "Prototype"];
var commonlist2 = ["Scissors", "Zipgun", "Chaotic Storm", "Puppy Paws", "Ethanol"];
commonlist2.push(rand(scrapitems));
var floor4items = ["Transformer@1", "Chainsaw"];
var floor5items = ["Wispy Kaboom Smash", "Juggling Discoball", "Rotten Egg@6"];
var vampireitem = ["Wooden Stake"];

shuffle(floor1countdowns);
shuffle(floor1spanner);
shuffle(floor1crap);
shuffle(commonlist1);
shuffle(shoplist1);
shuffle(scrapitems);
shuffle(midtierdrops);
shuffle(floor3items);
shuffle(commonlist2);
shuffle(floor4items);
shuffle(floor5items);
shuffle(vampireitem);

usestandardenemies();

var items = [];
var gooditems = [];
var otherstuff = [];
var goodotherstuff = [];

//Floor 1:
items = [pick(floor1countdowns),pick(floor1spanner)];
gooditems = [pick(floor1crap)];
otherstuff = [];
goodotherstuff = [];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 2:
items = [];
gooditems = [commonlist1.pop(), commonlist1.pop()];

otherstuff = [
  health(), 
  health()
];
goodotherstuff = [
  shop(shuffle(["upgrade", shoplist1.pop(), pick(scrapitems)]), shuffle([2, 3, 4]))
];

addfloor("small")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();

//Floor 3:
items = [pick(scrapitems)];
gooditems = [pick(floor3items)];

otherstuff = [health()];
goodotherstuff = [
  shop(shuffle([shoplist1.pop(), "upgrade", commonlist1.pop()]), shuffle([1, 2, 3]))
];
	
addfloor("big")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 4:
items = [pick(floor4items)];
gooditems = [midtierdrops.pop()];
		
otherstuff = [health(), health()];
goodotherstuff = [shop(shuffle([commonlist2.pop(), commonlist2.pop(), shoplist1.pop()]))];
		
addfloor("normal")
  .additems(items, gooditems)
  .addotherstuff(otherstuff, goodotherstuff)
  .generate();
  
//Floor 5:
items = [pick(floor5items)];
gooditems = [midtierdrops.pop()];
		
otherstuff = [health(), health()];
goodotherstuff = [
  shop(shuffle([commonlist2.pop(), "health", commonlist2.pop()])),
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