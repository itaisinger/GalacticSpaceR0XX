/// @description sprite stacking
if(!iframes_alpha or state == STATES.dead) exit;

//create a surface for myself
var _sur = surface_create(sprite_width*2,sprite_width*2);
surface_set_target(_sur);

#region sprite stacking

var _boostr = sprite_get_number(spr_boost)-1, _boost_ys = boost_ys;
shader_set(sh_tilt);
shader_set_uniform_f(uni_angle,angle);

//loop through layers
for(var i=0; i < image_number; i++)
{
	var _boost = (1 or state == STATES.boost) and (i == 2 or i == 3 or i == 6 or i == 7) or (boost_lvlup_a > 0);
	
	//repeat layers for pixel height
	for(var j=0; j < height; j++)
	{	
		//draw ship
		draw_sprite_ext(sprite_index,i,	sprite_width,sprite_width-(yoffset*i*image_yscale + j),
						image_xscale,image_yscale,image_angle,c_white,1);
		
		//draw boost
		if(_boost)
		{
			draw_sprite_ext(boost_sprite,irandom(_boostr),sprite_width,sprite_width-(yoffset*i*image_yscale + j),
							image_xscale,image_yscale*_boost_ys,image_angle,c_white,max(boost_lvlup_a,boost_a));
		}
	}
}

shader_reset();

#endregion

surface_reset_target();

//flash shader
shader_set(sh_hit) //its a flash shader
shader_set_uniform_f(shader_get_uniform(sh_hit,"prec"),flash_a);

draw_surface(_sur,x-sprite_width,y-sprite_width);

shader_reset();