//state machine
state_functions[state]();

//fix bbox 
if(fix_bbox)
{
	fix_bbox = 0;
	sprite_index = spr_pixel;
	
	draw_set_font(font);
	var _w = string_width(text) + max_input_width;
	var _h = string_height(text);

	image_xscale = _w;
	image_yscale = _h;
	
	//x += margin;
	//y += margin;
}