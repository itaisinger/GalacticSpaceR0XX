//set bloom shader
//shader_set(sh_bloom)
//shader_set_uniform_f_array(uni_res,[1920,720])
//shader_set_uniform_f(uni_amount,10)

//draw all shots to the surface
with(obj_shots_parent)
{
	draw_self();
}

//shader_reset(); 