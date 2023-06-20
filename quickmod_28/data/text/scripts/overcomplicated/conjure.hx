var _s = args[0];
var eq = args[1];
var x = args[2];
var y = args[3];
var tweenx = args[4];
var tweeny = args[5];

if (_s.hasstatus("conjureboost")) eq += "+";

var neweq = new elements.Equipment(eq);
neweq.equippedby = self;
neweq.x = x;
neweq.y = y;
neweq.animate("flashandshake");
neweq.temporary_thisturnonly = true;
_s.equipment.push(neweq);

if (args.length >= 5) {
	var act = new motion.actuators.SimpleActuator(neweq,0.5,{x: tweenx, y: tweeny});
	act.move();
}

return neweq;