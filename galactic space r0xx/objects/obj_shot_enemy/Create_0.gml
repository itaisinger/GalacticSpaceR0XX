die_sprite = spr_shot_die;
damage = 10;
yoff = 0;
hit = 0;
active = 0; //to not hurt myself (the tie fighter)
spd = 30;
alarm[0] = 160;
alarm[1] = 10;


hp = 2;

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