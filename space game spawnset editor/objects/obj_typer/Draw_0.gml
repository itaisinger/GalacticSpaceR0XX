//handle final text
var _input = string(my_input);

//add pointer
if(pointer_a and state == TYPER_STATES.typing)
	_input += "|";
	
if(string_width(_input) > max_input_width)
{
	while(string_width(".." + _input) > max_input_width)
		_input = string_copy(_input,2,string_length(_input))
	
	_input = ".." + _input;
}

var _final_string = string_replace(text,"<",_input);

//x += margin;
//y += margin;

draw_set_font(font);

//draw outline
draw_set_color(merge_color(current_col,c_black,0.5));
draw_rectangle(x-outline_w,y-outline_w, x+sprite_width+outline_w,y+sprite_height+outline_w,0);

//draw button background
draw_set_color(current_col);
draw_rectangle(x,y, x+sprite_width,y+sprite_height,0);

//draw input field
draw_set_color(field_col);
draw_rectangle(x+margin/2+string_width(string_copy(text,1,string_pos("<",text)-1)),y+margin-1, x+sprite_width-margin,y+sprite_height-margin+1,0)

//draw text
draw_set_color(c_white);
draw_text(x+margin,y+margin,_final_string);

//x -= margin;
//y -= margin;