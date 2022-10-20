// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function set_meteor_data(tier){
	hp	= obj_game.meteors_hp[tier];
	size = obj_game.meteors_size[tier];
	spin = obj_game.meteors_spin[tier] * random_range(0.2,2);
	speed = obj_game.meteors_spd[tier] * random_range(0.2,1.5);
}