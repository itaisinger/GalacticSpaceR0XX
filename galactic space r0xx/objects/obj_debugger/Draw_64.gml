if(room == rm_menu) exit;

draw_set_all(font_small,fa_left,fa_top,c_white,1);

if(instance_exists(obj_ui))
draw_text(5,25,obj_ui.trans_prec);
