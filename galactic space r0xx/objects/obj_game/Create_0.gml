/// @description Insert description here
// You can write your code in this editor
show_debug_overlay(0)
game_set_speed(60,gamespeed_fps);
global.score = 0;
global.double_score = 0;
global.list_tie_fighter_destpoints = ds_list_create();
global.game_paused = 0;


score_timer = 30;
game_time = [0,0,0];
alarm[0] = score_timer;

meteors_hp		= [5,	15,	5,	30,	80];
meteors_spin	= [15,	5,	15,	2,	1];
meteors_spd		= [7,	6,	4,	11,	2];
meteors_size	= [1,	3,	1,	6,	16];

//visuals
global.orange_col = make_color_rgb(242,101,34);

enum DEPTH{
	//gui
	ui = 10,
	trans = 0,
	pause = -20,
	screenshot = -500,
	
	//ingame
	text = -10,
	player = 0,
	meteor = 10,
	black_hole = 15,
	rocket = 9,
	
	effect_low = 20,
	effect_high = -2,
	
	black_hole_top = -8,
}

//create controls text
do_text = 1;
