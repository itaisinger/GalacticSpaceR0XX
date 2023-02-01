//macros
#macro OUTLINE_W 2
#macro MAX_ENEMY_NUM 12
#macro DIRECTORY "spacegame"

//globals
global.focus_inst = noone;
global.lerp_spd = 0.2;
global.file_name = "";
global.version = 1.02;

//show_debug_overlay(1);

//create general instances
randomise();
instance_create_depth(0,0,0,obj_mouse);
instance_create_depth(20,70,0,obj_spawnlists_manager);

//set the directory
if(!directory_exists(DIRECTORY))
{
	//copy base path
	var _dir = working_directory;
	
	//remove last slash
	_dir = string_copy(_dir,1,string_length(_dir)-1);
	
	//exit out of the folder
	while(string_char_at(_dir,string_length(_dir)) != "\\")
	{
		_dir = string_copy(_dir,1,string_length(_dir)-1);
	}
	
	directory_create(DIRECTORY);
	//working_directory = DIRECTORY;
	
	var _file = file_text_open_write(DIRECTORY + "\\test.text");
	file_text_write_string(_file,"hi");
	file_text_close(_file);
}

//enums
enum DEPTH{
	button		= 10,
	spawnlist	= 50,
	catcher		= 60,	
	
	taskbar_table	= 0,
	taskbar			= -10,
	spawnlist_drag	= -20,
	dropdown		= -20,
}

//functions
load_default = function()
{
	//open file dialogue
	global.file_name = "default2.spnst";
	
	//load with the spawnlists manager
	obj_spawnlists_manager.load();
}
load = function(){
	//open file dialogue
	global.file_name = get_open_filename("spawnset|*.spnst", "");
	
	obj_spawnlists_manager.load();
	//load with the spawnlists manager
}
save = function(){
	
	//save as if not working on an existing file
	if(global.file_name == "" or global.file_name = "default2.spnst")
	{
		save_as();
		return;
	}
	
	/// save the file
	
	//open the file
	var _file = file_text_open_write(global.file_name);//get_save_filename("spawnset|*.spnst", "")
	
	//create the map
	var _map = ds_map_create();
	_map[?"0"] = obj_spawnlists_manager.extract_spawnset_array();
	
	//convert to string and write
	var _string = json_encode(_map)
	file_text_write_string(_file,_string);
	
	//destroy the map
	ds_map_destroy(_map);
	
	//close the file
	file_text_close(_file);
	
	show_debug_message("saved file " + global.file_name);
}
save_as = function(){
	global.file_name = get_save_filename("spawnset|*.spnst", "");
	
	if(global.file_name != "")
		save();
}