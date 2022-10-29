my_sur = -1;



//application_surface_enable(false);

function kawase_set()
{
	/// Dual-Kawase blur implementation by @XorDev
	/*	
		Sets the kawase surface.
		Use this to draw to the blur surface and then reset!
	*/
	
	//Make sure the surfaces exist!
	if !surface_exists(surf_ping)
	{
		surf_ping = surface_create(w_2,h_2);
	}
	if !surface_exists(surf_pong)
	{
		surf_pong = surface_create(w_2,h_2);
	}

	//Update texel variables.
	var tex = surface_get_texture(surf_ping);
	texel_w = texture_get_texel_width(tex);
	texel_h = texture_get_texel_height(tex);

	surface_set_target(surf_ping);
}
function kawase_init(width,height)
{
	///@arg width - Blur surface width
	///@arg height - Blur surface height

	/// Dual-Kawase blur implementation by @XorDev
	/*	
		Initializes blur surface dimensions and internal shader, surface variables.
	*/

	//Input dimensions.
	var _w,_h;
	_w = argument[0];
	_h = argument[1];

	w_2 = power_of_2(_w);
	h_2 = power_of_2(_h);

	texel_w = 1/w_2;
	texel_h = 1/h_2;

	w_ratio = _w/w_2;
	h_ratio = _h/h_2;

	surf_ping = -1;
	surf_pong = -1;

	uni_d_texel = shader_get_uniform(shd_kawase_downscale,"texel");
	uni_u_texel = shader_get_uniform(shd_kawase_upscale,"texel");
}
function kawase_reset()
{
	/// Dual-Kawase blur implementation by @XorDev
	/*	
		Resets the kawase surface.
		Use this after you drew to the blur surface.
	*/
	
	surface_reset_target();
}
function kawase_draw(level)
{
	///@arg level - Blur level
	///@arg [x] - Optional x-offset
	///@arg [y] - Optional y-offset

	/// Dual-Kawase blur implementation by @XorDev
	/*	
		Draws blur result at input level of detail. Each consecutive LOD is 2x the last radius.
		Currently only supports home number LODs, but perhaps I'll revisit this later.
	*/

	//Inputs
	var _lvl,_x,_y;
	_lvl = round(argument[0]);
	_x = (argument_count>1)? argument[1] : 0;
	_y = (argument_count>2)? argument[2] : 0;

	//Remember the filter setting.
	var filter;
	filter = gpu_get_tex_filter();

	gpu_set_tex_filter(1);
	gpu_set_blendenable(0);

	var lod,surf1,surf2;
	lod = 1;
	surf1 = surf_ping;
	surf2 = surf_pong;

	//Downscale for LOD.
	shader_set(shd_kawase_downscale);
	for(var i = 0; i<_lvl; i++)
	{
		lod *= 2;
		surf1 = i%2 ? surf_ping : surf_pong;
		surf2 = i%2 ? surf_pong : surf_ping;
	
		surface_resize(surf1,w_2/lod,h_2/lod);
		surface_set_target(surf1);

		shader_set_uniform_f(uni_d_texel,texel_w*lod,texel_h*lod,w_ratio,h_ratio);
		draw_surface_ext(surf2,0,0,1/2,1/2,0,-1,1);
		surface_reset_target();
	}

	//Upscale for LOD.
	shader_set(shd_kawase_upscale);
	for(var i = _lvl; i>0; i--)
	{
		lod /= 2;
		surf1 = i%2 ? surf_ping : surf_pong;
		surf2 = i%2 ? surf_pong : surf_ping;

		surface_resize(surf1,w_2/lod,h_2/lod);
		surface_set_target(surf1);
		shader_set_uniform_f(uni_u_texel,texel_w*lod,texel_h*lod,w_ratio,h_ratio);
		draw_surface_ext(surf2,0,0,2,2,0,-1,1);

		surface_reset_target();
	}
	shader_reset();

	gpu_set_blendenable(1);
	gpu_set_tex_filter(filter);

	//Draw the result
	draw_surface(surf1,_x,_y);

}
function power_of_2()
{
	///@arg val - Input value
	
	/// Dual-Kawase blur implementation by @XorDev
	/*	
		Returns the value round up to the next power of 2 number (e.g. 20 => 32).
		Read about the technique here: https://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
	*/

	var val = argument[0]-1;

	//Fill bits to the right.
	val |= val >> 1;
	val |= val >> 2;
	val |= val >> 4;
	val |= val >> 8;
	val |= val >> 16;
	return val+1;
}

//Set the blur surface size.
kawase_init(1280,720);

//Blur level variables:
level = 0;
max_level = 6;