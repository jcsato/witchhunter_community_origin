the_wight_effect <- inherit("scripts/skills/skill", {
	m = {
	}

	function create() {
		m.ID					= "effects.the_wight";
		m.Name					= "The Wight";
		m.Icon					= "skills/status_effect_wco_02.png";
		m.IconMini				= "status_effect_wco_02_mini";
		m.Overlay				= "status_effect_wco_02";
		m.Type					= Const.SkillType.StatusEffect;
		m.Order					= Const.SkillOrder.Trait - 9;
		m.IsActive				= false;
		m.IsRemovedAfterBattle	= false;
		m.IsStacking			= false;
	}

	function getDescription() {
		return "As a witchhunter, you are an aberration to society, never existing truly within it, merely a transient passing through. But this isolation is what gives you the perspective and focus to fight horrors beyond the ken of normal men. Do you have that focus still?";
	}

	function getTooltip() {
		local numRanks = World.Statistics.getFlags().getAsInt("WCOWightRank");
		local ret = [
			{ id = 1, type = "title", text = getName() + " (Rank " + numRanks + ")" }
			{ id = 2, type = "description", text = getDescription() }
			{ id = 11, type = "text", icon = "ui/icons/special.png", text = "Rank 0: [color=" + Const.UI.Color.NegativeValue + "]-" + 5 + "[/color] Ranged Skill" }
			{ id = 12, type = "text", icon = "ui/icons/special.png", text = "Rank 1: [color=" + Const.UI.Color.PositiveValue + "]+" + 5 + "[/color] Resolve" }
			{ id = 13, type = "text", icon = "ui/icons/special.png", text = "Rank 2: [color=" + Const.UI.Color.PositiveValue + "]+" + 5 + "[/color] Resolve, [color=" + Const.UI.Color.PositiveValue + "]+" + 5 + "[/color] Melee and Ranged Skill" }
			{ id = 14, type = "text", icon = "ui/icons/special.png", text = "Rank 3+: [color=" + Const.UI.Color.PositiveValue + "]+" + 10 + "[/color] Resolve, [color=" + Const.UI.Color.PositiveValue + "]+" + 5 + "[/color] Melee and Ranged Skill, [color=" + Const.UI.Color.PositiveValue + "]+" + 5 + "[/color] Melee and Ranged Defense" }
			{ id = 15, type = "text", icon = "ui/icons/special.png", text = "Lose 1 rank every 15 days, gain 2 every time the company slays a Hexe" }
		];

		return ret;
	}

	function onUpdate(_properties) {
		if (World.Statistics.getFlags().getAsInt("WCOWightRank") == 0)
			_properties.RangedSkill -= 5;
		else if (World.Statistics.getFlags().getAsInt("WCOWightRank") == 1)
			_properties.Bravery += 5;
		else if (World.Statistics.getFlags().getAsInt("WCOWightRank") == 2) {
			_properties.Bravery += 5;
			_properties.MeleeSkill += 5;
			_properties.RangedSkill += 5;
		} else if (World.Statistics.getFlags().getAsInt("WCOWightRank") >= 3) {
			_properties.Bravery += 10;
			_properties.MeleeSkill += 5;
			_properties.RangedSkill += 5;
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		}
	}
})
