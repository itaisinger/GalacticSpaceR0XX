
//visuals
font = font_button;
pointer_a = 0;
alarm[0] = 60;

text_col	= c_white;
normal_col	= make_color_rgb(40,40,45);
hover_col	= make_color_rgb(100,100,105);
press_col	= make_color_rgb(30,30,35);
type_col	= make_color_rgb(60,60,65);
field_col	= make_color_rgb(20,20,25);

current_col = normal_col;
halign = fa_left;
valign = fa_top;

outline_w = 2;
margin = 5;
max_input_display = 4;
depth = DEPTH.button;

draw_set_font(font);
max_input_width = string_width("GGGG");

//logic
state = 0;
state_functions = [];
my_input = ""
parent = noone;
enum TYPER_STATES{
	natural,
	hover,
	down,
	typing,
}

state_functions[TYPER_STATES.natural] = function()
{
	current_col = normal_col;
	
	//do nothing if some other button is in focus
	if(global.focus_inst != noone) 
		return;
	
	//edge cases to victory
	if(instance_exists(obj_dropdown) and parent == noone)
		return;
		
	//detect hover
	if(place_meeting(x,y,obj_mouse))
	{
		global.focus_inst = id;
		state = TYPER_STATES.hover;
	}
}
state_functions[TYPER_STATES.hover]	  = function()
{
	current_col = hover_col;
		
	//detect unhover
	if(!place_meeting(x,y,obj_mouse))
	{
		global.focus_inst = noone;
		state = TYPER_STATES.natural;
	}
	
	//press
	if(mouse_check_button(mb_left))
	{
		state = TYPER_STATES.down;
	}
}
state_functions[TYPER_STATES.down]    = function()
{
	current_col = press_col;

	//end press
	if(!mouse_check_button(mb_left))
	{		
		//start typing
		if(place_meeting(x,y,obj_mouse))
		{
			state = TYPER_STATES.typing;
			keyboard_string = string(my_input);
		}
		//abort
		else
		{
			global.focus_inst = noone;
			state = TYPER_STATES.natural;
		}
	}
}
state_functions[TYPER_STATES.typing]  = function()
{
	current_col = type_col;
	
	if(accept_letters and accept_numbers)
		my_input = string_lettersdigits(keyboard_string);
	else if(accept_letters)
		my_input = string_letters(keyboard_string);
	else if(accept_numbers)
		my_input = string_digits(keyboard_string);
	
	
	
	if(keyboard_check_pressed(vk_enter) or mouse_check_button(mb_left))
	{
		state = TYPER_STATES.natural;
		global.focus_inst = noone;
	}
}

function set_size_typer(width,height,input_l,input_w)
{
	fix_bbox_must = 0;
	fix_bbox = 0;
	
	sprite_index = spr_pixel;

	image_xscale = width;
	image_yscale = height;
	
	max_input_display = input_l;
	max_input_width   = input_w;
}