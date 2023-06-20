var self = args[0];
var e = args[1];

var reuseablecopy:Equipment = self.createskillcard(e.name, []);
reuseablecopy.x = e.x;
reuseablecopy.y = e.y;
reuseablecopy.reuseable = 0;
reuseablecopy.ready = true;
reuseablecopy.weakened = e.weakened;
reuseablecopy.totalusesremaining = 0;
reuseablecopy.skillcard = "witch";
reuseablecopy.skillcard_special = true;
reuseablecopy.width = (132 + 20) * 6;
reuseablecopy.height = 980 + 49 * 3;
reuseablecopy.slotpositions[0].y = 5000;
reuseablecopy.temporary_thisturnonly = true;

self.equipment.push(reuseablecopy);