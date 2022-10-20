for(var i=0; i<75000; i++;)
{
	with (instance_create_layer(random(room_width), random(room_height),"bg",obj_bg_star))
	{
		image_speed = random_range(0.1,0.7);
		var s = random(3);
		image_xscale = s;
		image_yscale = s;
		image_alpha = random_range(0.5,1);
	}
}