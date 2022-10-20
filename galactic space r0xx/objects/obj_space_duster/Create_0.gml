/// @description Insert description here
// You can write your code in this editor

speed = 0;
direction = 0;
step_offset = 50;
create_remain = 0;
direction_add = 0;
turn_spd = 0.1;

function activate()
{
	var _hole = instance_find(obj_black_hole,0);
	direction_add = turn_spd * sign(angle_difference(point_direction(x,y, _hole.x,_hole.y),direction));
	
	while(create_remain > 0)
	{
		repeat(step_offset)
		{
			direction += direction_add;
			
			x += lengthdir_x(speed,direction);
			y += lengthdir_y(speed,direction);
		}
		
		create_dust(x,y,direction);
	}
}

function create_dust(_x,_y,_dir)
{
	//create the dust
	var _inst = instance_create_depth(_x,_y,50,obj_space_dust);
	_inst.direction = _dir;
}