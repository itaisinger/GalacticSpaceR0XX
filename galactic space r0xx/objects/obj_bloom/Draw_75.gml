//gpu_set_blendmode(bm_add)
//my_sur = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
//var _amount = 3, _res = [1920,1080];
//surface_set_target(my_sur);

//#region horizontal blur

////turn on blur effect
//shader_set(shd_gaussian_horizontal)

////uniforms
//shader_set_uniform_f(shader_get_uniform(shd_gaussian_horizontal,"blur_amount"),_amount);
//shader_set_uniform_f_array(shader_get_uniform(shd_gaussian_horizontal,"resolution"),_res);

////redraw the application surface
//draw_surface(application_surface,0,0);

//#endregion
//#region vertical blur

////turn on blur effect
//shader_set(shd_gaussian_vertical)

////uniforms
//shader_set_uniform_f(shader_get_uniform(shd_gaussian_vertical,"blur_amount"),_amount);
//shader_set_uniform_f_array(shader_get_uniform(shd_gaussian_vertical,"resolution"),_res);

////draw the application surface
//draw_surface(application_surface,0,0);

//#endregion

////reset stuff
//shader_reset();
//draw_reset();
//var _a = 0;
//surface_reset_target();
//draw_surface_ext(my_sur,0,0,1,1,0,c_white,_a);


//surface_free(my_sur);
////draw_surface(application_surface,0,0)

//gpu_set_blendmode(bm_normal);
