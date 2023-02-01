
//visuals
msg = "";
font = font_button;

depth = DEPTH.button;
text_col	= c_white;
text_disabled_col = make_color_rgb(180,180,180);

normal_col	= make_color_rgb(40,40,45);
hover_col	= make_color_rgb(100,100,105);
press_col	= make_color_rgb(30,30,35);
disabled_col= make_color_rgb(55,55,55);

current_col = normal_col;
current_text_col = text_col;
halign = fa_left;
valign = fa_top;

outline_w = OUTLINE_W;
margin = 5;

//logic
active = 1;
parent = noone;
state = 0;
state_functions = [];

my_function = function(){show_message("hi")};

is_hold = 0;	//if true, when pressing instantly transition to hold, and execute the function every frame.
leave_hold_function = function(){};
fix_bbox_must = 1;

enum BUTTON_STATES{
	natural,	//natural states. transitions to hover on hover.
	hover,		//transition to natural when cursor leaves or to down on press.
	down,		//when mouse released, trans to natural if cursor is not on me, otherwise execute function and then natural.
	disabled,	//cant reach on my own. set from outside to make me stuck. uninteractable.
	hold,		//needs to set is_hold to true. stay down for as long as pressing the mouse and execute the function every frame.
}

state_functions[BUTTON_STATES.natural] = function()
{
	current_col = normal_col;
	current_text_col = text_col;
	
	//do nothing if some other button is in focus
	if(global.focus_inst != noone) 
	{
		msg = "focus";
		return;
	}
	
	//edge cases to victory
	if(instance_exists(obj_dropdown) and parent == noone)
	{
		msg = "drop";
		return;
	}
	
	//detect hover
	if(active and place_meeting(x,y,obj_mouse))
	{
		global.focus_inst = id;
		state = BUTTON_STATES.hover;
	}
}
state_functions[BUTTON_STATES.hover] = function()
{
	current_col = hover_col;
	current_text_col = text_col;
	
	//detect unhover
	if(!place_meeting(x,y,obj_mouse))
	{
		global.focus_inst = noone;
		state = BUTTON_STATES.natural;
	}
	
	//press
	if(mouse_check_button_pressed(mb_left))
	{
		state = BUTTON_STATES.down;
		
		if(is_hold)
			state = BUTTON_STATES.hold;
	}
}
state_functions[BUTTON_STATES.down] = function()
{
	current_col = press_col;
	current_text_col = text_col;

	//end press
	if(!mouse_check_button(mb_left))
	{
		global.focus_inst = noone;
		state = BUTTON_STATES.natural;
		
		//execute
		if(place_meeting(x,y,obj_mouse))
		{
			my_function();
		}
	}
}
state_functions[BUTTON_STATES.disabled] = function()
{
	current_col = disabled_col;
	current_text_col = text_disabled_col;
}
state_functions[BUTTON_STATES.hold]		= function()
{
	//color
	current_col = press_col;
	current_text_col = text_col;
	
	//function
	my_function();
	
	//leave state
	if(!mouse_check_button(mb_left))
	{
		leave_hold_function();
		global.focus_inst = noone;
		state = BUTTON_STATES.natural;
	}
}

set_size = function(width,height)
{
	fix_bbox_must = 0;
	fix_bbox = 0;
	
	sprite_index = spr_pixel;

	image_xscale = width;
	image_yscale = height;
}