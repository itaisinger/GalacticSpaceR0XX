ds_list_destroy(menu_main);
ds_list_destroy(menu_controls);
ds_list_destroy(menu_sounds);

save_gamefile();

global.game_paused = 0;