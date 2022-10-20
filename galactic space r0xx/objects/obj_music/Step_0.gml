//menu ost
audio_sound_gain(menu_sound,(room == rm_menu)*audio_sound_get_gain(ost_menu)*global.music_volume,0);

//game ost
audio_sound_gain(game_sound,
	(room == rm_main)*audio_sound_get_gain(ost_game)*global.music_volume*global.music_vol_mult*!global.game_paused,0);

//pause ost
audio_sound_gain(pause_sound,
	(room == rm_main)*audio_sound_get_gain(ost_pause)*global.music_volume*global.music_vol_mult*global.game_paused,0);

audio_sound_pitch(ost_game,1 - 0.3*(room == rm_main and instance_exists(obj_ui) and obj_ui.dead));