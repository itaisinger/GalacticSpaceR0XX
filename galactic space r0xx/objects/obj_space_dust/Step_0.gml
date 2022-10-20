/// @description Insert description here
// You can write your code in this editor

image_alpha = approach(image_alpha,!destroy,0.002 * (1 + 1*destroy));
if(image_alpha == 0 and destroy)
	instance_destroy();
	
var _hole = instance_find(obj_black_hole,0);

//abort if hole is empty
if(_hole == noone)
{
	destroy = 1;
	exit;
}

if(!destroy) destroy = global.dust_destroy;

if(place_meeting(x,y, _hole))
	destroy = 5;

xdest = _hole.x;
ydest = _hole.y;

var _dirdest	= point_direction(x,y, xdest,ydest);
var _diff		= angle_difference(direction,_dirdest);

direction -= sign(_diff) * turn_spd;