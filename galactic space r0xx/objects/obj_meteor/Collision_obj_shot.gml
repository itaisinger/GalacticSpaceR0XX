/// @description Insert description here
// You can write your code in this editor
hp -= other.damage;
other.hit = 1;
play_sfx(global.hitmark_sfx,0,0);
instance_destroy(other);