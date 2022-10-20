if(obj_ui.dead) exit;

//unpause
if(instance_exists(obj_pause))
{
	instance_destroy(obj_pause);
	obj_player.speed = spd_prev;
	alarm[0] = alarm_prev;
	
	//resume vfxs
	var _vfx_num = instance_number(obj_vfx);
	for(var i=0; i < _vfx_num; i++)
	{
		with(instance_find(obj_vfx,i))
		{
			image_speed = image_speed_prev;
		}
	}
}
//pause
else
{
	alarm_prev = alarm[0];
	alarm[0] = -1;
	spd_prev = obj_player.speed;
	obj_player.speed = 0;
	instance_create_depth(0,0,0,obj_pause);
	
	//stop vfxs
	var _vfx_num = instance_number(obj_vfx);
	for(var i=0; i < _vfx_num; i++)
	{
		with(instance_find(obj_vfx,i))
		{
			image_speed_prev = image_speed;
			image_speed = 0;
		}
	}
	
	//stop shooting sound
	audio_stop_sound(obj_player.shoot_sfx);
}