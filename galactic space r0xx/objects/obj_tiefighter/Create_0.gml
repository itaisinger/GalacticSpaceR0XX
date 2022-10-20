event_inherited();
_stop = 0;

//visuals
image_xscale = size;
image_yscale = size;
yoffset = 0.4;
height = 1;
sprite_index = spr_tie_fighter61;

if(irandom(100) == 69)
{
	sprite_index = spr_yamato61;
	image_xscale *= 2;
	image_yscale *= 2;
}
rayx = x;
rayy = y;
ray_col = make_color_rgb(0,229,0);
ray_a = 0;

//sfx
my_boost_sfx = audio_play_sound(sfx_tiefighter_boost,0,1,0);
boost_gain = 0;
my_beep_sfx = -1;

//movement
momx = 0;
momy = 0;
mom_max = 40;
turn_current = 0;	//degreet currently turning per frame
turn_fric	 = 0.05;
frics	 = [];

chase_spd_accel		= 1.6;	//movement speed acceleration
chase_spd_max		= 35;	//max speed when chasing
frics[TSTATES.chase]= 0.55;
chase_turn_accel	= 0.17;	//turning speed aceleration while chasing
chase_turn_max		= 3.3;	//max angles able to turn per frame while chasing

aim_turn_accel		= 1.5;	//turning speed aceleration while aiming
aim_turn_max		= 2;	//max angles able to turn per frame while aiming
frics[TSTATES.aim]	= 0.35;

frics[TSTATES.shot] = 0.6;
frics[TSTATES.reset]= 0.65;
frics[TSTATES.avoid]= 0.65;

//gameplay 
shots_num = 3;
shots_speed = 4;

aim_time_max		= 10*room_speed;//max time in aiming state before aborting
aim_time_remain		= aim_time_max;	//time left in aiming before giving up
aim_abort_remain	= 2*room_speed;	//time left beofore aborting early due to offshooting too hard
aim_abort_max		= 2*room_speed;
aim_hit_max			= 2*room_speed;	//max time needed to hit with the ray in order to shoot
aim_hit_remain		= aim_hit_max;	//time left to hit consecutively to shoot 

shoot_cd = 0;
shoot_cd_max = 10;
shoot_remain = 0;
shoot_remain_max = 3;

chase_distance_margin = 800;	//distance_away from the player to reach before transitioning
chase_point_index = 0;			//place in the global chase angles
xdest = 0;
ydest = 0;

avoid_distance = 500;

shot_knockback = 20;		//knockback from shooting

//logic
active = 0;	//set to true when first engaging combat. used with the camera.
state = 0;
state_prev = -1;
state_changed = 0;
state_time = 0;
arr_state_functions = [];
enum TSTATES{
	chase,
	aim,
	shot,
	reset,
	avoid,
}

/*/ to do:

states:
	- chase:	chase down the player head on until reaching a set distance away. 
				the chase dest point is stored in a global array and the angle to the player is relative to the position in the array
	
	- aim:		stay in place and aim at the player by turning towards him and sending a green ray. 
				if the ray hits the player for 10 frames in a row, transition to shoot.
				if it takes too long and the ray doesnt work, transition to shoot a rocket.
				
	- shoot:	shoot a few shots at the player while still trying to turn towards him. if too hard make it so he doesnt turn in this state.
	
	- rocket1:	spin opposite to where aiming then transition to rocket2
	- rocket2:	shoot a rocket at the player
	
sfx/vfx:
	- iconic sfx plays either on loop and vol up according to speed, or when entering
	  boost state.
	- green shots + explode particle
	- shots sfx from star wars

/*/

/// functions

//state functions
arr_state_functions[TSTATES.chase]	= function()
{	
	if(state_changed)
	{
		//calculate new dest pos angle
		//if the list is empty, meaning im the only tie fighter chasing, pick my angle. 
		//	otherwise, recalculate all the angles.
		
		var _chase_num = ds_list_size(global.list_tie_fighter_destpoints);
		
		if(_chase_num == 0)	//im the only one chasing
		{
			//add my current angle
			ds_list_add(global.list_tie_fighter_destpoints,point_direction(x,y, obj_player.x,obj_player.y))
			chase_point_index = 0;
		}
		else	//give everyone new angles and add myself
		{
			for(var i=0; i < _chase_num+1; i++)
			{
				ds_list_set(global.list_tie_fighter_destpoints,i,(360/(_chase_num+1))*i)
			}
			
			chase_point_index = _chase_num;
		}
		
		//unpitch boost
		audio_sound_pitch(my_boost_sfx,1);
	}
	
	//calculate dest pos
	var _angle = global.list_tie_fighter_destpoints[| chase_point_index];
	xdest = obj_player.x + lengthdir_x(chase_distance_margin,_angle);
	ydest = obj_player.y + lengthdir_y(chase_distance_margin,_angle);
	
	//turn in the direction
	var _diff = angle_difference(direction, point_direction(x,y, xdest,ydest));
	var _dir = sign(_diff);
	turn_current -= _dir*chase_turn_accel;
	turn_current = clamp(-chase_turn_max,turn_current,chase_turn_max);
	
	//apply speed
	var _current_spd = power(power(momx,2) + power(momy,2),0.5);
	var _spd = chase_spd_accel;
	if(distance_to_point(xdest,ydest) < 300 and _current_spd > 10)
		_spd *= 0.6;
		
	if(_current_spd < chase_spd_max)
	{
		momx += lengthdir_x(_spd,direction);
		momy += lengthdir_y(_spd,direction);
	}
	
	//transition to aim
	if(distance_to_object(obj_player) < chase_distance_margin*0.7)
	or(distance_to_object(obj_player) < chase_distance_margin*1.1 and _diff < 20)
	{
		state = TSTATES.aim;
	}
}
arr_state_functions[TSTATES.aim]	= function()
{
	xdest = obj_player.x;
	ydest = obj_player.y;
	
	if(state_changed)
	{
		active = 1;
		aim_hit_remain = aim_hit_max;
		aim_abort_remain = aim_abort_max;
		
		//create sfx
		my_beep_sfx = play_sfx(sfx_beep);
	}
	
	//turn
	var _dir_dest = point_direction(x,y, xdest,ydest)
	var _diff = angle_difference(direction, _dir_dest);
	var _dir = sign(_diff);
	
	if(abs(_diff) > aim_turn_accel)
		direction -= _dir*aim_turn_accel;
	else 
		direction = _dir_dest;
	
	
	//ray alpha and beep volume
	var _cur = animcurve_get(cur_tighfighter);
	var _ray_ch	 = animcurve_get_channel(_cur,1);
	var _beep_ch = animcurve_get_channel(_cur,0);
	var _prec = (aim_hit_max-aim_hit_remain)/aim_hit_max;
	
	ray_a = animcurve_channel_evaluate(_ray_ch,_prec);
	var _vol = animcurve_channel_evaluate(_beep_ch,_prec) * audio_sound_get_gain(sfx_beep);
	audio_sound_gain(my_beep_sfx,_vol,0)
	
	/// RAY CASTING ///
	if(0 or current_time%2 == 0)
	{
		var _count = 0, _count2 = 0, _max_cnt = 1000 
		_stop = 0;
		_xadd = lengthdir_x(20,direction);
		_yadd = lengthdir_y(20,direction);
		var _xadd2 = _xadd/20, _yadd2 = _yadd/20, ;
		var _xprev = x, _yprev = y;
		mask_index = spr_pixel;
	
		while(!_stop and _count < _max_cnt)			//initial dash through
		{
			while(place_meeting(x,y,obj_player))	//readjust
			{
				x -= _xadd2;
				y -= _yadd2;
				
				_stop = 1;
				_count2++;
			}
		
			x += _xadd;	
			y += _yadd;	
		
			_count++;
		}
	
		mask_index = sprite_index;
	
		rayx = x;
		rayy = y;
	
		x = _xprev;
		y = _yprev;
		
		//var ray_dis = _count*20 - _count2;
		//rayx = x + lengthdir_x(ray_dis,direction)
		//rayy = y + lengthdir_y(ray_dis,direction)
	}
	
	/// state transitions ///
	
	//abort due to too big diff
	if(_diff > 90 and aim_abort_remain-- <= 0)
		state = TSTATES.chase;
	else
		aim_abort_remain = 60;
		
	//abort due to too long in this state
	if(state_time >= aim_time_max)
		state = TSTATES.chase;
	
	//shoot
	if(_stop)
		aim_hit_remain--;
	else
		aim_hit_remain = aim_hit_max;
		
	if(aim_hit_remain <= 0)
		state = TSTATES.shot;
}
arr_state_functions[TSTATES.shot]	= function()
{
	if(state_changed)
	{
		shoot_remain = irandom_range(shoot_remain_max-1,shoot_remain_max+1);
		shoot_cd = 0;
	}
	
	
	if(shoot_cd-- <= 0)
	{
		shoot_remain--;
		shoot();
		shoot_cd = shoot_cd_max// * random_range(0.8,1.2);
	}
	
	if(shoot_remain <= 0)
		state = TSTATES.reset;
}
arr_state_functions[TSTATES.reset]	= function()
{	
	//calculate dest pos
	if(state_changed)
	{
		var _dir_to_player = point_direction(x,y, obj_player.x,obj_player.y)
		var _dest_dir = _dir_to_player + 110*choose(-1,1);
		
		xdest = x + lengthdir_x(400,_dest_dir);
		ydest = y + lengthdir_y(400,_dest_dir);
	}
	
	//turn in the direction
	var _diff = angle_difference(direction, point_direction(x,y, xdest,ydest));
	var _dir = sign(_diff);
	turn_current -= _dir*chase_turn_accel;
	turn_current = clamp(-chase_turn_max,turn_current,chase_turn_max);
	
	//apply speed
	var _current_spd = power(power(momx,2) + power(momy,2),0.5);
	if(1 or _current_spd < chase_spd_max)
	{
		momx += lengthdir_x(chase_spd_accel,direction);
		momy += lengthdir_y(chase_spd_accel,direction);
	}
	
	//transition to chase
	if(distance_to_point(xdest,ydest) < 50 or state_time > 60)
	{
		state = TSTATES.chase;
	}
}
arr_state_functions[TSTATES.avoid]	= function()
{
	//flip dir if player is begind me 
	var _dir = direction;
	if(angle_difference(direction,point_direction(x,y,obj_player.x,obj_player.y)) > 140)
		_dir += 180;
	
	//force
	var _dis = distance_to_object(obj_player);
	var _force = 3.5*((avoid_distance-_dis)/avoid_distance);
	
	//push
	momx -= lengthdir_x(_force,_dir);
	momy -= lengthdir_y(_force,_dir);
	
	if(state_time > 120 or _dis > avoid_distance*0.8)
	{
		state = TSTATES.reset;
	}
}

//other functions
function shoot()
{
	var _shot = instance_create_depth(x,y-20,depth,obj_shot_enemy);
	_shot.image_angle	= direction + 90;
	_shot.direction		= direction;
	_shot.image_xscale	= image_xscale;
	_shot.image_yscale	= image_yscale;
	
	//sfx
	audio_sound_pitch(sfx_tiefighter_shot,random_range(0.8,1.2));
	play_sfx(sfx_tiefighter_shot);
	
	//recoil
	if(abs(momx) + abs(momy) < 6) 
		push(direction + 180,shot_knockback);
}
function push(angle,force)
{
	momx += lengthdir_x(force,angle);
	momy += lengthdir_y(force,angle);
}

















