/// pointer ///

//add
var _add = (keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))) - (keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S")));
if(!is_typing) pointer -= _add;

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
	wave_height = 10;
}

/// extra ///
//vars
var _xmid = camera_get_view_width(view_get_camera(view_current))/2;
var _ymid = camera_get_view_height(view_get_camera(view_current))/2;

//center text objs
with(obj_text)
{
	x = _xmid;
	ystart = _ymid * 1.2;
	y = _ymid * 1.2;
}

//time
ui_time += current_time - prev_time;
prev_time = current_time;
wave_height = approach(wave_height,2,1.1);


//oops
menu_load_spawnset[|0][0] = keyboard_string + ".space";