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

function draw_function()
{
	var _pos = [x,y];
	x -= obj_camera.x + obj_camera.get_width()/2;
	x -= obj_camera.y + obj_camera.get_height()/2;
	
	y -= yoff;
	draw_self();
	
	x = _pos[0];
	y = _pos[1];
}