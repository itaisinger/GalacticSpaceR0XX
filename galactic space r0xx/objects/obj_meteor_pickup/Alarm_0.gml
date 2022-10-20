///@desc create dust
alarm[0] = 10;

if(global.game_paused) exit;
var _e = create_effect(spr_present_trail,5,random(360));
_e.depth = DEPTH.effect_low;