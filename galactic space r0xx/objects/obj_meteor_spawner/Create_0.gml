global.spawns = 0;
depth = 5;

//save some headache
meteors_types_num = -1;

//logic
spawnset_timer_remain = 0;
spawnset_index = -1;
list_alarms = ds_list_create();

//meteors obs
list_meteors_objs = ds_list_create();

ds_list_add(list_meteors_objs,-1);
ds_list_add(list_meteors_objs,obj_meteor_small);
ds_list_add(list_meteors_objs,obj_meteor_medium);
ds_list_add(list_meteors_objs,obj_meteor_large);
ds_list_add(list_meteors_objs,obj_meteor_fast);
ds_list_add(list_meteors_objs,obj_meteor_fast2);
ds_list_add(list_meteors_objs,obj_rocket);	
ds_list_add(list_meteors_objs,obj_meteor_pickup);
ds_list_add(list_meteors_objs,obj_meteor_metal);
ds_list_add(list_meteors_objs,obj_meteor_metal_large);
ds_list_add(list_meteors_objs,obj_tiefighter);
ds_list_add(list_meteors_objs,obj_black_hole);
ds_list_add(list_meteors_objs,obj_obama);

enum SPAWNLIST_DATA{
	name,
	duration,
	spawns,
}
enum SPAWN_DATA{
	type,
	cooldown,
	seconds,
	repeats,
	num,
}
enum METEORS{
	none,
	small,
	mid,
	large,
	fast,
	fast2,
	rocket,
	pickup,
	metal,
	metal_large,
	tie,
	hole,
}
enum RARITY{
	common,
	uncommon,
	rare,
	single,		//spawn once at the start
}
enum RESPAWN{
	normal		= 40,
	special		= 60 * 7,
	mass		= 20,
	little		= 100,
	single		= -1,
}
//
current_spawnset = -1;
arr_spawnsets = spawnset_load(global.spawnset_path);

/*/
spawnset array guide
0 - spawnlist name (isnt relevent, its just there for the editor.
1 - spawnset time in seconds
2 - 
[
	0 - meteor index
	1 - spawn timer
	2 - seconds or frames (true for seconds)
	2 - spawn repeats number (-1 for infinite)
	3 - how many are spawned at once each time		
[
[ 0,1,2,3 - repeat]

becuase there is no split from the spawnset timer to the meteor arrays,
all the fors that go through the meteors for this and that usually start from i=2 to skip it.
its a bit confusing.

meteors split:
each meteor has its own alarm. a
use different alarm for each meteor.
/*/

if(array_length(arr_spawnsets) == 0)
{
#region default spawnset setup

arr_spawnsets[array_length(arr_spawnsets)] = [20,"",		[METEORS.fast2,RESPAWN.little,0]]		
arr_spawnsets[array_length(arr_spawnsets)] = [200,"",		[METEORS.fast,RESPAWN.normal,-1],[METEORS.fast2,RESPAWN.normal,-1],[METEORS.pickup,RESPAWN.special*3,-1]]	//encounter: fast
arr_spawnsets[array_length(arr_spawnsets)] = [20,"",		[METEORS.fast2,RESPAWN.little,-1]]									//first hard
arr_spawnsets[array_length(arr_spawnsets)] = [10,"",		[METEORS.pickup,190,2]]
arr_spawnsets[array_length(arr_spawnsets)] = [20,"",		[METEORS.pickup,RESPAWN.special,2]]
arr_spawnsets[array_length(arr_spawnsets)] = [10,"",		[METEORS.rocket,190,2]]//encounter: large
arr_spawnsets[array_length(arr_spawnsets)] = [20,"",		[METEORS.large,RESPAWN.little,-1],[METEORS.pickup,120,1]]
arr_spawnsets[array_length(arr_spawnsets)] = [10,"",		[METEORS.large,RESPAWN.special*3,-1]]
arr_spawnsets[array_length(arr_spawnsets)] = [30,"",		[METEORS.rocket,130,-1]]//encounter: large
arr_spawnsets[array_length(arr_spawnsets)] = [20,"",		[METEORS.metal,RESPAWN.normal,-1],[METEORS.metal_large,RESPAWN.little,-1]]
arr_spawnsets[array_length(arr_spawnsets)] = [20,"",		[METEORS.fast,RESPAWN.normal,-1],[METEORS.fast2,RESPAWN.normal,-1],[METEORS.rocket,RESPAWN.special,-1],[METEORS.pickup,RESPAWN.special*3,-1]]	//encounter: fast

spawnset_save(arr_spawnsets,DEFAULT_SPAWNSET);

#endregion
}

function spawn_meteor(index)
{
	//i dont think its needed
	//global.spawns++;
	
	//how many meteors to spawn at once
	var _spawn_num = current_spawnset[index][SPAWN_DATA.num];	
	
	//angle from the player to spawn
	var _angle = random(360);									//angle from to player to spawn the meteor
	var _angle_margin = 360/_spawn_num;							//degrees to add between each spawn
	var _dis = (obj_camera.zoom * (obj_camera.base_w/2)) * 1.5;	//distance away from the player to spawn the meteor
	
	for(var i=0; i < _spawn_num; i++)
	{
		var _x = obj_camera.xdest + lengthdir_x(_dis,_angle);
		var _y = obj_camera.ydest + lengthdir_y(_dis,_angle);
	
		var _obj = list_meteors_objs[|current_spawnset[index][SPAWN_DATA.type]]
		
		//spawn at center if its a black hole
		if(_obj == obj_black_hole)
		{
			_x = obj_player.x;
			_y = obj_player.y;
		}
		
		//dont spawn if its "empty"
		if(_obj != -1)
		{
			var _inst = instance_create_depth(_x,_y,0,_obj);	//the meteor angles itself to the player in the create event.
			_inst.update();
		}
		
		_angle += _angle_margin;
	}
}