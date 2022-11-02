/// @description Insert description here
// You can write your code in this editor
spd = 0.05;
zoom = 1;
min_zoom_dest	= 1.55;
min_zoom		= 1.55;
min_zoom_def	= 1.55;
max_zoom = 6//2.7;
zoom_mult = 1;
cam = view_get_camera(view_current);

//snap to player at start
x = obj_player.x;
y = obj_player.y;

resolution = [640,360];
base_w = 2732;
base_h = 1536;

xdest = 0;
ydest = 0;

sprite_index = spr_pixel;


//functions
function change_res(width,height)
{
	view_set_wport(view_current,width);
	view_set_hport(view_current,height);
}

surface_resize(application_surface,640,360);

//var _follow = noone;
//if(variable_global_exists("player_inst"))
//	_follow = global.player_inst;

//x = _follow.x;
//y = _follow.y;