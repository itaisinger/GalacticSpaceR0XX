/// @description home 
if(is_homing)
{
	var _spr_prev = sprite_index;
	sprite_index = spr_shot_cone;
	var _insts = ds_list_create();
	instance_place_list(x,y,obj_meteor,_insts,0);
	sprite_index = _spr_prev;

	if(ds_list_size(_insts))
		my_target = _insts[|0];
	else
		my_target = noone;
}

//attract to unlock
if(instance_exists(obj_homing_unlock))
{
	var _spr_prev = sprite_index;
	sprite_index = spr_shot_cone;
	my_target = instance_place(x,y,obj_homing_unlock);
	sprite_index = _spr_prev;
}

alarm[1] = 10;