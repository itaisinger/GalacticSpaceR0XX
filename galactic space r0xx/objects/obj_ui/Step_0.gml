if(global.game_paused) exit;

switch(state)
{
	#region natural
	case UI_STATES.natural:
	
	//transition to death state
	if(global.player_inst.state == STATES.dead)
	{
		trans_prec = 0;
		state = UI_STATES.death;
		dead = 1;
	}
	
	break;
	#endregion
	
	#region death screen
	case UI_STATES.death:
	
	//progress transition precent into death screen
	//trans_prec = lerp(trans_prec,1,0.01 + 0.02 * keyboard_check(vk_space));
	trans_prec = lerp(trans_prec,1,0.0023 + 0.02 * keyboard_check(vk_space));
	//trans_prec = approach(trans_prec,1,0.0001);
	trans_prec = approach(trans_prec,1,0.004);
	
	//quit back to main menu
	var _not_typing_score = !instance_exists(obj_upload_score) or (instance_exists(obj_upload_score) and !obj_upload_score.active)
	if(trans_prec > 0.9 and keyboard_check_pressed(vk_space) and _not_typing_score)
	{
		dead = 0;
		obj_transition.transition(rm_menu);
	}
	
	//evaluate death curve
	for(var i=0; i < 6; i++)	//was 6
	{
		var _cur = animcurve_get(cur_death_ui);
		var _channel = animcurve_get_channel(_cur,i);
		arr_curves[i] = animcurve_channel_evaluate(_channel,trans_prec);
	}
	
	break;
	#endregion
	
	#region tutorial
	case UI_STATES.tutorial:
	
	//transition out of the tutorial
	if(!global.tutorial_active)
	{
		trans_prec = lerp(trans_prec,1,0.01);
		trans_prec = approach(trans_prec,1,0.001);
		
		//finsh transition
		if(trans_prec == 1)
		{
			trans_prec = 0;
			state = UI_STATES.natural;
		}
		
		//evaluate tutorial curve
		for(var i=0; i < 2; i++)
		{
			var _cur = animcurve_get(cur_tutorial_ui);
			var _channel = animcurve_get_channel(_cur,i);
			arr_curves[i] = animcurve_channel_evaluate(_channel,trans_prec);
		}
	}
	
	break;
	#endregion
}

//decrease flashes alpha to 0 overtime
for(var i=0; i < 6; i++)
	list_flash_a[|i] = approach(list_flash_a[|i],0,0.05);



//play bars combining animation
if(bars_anim_prec != -1)
{
	bars_anim_prec = approach(bars_anim_prec,5.9,0.03*3);
	
	var _prog = bars_anim_prec;
	bars_gap = bars_gap_max*(-power(_prog,2)*0.2+1+_prog);
	
	//end
	if(bars_anim_prec == 5.9)
	{
		//create vfx and sfx
		my_effect = create_effect(spr_bars_anim,1,0,_res[0]/2,_res[1] - 18 + 20 * arr_curves[UI_ELEM.bars]);
		my_effect.image_alpha = 0;
		
		play_sfx(sfx_bars_anim_end);
		
		bars_anim_prec = -1;
		bars_gap = 0;
	}
}