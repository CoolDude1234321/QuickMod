// Transformation and hook injection script for equipment that transforms back into its old form
var _e = args[0]; // This equipment (eq type)
var _eTarget = args[1]; // Name of the target equipment (string type)
var _modifier = args[2]; // Equipment is upgraded or downgraded? (done like deck of wonder's script) (aka hardcoded)
var _use = args[3]; // Ends after use?
var _turn = args[4]; // Ends after turn?
var _battle = args[5]; // Ends after battle? (Can't get transformed cards back if false and other conds not used! Know what you're doing please!)

// Create a new card and affect its upgrade/downgrade status
var newCard = new elements.Equipment(_eTarget, _modifier == "+");
var down = "";
if (_modifier == "-") {
  newCard.downgrade();
  down = "original.downgrade();";
};
// Create the script hook to inject into the target
// This is more modular than just hardcoding the hook, and lets me use the cards individually
var scriptHook = "var original = new elements.Equipment(\""+_e.name+"\","+(_modifier == "+")+");"+down+"e.ready = false;e.show = false; _internalexchangeequipment(self,e,original,-1);";
// Inject into script on use and script after combat
if (_use == true) {
	newCard.script = newCard.script + scriptHook + "sfx(\"_thinghappens\");";
}
if (_turn == true) {
	newCard.scriptendturn = newCard.scriptendturn + scriptHook;
}
if (_battle == true) {
	newCard.scriptaftercombat = newCard.scriptaftercombat + scriptHook;
}
// Add tags to prevent extra weakens from deleting the injection
newCard.tags = newCard.tags.concat(["weakenavoid", "weakenimmune"]);
// Exchange pls
_e.ready = false;
_e.show = false;
_internalexchangeequipment(self,_e,newCard,-1);
sfx("_thinghappens");