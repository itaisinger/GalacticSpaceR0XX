
//gather basic inputs
key_right	= max(key_right-1,	input_buffer*(keyboard_check(ord("D")) or keyboard_check(vk_right) ));
key_left	= max(key_left-1,	input_buffer*(keyboard_check(ord("A")) or keyboard_check(vk_left)  ));
key_up		= max(key_up-1,		input_buffer*(keyboard_check(ord("W")) or keyboard_check(vk_up)    ));
key_down	= max(key_down-1,	input_buffer*(keyboard_check(ord("S")) or keyboard_check(vk_down)  ));
key_shoot_pressed	= keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_space);


//determine input_dir
switch((key_right>0) + (key_left>0) + (key_up>0) + (key_down>0))
{
	//neutral
	case 0:
		//if not pressing anything, keep input_dir the same to allow delayed boost.
	break;
	
	//straights
	case 1:
			 if(key_right)	input_dir = DIR.right;
		else if(key_up)		input_dir = DIR.up;
		else if(key_down)	input_dir = DIR.down;
		else if(key_left)	input_dir = DIR.left;
	break;
	
	//diagonals
	case 2:
			 if(key_right and key_up)	input_dir = DIR.right_up;
		else if(key_right and key_down)	input_dir = DIR.right_down;
		else if(key_left and key_up)	input_dir = DIR.left_up;
		else if(key_left and key_down)	input_dir = DIR.left_down;
	break;
}

//determine angle_dest
angle_dest = input_dir*45;