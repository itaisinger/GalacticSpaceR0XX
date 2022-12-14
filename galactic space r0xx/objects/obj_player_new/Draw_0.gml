/// @description sprite stacking
if(!iframes_alpha) exit;

var _boostr = sprite_get_number(spr_boost)-1, _boost_ys = boost_ys;
shader_set(sh_tilt);
shader_set_uniform_f(uni_angle,angle);

//loop through layers
for(var i=0; i < sprite_get_number(sprite_index); i++)
{
	var _boost = (1 or state == STATES.boost) and (i == 2 or i == 3 or i == 6 or i == 7);
	
	//repeat layers for pixel height
	for(var j=0; j < height; j++)
	{	
		//draw ship
		draw_sprite_ext(sprite_index,i,	x,y-(yoffset*i*image_yscale + j),
						image_xscale,image_yscale,image_angle,c_white,1);
		
		//draw boost
		if(_boost)
		{
			draw_sprite_ext(spr_boost,irandom(_boostr),	x,y-(yoffset*i*image_yscale + j),
							image_xscale,image_yscale*_boost_ys,image_angle,c_white,boost_a);
		}
	}
}

shader_reset();