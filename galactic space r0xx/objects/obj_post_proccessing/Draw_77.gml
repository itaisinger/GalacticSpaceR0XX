////draw the application surface
//surface_copy(my_sur,0,0,application_surface)
//draw_surface(my_sur,0,0);
	
////turn on additive blendmode
//gpu_set_blendmode(bm_add)

////turn on blur shader
//shader_set(sh_blur);

////redraw the application surface
//draw_surface(my_sur,0,0);

////reset stuff
//gpu_set_blendmode(bm_normal);
//shader_reset();


//Apply the kawase blur to the application surface.
kawase_set();
draw_surface(application_surface,0,0);
kawase_reset();

//Draw the result.
kawase_draw(level);


