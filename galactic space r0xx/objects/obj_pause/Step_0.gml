/// pointer ///

//add
var _add = (keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))) - (keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S")));
pointer -= _add;

//loop
var _max = ds_list_size(menu_current);
if(pointer >= _max)	pointer = 0;
if(pointer < 0)		pointer = _max-1;

//pointer sfx
if(_add != 0)
	play_sfx(sfx_menu_pointer);

/// choose ///
if(keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("Z")))
{
	//execute
	menu_current[|pointer][1]();
	
	//sfx
	play_sfx(arr_sfx[sfx_i++])
	if(sfx_i >= array_length(arr_sfx))
		sfx_i = 0;
	
	//push
	ui_time = 0;
	wave_height = 15;
}

/// extra ///

//vars
var _xmid = display_get_gui_width()/2;
var _ymid = display_get_gui_height()/2;

//center text objs
with(my_text)
{
	x = _xmid;
	ystart = _ymid * 0.7;
	y = _ymid * 0.7;
	depth = other.depth-1;
}

//time
ui_time += current_time - prev_time;
prev_time = current_time;
wave_height = approach(wave_height,2,1.1);