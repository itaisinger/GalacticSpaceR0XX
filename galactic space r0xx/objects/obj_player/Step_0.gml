if(global.game_paused) 
{
	exit;
}

//// state functions ////

arr_states_functions[state]();
state_changed = state != state_prev;
state_prev = state;

//// logic/gameplay vars ////
if(state == STATES.dead) exit;
iframes = approach(iframes,0,1);
boost_cd = approach(boost_cd,0,1);

//double score when at max hp
global.double_score = hp == 6;

//switch shots
if(keyboard_check_pressed(vk_control))
{
	play_sfx(sfx_shots_switch);
	
	//play sfx
	 if(current_shots == SHOTS.red)
		set_shots(SHOTS.purple);
else if(current_shots == SHOTS.purple)
		set_shots(SHOTS.red);
}

//// turn ////
var _turn = key_left - key_right;

//if just done boosting, boost turn spd
var _turn_speed = turn_accel;
if(state != STATES.boost and speed > spd_natural)
	_turn_speed *= 5;

if(_turn != 0)
	turn_current = lerp(turn_current,turn_max*sign(_turn),_turn_speed);
else
{
	turn_current = lerp(turn_current,0,turn_accel*1);
	turn_current = approach(turn_current,0,turn_accel*0.2);
}

var _angles_to_turn = turn_current * can_turn;

//recoil
if(shooting_this_frame) 
	_angles_to_turn *= 2 + choose(3,-3);
_angles_to_turn = clamp(_angles_to_turn,-max_turning_spd,max_turning_spd);

image_angle += _angles_to_turn;
direction = image_angle + 90;


//// visuals ////

boost_ys = lerp(boost_ys,0.9,0.06);
boost_a  = lerp(boost_a,state == STATES.boost,0.07);

//tilt for shader
angle = lerp(angle,angle_max*_turn,0.1);

boost_lvlup_a = approach(boost_lvlup_a,0,0.05);

flash_a = approach(flash_a,0,0.03);

//// movement ////


//basic movement
speed = approach(speed,spd_current,spd_accel*0.5);
speed = lerp(speed,spd_current,0.03);

//momentum
xmom = approach(xmom,0,fric + (fric)*(state == STATES.boost));
ymom = approach(ymom,0,fric + (fric)*(state == STATES.boost));

attract_to_hole();

xmom = clamp(xmom,-mom_max,mom_max);
ymom = clamp(ymom,-mom_max,mom_max);

x += xmom;
y += ymom;


//reset some vars
shooting_this_frame = 0;