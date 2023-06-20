// controller for excess status conversions
var self = args[0];
var target = args[1];

// there can only be one!!! terry cant be bothered to make it work for multiple and neither am i
var equipmentname = args[2]; 
// convert from arg3 to arg4
var fromStatus = args[3];
var toStatus = args[4];
var sound = args[5];

var e = null;
for(eq in self.equipment){
	if(eq.name == equipmentname){
		e = eq;
	}
}

trace("Attempt - Nullcheck");

if(e != null){
	trace("Attempt - Shock");
	if(e.shockedsetting == 0){
		trace("Attempt - Any fromStatus here?");
		if(target.getstatus(fromStatus) != null) {
			trace("Attempt - Excess");
			var excess = target.getstatus(fromStatus).value - target.equipment.length;
			trace(target.getstatus(fromStatus).value);
			trace(target.equipment.length);
			trace(excess);
			if (excess > 0) {
				trace("Success!");
				e.animate("flashandshake"); 
				target.removestatus(fromStatus,excess);
				trace("Removed!");
				trace(excess);
				//target.addstatus(toStatus,excess);
				if(sound != null) {
					sfx(sound,"",0.2);
				}
			}
		}
	}
}