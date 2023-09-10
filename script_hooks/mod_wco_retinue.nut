::mods_hookNewObject("ui/screens/world/world_campfire_screen", function(wcs) {
	local onSlotClicked = wcs.onSlotClicked;

	wcs.onSlotClicked = function( _data ) {
		if (World.Assets.getOrigin().getID() == "scenario.witchhunter_community_origin") {
			local retinueMemberAtSlot = World.Retinue.m.Slots[_data];

			if (retinueMemberAtSlot != null && (World.Retinue.m.Slots[_data].getID() == "follower.scavenger"))
				return;
		}

		onSlotClicked(_data);
	}
});
