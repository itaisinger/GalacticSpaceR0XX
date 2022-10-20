/*/
menu opetions are 2 element arays, text and a function.
menu_current is the current list of menu options. 
to switch page, call change_menu(menu_page).

/*/
global.game_paused = 1;
depth = DEPTH.pause;

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

	instance_destroy(my_text);
	my_text = create_text(0,0,"music volume: " + string(global.music_volume),c_white,c_white,0);
	my_text.font = font_small;
	my_text.yoff = 0;
	my_text.is_gui = 1;
}
function music_vol_down()
{
	global.music_volume = max(0,global.music_volume - 0.1)
	instance_destroy(my_text);
	my_text = create_text(0,0,"music volume: " + string(global.music_volume),c_white,c_white,0);
	my_text.font = font_small;
	my_text.yoff = 0;
	my_text.is_gui = 1;
}
function sfx_vol_down()
{
	global.sfx_volume = max(0,global.sfx_volume - 0.1)
	instance_destroy(my_text);
	my_text = create_text(0,0,"sfx volume: " + string(global.sfx_volume),c_white,c_white,0);
	my_text.font = font_small;
	my_text.yoff = 0;
	my_text.is_gui = 1;
}
function sfx_vol_up()
{
	global.sfx_volume = min(1,global.sfx_volume + 0.1)
	instance_destroy(my_text);
	my_text = create_text(0,0,"sfx volume: " + string(global.sfx_volume),c_white,c_white,0);
	my_text.font = font_small;
	my_text.yoff = 0;
	my_text.is_gui = 1;
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

#endregion

//conent
menu_main = ds_list_create();
menu_controls = ds_list_create();
menu_sounds = ds_list_create();
my_text = noone;	//text display of changing volume

//main menu
ds_list_add(menu_main,["resume",		function(){instance_destroy()}])
ds_list_add(menu_main,["controls",		function(){change_menu(menu_controls)}])
ds_list_add(menu_main,["settings",		function(){change_menu(menu_sounds)}])
ds_list_add(menu_main,["quit to menu",	function(){obj_transition.transition(rm_menu)}])

//controls
ds_list_add(menu_controls,["turn         A/D or left/right arrow keys",			function(){if(sfx_i != 1) sfx_i = 0}])
ds_list_add(menu_controls,["boost                      W,Z or up arrow key",	function(){if(sfx_i != 3) sfx_i = 2}])
ds_list_add(menu_controls,["shoot       S,space or down arrow key",				function(){if(sfx_i != 5) sfx_i = 4}])
ds_list_add(menu_controls,["toggle shots type                      contorl",	function(){}])
ds_list_add(menu_controls,["back",												function(){change_menu(menu_main)}])

//sounds settings
ds_list_add(menu_sounds,["music volume +",	music_vol_up])
ds_list_add(menu_sounds,["music volume -",	music_vol_down])
ds_list_add(menu_sounds,["sfx volume +",	sfx_vol_up])
ds_list_add(menu_sounds,["sfx volume -",	sfx_vol_down])
ds_list_add(menu_sounds,["back",			function(){change_menu(menu_main); save_gamefile();}])

//logic
pointer = 0;
menu_current = menu_main;

//sfx
arr_sfx = [sfx_menu_C,sfx_menu_C,sfx_menu_Eb,sfx_menu_Eb,sfx_menu_B,sfx_menu_B]
sfx_i = 0;

//visuals
menu_option_yoff = 0;
ui_time = 0;
prev_time = 0;
wave_height = 2;