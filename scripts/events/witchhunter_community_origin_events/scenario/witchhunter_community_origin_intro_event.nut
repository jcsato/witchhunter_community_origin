witchhunter_community_origin_intro_event <- inherit("scripts/events/event", {
	m = { },

	function create() {
		m.ID = "event.witchhunter_community_origin_scenario_intro";
		m.IsSpecial = true;
		m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_wco_01.png[/img]{You scan the contents of the letter, glossing over the beautiful letters that only Fuchs would give such care to. He tries to dissuade you, in his way, as if one missing ear wasn't enough to remind you of the hazards of mercenary work. You put aside the letter and open the parcel that came with it. The familiar clink of coin and - what's this - potion bottles greets you. You set the package aside as Hobbs walks in.%SPEECH_ON%Well, Richter? What's it say? What'd you get?%SPEECH_OFF%You ruffle the boy's hair and he squirms away in protest.%SPEECH_ON%Nothing you need to worry about. Have you got your things? We're leaving.%SPEECH_OFF%You scoop up the parcel and burn the letter. You're not sure if Fuchs sent it to you with the hopes you'd leave witchhunting, sellswording, or both behind - but you won't be so easily turned aside. You don your hat and step out the door, facing down the world as a mercenary, as a hexenjager, as Richter von Dagentear.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's get to it.",
					function getResult( _event ) { return 0; }
				}
			],
			function start( _event ) {
				Banner = "ui/banners/" + World.Assets.getBanner() + "s.png";

				local item = new("scripts/items/accessory/antidote_item");
				List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + item.getName() });
				World.Assets.getStash().add(item);

				item = new("scripts/items/accessory/cat_potion_item");
				List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + item.getName() });
				World.Assets.getStash().add(item);

				item = new("scripts/items/accessory/lionheart_potion_item");
				List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + item.getName() });
				World.Assets.getStash().add(item);

				local money = 700 + (2 - World.Assets.getEconomicDifficulty()) * 300;
				World.Assets.addMoney(money);
				List.push({ id = 10, icon = "ui/icons/asset_money.png", text = "You gain [color=" + Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns" });
			}
		});

	}

	function onUpdateScore() {
		return;
	}

	function onPrepare() {
		m.Title = "The Witchhunter";
	}

	function onPrepareVariables( _vars ) { }

	function onClear() { }
});
