//x += margin;
//y += margin;

draw_set_font(font);

//draw outline
draw_set_color(merge_color(current_col,c_black,0.5));
draw_rectangle(x-outline_w,y-outline_w, x+sprite_width+outline_w,y+sprite_height+outline_w,0);

//draw button background
draw_set_color(current_col);
draw_rectangle(x,y, x+sprite_width,y+sprite_height,0);

//draw text
draw_set_color(current_text_col);
draw_text_scribble(x+margin,y+margin,text);

//x -= margin;
//y -= margin;