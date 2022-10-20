/// @description Insert description here
// You can write your code in this editor
_dir_dest = 0;
// Inherit the parent event
event_inherited();
active = 1;
chase = 0;
chase_spd = 0.4;
degrees_margin = 20;
chase_turn = 0.03;
turn_turn = 0.06;
fric = 0.18;
xmom = 0;
ymom = 0;
dir = 1;			//1 for going left (counterclockwise), -1 for right.
turn_current = 0;	//degrees to turn in this frame

//visuals
boost_a = 0;
boost_xs = 1;
boost_ys = 1;
destroy_vfx_size = 10;
depth = DEPTH.rocket;

//sfx
bip_sfx = play_sfx(sfx_rocket_bip,0,1);
audio_sound_gain(bip_sfx,0,0);

direction = point_direction(x,y, obj_player.x,obj_player.y)

/*/
the rocket has two states: chase and turn.
when the player is within 20 degrees of the rocket, the rocket is chasing 
with increasing speed and sound.
otherwise, slow down and turn at a higher speed.

