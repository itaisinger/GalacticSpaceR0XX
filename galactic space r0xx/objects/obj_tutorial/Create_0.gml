space_counter = 30;
stage = 0;
enum TUT_STAGES{
	shot,		//wait for the player to press space
	meteor,		//spawn a meteor infront of the player
	hit,		//hit the player from behind
	levelup,	//spawn meteors infront until player levels up
	controls,
}

//setup
with(obj_player) setup_tutorial();

//functions
function end_tutorial()
{
	global.tutorial_active = 0;
	obj_game.alarm[0] = 1;
	
	var _x = display_get_gui_width()/2;
	var _y = 70;
	with(instance_create_depth(_x,_y,0,obj_text_fade))
	{
		is_gui = 1;
		text = "turn with [spr_keys_turn,0]/[spr_keys_turn,1] or [spr_keys_turn,2]/[spr_keys_turn,3]"+
				"\nboost with [spr_keys_turn,4] or [spr_keys_turn,5]";
		time = room_speed*9;
		image_alpha = 0;
		o_width = 0;
		font = font_continue;
		halign = fa_center;
		other.controls_text = self;
	}
	
	instance_destroy();
}

//how to shoot text
var _x = display_get_gui_width()/2;
var _y = display_get_gui_height() * 0.6;
with(instance_create_depth(_x,_y,0,obj_text_fade))
{
	is_gui = 1;
	text = "shoot [spr_keys,0]"
	time = room_speed*7;
	o_width = 0;
	font = font_continue
	halign = fa_center;
	valign = fa_top;
	other.space_text = self;
}