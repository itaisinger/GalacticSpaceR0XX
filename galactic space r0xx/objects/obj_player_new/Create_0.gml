/// @description Insert description here
// You can write your code in this editor
turn = 0;

//visuals/drawing
yoffset = 0.5;
height = 2;
image_xscale = 5;
image_yscale = 6;
boost_ys = 1;
boost_a  = 1;
angle = 0;
angle_max = 20;
uni_angle = shader_get_uniform(sh_tilt,"angle");
iframes_alpha = 1;
iframes_flicker_speed = 5;

//movement
spd_current = 0;	//the speed at which we are currently turning
spd_natural = 6;	//max natural turning speed 
spd_boost = 20;		//max boosting turning speed
spd_shoot = 2;		//max shooting turning speed
spd_accel = 0.3;	

turn_current = 0;	//the speed (including direction) we are currently turning at
turn_max = 1;		//the current max speed we are able to (naturally) turn at
turn_lerp = 0.1;	//lerp value towards new angle dest
turn_natural = 5;	//max turn speed in natural state
turn_shoot = 1;		//max turn speed when shooting
turn_boost = 1;		//max turn speed when boosting
max_turning_spd = 8;//turning speed hard clamp
angle_dest = 0;		//angle current aiming to point at

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
key_shoot   = 0;
key_boost   = 0;	//unrelevent
key_up		= 0;
key_down	= 0;
key_left	= 0;
key_right	= 0;

input_dir	= 2;
input_buffer = 5;

enum DIR{
	right,
	right_up,
	up,
	left_up,
	left,
	left_down,
	down,
	right_down,
}


//gameplay
iframes = 0;
iframes_max = 60;
hp = 3;	
dmg = 5;			//shots damage
dmg_collide = 20;	//damage given to meteors on collision

//logic
state = 0;
state_changed = 0;
state_prev = state;

enum STATESS{
	natural,
	shoot,
	boost,
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
		boost_a = 0.9;
		boost_ys = 1.2;
		boost_cd = boost_cd_max;
		
		//speed += spd_boost;
		xmom += lengthdir_x(spd_boost,direction);
		ymom += lengthdir_y(spd_boost,direction);
	}

	//transition
	if(!key_boost)// or key_right or key_left)
		state = STATES.natural;
	if(key_shoot_pressed)
		state = STATES.shoot;
}
arr_states_functions[STATES.shoot] = function()
{
	spd_current = spd_shoot;
	turn_max	= turn_shoot;
	
	if(state_changed)
	{
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
	var _shot = instance_create_depth(x,y,depth,obj_shot);
	_shot.image_angle	= image_angle;
	_shot.direction		= direction;
	_shot.image_xscale	= image_xscale;
	_shot.image_yscale	= image_yscale;
	_shot.speed			= shot_spd;
	_shot.damage = dmg;
	
	//yoff: roll an image index, shoot from bottom or top blasters. if rolled top, give it a yoff.
	_shot.image_index = (++flicker)%2;
	if(_shot.image_index)
	{
		_shot.y -= image_number*(height+yoffset);
	}
	
	//play sfx
	
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
	
	//play sfx
	
	hp--;
	iframes = iframes_max;
	iframes_alpha = 0;
	alarm[1] = iframes_flicker_speed;
	
	if(hp <= 0)
		die();
}
function die()
{
	//stop hurt sfx and play sfx
}


