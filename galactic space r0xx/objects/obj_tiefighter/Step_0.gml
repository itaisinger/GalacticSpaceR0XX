if(global.game_paused)
{
	speed = 0;
	exit;
}
else speed = spd;

msg = "";
#region state machine

state_time++;

state_changed = state != state_prev;
if(state_changed)
{
	audio_stop_sound(my_beep_sfx);
	state_time = 0;
}
state_prev = state;

arr_state_functions[state]();


#endregion
#region general stuff

/// die
if(hp <= 0)
	instance_destroy();


#region attract to black hole

var _hole = instance_find(obj_black_hole,0);
if(_hole != noone)
{
	_force = 0.2*(max(0,_hole.pull_dis-distance_to_object(_hole))/_hole.pull_dis);
	_force *= _hole.pull_force_mult;
	var _dir = point_direction(x,y, _hole.x,_hole.y);
	
	//direction = approach(direction,_dir,_force*2);
	direction -= sign(angle_difference(direction,_dir))*_force*3;
	
	momx += lengthdir_x(_force*0.02,_dir);
	momy += lengthdir_y(_force*0.02,_dir);
}

#endregion
#region avoid collision with player

//normal collision
if(place_meeting(x + momx*10,y + momy*10, obj_player))
{
	momx *= 0.8;
	momy *= 0.8;
	msg = "brake";
}

//push away
var _dis = distance_to_object(obj_player)
var _dir_2player = point_direction(x,y,obj_player.x,obj_player.y);
//natural avoid
if(_dis < avoid_distance)
{
	//flip dir if player is begind me 
	var _dir = direction;
	if(angle_difference(direction,_dir_2player) > 180)
		_dir += 180;
	
	//force
	var _dis = distance_to_object(obj_player);
	var _force = 2.5*((avoid_distance-_dis)/avoid_distance);
	
	//push
	momx -= lengthdir_x(_force,_dir);
	momy -= lengthdir_y(_force,_dir);
	
	//cheating
	momx -= lengthdir_x(_force/1.5,_dir_2player);
	momy -= lengthdir_y(_force/1.5,_dir_2player);
}

//soft collision with other fighters
var _inst = instance_place(x,y,obj_tiefighter)
if(_inst != noone and _inst.id != id)
{
	var _dir = point_direction(x,y, _inst.x,_inst.y)
	
	x -= lengthdir_x(10,_dir)
	y -= lengthdir_y(10,_dir)
}

#endregion


direction += turn_current;
turn_current = approach(turn_current,0,turn_fric);

/// momentum

momx = clamp(-mom_max,momx,mom_max);
momy = clamp(-mom_max,momy,mom_max);

x += momx;
y += momy;

momx = approach(momx,0,frics[state]);
momy = approach(momy,0,frics[state]);


//play shader animation
shader_a = approach(shader_a,0,0.07);
if(hp_prev > hp)
{
	shader_a = 1;
	shader_val = 1- hp/hp_max;
}
hp_prev = hp;

#endregion

/// sfx

//boost sfx 
var _speed = power(power(momx,2) + power(momy,2),0.5);
var _min_speed = 5, _max_speed = 25;
boost_gain = max(0,(_speed-_min_speed)/_max_speed)

audio_sound_gain(my_boost_sfx,boost_gain,0.05)
