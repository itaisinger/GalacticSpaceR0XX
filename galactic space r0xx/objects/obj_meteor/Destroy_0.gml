/// @description play sfx and vfx
if(no_reward or obj_player.state == STATES.dead)
{
	//maybe play a ouch sfx
	//dont give rewards
	_e = noone;
}
else
{
	if(global.double_score)
	{
		_e = create_text(x,y,string(reward) + "x2",global.orange_col,merge_color(global.orange_col,c_black,0.6),2);//
		_e.font = font_ingame;
		_e.time *= 1;
		_e.size = max(1,reward_text_scale*(image_xscale/3));
	
		global.score += reward*2;
		global.player_inst.progress(reward*2);
	}
	else
	{
		_e = create_text(x,y,reward,color,merge_color(color,c_black,0.6),2);//
		_e.font = font_ingame;
		_e.time *= 1;
		_e.size = max(1,image_xscale/4);
	
		global.score += reward;
		global.player_inst.progress(reward);
	}
}

play_sfx(destroy_sfx);
_vfx = create_effect(destroy_vfx);
_vfx.image_angle = random(360);
_vfx.image_xscale = image_xscale*destroy_vfx_size;
_vfx.image_yscale = image_yscale*destroy_vfx_size;