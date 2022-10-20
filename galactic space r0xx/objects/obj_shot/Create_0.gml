die_sprite = spr_shot_die;
damage = 1;
yoff = 0;
hit = 0;
speed = 40;
spd = speed;
alarm[0] = 120;

//purple
is_homing = 0;
alarm[1] = 10;
turn_spd = 5;
my_target = noone;

enum HOMING_PRIO{
	rocket,
	pickup,
	tie,
	small,
	fast,
	fast2,
	mid,
	large,
	metal,
	metal_large,
	hole
}

//if(!variable_global_exists("list_homing_prio"))
//{
//	global.list_homing_prio = ds_list_create();
//}