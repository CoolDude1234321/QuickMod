var self = args[0];

self.changetodecklayout([]);

var skillcard = self.createskillcard("Jester Deck", []);
      skillcard.temporary_thisturnonly = true;
      self.equipment.push(skillcard);

animateequipmentintoplace(self);
