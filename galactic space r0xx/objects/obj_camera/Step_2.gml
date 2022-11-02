/// @description Insert description here
// You can write your code in this editor
if(global.game_paused) exit;

var _follow = noone;
if(variable_global_exists("player_inst"))
	_follow = global.player_inst;

if(_follow != noone)
{
	xdest = _follow.x;// + lengthdir_x(100,_follow.direction);
	ydest = _follow.y;// + lengthdir_y(100,_follow.direction);
}

//lerp to black hole
var _hole = instance_find(obj_black_hole,0);
_rate = 1;

if(_hole != noone)
{
	min_zoom_dest = min_zoom_def + 0.4;
	var _dis = point_distance(_hole.x,_hole.y, xdest,ydest);
	if(_dis < _hole.pull_dis)
	{
		_rate = _dis/_hole.pull_dis;
		_rate = clamp(_rate,0.2,1);
	
		xdest = lerp(xdest,_hole.x,_rate/5);
		ydest = lerp(ydest,_hole.y,_rate/5);
	}
}
else
{
	min_zoom_dest = min_zoom_def;
}

//move
x = lerp(x,xdest,spd);
y = lerp(y,ydest,spd);

var _hw = camera_get_view_width(cam)/2;
var _hh = camera_get_view_height(cam)/2;

//zoom is x2 when the player is at the edge of the screen
zoom_dest = (distance_to_object(_follow) / base_w) + min_zoom;

#region zoom out on special enemies

//tie fighters
with(obj_tiefighter)
{
	if(active)
		other.min_zoom_dest += 0.15;
}


//black hole
if(_hole != noone and _dis < _hole.pull_dis)
	zoom_mult = approach(zoom_mult,_rate*1.4,0.02);
else
	zoom_mult = approach(zoom_mult,1,0.02);


	
#endregion
	

min_zoom = approach(min_zoom,min_zoom_dest,0.005);

zoom_dest *= zoom_mult;

zoom = lerp(zoom,zoom_dest,0.05);
zoom = clamp(zoom,min_zoom,max_zoom);

//apply size and position to the camera
camera_set_view_pos(cam,x-_hw,y-_hh);
camera_set_view_size(cam,base_w*zoom,base_h*zoom);

image_xscale = base_w*zoom;
image_yscale = base_h*zoom;

