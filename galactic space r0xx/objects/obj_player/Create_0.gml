/// @description Insert description here
// You can write your code in this editor
sprite_index = spr_spaceship;

//visuals/drawing
yoffset = 0.5;
height = 2;
depth = DEPTH.player;
image_xscale = 5;
image_yscale = 6;
boost_ys = 1;
boost_a  = 1;
angle = 0;
angle_max = 20;
uni_angle = shader_get_uniform(sh_tilt,"angle");
iframes_alpha = 1;
iframes_flicker_speed = 5;
global.player_inst = id;
flash_a = 0;

//vfx
boost_sprite = spr_boost;
boost_initial_vfx = spr_boost_initial;
shot_sprite = spr_shot;
shot_die_sprite = spr_shot_die;
boost_lvlup_a = 0;			//used to artificially show the boost when leveling up
body_sprite = spr_spaceship_dead;


//sfx
shoot_sfx			= sfx_shoot;
boost_sfx			= sfx_boost;
boost_sustain_sfx	= sfx_boost_sustain;
boost_fade_sfx		= sfx_boost_fade;
global.hitmark_sfx	= sfx_hitmark;

//movement
spd_current = 0;	//the speed at which we are currently turning
spd_natural = 6;	//max natural turning speed 
spd_boost = 25;		//max boosting turning speed
spd_shoot = 2;		//max shooting turning speed
spd_accel = 0.3;	
boost_initial = 0.3;//multiplier for the initial boost 
turn_current = 0;	//the speed (including direction) we are currently turning at
turn_max = 1;		//the current max speed we are able to (naturally) turn at
turn_accel = 0.07;	//acceleration towards max turn speed
turn_natural = 6;	//max turn speed in natural state
turn_shoot = 2;		//max turn speed when shooting
turn_boost = 1;		//max turn speed when boosting
max_turning_spd = 8;//turning speed hard clamp
can_turn = 1;		//used in the tutorial

xmom = 0;			//xmomentum
ymom = 0;			//ymomentum
fric = 0.2;			//how fast momentum approaches 0
mom_max = 20;		//max momentum for x/y so it wouldnt stack

boost_cd = 0;		//cooldown for the initial string boost to prevent spamming 
boost_cd_max = 30;	

//shooting
shot_cd_max = 13;		//delay between shots
shot_spd = 60;
flicker = 0;			//flicker between shooting from top or bottom blasters
shot_knockback = 3;		//knockback from shooting
shooting_this_frame = 0;//used to affect direction with recoil 

//input
key_shoot = 0;
key_boost = 0;
key_left	= 0;
key_right	= 0;

//gameplay
iframes = 0;
iframes_max = 60;
hp = 3;	
hp_max = 3;
dmg = 2.5;			//shots damage
dmg_collide = 20;	//damage given to meteors on collision

level = 1;								//used by ui obj
list_bars = ds_list_create();			//progress in the hp/upgrade bar
list_bars_events = ds_list_create();	//events that run when a bar is filled
list_bar_max = ds_list_create();		//list of points needed to complete a bar

current_shots = 0;
shots_unlocked = [1,0,0];

//logic
state = 0;
state_changed = 0;
state_prev = state;
inst_body = noone;

enum STATES{
	natural,
	shoot,
	boost,
	dead,
}
enum SHOTS{
	white,
	red,
	purple,
}
arr_states_functions = [];

/*/
movements logic:
	by default move forward in natural speed
	if shooting, move slower and turn slower
	if not shooting, you can boost and turn slower or drift?
/*/

///functions
arr_states_functions[STATES.natural] = function()
{
	spd_current = spd_natural;
	turn_max	= turn_natural;
	
	//transition
	if(key_boost)
		state = STATES.boost;
	if(key_shoot)
		state = STATES.shoot;
}
arr_states_functions[STATES.boost] = function()
{
	spd_current = spd_boost;
	turn_max	= turn_boost;
	speed = lerp(speed,spd_current,0.1);
	
	if(state_changed and boost_cd <= 0)
	{
		//sfx
		play_sfx(boost_sfx);
		play_sfx(boost_sustain_sfx,100,1)
		boost_a = 0.9;
		boost_ys = 1.2;
		boost_cd = boost_cd_max
		
		//vfx
		var _fx = create_effect(boost_initial_vfx);
		_fx.image_xscale = 7;
		_fx.image_yscale = 7;
		_fx.image_angle = direction - 90;
		alarm[2] = 10;
		
		//speed += spd_boost;
		xmom += lengthdir_x(spd_boost*boost_initial,direction);
		ymom += lengthdir_y(spd_boost*boost_initial,direction);
	}

	//transition
	if(!key_boost)
		state = STATES.natural;
	if(key_shoot_pressed)
		state = STATES.shoot;
	
	if(state != STATES.boost)
	{
		audio_stop_sound(boost_sustain_sfx);
		play_sfx(boost_fade_sfx)
	}
}
arr_states_functions[STATES.dead] = function()
{
	xmom = 0;
	ymom = 0;
	image_alpha = 0;
	x = obj_player_body.x;
	y = obj_player_body.y;
}
arr_states_functions[STATES.shoot] = function()
{
	spd_current = spd_shoot;
	turn_max	= turn_shoot;
	
	if(state_changed)
	{
		turn_current = 0;
		flicker = 0;
		alarm[0] = 1;
		
		//state start recoil
		push(direction + 180,shot_knockback);
	}
	
	//transition
	if(!key_shoot)
		state = STATES.natural;
	if(key_boost_pressed)
		state = STATES.boost;
}

function shoot()
{
	/*/
	use an array to store where each one of the shots are shot from.
	[first shot, second shot]. 0 for bottom and 1 for top blasters.
	/*/
	
	var _blasters = [choose(0,1),choose(0,1)];
	var _num = 2 - (level == 0);	//in the tutorial, shoot just one shot.
	
	for(var i=0; i < 2; i++)
	{
		var _shot = instance_create_depth(x,y,depth,obj_shot);
		_shot.image_angle	= image_angle;
		_shot.direction		= direction;
		_shot.image_xscale	= image_xscale;
		_shot.image_yscale	= image_yscale;
		_shot.spd			= shot_spd;
		_shot.speed			= shot_spd;
		_shot.damage = dmg;
		_shot.sprite_index	= shot_sprite;
		_shot.die_sprite	= shot_die_sprite;
		
		_shot.is_homing = current_shots == SHOTS.purple;
	
		//left or right blasters
		var _xoff = image_xscale*(-14 + i*28);	//fancy way of saying "first one is -14 second is 14."
		
		if(level == 0)
			_xoff = 0;
		else
		{
			_shot.x += lengthdir_x(_xoff,image_angle);
			_shot.y += lengthdir_y(_xoff,image_angle);
		}
		
		//yoff: roll an image index, shoot from bottom or top blasters. if rolled top, give it a yoff.
		_shot.image_index = _blasters[i];//(++flicker)%2;
		if(_shot.image_index)
		{
			_shot.y -= image_number*(height+yoffset);
		}
	}
	
	//sfx
	play_sfx(shoot_sfx);
	
	//recoil
	if(abs(xmom) + abs(ymom) < 6) 
		push(direction + 180,shot_knockback);
		
	shooting_this_frame = 1;			//used to recoil to the side
}
function push(angle,force)
{
	xmom += lengthdir_x(force,angle);
	ymom += lengthdir_y(force,angle);
}
function hurt(angle)
{	
	//abort if during iframes
	if(iframes > 0) return;
	
	if(!is_undefined(angle))
		push(angle,14);	
	
	//sfx
	play_sfx(sfx_hurt);
	audio_stop_sound(sfx_boost_sustain);
	
	hp--;
	list_bars[|hp] = 0;
	iframes = iframes_max;
	iframes_alpha = 0;
	alarm[1] = iframes_flicker_speed;
	
	if(hp <= 0)
		die();
}
function heal()	//not used
{
	if(hp < hp_max)
	{
		hp++;
	}
	else
	{
		global.score += 100;
		obj_ui.flash_hp_score("100");
	}
}
function die()
{
	//stop hurt sfx and play sfx
	audio_stop_sound(sfx_hurt);
	play_sfx(sfx_death);
	inst_body = instance_create_depth(x,y,depth,obj_player_body);
	with(inst_body)
	{
		image_angle = other.image_angle;
		xmom = other.xmom;
		ymom = other.ymom;	
		sprite_index = other.body_sprite;
		
		list_bars = other.list_bars;
		list_bar_max = other.list_bar_max;
	}
	
	state = STATES.dead;
	mask_index = -1;
	
	
	
	//upade high score
	if(global.score > global.high_score and global.spawnset_path == DEFAULT_SPAWNSET)
	{
		global.high_score = global.score;
		obj_ui.high_score = 1;
		save_gamefile();
		
		instance_create_depth(0,0,0,obj_upload_score);
	}
}
function progress(amount)
{
	///add progress to the upgrade\health bars
	
	//loop through all the bars and fill the score in the leftmost place that is missing. 
	//when filling, check for completing, then fill just the amount missing, trigger the event and continue to fill the rest.
	
	var num = ds_list_size(list_bars), sub = 0;
	for(var i=0; i < num and amount > 0; i++)
	{
		//check wether any score is missing
		sub = list_bar_max[|i] - list_bars[|i];
		
		//fill
		if(sub > 0)
		{
			var fill = min(sub,amount);
			amount -= fill;
			
			list_bars[|i] += fill;
			
			//trigger event
			if(list_bars[|i] == list_bar_max[|i])
			{
				list_bars_events[|i]();
				obj_ui.flash_hp(i);
				
				//sfx
				audio_sound_pitch(sfx_bar,0.7 + 0.1*i)
				play_sfx(sfx_bar);
				//reset cooldown if that exists	
			}
		}
	}
}
_force = 0;
function attract_to_hole()
{
	var _hole = instance_find(obj_black_hole,0);
	if(_hole != noone)
	{
		_force = 0.16*(max(0,_hole.pull_dis*10-distance_to_object(_hole))/(_hole.pull_dis));
		_force *= _hole.pull_force_mult;
		var _dir = point_direction(x,y, _hole.x,_hole.y);

		//direction -= approach(direction,_dir,_force);
		turn_current += sign(angle_difference(_dir,direction))*_force*0.03;
		
		_force = min(_force,0.20);
		xmom += lengthdir_x(_force,_dir);
		ymom += lengthdir_y(_force,_dir);
	}
}
function unlock_homing()
{
	shots_unlocked[SHOTS.purple] = 1;
	//set_shots(SHOTS.purple);
	
	//show controls
	var _x = display_get_gui_width()/2;
	var _y = 70;
	with(instance_create_depth(_x,_y,0,obj_text_fade))
	{
		is_gui = 1;
		text = "switch guns with Cntrl"
		time = room_speed*4;
		o_width = 0;
		font = font_continue
		halign = fa_center;
		other.controls_text = self;
	}
}

function set_shots(index)
{
	//abort if the shots are not unlocked
	if(!shots_unlocked[index]) 
		return;
	
	//set the shots
	current_shots = index;
	
	switch(index)
	{
		case SHOTS.white:
			shoot_sfx			= sfx_shoot;
			global.hitmark_sfx	= sfx_hitmark;
			shot_sprite			= spr_shot;
			shot_die_sprite		= spr_shot_die;
			shot_cd_max			= 13;				//delay between shots
			dmg					= 2.5;
		break;
		
		//////////
		
		case SHOTS.red:
			dmg					= 3.75;	//*= 1.5
			shot_cd_max			= 9;	//*= 0.8
			shot_sprite			= spr_shot_2;
			shot_die_sprite		= spr_shot_die_2;
			shoot_sfx			= sfx_shoot_2;
			global.hitmark_sfx	= sfx_hitmark_2;
		break;
		
		//////////////
		
		case SHOTS.purple:
			dmg						= 3.3;
			shot_cd_max				= 13;
			shot_sprite				= spr_shot_3;
			shoot_sfx				= sfx_shoot_3;
			shot_die_sprite			= spr_shot_die_3;
			global.hitmark_sfx		= sfx_hitmark_3;
		break;
	}
}

// bars events
function bar_hp()
{
	hp = min(hp_max,hp+1);
	//play hp up sfx
}
function bar_empty()
{
	//play progress sfx
}
function bar_level3()
{
	//vfx
	var _vfx = create_effect(spr_lvlup,4,0,x,y);
	_vfx.anchor_obj = self;
	flash_a = 1.2;
	
	//set new ship sprite
	
	//upgrade
	hp_max += 3;
	obj_ui.play_bars_anim(); 
	sprite_index = spr_spaceship_2;
	body_sprite = spr_spaceship_2_dead;
	level++;
	
	//reset bars
	list_bars[|3] = 0;
	list_bars[|4] = 0;
	list_bars[|5] = 0;
	list_bars_events[|3] = bar_hp;
	list_bars_events[|4] = bar_hp;
	list_bars_events[|5] = bar_hp;
	
	//set new level max
	list_bar_max[|3] = 100;
	list_bar_max[|4] = 100;
	list_bar_max[|5] = 100;
}
function bar_level2()
{
	//play lvlup sfx
	play_sfx(sfx_lvlup);
	
	//vfx
	var _vfx = create_effect(spr_lvlup,4,0,x,y);
	_vfx.anchor_obj = self;
	flash_a = 1.2;
	
	//upgrade
	shots_unlocked[SHOTS.red] = 1;
	set_shots(SHOTS.red);
	level++;
	
	//make the camera zoom out
	obj_camera.min_zoom_def += 0.2;
	
	//set new event
	list_bars_events[|5] = bar_level3;
	
	//reset bars
	list_bars[|3] = 0;
	list_bars[|4] = 0;
	list_bars[|5] = 0;
	
	//set new level max
	list_bar_max[|3] = 300;
	list_bar_max[|4] = 300;
	list_bar_max[|5] = 300;
}
function bar_level1()
{
	//play lvlup sfx
	boost_sfx = sfx_boost_2;
	play_sfx(sfx_lvlup);
	
	//vfx
	var _vfx = create_effect(spr_lvlup,8,0,x,y);
	_vfx.anchor_obj = self;
	_vfx.depth = DEPTH.effect_high;
	air_wave();
	flash_a = 1.2;
	
	//make the camera zoom out
	obj_camera.min_zoom_def += 0.4;
	
	//upgrade
	spd_boost *= 1.1;
	boost_initial = 0.9;
	boost_sprite = spr_boost_2;
	boost_lvlup_a = 1;
	boost_initial_vfx = spr_boost_initial_p1;
	boost_ys = 1;
	level++;
	
	//set new event
	list_bars_events[|5] = bar_level2;
	
	//reset bars
	list_bars[|3] = 0;
	list_bars[|4] = 0;
	list_bars[|5] = 0;
	
	//set new level max
	list_bar_max[|3] = 200;
	list_bar_max[|4] = 200;
	list_bar_max[|5] = 200;
}
function bar_level0()
{
	sprite_index = spr_spaceship;
	level = 1;
	can_turn = 1;
	flash_a = 1.5;
	
	list_bar_max[|0] = 100;
	list_bar_max[|1] = 100;
	list_bar_max[|2] = 100;
	list_bar_max[|3] = 150;
	list_bar_max[|4] = 150;
	list_bar_max[|5] = 150;

	list_bars[|0] = list_bar_max[|0];
	list_bars[|1] = list_bar_max[|1];
	list_bars[|2] = list_bar_max[|2];
	list_bars[|3] = 0;
	list_bars[|4] = 0;
	list_bars[|5] = 0;
	
	//set new event
	list_bars_events[|5] = bar_level1;
}
setup_tutorial = function()
{
	level = 0;
	sprite_index = spr_spaceship_0;
	can_turn = 0;
	
	for(var i=0; i < 6; i++)
		list_bar_max[|i] = 10;
		
	list_bars[|0] = 10;
	list_bars[|1] = 10;
	list_bars[|2] = 10;
	list_bars[|3] = 0;
	list_bars[|4] = 0;
	list_bars[|5] = 0;
	
	//set new event
	list_bars_events[|5] = bar_level0;
}

function air_wave()
{
	//push meteors away
	with(obj_meteor)
	{
		var _dir = point_direction(other.x,other.y, x,y)
		var _force = 15*(max(0,5000-distance_to_object(other))/5000);
		momx += lengthdir_x(_force,_dir);
		momy += lengthdir_y(_force,_dir);
	}
}
//set basic bar events
list_bars_events[|0] = bar_hp;
list_bars_events[|1] = bar_hp;
list_bars_events[|2] = bar_hp;
list_bars_events[|3] = bar_empty;
list_bars_events[|4] = bar_empty;
list_bars_events[|5] = bar_level1;

list_bar_max[|0] = 100;
list_bar_max[|1] = 100;
list_bar_max[|2] = 100;
list_bar_max[|3] = 150;
list_bar_max[|4] = 150;
list_bar_max[|5] = 150;

list_bars[|0] = list_bar_max[|0];
list_bars[|1] = list_bar_max[|1];
list_bars[|2] = list_bar_max[|2];
list_bars[|3] = 0;
list_bars[|4] = 0;
list_bars[|5] = 0;

with(obj_ui)
{
	list_bars = other.list_bars;
	list_bar_max = other.list_bar_max;
}