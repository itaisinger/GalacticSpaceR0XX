//time
if(global.player_inst.state != STATES.dead and !global.game_paused)
	game_time[0]++;
	
if(game_time[0] >= 60)
{
	game_time[0] = 0;
	game_time[1]++;
}
if(game_time[1] >= 60)
{
	game_time[1] = 0;
	game_time[2]++;
}


if(do_text)
{
	do_text = 0;
	
	var _x = display_get_gui_width()/2;
	var _y = 70;
	with(instance_create_depth(_x,_y,0,obj_text_fade))
	{
		is_gui = 1;
		text = "turn with A/D or left/right"+
				"\nboost with W or up"+
				"\nshoot with space"
		time = room_speed*7;
		o_width = 0;
		font = font_continue
		halign = fa_center;
		other.controls_text = self;
	}
}