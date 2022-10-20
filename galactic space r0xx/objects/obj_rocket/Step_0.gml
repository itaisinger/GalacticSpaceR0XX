//pause
if(global.game_paused)
{
	speed = 0;
	exit;
}
else speed = spd;

if(hp <= 0) instance_destroy();

var _xdest = global.player_inst.x;
var _ydest = global.player_inst.y;
_dir_dest = point_direction(x,y, _xdest,_ydest);

//determine direction
var _diff_r = 0, _diff_l = 0, _diff;
var _ar = direction, _al = direction;
var _jump = 5;

//check right
while(abs(_al - _dir_dest) > _jump+1)
{
	_al += _jump;
	_diff_l += _jump;
	
	if(_al > 360) _al -= 360;
}
//check left
while(abs(_ar - _dir_dest) > _jump+1)
{
	_ar -= _jump;
	_diff_r += _jump;
	
	if(_ar < 0)
		_ar += 360;
}

if(_diff_l < _diff_r)
{
	dir = 1;
	_diff = _diff_l;
}
else
{
	dir = -1;
	_diff = _diff_r;
}


if(mouse_check_button_pressed(mb_left))
	active = !active;

//act out
if(chase)
{
	xmom += lengthdir_x(chase_spd,direction);
	ymom += lengthdir_y(chase_spd,direction);
	
	direction += chase_turn*dir;
	turn_current = approach(turn_current,0,chase_turn);
	
	//trans to turn
	if(_diff > degrees_margin)
	{
		chase = 0;
	}
}
else
{
	xmom = approach(xmom,0,fric);
	ymom = approach(ymom,0,fric);
	
	turn_current += turn_turn*dir
	
	//trans to chase
	if(_diff < degrees_margin)
	{
		chase = 1;
		turn_current = lerp(turn_current,0,0.8);
		xmom = lerp(xmom,0,0.7);
		ymom = lerp(ymom,0,0.7);
	}
}


//attract to black hole
var _hole = instance_find(obj_black_hole,0);
if(_hole != noone)
{
	_force = 0.4*(max(0,_hole.pull_dis-distance_to_object(_hole))/_hole.pull_dis);
	_force *= _hole.pull_force_mult;
	var _dir = point_direction(x,y, _hole.x,_hole.y);
	
	//direction = approach(direction,_dir,_force*2);
	direction -= sign(angle_difference(direction,_dir))*_force*2;
	
	momx += lengthdir_x(_force*0.2,_dir);
	momy += lengthdir_y(_force*0.2,_dir);
}


direction += turn_current
x += xmom;
y += ymom;

//visuals
boost_a = approach(boost_a,chase,0.1);
audio_sound_gain(bip_sfx,boost_a*audio_sound_get_gain(sfx_rocket_bip),0);
boost_ys = max(1,2*(abs(xmom) + abs(ymom))/30);
boost_xs = max(1,1.5*(abs(xmom) + abs(ymom))/30);
image_angle = direction - 90;

