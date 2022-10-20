event_inherited();

//stop boost sound
audio_stop_sound(my_boost_sfx);
audio_stop_sound(my_beep_sfx);

//manage extra vfx
var _vfx2 = create_effect(spr_rocket_explosion);
_vfx2.image_angle = random(360);
_vfx2.image_xscale = 3*image_xscale*destroy_vfx_size;
_vfx2.image_yscale = 3*image_yscale*destroy_vfx_size;
_vfx2.image_speed *= 0.7;
_vfx2.depth = _vfx.depth-2;