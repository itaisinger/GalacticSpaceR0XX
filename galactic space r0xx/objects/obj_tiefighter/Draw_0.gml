

/// draw ray
if(state == TSTATES.aim)
{
	draw_set_color(ray_col);
	draw_set_alpha(ray_a);
	
	draw_line(x,y-20, rayx,rayy);
	
	draw_reset();
}


/// draw self with sprite stacking
image_angle = direction - 90;

//loop through layers
for(var i=0; i < image_number; i++)
{	
	//repeat layers for pixel height
	for(var j=0; j < height; j++)
	{	
		//draw layer
		draw_sprite_ext(sprite_index,i,	x,y-(yoffset*i*image_yscale),
						image_xscale,height*image_yscale,image_angle,c_white,1);
		draw_sprite_ext(sprite_index,i,	x,y-(yoffset*i*image_yscale),
						-image_xscale,height*image_yscale,image_angle,c_white,1);
	}
}

image_angle = 0;

draw_set_font(font_ingame);
//draw_text(x,y-100,direction-angle_prev);


//draw_set_color(c_green)
//draw_ellipse(bbox_left,bbox_top,bbox_right,bbox_bottom,1)