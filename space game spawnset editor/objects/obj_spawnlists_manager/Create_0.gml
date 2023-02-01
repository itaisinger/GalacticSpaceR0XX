/*/
this object will handle everything that regards the main part of the screen - the spawnlists.
	- spawnlists list
	- spawnlists instances
	- drop catchers instances 
	- plus button
	- total spawnset time button
	
this object will also draw the black table over the top of the spawnlists and below the task bar
/*/

//visuals
depth = DEPTH.taskbar_table;
//positions
gap = 60;
taskbar_bottom = ystart;

list_spawnlists = ds_list_create();
list_catchers	= ds_list_create();

button_plus = instance_create_depth(xstart,ystart,depth,obj_button);
with(button_plus)
{
	text = "[spr_plus]";
	
	my_function = function(){
		parent.add_spawnlist();
	}
	parent = other.id;
	set_size(30,30);
}
button_dup = instance_create_depth(xstart-2,ystart-2,depth,obj_drop);
with(button_dup)
{
	depth = DEPTH.button-1;
	index = 1;
	alpha_dest = 0;
	alpha_def = 0;
	var _dest = 34;
	var _current = sprite_width;
	image_xscale = _dest/_current;
	image_yscale = image_xscale;
	parent = other.id;
}

button_time = instance_create_depth(450,30,depth,obj_button);
with(button_time)
{
	text = "total spawnset time: ";
	
	state = BUTTON_STATES.disabled;
	
	disabled_col = normal_col;
	outline_w = 0;
	
	depth = DEPTH.taskbar;
	parent = other.id;
	draw_set_font(font)
	set_size(155,30);
}
button_build = instance_create_depth(625,30,depth,obj_button);
with(button_build)
{
	text = "build: " + string(global.version);
	
	state = BUTTON_STATES.disabled;
	
	disabled_col = normal_col;
	outline_w = 0;
	
	depth = DEPTH.taskbar;
	parent = other.id;
	set_size(string_width(text)+10,30);
}

//create up and down buttons. make them disable when not in need.

//functions
function load()
{
	//create spawnlist instances according to a spawnset file
	
	//abort if not file chosen
	if(!file_exists(global.file_name))
	{
		show_message("no file selected or file doesn't exists.");
		return;
	}
	
	//open file
	var _file = file_text_open_read(global.file_name);
	
	//read string
	var _string = file_text_read_string(_file);
	
	//convert to map
	var _map = json_decode(_string);
	
	//extract the array
	var _arr = list_to_array(_map[?"0"])
	 
	//destroy spawnlists and catchers
	with(obj_spawnlist) instance_destroy();
	with(obj_catcher)	instance_destroy();
	
	ds_list_clear(list_spawnlists);
	ds_list_clear(list_catchers);
	
	//fill up
	var _length = array_length(_arr);
	for(var i=0; i < _length; i++)
	{
		//spawnlist
		var _spawnlist = instance_create_depth(0,0,0,obj_spawnlist);
		_spawnlist.import_spawnlist_array(_arr[i]);
		_spawnlist.index = i;
		ds_list_add(list_spawnlists,_spawnlist);
		
		//catcher
		var _catcher = instance_create_depth(0,0,0,obj_catcher);
		_catcher.index = i;
		ds_list_add(list_catchers,_catcher);
	}
	
	//last catcher
	var _catcher = instance_create_depth(0,0,0,obj_catcher);
	_catcher.index = _length;
	ds_list_add(list_catchers,_catcher);
		
	//finish here
	
	//destroy map and close file
	ds_map_destroy(_map);
	file_text_close(_file);
}
function extract_spawnset_array()
{
	//returns a complete array of the spawnset from all the spawnlist instances.
	/*/
	[
	/(index is skipped)
	name
	duration
	spawns list
	/*/
	
	var _full_arr = [];
	
	var _length = ds_list_size(list_spawnlists);
	for(var i=0; i < _length; i++)
	{
		_full_arr[i] = list_spawnlists[|i].extract_spawnlist_array();
	}
	
	return _full_arr;
}
function add_spawnlist()
{
	//add spawnlist
	ds_list_add(list_spawnlists,instance_create_depth(0,room_height+20,0,obj_spawnlist));
	list_spawnlists[|ds_list_size(list_spawnlists)-1].index = ds_list_size(list_spawnlists)-1
	
	//add catcher
	ds_list_add(list_catchers,instance_create_depth(0,room_height,0,obj_catcher));
	list_catchers[|ds_list_size(list_catchers)-1].index = ds_list_size(list_catchers)-1
	
	//return the spawnlist instance
	return list_spawnlists[|ds_list_size(list_spawnlists)-1];
}
function change_pos(index_from,index_to)
{
	//remove from previous position
	var _spawnlist = list_spawnlists[|index_from];
	
	//insert placeholder
	ds_list_set(list_spawnlists,index_from,-1);
	
	//insert in new position
	ds_list_insert(list_spawnlists,clamp(0,index_to,ds_list_size(list_spawnlists)),_spawnlist);
	
	//remove placeholder
	ds_list_delete(list_spawnlists,ds_list_find_index(list_spawnlists,-1));
	
	//set new indexes
	for(var i=0; i < ds_list_size(list_spawnlists); i++)
	{
		list_spawnlists[|i].index = i;
	}
}
function remove(index)
{
	//remove sp and catcher from list
	instance_destroy(list_spawnlists[|index]);
	instance_destroy(list_catchers[|index]);
	
	//destroy the instances
	ds_list_delete(list_spawnlists,index);
	ds_list_delete(list_catchers,index);
	
	//set new indexes
	for(var i=0; i < ds_list_size(list_spawnlists); i++)
	{
		list_spawnlists[|i].index = i;
	}
}
function duplicate(index)
{
	//duplicate a spawnlist
	
	//extract data array
	var _spawnlist_data = list_spawnlists[|index].extract_spawnlist_array();

	//create and add a new spawnlist
	var _inst = add_spawnlist();
	
	//import the array
	_inst.import_spawnlist_array(_spawnlist_data);
	
	//insert the new instance after the index
	change_pos(ds_list_size(list_spawnlists)-1,index+1);
}

//create blank spawnlists
for(var i=0; i < 10; i++)
{
	ds_list_add(list_spawnlists,instance_create_depth(0,0,0,obj_spawnlist));
	ds_list_add(list_catchers,instance_create_depth(0,0,0,obj_catcher));
	list_catchers[|i].index = i;
	list_spawnlists[|i].index = i;
}
ds_list_add(list_catchers,instance_create_depth(0,0,0,obj_catcher));
list_catchers[|ds_list_size(list_catchers)-1].index = ds_list_size(list_catchers)-1;

extract_spawnset_array();