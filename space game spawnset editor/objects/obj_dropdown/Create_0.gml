/*/
a dropdown menu is essentialy a list of buttons that appear and then disappear.
a drop down is created using a function dropdown_menu(), and is given an array for the buttons, like so:
[
buttons width
buttons height
[
button content (text\icon)
button function
]
]

buttons functions are usually somthing like
function(){
	parent.return_value = 3;
}

dropdown function are usually kind of the same. the button that created it would give it a reference to itself,
and the dropdown will change its parent button content or smt like that. 
its function will have to consider the possiblility that the return value wasnt changed.
/*/

arr_buttons = [];
return_value = "";
my_function = -1;
parent = noone;

depth = DEPTH.dropdown; 
image_alpha = 0.1;
width = 30;
height = 20;
margin = 3;
outline_w = 3;
fix_bbox = 1;

function done(value)
{
	//destroy buttons
	for(var i=0; i < array_length(arr_buttons); i++)
	{
		instance_destroy(arr_buttons[i]);
	}
	
	//run function
	return_value = value;
	my_function();	
	
	//die
	instance_destroy();
}

