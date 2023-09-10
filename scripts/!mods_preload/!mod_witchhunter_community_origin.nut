::mods_registerMod("witchhunter_community_origin", 0.2, "Witchhunter Community Origin");

::mods_queue("witchhunter_community_origin", null, function() {
	::include("script_hooks/mod_wco_retinue");
});
