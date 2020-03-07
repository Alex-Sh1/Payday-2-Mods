--Use 5/7 AP hold and reload. Reload is silent until 5/7 AP has been equipped in-game once.
--mod_overrides method useless, makes it permanently silent.

Hooks:PostHook(WeaponTweakData, "_init_new_weapons", "RafficaCZHold_post_WeaponTweakData__init_new_weapons", function(self, ...)
	self.beer.weapon_hold = "packrat"--Warning: will crash in auto-fire if PlayerStandard is not changed
	self.beer.animations = {
		reload_name_id = "lemming",
		equip_id = "equip_packrat",
		recoil_steelsight = true,
		magazine_empty = "last_recoil"
	}
	
	self.czech.weapon_hold = "packrat"--Warning: will crash in auto-fire if PlayerStandard is not changed
	self.czech.animations = {
		reload_name_id = "lemming",
		equip_id = "equip_packrat",
		recoil_steelsight = true,
		magazine_empty = "last_recoil"
	}
end)
