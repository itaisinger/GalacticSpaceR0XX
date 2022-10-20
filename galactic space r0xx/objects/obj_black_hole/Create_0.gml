
event_inherited();

//visuals
image_xscale = 0;
image_yscale = 0;
scale_dest	= 0;
alpha_dest	= 0;
scale_spd	= 0.2;
image_angle -= 30;			//turn sideways to align with the mask
depth = DEPTH.black_hole;
reward_text_scale = 100;

//logic
global.dust_destroy = 0;
alarm[0] = 1;				//spawn dust 
alarm[1] = room_speed*7.85;	//finish entrance
state = 0;
state_prev = state;
state_changed = 0;
enum BSTATES{
	create,
	natural,
	destroy,
	destroy2,
}

//gameplay
pull_dis = 4000;
pull_force_mult = 1;

//shader
hp_prev = hp;
hp_max	= hp;
uniform_hit = shader_get_uniform(sh_hit,"prec");
shader_a = 0;
shader_val = 0;

//destroy
vfx_num = [60,4];
destroy_vfx_scale = 7;
destroy_vfx_spin_spd = 2;

/// create dusts
//creates a few rounds of dusts and speeds them into their cycle to make it seems as they were created b4.
max_space_dust_dis = 7000;
space_dust_num = 8;
var _rounds_num = 22;
var _rounds_diff = 100;		//how many steps are between each round.
for(var i=0; i < _rounds_num; i++)
{
	for(var j=0; j < space_dust_num; j++)
	{
		//create the dust
		var _dir = (360/space_dust_num)*j;
		var _x = x + lengthdir_x(max_space_dust_dis,_dir);
		var _y = y + lengthdir_y(max_space_dust_dis,_dir);
	
		var _inst = instance_create_depth(_x,_y,50,obj_space_dust);
		_inst.direction = _dir + 90;
	
		//speed up!
		var _steps = i * _rounds_diff;
		show_debug_message(_steps)
		//_inst.image_blend = c_red;
		//_inst.image_alpha = 1;
		//_inst.direction += _steps * _inst.turn_spd;
		with(_inst)
		{
			var _turn = turn_spd*sign(angle_difference(point_direction(x,y, other.x,other.y),direction));
			for(var k=0; k < _steps; k++)
			{
				x += lengthdir_x(speed,direction);
				y += lengthdir_y(speed,direction);
				direction += _turn;
			}
		}
	}
}


///vfxs

//orbs
vfx[0] = create_effect(spr_black_hole_c,14,0,x,y)
vfx[0].loop = 1;
vfx[0].image_alpha = 0;
vfx[0].image_speed *= -1;


image_alpha = 0;

play_sfx(sfx_black_hole_create);