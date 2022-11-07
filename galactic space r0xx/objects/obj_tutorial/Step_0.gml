//update space text
var _add = instance_exists(obj_player) and obj_player.key_shoot ? 3 : 0
with(space_text) text = "[spr_keys," + string(1+_add) +"][spr_keys," + string(0+_add) + "][spr_keys," + string(2+_add) + "]";

switch(stage)
{
	case TUT_STAGES.shot:
	
	//fixate space text
	//space_text.text = "[spr_keys," + string(keyboard_check(vk_space) ? 1 : 0) +"]"
	space_text.x = display_get_gui_width()/2;
	space_text.y = display_get_gui_height() * 0.57;
	space_text.time = 10;
	
	//advance stage
	if(_add and space_counter-- < 0)
	{
		space_text.time = room_speed*3;
		stage = TUT_STAGES.meteor;
		alarm[0] = 1;
	}
	
	break;
	///////////////
	case TUT_STAGES.meteor:
	
	//spawn meteor
	if(alarm[0] == 0)
	{
		alarm[0] = room_speed*6;
		
		var _dis = instance_exists(obj_camera) ? (obj_camera.zoom * (obj_camera.base_h/2)) * 1.2 : 500;
		var _y = obj_player.y - _dis;
		
		var _meteor = instance_create_depth(obj_player.x,_y,0,obj_meteor_medium);
		_meteor.direction = 270;
		_meteor.update();
		_meteor.hp *= 5;
		_meteor.hp_max *= 5;
	}
	
	//advance stage
	if(obj_player.list_bars[|3] == obj_player.list_bar_max[|3])
	{
		with(obj_meteor) instance_destroy();
		stage = TUT_STAGES.hit;
	}

	break;
	///////////////
	case TUT_STAGES.hit:
	
	var _dis = (obj_camera.zoom * (obj_camera.base_w/2)) * 1.1;
	var _y = obj_player.y + _dis;
	
	var _meteor = instance_create_depth(obj_player.x,_y,0,obj_meteor_fast);
	_meteor.direction = 90;
	_meteor.speed *= 2;
	_meteor.spd *= 2;
	_meteor.update();
	
	stage++;
	alarm[0] = room_speed*6;
	
	break;
	///////////////
	case TUT_STAGES.levelup:

	//spawn meteor
	if(alarm[0] < 1)
	{
		alarm[0] = room_speed*5;
		
		var _dis = instance_exists(obj_camera) ? (obj_camera.zoom * (obj_camera.base_h/2)) * 1.2 : 500;
		var _y = obj_player.y - _dis;
		
		var _meteor = instance_create_depth(obj_player.x,_y,0,obj_meteor_medium);
		_meteor.direction = 270;
		_meteor.update();
		_meteor.spd *= 1.5;
		_meteor.spd *= 1.5;
	}
	
	//transition to controls stage
	if(instance_exists(obj_player) and obj_player.level == 1)
	{
		space_text.time = 0;
		stage++;
		end_tutorial();
	}
	
	break;
	///////////////
	case TUT_STAGES.controls:

	break;
	///////////////
}

