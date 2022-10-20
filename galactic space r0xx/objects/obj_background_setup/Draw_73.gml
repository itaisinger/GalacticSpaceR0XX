/// @description Insert description here
// You can write your code in this editor
if(count == count_max)
{
	bg_sprite = sprite_create_from_surface(surface, 0,0, BGW,BGH, 0,0, 0,0);
}
else
{
	sprite_add_from_surface(bg_sprite,surface, 0,0, BGW,BGH, 0,0);
}
count--;
surface_reset_target();
surface_free(surface);