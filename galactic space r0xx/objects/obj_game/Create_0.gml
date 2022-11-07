show_debug_overlay(0)
game_set_speed(60,gamespeed_fps);
global.score = 0;
global.double_score = 0;
global.list_tie_fighter_destpoints = ds_list_create();
global.game_paused = 0;
global.tutorial_active = 0;	//create tutorial instance here

score_timer = 30;
game_time = [0,0,0];
alarm[0] = score_timer;

//create essential objs
var _lay = layer_get_id("main");
instance_create_layer(0,0,_lay,obj_player);
instance_create_layer(0,0,_lay,obj_camera);
//instance_create_layer(0,0,_lay,obj_shots_renderer);

if(global.do_tutorial)
{
	global.tutorial_active = 1;
	instance_create_depth(0,0,_lay,obj_tutorial)
}


//visuals
global.orange_col = make_color_rgb(242,101,34);
depth = 5;

enum DEPTH{
	//gui
	ui = 10,
	trans = 0,
	pause = -20,
	screenshot = -500,
	
	//ingame
	text = -10,
	player = -1,
	meteor = 10,
	black_hole = 15,
	rocket = 9,
	
	shot = 2,
	
	effect_low = 20,
	effect_high = -2,
	
	black_hole_top = -8,
}

//create controls text
do_text = 1;

