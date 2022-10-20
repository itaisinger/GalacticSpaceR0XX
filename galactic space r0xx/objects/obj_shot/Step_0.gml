if(global.game_paused)
{
	speed = 0;
	exit;
}
else speed = spd;

if(my_target != noone and instance_exists(my_target))
{
	var _dir_dest = point_direction(x,y, my_target.x,my_target.y);
	var _turn_dir = sign(angle_difference(direction,_dir_dest));
	direction -= turn_spd*_turn_dir;
	
	image_angle = direction - 90;
	
	if(distance_to_object(my_target) < 20)
	{
		x += lengthdir_x(4,_dir_dest);
		y += lengthdir_y(4,_dir_dest);
	}
}