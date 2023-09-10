::mods_hookExactClass("retinue/retinue_manager", function(rm) {
	local onNewDay = ::mods_getMember(rm, "onNewDay");

	::mods_override(rm, "onNewDay", function() {
		onNewDay();
		if (World.Assets.getOrigin() != null && World.Assets.getOrigin().getID() == "scenario.witchhunter_community_origin") {
			World.Statistics.getFlags().increment("WCOWightDecayCounter");
			if (World.Statistics.getFlags().getAsInt("WCOWightDecayCounter") > 15) {
				World.Statistics.getFlags().set("WCOWightDecayCounter", 0);

				if (World.Statistics.getFlags().getAsInt("WCOWightRank") > 0)
					World.Statistics.getFlags().increment("WCOWightRank", -1);
			}
		}
	});
});
