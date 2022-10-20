/// @description sprite stacking

//loop through layers
for(var i=0; i < sprite_get_number(sprite_index); i++)
{
	//repeat layers for pixel height
	for(var j=0; j < height; j++)
	{	
		//draw ship
		draw_sprite_ext(sprite_index,i,	x,y-(yoffset*i*image_yscale + j),
						image_xscale,image_yscale,image_angle,c_white,1);
	}
}

shader_reset();