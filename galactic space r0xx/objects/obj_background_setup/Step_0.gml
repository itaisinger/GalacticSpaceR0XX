/// @description Insert description here
// You can write your code in this editor
if(count < 0)
{
	layer_background_destroy(layer_background_get_id(layer_get_id("background_black")))
	instance_activate_all();
	obj_background.sprite_index = bg_sprite;
	obj_background.setup_phase_over = 1;
	instance_destroy(obj_bg_star);
	instance_destroy();
}