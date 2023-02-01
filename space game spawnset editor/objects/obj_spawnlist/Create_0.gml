/*/
this object will be the main list the fills the screen.

an instance of this will hold a few other elements, to display the data.
an object of this will also hold an array of the data that is relevent to it.

this object stores the spawnlist data in an unfriendly way to the one it will eventually need to output to the file.
the conversion will take place in the file save function.

elements list:
list index: uninteractable text element
name:		interactable typer element displaying the name of the list, accept digits and letters.
duration:	interactable typer element displaying the duration of the list in seconds. accepts digits.
[
enemy type:		interactable enemy icon. when pressed opens a dropdown menu of the enemy types.
spawn cooldown:	interactable typer element displaying the difference between spawns. accepts digits.
repeat times:	interactable typer element.
spawns num:		interactable spawn elements
]
10 icon buttons showing the sprites of the enemies.

ugh, its lame.
every frame the actual imoprtant data in arr_spawns sucks the data out of the literal ui elements,
and when a enemy switch accours (other enemy button is pressed), the ui elements suck the data out of the other array.
the data needs to be sucked out of the current ui elements when exporting.

this object needs some function that makes it wrapp up all of its weird data in one big array and give it to some1 else.
that function also needs to int64() all the strings.

make the enemy icon also suck data by giving it a vara called enemy_index and make it update it after pressing the dropdown menu.
now make sure switching enemies works as intended.

make it disable the first other button at the start
/*/

enum SPAWNLIST_DATA{
	name,
	duration,
	spawns,
}
enum SPAWNS_DATA{
	type,
	cooldown,
	seconds,
	repeats,
	num,
}
enum METEORS{
	none,
	small,
	mid,
	large,
	fast,
	fast2,
	rocket,
	pickup,
	metal,
	metal_large,
	tie,
	hole,
	obama,
}
enum SPAWNLIST_STATES{
	natural,
	hover,
	drag,
}
enum SPAWNLIST_ELEM{
	drag,		//0
	index,		//1
	name,		//2
	duration,	//3
	type,		//4
	cooldown,	//5
	seconds,	//6
	repeats,	//7
	num,		//8
	others,		//9
}
index	 = 0;
name	 = "";
if(irandom(10) == 5)
	name = choose("james","jacob","jack","juliah","jayden","julian","joshua","jordan","josh","jermy","jeffery","jennice","jayce","jonathan","jolyn","jake","jumbo","dubu");
duration = 20;

cooldown = 1;
repeats	 = -1;
spawn_num = 1;

for(var i=0; i < MAX_ENEMY_NUM; i++)
{
	arr_spawns[i] = [METEORS.none,20,1,-1,1];
}

//visuals
height = 40		//including margins
//my_width = 0;	//the actual spawnlist element width
outline_w = OUTLINE_W;
margin = 6;
font = font_button;

text_col	= c_white;
normal_col	= make_color_rgb(40,40,45);
hover_col	= make_color_rgb(100,100,105);
//drag_col	= make_color_rgb(30,30,35);

current_color = normal_col;
halign = fa_left;
valign = fa_top;

depth = DEPTH.spawnlist;

//logic
state = 0;
current_spawn = 0;
arr_states_functions = [];
arr_elements = [];

xdest = xstart;	//obj_program sets these according to a list of all the spawnlists.
ydest = ystart;
lerp_spd = global.lerp_spd;


//functions
function set_size_spawnlist(_width,_height)
{	
	sprite_index = spr_pixel;

	image_xscale = _width;
	image_yscale = _height;
}
function switch_enemy(index)
{	
	//here is the line for flexing. undisable the last other button.
	arr_elements[SPAWNLIST_ELEM.others][current_spawn].state = BUTTON_STATES.natural;
	
	//re set the new data array
	var _arr = arr_spawns[index];
	current_spawn = index;
	
	//type
	arr_elements[SPAWNLIST_ELEM.type].text = "[spr_enemy_icons," + string(_arr[SPAWNS_DATA.type]) + "]";
	arr_elements[SPAWNLIST_ELEM.type].enemy_index = _arr[SPAWNS_DATA.type];
	
	//cooldown
	arr_elements[SPAWNLIST_ELEM.cooldown].my_input = string(_arr[SPAWNS_DATA.cooldown]);
	
	//seconds or frames
	if(arr_elements[SPAWNLIST_ELEM.seconds].is_seconds != _arr[SPAWNS_DATA.seconds])
		arr_elements[SPAWNLIST_ELEM.seconds].my_function();
	
	//repeats
	arr_elements[SPAWNLIST_ELEM.repeats].my_input = string(_arr[SPAWNS_DATA.repeats]);
	
	//num
	arr_elements[SPAWNLIST_ELEM.num].my_input = string(_arr[SPAWNS_DATA.num]);
	
	//undisable the previous "other" button by looping through them all.
		//not effective but safe.
	//for(var i=0; i < MAX_ENEMY_NUM; i++)
	//{
		//buttons_other[i].state = BUTTON_STATES.natural;
	//}

	
	//disable the corresponding "other" button
	arr_elements[SPAWNLIST_ELEM.others][index].state = BUTTON_STATES.disabled;
}
function drop()
{
	//drop a spawnlist on the screen. if its place meeting a catcher, insert it in the corresponding place in the list.
	
	//change position
	var _place = instance_place(x,y,obj_catcher)
	if(_place != noone and _place.y > obj_spawnlists_manager.taskbar_bottom)
	{
		obj_spawnlists_manager.change_pos(index,_place.index);
		return;
	}
	
	//drop on a button
	var _place = instance_place(x,y,obj_drop)
	if(_place != noone)
	{
		switch(_place.index)
		{
			//destroy
			case DROP.trash:
				obj_spawnlists_manager.remove(index);
			break;
			
			//duplicate
			case DROP.duplicate:
				obj_spawnlists_manager.duplicate(index);
			break;
		}
		return;
	}
}
function extract_spawnlist_array()
{
	//send an array that holds all of the data properly.
	var _arr;
	
	//name and duration
	_arr[SPAWNLIST_DATA.name]		= arr_elements[SPAWNLIST_ELEM.name].my_input;
	_arr[SPAWNLIST_DATA.duration]	= int64(arr_elements[SPAWNLIST_ELEM.duration].my_input);
	
	//loop through all the spawns.
	for(var i=0; i < array_length(arr_spawns); i++)
		_arr[SPAWNLIST_DATA.spawns + i]	= array_to_int(arr_spawns[i]);
	
	//return the final array
	return _arr;
}
function import_spawnlist_array(arr)
{
	//import an array that holds all of the data properly.
	
	arr_elements[SPAWNLIST_ELEM.name].my_input		= arr[SPAWNLIST_DATA.name];
	arr_elements[SPAWNLIST_ELEM.duration].my_input	= string(arr[SPAWNLIST_DATA.duration]);
	
	//loop through all the spawns and insert them into arr_spawns
	for(var i=0; i < MAX_ENEMY_NUM; i++)
	{
		arr_spawns[i] = arr[SPAWNLIST_DATA.spawns+i];//[SPAWNLIST_DATA.spawns];
	}
	
	//choose enemy 0 to reset button contents
	switch_enemy(0);
}

//states functions
arr_states_functions[SPAWNLIST_STATES.natural]	= function()
{
	//move to my point
	x = lerp(x,xdest,lerp_spd);
	y = lerp(y,ydest,lerp_spd);
	
	depth = DEPTH.spawnlist;
	//color
	//current_color = normal_col;
	
	////transition to hover
	//if(place_meeting(x,y,obj_mouse))
	//	state = SPAWNLIST_STATES.hover;
}
arr_states_functions[SPAWNLIST_STATES.hover]	= function()
{
	//move to my point
	x = lerp(x,xdest,lerp_spd);
	y = lerp(y,ydest,lerp_spd);
	
	depth = DEPTH.spawnlist;
	
	//color
	//current_color = hover_col;
	
	////transition to natural
	//if(!place_meeting(x,y,obj_mouse))
	//	state = SPAWNLIST_STATES.natural;
		
	////transition to drag
	//if(mouse_check_button(mb_left))
	//	state = SPAWNLIST_STATES.drag;
}
arr_states_functions[SPAWNLIST_STATES.drag]		= function()
{	
	//color
	//current_color = drag_col;
	
	//turn up alpha of the place catchers thingies
	
	//drop where im at
	depth = DEPTH.spawnlist_drag;
	global.focus_inst = id;
	
	with(obj_catcher)
		alpha_dest = 0.2;
		
	with(obj_drop)
		alpha_dest = 0.2;
		
	var _place = instance_place(x,y,obj_catcher)
	with(_place)
		alpha_dest = 0.7;
		
	var _place = instance_place(x,y,obj_drop)
	with(_place)
		alpha_dest = 0.7;
}

/// create elements intances ///

//drag
var xx = x+margin;
arr_elements[SPAWNLIST_ELEM.drag] = instance_create_depth(xx,y+margin,0,obj_button)
with(arr_elements[SPAWNLIST_ELEM.drag])
{	
	text = "[spr_drag]";
	outline_w = 0;
	
	my_function = function(){
		parent.x += obj_mouse.x-obj_mouse.xprevious;
		parent.y += obj_mouse.y-obj_mouse.yprevious;
		parent.state = SPAWNLIST_STATES.drag;
	}
	
	leave_hold_function = function(){
		parent.state = SPAWNLIST_STATES.natural;
		parent.drop();
	}
	
	is_hold = 1;
	parent = other;
	
	margin = 0;
	set_size(21,30);
}
xx += 30;

//index
arr_elements[SPAWNLIST_ELEM.index] = instance_create_depth(xx,y+margin,0,obj_button)
with(arr_elements[SPAWNLIST_ELEM.index])
{
	text = other.index;
	outline_w = 0;
	state = BUTTON_STATES.disabled;
	
	disabled_col = normal_col;
	
	set_size(20,30);
}
xx += 30;

//name
arr_elements[SPAWNLIST_ELEM.name] = instance_create_depth(xx,y+margin,0,obj_typer)
with(arr_elements[SPAWNLIST_ELEM.name])
{
	text = "name: <";
	my_input = other.name;
	
	set_size_typer(170,28,30,110);
}
xx += 180;

//duration
arr_elements[SPAWNLIST_ELEM.duration] = instance_create_depth(xx,y+margin,0,obj_typer)
with(arr_elements[SPAWNLIST_ELEM.duration])
{
	text = "duration: <";
	my_input = other.duration;
	
	set_size_typer(110,28,3,30);
	accept_letters = 0;
}
xx += 120;

//enemy icon
arr_elements[SPAWNLIST_ELEM.type] = instance_create_depth(xx,y+margin,0,obj_button)
with(arr_elements[SPAWNLIST_ELEM.type])
{
	text = "[spr_enemy_icons,"+string(METEORS.none)+"]";
	enemy_index = 0
	
	//function, switch enemy type
	my_function = function()
	{
		//create the function for the dropdown buttons
		function _func(){
			if(return_value != "")
			{
				parent.text = "[spr_enemy_icons,"+string(return_value)+"]";
				parent.enemy_index = return_value;
			}
			//else 
			//	parent.enemy_index = "0";
		}
		
		//create the drop down options
		var _arr_options = [];
		for(var i=0; i < 13; i++)
		{
			_arr_options[i] = ["[spr_enemy_icons,"+string(i)+"]",i];
		}
		
		//create the menu
		var _inst = dropdown_menu(x,y+sprite_height+margin,60,30,_func,_arr_options);
		_inst.parent = id;
	}
	
	set_size(other.height - other.margin*2,28);
}
xx += height;

//cooldown
arr_elements[SPAWNLIST_ELEM.cooldown] = instance_create_depth(xx,y+margin,0,obj_typer)
with(arr_elements[SPAWNLIST_ELEM.cooldown])
{
	text = "cooldown: <";
	my_input = other.duration;
	
	set_size_typer(110,28,3,30);
	accept_letters = 0;
}
xx += 110;

//seconds\frames
arr_elements[SPAWNLIST_ELEM.seconds] = instance_create_depth(xx,y+margin,0,obj_button)
with(arr_elements[SPAWNLIST_ELEM.seconds])
{
	text = "seconds";
	is_seconds = 1;
	set_size(60,28);
	
	my_function = function()
	{
		is_seconds = !is_seconds;
		
		if(is_seconds)
			text = "seconds";
		else
			text = "frames";
	}
}
xx += 70;

//reapeats
arr_elements[SPAWNLIST_ELEM.repeats] = instance_create_depth(xx,y+margin,0,obj_typer)
with(arr_elements[SPAWNLIST_ELEM.repeats])
{
	text = "repeats: <";
	my_input = other.repeats;
	
	set_size_typer(110,28,3,30);
	accept_letters = 0;
}
xx += 120;

//num
arr_elements[SPAWNLIST_ELEM.num] = instance_create_depth(xx,y+margin,0,obj_typer)
with(arr_elements[SPAWNLIST_ELEM.num])
{
	text = "spawn num: <";
	my_input = other.spawn_num;
	
	set_size_typer(130,28,3,30);
	accept_letters = 0;
}
xx += 150;


//xx = x+margin;

//other enemies icons
var _arr_others;
for(var i=0; i < MAX_ENEMY_NUM; i++)
{
	//enemy icon
	_arr_others[i] = instance_create_depth(xx,y+margin,0,obj_button)
	with(_arr_others[i])
	{
		xoff = x - other.x; 

		text = "[spr_icon,0]";
		index = i;
		my_parent = other;
		my_function = function(){
			my_parent.switch_enemy(index);
		}
		
		set_size(other.height - other.margin*2,28);
	}
	xx += height;
}
_arr_others[0].state = BUTTON_STATES.disabled;
arr_elements[SPAWNLIST_ELEM.others] = _arr_others;

var _total_width = xx-x;
set_size_spawnlist(_total_width,height);

//give all the elements the xoff so thell be able to adjust later.
//the others buttons were given it when they were created.
for(var i=0; i < array_length(arr_elements)-1; i++)
{
	with(arr_elements[i]) xoff = x - other.x;
}



