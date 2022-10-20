/// @description Insert description here
// You can write your code in this editor

if(hit)
{
	with(instance_create_depth(x,y,depth,obj_vfx))
	{
		sprite_index = other.die_sprite;
		image_xscale = other.image_xscale;
		image_yscale = other.image_xscale;
		image_angle	 = random(360);
		y -= other.yoff;
	}
}