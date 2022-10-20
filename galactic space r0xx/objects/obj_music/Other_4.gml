audio_stop_all();
//audio_stop_sound(ost_game);
//audio_stop_sound(ost_menu);
//audio_stop_sound(ost_pause);

menu_sound = audio_play_sound(ost_menu,999,1);
game_sound = audio_play_sound(ost_game,999,1);
pause_sound = audio_play_sound(ost_pause,999,1);

audio_sound_gain(menu_sound,global.music_volume,0);
audio_sound_gain(game_sound,0,0);
audio_sound_gain(pause_sound,0,0);