/// @description Insert description here
// You can write your code in this editor
surface = -1;
count_max = 1;		//number of bacground frames to record
count = count_max;	//number of bacground frames to record left
bg_sprite = -1;

instance_deactivate_layer(layer_get_id("main"))

#macro BGW 2500
#macro BGH 2500

for(var i=0; i<7500; i++;)
{
	with (instance_create_layer(random(room_width), random(room_height),"bg",obj_bg_star))
	{
		image_speed = random_range(0.1,0.7);
		var s = random_range(1,4);
		image_xscale = s;
		image_yscale = s;
		image_alpha = random_range(0.8,1.2);
	}
}