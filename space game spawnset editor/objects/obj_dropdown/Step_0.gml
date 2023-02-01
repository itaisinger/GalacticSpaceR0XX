

if(fix_bbox)
{
	sprite_index = spr_pixel;
	
	var _w = width;
	var _h = array_length(arr_buttons)*(height + 1*margin);
	
	image_xscale = _w;
	image_yscale = _h;
}

//done
if(return_value != "")
{
	//destroy buttons
	for(var i=0; i < array_length(arr_buttons); i++)
	{
		instance_destroy(arr_buttons[i]);
	}
	
	//run function
	my_function();
	
	//die
	instance_destroy();
}

//clicking not me
if(mouse_check_button_pressed(mb_left) and !place_meeting(x,y,obj_mouse))
{
	done("");
}