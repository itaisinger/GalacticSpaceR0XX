if(!save) exit;

save = 0;
screen_save(working_directory + "screenshots\\" + "screenshot " + string(count++) + ".png")
//var _spr = sprite_create_from_surface(application_surface,0,0,display_get_gui_width(),display_get_gui_height(),0,0,0,0);
//sprite_save(_spr,0,working_directory + "screenshots\\" + "screenshot " + string(count++) + ".png");
//sprite_delete(_spr);