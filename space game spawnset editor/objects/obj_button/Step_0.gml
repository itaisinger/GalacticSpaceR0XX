//state machine
msg = "";

state_functions[state]();

//fix bbox 
if(fix_bbox_must)
{
	fix_bbox_must = 0;
	
	//create the button around the content
	if(fix_bbox)
	{
		fix_bbox = 0;
		sprite_index = spr_pixel;
	
		draw_set_font(font);
		var _w  = string_width_scribble(text)  + 2*margin;
		var _h  = string_height_scribble(text) + 2*margin;

		image_xscale = _w;
		image_yscale = _h;
	
		//x += margin;
		//y += margin;
	}
	//just spread out the bbox to the margin
	else
	{
		var _w = sprite_width  //+ 2*margin;
		var _h = sprite_height //+ 2*margin;
		
		sprite_index = spr_pixel
		
		image_xscale = _w;
		image_yscale = _h;
		
		//x += margin;
		//y += margin;
	}
}