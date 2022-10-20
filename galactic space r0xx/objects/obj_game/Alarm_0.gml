/// @description increment score
if(global.player_inst.state == STATES.dead) exit;

global.score += 5;
alarm[0] = score_timer;

if(global.double_score) alarm[0] *= 0.5;