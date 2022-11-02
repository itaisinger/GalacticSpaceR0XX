//time
if(!global.tutorial_active and global.player_inst.state != STATES.dead and !global.game_paused)
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