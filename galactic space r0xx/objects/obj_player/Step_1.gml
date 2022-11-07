/// @description gather inputs
key_right	= keyboard_check(ord("D")) or keyboard_check(vk_right);
key_left	= keyboard_check(ord("A")) or keyboard_check(vk_left);
key_boost	= keyboard_check(ord("W")) or keyboard_check(vk_up) or keyboard_check(ord("Z"));
key_shoot	= keyboard_check(vk_space) or keyboard_check(ord("S")) or keyboard_check(vk_down);
key_shoot_pressed	= keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("S"));
key_boost_pressed	= keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("Z"));

if(!can_turn)
{
	//key_left = 0;
	//key_right = 0;
	key_boost = 0;
	key_boost_pressed = 0;
}