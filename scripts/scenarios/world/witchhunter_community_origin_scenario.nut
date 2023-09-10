witchhunter_community_origin_scenario <- inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create() {
		m.ID = "scenario.witchhunter_community_origin";
		m.Name = "The Witchhunter";
		m.Description = "[p=c][img]gfx/ui/events/event_wco_01.png[/img][/p][p]You are Richter von Dagentear, a legendary witchhunter feared equally by both hexen and your fellow man alike. Your world has turned upside down, and now you find yourself working as a mercenary. Do you have what it takes to survive?\n\n[color=#bcad8c]The Wight:[/color] Start with a single powerful witchhunter. The campaign ends if he dies.\n[color=#bcad8c]New to Command:[/color] Can never have more than 12 men in your roster.\n[color=#bcad8c]Reputation to Uphold:[/color] Gain various boons based on your success as a sellsword and a witchhunter.[/p]";
		m.Difficulty = 2;
		m.Order = 100;
		m.IsFixedLook = true;
	}

	function isValid() {
		return Const.DLC.Unhold;
	}

	function onSpawnAssets() {
		local roster = World.getPlayerRoster();

		for( local i = 0; i < 1; i = ++i ) {
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([ "witchhunter_background" ]);
		bros[0].setPlaceInFormation(3);
		bros[0].setName("Richter");
		bros[0].setTitle("von Dagentear");
		bros[0].getBackground().m.RawDescription = "In some ways, you are a mirror, a reflection of what others think you are. To the witch, you are a skilled hexenjager, prudent, cautious, and fatally driven. To the villager, you are the Wight, a legendary boogeyman and omen of ill fortune. But now that you've turned to mercenary work, you wonder - might you just be %name%?";
		bros[0].getBackground().buildDescription(true);

		bros[0].getFlags().set("IsPlayerCharacter", true);

		bros[0].m.PerkPoints = 2;
		bros[0].m.LevelUps = 2;
		bros[0].m.Level = 3;

		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(Const.Attributes.COUNT, 0);
		talents[Const.Attributes.Bravery] = 3;
		talents[Const.Attributes.RangedSkill] = 3;
		talents[Const.Attributes.MeleeDefense] = 1;

		bros[0].getSkills().removeByID("trait.survivor");
		bros[0].getSkills().removeByID("trait.greedy");
		bros[0].getSkills().removeByID("trait.loyal");
		bros[0].getSkills().removeByID("trait.disloyal");
		bros[0].getSkills().add(new("scripts/skills/traits/player_character_trait"));
		bros[0].getSkills().add(new("scripts/skills/injury_permanent/missing_ear_injury"));
		bros[0].getSkills().add(new("scripts/skills/effects/the_captain_effect"));
		bros[0].getSkills().add(new("scripts/skills/effects/the_wight_effect"));

		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Ammo));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Bag));

		items.equip(new("scripts/items/weapons/crossbow"));
		items.equip(new("scripts/items/ammo/quiver_of_bolts"));
		items.equip(new("scripts/items/helmets/witchhunter_hat"));
		items.equip(new("scripts/items/armor/ragged_dark_surcoat"));
		items.addToBag(new("scripts/items/weapons/arming_sword"));

		World.Assets.getStash().add(new("scripts/items/supplies/ground_grains_item"));
		World.Assets.m.Money = 0;
	}

	function onSpawnPlayer() {
		local randomVillage;
		for(local i=0; i != World.EntityManager.getSettlements().len(); ++i) {
			randomVillage = World.EntityManager.getSettlements()[i];

			if(randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 2 && !randomVillage.isSouthern())
				break;
		}

		local randomVillageTile = randomVillage.getTile();

		local navSettings = World.getNavigator().createSettings();
		navSettings.ActionPointCosts = Const.World.TerrainTypeNavCost_Flat;

		do {
			local x = Math.rand(Math.max(2, randomVillageTile.SquareCoords.X - 3), Math.min(Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 3));
			local y = Math.rand(Math.max(2, randomVillageTile.SquareCoords.Y - 3), Math.min(Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 3));

			if(!World.isValidTileSquare(x, y))
				continue;

			local tile = World.getTileSquare(x, y);

			if(tile.Type == Const.World.TerrainType.Ocean || tile.Type == Const.World.TerrainType.Shore || tile.IsOccupied)
				continue;

			if(tile.getDistanceTo(randomVillageTile) > 2)
				continue;

			local path = World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);
			
			if(!path.isEmpty())
			{
				randomVillageTile = tile;
				break;
			}			
		}
		while(1);

		World.Statistics.getFlags().set("WCOCaptainRank", 0);
		World.Statistics.getFlags().set("WCOWightRank", 0);
		World.Statistics.getFlags().set("WCOWightDecayCounter", 0);

		if (Const.DLC.Desert)
			World.Retinue.setFollower(0, World.Retinue.getFollower("follower.scavenger"));

		World.State.m.Player = World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		World.Assets.updateLook(110);
		World.getCamera().setPos(World.State.m.Player.getPos());

		Time.scheduleEvent(TimeUnit.Real, 1000, function(_tag) {
			Music.setTrackList(Const.Music.CivilianTracks, Const.Music.CrossFadeTime);
			World.Events.fire("event.witchhunter_community_origin_scenario_intro")

		}, null);
	}

	function onInit() {
		if (!(World.Statistics.getFlags().get("WitchhunterCommunityOriginEventsAdded"))) {
			local mundaneEvents = IO.enumerateFiles("scripts/events/witchhunter_community_origin_events");
			foreach ( i, event in mundaneEvents ) {
				local instantiatedEvent = new(event);
				World.Events.m.Events.push(instantiatedEvent);
			};
		}
		World.Statistics.getFlags().set("WitchhunterCommunityOriginEventsAdded", true);

		World.Assets.m.BrothersMax = 12;
		setBonuses();
	}

	function onActorKilled(_actor, _killer, _combatID) {
		if (_killer == null || (_killer.getFaction() != Const.Faction.Player && _killer.getFaction() != Const.Faction.PlayerAnimals)) {
			if (_actor.isPlayerControlled() && World.Statistics.getFlags().getAsInt("WCOCaptainRank") > 0) {
				World.Statistics.getFlags().increment("WCOCaptainRank", -1);
				setBonuses();
			}

			return;
		}

		if (_actor.getType() == Const.EntityType.Hexe) {
			World.Statistics.getFlags().increment("WCOWightRank", 2);
			setBonuses();
		}
	}

	function onContractFinished(_contractType, _cancelled)
	{
		if (_contractType == "contract.arena" || _contractType == "contract.arena_tournament")
			return;

		if (_cancelled && World.Statistics.getFlags().getAsInt("WCOCaptainRank") > 0)
			World.Statistics.getFlags().increment("WCOCaptainRank", -1);
		else if (!_cancelled)
			World.Statistics.getFlags().increment("WCOCaptainRank");

		setBonuses();
	}

	function onCombatFinished() {
		local roster = this.World.getPlayerRoster().getAll();

		foreach ( bro in roster ) {
			if (bro.getFlags().get("IsPlayerCharacter")) {
				return true;
			}
		}

		return false;
	}

	function setBonuses() {
		if (World.Statistics.getFlags().getAsInt("WCOCaptainRank") <= 0) {
			World.Assets.m.BuyPriceMult = 1.1;
			World.Assets.m.SellPriceMult = 0.9;
		}

		if (World.Statistics.getFlags().getAsInt("WCOCaptainRank") >= 1)
			World.Assets.m.ContractPaymentMult *= 1.1;

		if (World.Statistics.getFlags().getAsInt("WCOCaptainRank") >= 2)
			World.Assets.m.TryoutPriceMult *= 0.9;

		if (World.Statistics.getFlags().getAsInt("WCOCaptainRank") >= 3)
			World.Assets.m.HiringCostMult *= 0.9;
	}
});
