/// @description sprite stacking

y += y_wave;

//loop through layers
for(var i=0; i < sprite_get_number(sprite_index); i++)
{	
	//repeat layers for pixel height
	//for(var j=0; j < height; j++)
	//{	
		//draw layer
		draw_sprite_ext(sprite_index,i,	x,y-(yoffset*i*image_yscale),
						image_xscale,height*image_yscale,image_angle,c_white,1);
	//}
}

y -= y_wave;