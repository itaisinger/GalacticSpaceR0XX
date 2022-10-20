/// @description Insert description here
// You can write your code in this editor
if(global.game_paused)
{
	speed = 0;
	exit;
}
else speed = spd;

if(hp <= 0)
	instance_destroy();
	
if(instance_exists(obj_player) and point_distance(x,y, obj_player.x,obj_player.y) >= destroy_distance)
{
	no_reward = 1;
	destroy_sfx = sfx_empty;
	destroy_vfx = spr_empty
	instance_destroy();
}

image_angle += spin;

//attract to black hole
var _hole = instance_find(obj_black_hole,0);
if(_hole != noone)
{
	_force = 0.2*(max(0,_hole.pull_dis-distance_to_object(_hole))/_hole.pull_dis);
	_force *= _hole.pull_force_mult;
	var _dir = point_direction(x,y, _hole.x,_hole.y);
	
	//direction = approach(direction,_dir,_force*2);
	direction -= sign(angle_difference(direction,_dir))*_force*3;
	
	momx += lengthdir_x(_force*0.02,_dir);
	momy += lengthdir_y(_force*0.02,_dir);
}

x += momx;
y += momy;

momx = approach(momx,0,fric);
momy = approach(momy,0,fric);

//play shader animation
shader_a = approach(shader_a,0,0.07);
if(hp_prev > hp)
{
	shader_a = 1;
	shader_val = 1- hp/hp_max;
}
hp_prev = hp;