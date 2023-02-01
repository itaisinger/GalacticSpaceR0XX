//draw some leftmost part you can pull maybe?

//draw outline
draw_set_color(merge_color(current_color,c_black,0.5));
draw_rectangle(x-outline_w,y-outline_w, x+sprite_width+outline_w,y+sprite_height+outline_w,0);

//draw button background
draw_set_color(current_color);
draw_rectangle(x,y, x+sprite_width,y+sprite_height,0);
