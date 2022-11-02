if(!is_gui) exit;

draw_set_font(font)
draw_set_alpha(image_alpha);
draw_set_halign(halign);
draw_set_valign(valign);
draw_set_color(color);

draw_text_scribble(x,y,text);

draw_reset();