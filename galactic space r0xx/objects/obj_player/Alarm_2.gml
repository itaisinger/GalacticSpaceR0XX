/// @description boost smoke

if(state == STATES.boost)
{
	alarm[2] = 8;
	if(random(10) < 3) alarm[2] *= 0.5;
	
	//create sfx
	var _fx = create_effect(choose(spr_boost_sustain1,spr_boost_sustain2,spr_boost_sustain3),3,direction-90);
	_fx.image_alpha = 0.8;
	
	if(boost_sprite == spr_boost_2)
	{
		var _fx = create_effect(choose(spr_boost_sustain_p1),4,direction-90);
		_fx.image_alpha = 1;
	}
}
else
	alarm[2] = -1;