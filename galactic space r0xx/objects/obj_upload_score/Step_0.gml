if(!active) exit;

//type out name
player_name = string_letters(keyboard_string);

//enter
if(keyboard_check_pressed(vk_enter) and player_name != "")
{
	//deactivate
	active = 0;
	
	//disable ui typer pointer
	obj_ui.alarm[0] = -1;
	obj_ui.typer_a = 0;
	
	//update player name
	LootLockerSetPlayerName(player_name);
	
	//upload score
	LootLockerSubmitScore(global.leaderboardsID,global.score);
	
	//display
	my_text = create_text(display_get_gui_width()/2,display_get_gui_height()*0.25,"score uplaoded",c_white,c_white,0);
	my_text.font = font_small;
	my_text.yoff = 0;
	my_text.is_gui = 1;
	my_text.time = 70;
}