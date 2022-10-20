switch(stage)
{
	case 0:
	
	var _dis = distance_to_object(obj_player)
	
	//volume
	audio_sound_gain(idle_sfx,max(0,1 - _dis/4000),0);
	
	//stage up
	if(_dis < 30)
	{
		stage++;
		play_sfx(sfx_homing_unlock2);
		my_vfx = create_effect(spr_homing_unlock2,image_xscale,0,x,y);
		my_vfx.depth = DEPTH.effect_low;
		
		my_vfx2 = create_effect(spr_homing_unlock2,image_xscale,0,x,y);
		my_vfx2.depth = DEPTH.effect_high;
		my_vfx2.image_angle = 90;
		my_vfx2.image_alpha = 0.3;
		
		audio_stop_sound(idle_sfx);
	}
	
	break;
	
	/////
	
	case 1:
	
	image_alpha = approach(image_alpha,0,0.1);
	image_xscale = approach(image_xscale,0,0.1);
	image_yscale = approach(image_yscale,0,0.1);
	x = lerp(x,obj_player.x,0.05 + 0.011*obj_player.speed);
	y = lerp(y,obj_player.y,0.05 + 0.011*obj_player.speed);
	
	if(instance_exists(my_vfx))
	{
		my_vfx.x = x;
		my_vfx.y = y;
		my_vfx2.x = x;
		my_vfx2.y = y;
	}
	
	//stage up
	if(!instance_exists(my_vfx))
	{
		my_vfx = create_effect(spr_homing_unlock3,16,0,x,y);
		my_vfx.depth = DEPTH.effect_low;
		
		my_vfx2 = create_effect(spr_homing_unlock3,16,0,x,y);
		my_vfx2.depth = DEPTH.effect_high;
		my_vfx2.image_angle = 90;
		my_vfx2.image_alpha = 0.4;
		
		stage++;
		play_sfx(sfx_homing_unlock3);
	}
	
	break;
	
	//////

	case 2:
	
	image_alpha = approach(image_alpha,0,0.1);
	image_xscale = approach(image_xscale,0,0.1);
	image_yscale = approach(image_yscale,0,0.1);
	x = lerp(x,obj_player.x,0.05 + 0.008*obj_player.speed);
	y = lerp(y,obj_player.y,0.05 + 0.008*obj_player.speed);
	
	if(instance_exists(my_vfx) and floor(my_vfx.image_index) == 7 and !pushed)
	{
		//push meteors away
		with(obj_meteor)
		{
			var _dir = point_direction(other.x,other.y, x,y)
			var _force = 50*(max(0,5000-distance_to_object(other))/5000);
			momx += lengthdir_x(_force,_dir);
			momy += lengthdir_y(_force,_dir);
		
			fric *= 1.5;
		}
		
		pushed = 1;
	}
	
	if(instance_exists(my_vfx))
	{
		my_vfx.x = x;
		my_vfx.y = y;
		my_vfx2.x = x;
		my_vfx2.y = y;
	}
	
	if(!instance_exists(my_vfx))
	{
		//unlock homing to the player
		obj_player.unlock_homing()
		instance_destroy();
	}
}
