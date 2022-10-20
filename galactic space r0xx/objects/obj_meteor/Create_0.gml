

direction = random(360);
depth = DEPTH.meteor;

momx = 0;
momy = 0;
fric = 0.2;
reward_text_scale = 1;

//shader
hp_prev = hp;
hp_max	= hp;
uniform_hit = shader_get_uniform(sh_hit,"prec");
shader_a = 0;
shader_val = 0;


_force = 0;
no_reward = 0;
destroy_distance = obj_camera.base_w * obj_camera.max_zoom * 3;
play_sfx(create_sfx);
destroy_vfx_size = 1;



//choose image
image_index = irandom(image_number);

function update()
{
	speed = spd;
	
	image_xscale = size;
	image_yscale = size;
	
	spin = random_range(-spin_max,spin_max);
}