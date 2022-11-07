if(!is_gui) exit;

draw_set_font(font)
var _h = string_height(text)+o_width*2;
var _w = string_width(text)+o_width*2;
if(!surface_exists(sur))
	sur = surface_create(_w,_h)


draw_set_halign(fa_left);
draw_set_valign(fa_top);
surface_set_target(sur);

//clear surface
draw_clear_alpha(c_white,0);

//draw text
draw_text_outlined(o_width,o_width,o_color,color,text,o_width,1,1)

surface_reset_target();

draw_surface_ext(sur,x-_w/2,y-_h*image_yscale/2,size,size*image_yscale,0,c_white,1);