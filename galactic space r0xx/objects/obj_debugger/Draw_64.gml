if(room == rm_menu) exit;

draw_set_all(font_small,fa_left,fa_top,c_white,1);

if(instance_exists(obj_meteor_spawner) and is_array(obj_meteor_spawner.current_spawnset))
	draw_text(5,25,obj_meteor_spawner.current_spawnset[SPAWNLIST_DATA.name]);
