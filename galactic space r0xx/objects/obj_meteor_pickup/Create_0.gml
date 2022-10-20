/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
var _p = global.player_inst;
var _pointx = _p.x - lengthdir_x(100,_p.direction);
var _pointy = _p.y - lengthdir_y(100,_p.direction);
direction = point_direction(x,y, _pointx,_pointy);

alarm[0] = 1;

destroy_vfx_size = 3;