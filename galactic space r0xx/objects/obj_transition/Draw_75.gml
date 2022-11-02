var _res = [display_get_gui_width(),display_get_gui_height()];
if(update_sprite)
{
	update_sprite = 0;
	trans_spr = sprite_create_from_surface(application_surface,0,0,_res[0],_res[1],0,0,_res[0]/2,_res[1]/2);
}



if(state == TRANS_STATES.active and room == room_dest)
{
	
	/*/
	create a surface at the size of the view
	draw the screenshot to the surface
	draw a circle at the keyer color at the size of the trans precent at the center
	copy the surface to a new sprite with the removeback set to the keyer
	draw the new sprite
	/*/
	
	var _col = make_color_rgb(255,0,255)
	
	var _sur1 = surface_create(_res[0],_res[1]);					//create a surface at the size of the GUI
	surface_set_target(_sur1);										
	draw_sprite_stretched(trans_spr,0,0,0,_res[0],_res[1]);			//draw the screenshot to the surface
	
	//outline
	draw_set_color(c_white);
	draw_circle(_res[0]/2,_res[1]/2,(_res[0]/2)*1.5*trans_prec+2,0)
	
	//mask
	draw_set_color(_col);
	draw_circle(_res[0]/2,_res[1]/2,(_res[0]/2)*1.5*trans_prec,0)	//draw a circle at the keyer color at the size of the trans precent at the center
	
	//point to use in the removeback
	draw_set_color(_col);
	draw_circle(0,_res[1]-1,3,0);
	
	var _spr = sprite_create_from_surface(_sur1,0,0,_res[0],_res[1],1,0,0,0);
	//sprite_save(_spr,0,working_directory + "trans2.png");			//debug
	
	//draw the new sprite
	surface_reset_target();
	draw_reset();
	draw_sprite_stretched(_spr,0,0,0,_res[0],_res[1]);
	
	surface_free(_sur1);
	sprite_delete(_spr);
}