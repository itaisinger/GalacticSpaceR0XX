if(is_gui) exit;

draw_set_font(font)
draw_set_alpha(image_alpha);
draw_set_halign(halign);
draw_set_valign(valign);

draw_text_outlined(x,y,o_color,color,text,o_width,image_xscale,image_yscale);

draw_reset();