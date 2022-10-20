/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(_vfx != noone)
{
	_vfx.y += lengthdir_y(128*image_yscale,direction);
	_vfx.x += lengthdir_x(128*image_yscale,direction);
	_vfx.depth = depth;
}
if(_e != noone)
{
	_e.y = _vfx.y;
	_e.ystart = _vfx.y;
	draw_set_font(_e.font);
	_e.x = _vfx.x// + string_width("20")/2;
}

audio_stop_sound(bip_sfx);