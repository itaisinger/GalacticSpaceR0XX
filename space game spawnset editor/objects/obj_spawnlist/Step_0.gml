//states
arr_states_functions[state]();

//if typing "" in repeats, switch it to "-1".
if(arr_elements[SPAWNLIST_ELEM.repeats].my_input == "" and arr_elements[SPAWNLIST_ELEM.repeats].state == 0)
{
	arr_elements[SPAWNLIST_ELEM.repeats].my_input = "-1"
}

///constantly update the current spawns data array out of the ui elements.
//constantly. except for the index, that one is inverse. the button is invalid and takes data from me.
var _arr = arr_spawns[current_spawn];

_arr[SPAWNS_DATA.type]		= arr_elements[SPAWNLIST_ELEM.type].enemy_index;
_arr[SPAWNS_DATA.cooldown]	= arr_elements[SPAWNLIST_ELEM.cooldown].my_input;
_arr[SPAWNS_DATA.seconds]	= arr_elements[SPAWNLIST_ELEM.seconds].is_seconds;
_arr[SPAWNS_DATA.repeats]	= arr_elements[SPAWNLIST_ELEM.repeats].my_input;
_arr[SPAWNS_DATA.num]		= arr_elements[SPAWNLIST_ELEM.num].my_input;

arr_elements[SPAWNLIST_ELEM.index].text = index;

if(arr_elements[SPAWNLIST_ELEM.duration].my_input != "")
	duration = int64(arr_elements[SPAWNLIST_ELEM.duration].my_input);

//update other enemies icons

for(var i=0; i < MAX_ENEMY_NUM; i++)
{
	arr_elements[SPAWNLIST_ELEM.others][i].text = "[spr_enemy_icons," + string(arr_spawns[i][0]) + "]";	
	//arr_elements[SPAWNLIST_ELEM.others][i].text = "hi"//"[spr_enemy_icons," + string(arr_spawns[i][0]) + "]";	
	//show_debug_message("[spr_enemy_icons," + string(arr_spawns[i][0]) + "]");	
}

//update all of the elements x and y according to mine
for(var i=0; i < array_length(arr_elements)-1; i++)
{
	with(arr_elements[i])
	{
		y = other.y + other.margin;
		x = other.x + xoff;
		depth = other.depth-1;
	}
}

//others buttons
for(var i=0; i < MAX_ENEMY_NUM; i++)
{
	with(arr_elements[SPAWNLIST_ELEM.others][i])
	{
		y = other.y + other.margin;
		x = other.x + xoff;
		depth = other.depth-1;
	}
}