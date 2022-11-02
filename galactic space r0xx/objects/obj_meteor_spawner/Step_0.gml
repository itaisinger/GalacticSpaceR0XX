/// @description Insert description here
// You can write your code in this editor
if(global.game_paused) exit;

if(instance_exists(obj_player))
{
	x = obj_player.x;
	y = obj_player.y;
}

/// switch spawnset
if(!global.tutorial_active and --spawnset_timer_remain <= 0)
{
	global.spawns = 0;
	
	var _endloop = false;	//whether we are now in the endloop and need to tighten the loop each time.
	
	/// set new spawnlist
	spawnset_index++;
	
	//reset last one if we are on the last spawnlist
	if(spawnset_index >= array_length(arr_spawnsets))
	{
		spawnset_index = array_length(arr_spawnsets)-1;
		_endloop = true;
	}
	
	//set the new spawnlist
	current_spawnset = arr_spawnsets[spawnset_index];
	
	//reduce the cooldowns if we are on the endloop
	if(_endloop)	
	{
		meteors_types_num = array_length(current_spawnset)-1
		for(var i=SPAWNLIST_DATA.spawns; i <= meteors_types_num; i++)
		{
			current_spawnset[i][1] *= 0.93;
		}
	}
	
	//apply timer
	spawnset_timer_remain = room_speed * current_spawnset[SPAWNLIST_DATA.duration];
	
	///reset alarms
	ds_list_destroy(list_alarms);
	list_alarms = ds_list_create();
	
	//apply starting cooldown
	meteors_types_num = array_length(current_spawnset)-1;
	for(var i=SPAWNLIST_DATA.spawns; i <= meteors_types_num; i++)
	{
		list_alarms[|i] = 0;
		//currently there is no starting cooldown, 
		//meaning all meteor spawns will spawn as soon as the spawlist starts and only then will respawn according to cooldown.
		//current_spawnset[i][SPAWN_DATA.cooldown]*<seconds>;	//this line will make them wait the cooldown before first spawn.
	}
}

/// alarms
for(var i=SPAWNLIST_DATA.spawns; i <= meteors_types_num; i++)
{
	//decrement current alarm
	list_alarms[|i]--;
	
	//trigger if the alarm reached 0 and there are spawns repeats remain
	if(list_alarms[|i] <= 0 and (current_spawnset[i][SPAWN_DATA.repeats] > 0 or current_spawnset[i][SPAWN_DATA.repeats] == -1))
	{
		//decrement meteors left to spawn of this spawn
		current_spawnset[i][SPAWN_DATA.repeats] = max(-1,current_spawnset[i][SPAWN_DATA.repeats]-1);	
			//this line is a bit edgy, but if it equals to 0 it will never reach this line so i think it works.
		
		//reset alarm
		list_alarms[|i] = random_range(0.8,1.2) * current_spawnset[i][SPAWN_DATA.cooldown];
		
		//multiply by room speed if the cooldown is by frames and not seconds
		if(current_spawnset[i][SPAWN_DATA.seconds])
			list_alarms[|i] *= 60;
		
		//spawn meteor
		spawn_meteor(i);
	}
}
