/// @description Insert description here
// You can write your code in this editor

if(hit)
{
	with(instance_create_depth(x,y,depth,obj_vfx))
	{
		sprite_index = spr_shot_die_green;
		image_xscale = other.image_xscale;
		image_yscale = other.image_xscale;
		image_angle	 = random(360);
	}
}