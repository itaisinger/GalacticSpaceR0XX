/*/
menu opetions are 2 element arays, text and a function.
menu_current is the current list of menu options. 
to switch page, call change_menu(menu_page).

/*/
randomise();

if(!variable_global_exists("spawnset_path"))
	global.spawnset_path = DEFAULT_SPAWNSET;

global.game_paused = 0;
global.high_score = 0;
global.music_volume = 0.5;
global.sfx_volume = 0.5;

//file and saving system
global.map_file = ds_map_create();
ds_map_add(global.map_file,"music",	0.5);
ds_map_add(global.map_file,"sfx",	0.5);
ds_map_add(global.map_file,"score",	0);

#macro FILE_NAME working_directory+"homework.space"

//load prexisting file
if(file_exists(FILE_NAME))
	load_gamefile();
else
	save_gamefile();

#region functions

//functions
function change_menu(menu_page)
{
	menu_current = menu_page;
	pointer = 0;
}
function music_vol_up()
{
	global.music_volume = min(1,global.music_volume + 0.1)
	instance_destroy(obj_text);
	var _e = create_text(0,0,"music volume: " + string(global.music_volume),c_white,c_white,0);
	_e.font = font_small;
	_e.yoff = 0;
}
function music_vol_down()
{
	global.music_volume = max(0,global.music_volume - 0.1)
	instance_destroy(obj_text);
	var _e = create_text(0,0,"music volume: " + string(global.music_volume),c_white,c_white,0);
	_e.font = font_small;
	_e.yoff = 0;
}
function sfx_vol_down()
{
	global.sfx_volume = max(0,global.sfx_volume - 0.1)
	instance_destroy(obj_text);
	var _e = create_text(0,0,"sfx volume: " + string(global.sfx_volume),c_white,c_white,0);
	_e.font = font_small;
	_e.yoff = 0;
}
function sfx_vol_up()
{
	global.sfx_volume = min(1,global.sfx_volume + 0.1)
	instance_destroy(obj_text);
	var _e = create_text(0,0,"sfx volume: " + string(global.sfx_volume),c_white,c_white,0);
	_e.font = font_small;
	_e.yoff = 0;
}
function load_spawnset()
{
	///
	var _path = get_open_filename("spawnset|*.spnst",""); //working_directory + keyboard_string + ".space";
	var _string = "no file loaded";	//default
	if(_path != "")
	{
		global.spawnset_path = _path;
		var _string = "spawnset file loaded";
	}

	instance_destroy(obj_text)
	var _e = create_text(0,0,_string,c_white,c_white,0);
	_e.font = font_small;
	_e.yoff = 0;
}
function reset_spawnset()
{
	global.spawnset_path = DEFAULT_SPAWNSET;
	
	instance_destroy(obj_text)
	var _e = create_text(0,0,"spawnset file reset to default",c_white,c_white,0);
	_e.font = font_small;
	_e.yoff = 0;
}
function reset_highscore()
{
	instance_destroy(obj_text);
	var _e = create_text(0,0,"local highscore file reset",c_white,c_white,0);
	_e.font = font_small;
	_e.yoff = 0;
	
	global.high_score = 0;
	save_gamefile();
}
function update_boards()
{
	
}

function wave_ui(argument0, argument1, argument2, argument3)
{
	///@desc Wave(from, to, duration, offset)
	///@arg0from
	///@arg1to
	///@arg2duration
	///@arg3offset
	a4 = (argument1 - argument0) * 0.5;
	return argument0 + a4 + sin((((ui_time * 0.001) + argument2 * argument3) / argument2) * (pi*2)) * a4;
}
function draw_leaderboard(_x,_y,margin,top_text,ranks,names,scores)
{
	var _length = array_length(ranks);
	var _text = "";
	var _width = string_width("1.GGGGGGGGGG");
	
	draw_text(_x,_y,top_text);
	_y += string_height("hi") + margin;
	
	for(var i=0; i < _length and i < 10 and ranks[i] != " "; i++)
	{
		_text = ranks[i] + ". ";				//rank
		
		//name
		if(string_width(names[i] + ". ") < _width)
			_text += names[i];
		else
		{
			for(var j=0; j < string_length(names[i]) and string_width(_text) < _width; j++)
				_text += string_char_at(names[i],j);
		}
		
		//draw rank and name
		draw_text(_x,_y,_text);
		
		//draw score
		draw_text(_x+_width,_y,"  "  + scores[i]);
		
		_y += string_height("hi") + margin;
	}
}

#endregion

global.version = 1.11;
window_set_fullscreen(1);
game_set_speed(20,gamespeed_fps);

//content
menu_main			= ds_list_create();
menu_controls		= ds_list_create();
menu_settings		= ds_list_create();
menu_sounds			= ds_list_create();
menu_spawnsets		= ds_list_create();
menu_load_spawnset	= ds_list_create();
menu_leaderboards	= ds_list_create();

is_typing = 0;



//main menu
ds_list_add(menu_main,["start game",	function(){obj_transition.transition(rm_main)}])
ds_list_add(menu_main,["leaderboards",	function(){update_boards(); change_menu(menu_leaderboards)}])
ds_list_add(menu_main,["controls",		function(){change_menu(menu_controls)}])
ds_list_add(menu_main,["settings",		function(){change_menu(menu_settings)}])
ds_list_add(menu_main,["quit",			function(){game_end()}])

//leaderboards
ds_list_add(menu_leaderboards,["back",						function(){change_menu(menu_main)}])
ds_list_add(menu_leaderboards,["reset local highscore",		function(){reset_highscore()}])

//controls
ds_list_add(menu_controls,["turn         A/D or left/right arrow keys",			function(){if(sfx_i != 1) sfx_i = 0}])
ds_list_add(menu_controls,["boost                      W,Z or up arrow key",	function(){if(sfx_i != 3) sfx_i = 2}])
ds_list_add(menu_controls,["shoot       S,space or down arrow key",				function(){if(sfx_i != 5) sfx_i = 4}])
ds_list_add(menu_controls,["toggle shots type                      contorl",	function(){}])
ds_list_add(menu_controls,["back",												function(){change_menu(menu_main)}])

//settings
ds_list_add(menu_settings,["sounds",	function(){change_menu(menu_sounds);}])
ds_list_add(menu_settings,["spawnsets",	function(){change_menu(menu_spawnsets);}])
ds_list_add(menu_settings,["back",		function(){change_menu(menu_main); save_gamefile();}])

//spawnsets
ds_list_add(menu_spawnsets,["load spawnset",	function(){load_spawnset()}])//change_menu(menu_load_spawnset);keyboard_string = ""; is_typing=1}])
ds_list_add(menu_spawnsets,["reset spawnset",	function(){reset_spawnset();}])
ds_list_add(menu_spawnsets,["back",				function(){change_menu(menu_settings);}])

//load spawnset
ds_list_add(menu_load_spawnset,[".space",							function(){load_spawnset(); change_menu(menu_spawnsets); is_typing=0}])
ds_list_add(menu_load_spawnset,["press enter or space to confirm",	function(){}])

//sounds
ds_list_add(menu_sounds,["music volume +",	music_vol_up])
ds_list_add(menu_sounds,["music volume -",	music_vol_down])
ds_list_add(menu_sounds,["sfx volume +",	sfx_vol_up])
ds_list_add(menu_sounds,["sfx volume -",	sfx_vol_down])
ds_list_add(menu_sounds,["back",			function(){change_menu(menu_settings); save_gamefile();}])

//string_title = "SPACE R0XX";
string_title = "GALACTIC SPACE R0XX";

//logic
pointer = 0;
menu_current = menu_main;

//spawn stars
repeat(100)
{
	with (instance_create_layer(random(room_width), random(room_height),"bg",obj_bg_star))
	{
		image_speed = random_range(0.1,0.7);
		var s = random(2.5);
		image_xscale = s;
		image_yscale = s;
		image_alpha = random_range(0.8,1.2);
	}
}

//sfx
arr_sfx = [sfx_menu_C,sfx_menu_C,sfx_menu_Eb,sfx_menu_Eb,sfx_menu_B,sfx_menu_B]
sfx_i = 0;

//visuals
menu_option_yoff = 0;
ui_time = 0;
prev_time = 0;
wave_height = 2;