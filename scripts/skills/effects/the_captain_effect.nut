the_captain_effect <- inherit("scripts/skills/skill", {
	m = {
	}

	function create() {
		m.ID					= "effects.the_captain";
		m.Name					= "The Captain";
		m.Icon					= "skills/status_effect_wco_01.png";
		m.IconMini				= "status_effect_wco_01_mini";
		m.Overlay				= "status_effect_wco_01";
		m.Type					= Const.SkillType.StatusEffect;
		m.Order					= Const.SkillOrder.Trait - 10;
		m.IsActive				= false;
		m.IsRemovedAfterBattle	= false;
		m.IsStacking			= false;
	}

	function getDescription() {
		return "As the captain, you represent the company to both itself and to the outside world. A skilled leader can command the respect of even the greatest skeptic, while a poor one crumples under the weight of command. Are you up to the task?";
	}

	function getTooltip() {
		local numRanks = World.Statistics.getFlags().getAsInt("WCOCaptainRank");
		local ret = [
			{ id = 1, type = "title", text = getName() + " (Rank " + numRanks + ")" }
			{ id = 2, type = "description", text = getDescription() }
			{ id = 11, type = "text", icon = "ui/icons/special.png", text = "Rank 0: [color=" + Const.UI.Color.NegativeValue + "]-" + 10 + "%[/color] worse prices for buying and selling, [color=" + Const.UI.Color.NegativeValue + "]-" + 10 + "[/color] Resolve" }
			{ id = 12, type = "text", icon = "ui/icons/special.png", text = "Rank 1: Contracts pay out [color=" + Const.UI.Color.PositiveValue + "]+" + 10 + "%[/color] more" }
			{ id = 13, type = "text", icon = "ui/icons/special.png", text = "Rank 2: Contracts pay out [color=" + Const.UI.Color.PositiveValue + "]+" + 10 + "%[/color] more, tryouts are [color=" + Const.UI.Color.PositiveValue + "]+" + 10 + "%[/color] cheaper" }
			{ id = 14, type = "text", icon = "ui/icons/special.png", text = "Rank 3+: Contracts pay out [color=" + Const.UI.Color.PositiveValue + "]+" + 10 + "%[/color] more, tryouts and recruits are [color=" + Const.UI.Color.PositiveValue + "]+" + 10 + "%[/color] cheaper" }
			{ id = 15, type = "text", icon = "ui/icons/special.png", text = "Lose 1 rank every time you lose a man or fail a contract, gain 1 every time you succeed a contract" }
		];

		return ret;
	}

	function onUpdate(_properties) {
		if (World.Statistics.getFlags().getAsInt("WCOCaptainRank") == 0)
			_properties.Bravery -= 10;
	}
})
