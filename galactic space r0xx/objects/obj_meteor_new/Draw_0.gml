var _sur = surface_create(sprite_width,sprite_height)
surface_set_target(_sur);

draw_sprite_ext(sprite_index,0,sprite_get_xoffset(sprite_index),sprite_get_yoffset(sprite_index),
	image_xscale,image_yscale,image_angle,image_blend,image_alpha);

surface_reset_target();

draw_surface_ext(_sur,x,y,1,1,0,c_white,1);

surface_free(_sur);