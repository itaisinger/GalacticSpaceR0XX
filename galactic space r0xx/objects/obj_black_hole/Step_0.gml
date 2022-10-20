

image_alpha		= approach(image_alpha,alpha_dest,0.05);
image_xscale	= approach(image_xscale,scale_dest,scale_spd);
image_yscale	= approach(image_yscale,scale_dest,scale_spd);

//states
state_changed = state != state_prev;
state_prev = state;

switch(state)
{
	case BSTATES.create:
	
	pull_force_mult = 0.5;
	
	with(vfx[0])
	{
		image_alpha = approach(image_alpha,1,0.005);
		image_xscale -= 0.03;	
		image_yscale -= 0.03;	
	}
	
	global.music_vol_mult = approach(global.music_vol_mult,0,0.01);
	
	break;
	
	///////////
	
	case BSTATES.natural:
	
	//over image
	
	with(vfx[1])
	{
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
		image_alpha  = other.image_alpha * 0.2;
	}
	
	pull_force_mult = 1;
	global.music_vol_mult = approach(global.music_vol_mult,1,0.04);
	
	if(state_changed)
		pull_force_mult = -150;
	
	//die
	if(hp <= 0)
	{
		//logic 
		state = BSTATES.destroy;
		
		//v/s fx
		instance_destroy(vfx[1]);
		vfx[1] = create_effect(spr_black_hole_destroy_1,15);
		vfx[1].image_alpha	= 0;
		vfx[1].depth		= DEPTH.black_hole_top-1;
		scale_dest = 0;
		play_sfx(sfx_black_hole_destroy)
	}
	
	//play shader animation
	shader_a = approach(shader_a,0,0.07);
	if(hp_prev > hp)
	{
		shader_a = 1;
		shader_val = 1- hp/hp_max;
	}
	hp_prev = hp;
	
	break;
	
	//////////
	
	case BSTATES.destroy:	//explosion build up
	
	shader_a = approach(shader_a,0,0.07);
	pull_force_mult = 2;
	
	var _finish = 0;
	
	with(vfx[1])
	{
		image_alpha		= approach(image_alpha,1,0.05);
		image_xscale	= approach(image_xscale,0,0.065);
		image_yscale	= approach(image_yscale,0,0.065);
		
		if(image_alpha == 1)
		{
			other.image_xscale = 0;
			other.image_yscale = 0;
			
			//just feels right putting it here. if there is some more nuanced state machine just push this to the next stage.
			with(obj_space_dust)
				global.dust_destroy = 1;
		}
		
		//stop playing at the end
		if(image_index == image_number)
			image_speed = 0;
		

		//pre explosion 
		if(image_xscale <= 3)
		{
			var _fx = create_effect(spr_black_hole_destroy_3,other.destroy_vfx_scale);
			_fx.spin_spd = other.destroy_vfx_spin_spd;
			_fx.depth = depth+10;
		}
		
		//trigger end of state, explode.
		if(image_xscale <= 1)
		{
			_finish = 1;
		}
	}
	
	if(_finish)
	{
		//transition to next state
		state = BSTATES.destroy2;
		
		//main explosion effect
		var _fx = create_effect(spr_black_hole_destroy_2,10);
		_fx.depth = DEPTH.effect_high-1;
			
		//make the next aprticles bigger
		destroy_vfx_scale += 2;
		
		pull_force_mult = -250;
	}
	
	break;
	
	///////////
	
	case BSTATES.destroy2:	//explosion
	
	pull_force_mult = 0;
	
	if(vfx_num[0]-- > 0)// and vfx_num[0] < 4)
	{
		var _fx = create_effect(spr_black_hole_destroy_3,destroy_vfx_scale);
		_fx.spin_spd = destroy_vfx_spin_spd;
		_fx.depth = DEPTH.effect_high-1;
	}
	else instance_destroy();
	
	break;
}