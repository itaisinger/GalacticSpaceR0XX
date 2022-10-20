#macro DEFAULT_SPAWNSET "default.spnst"
#macro COSTUME_SPAWNSET working_directory + "costume.space"

function save_gamefile()
{
	//update data
	global.map_file[? "music"] = global.music_volume
	global.map_file[? "sfx"]	= global.sfx_volume	
	global.map_file[? "score"]	= global.high_score	
	
	//delete previous file
	file_delete(FILE_NAME);
	
	//create and open a new file
	var _file = file_text_open_write(FILE_NAME);
	
	//encode the current map
	var _string = json_encode(global.map_file);
	
	//write it in
	file_text_write_string(_file,_string)
	
	//close the file
	file_text_close(_file);
}
function load_gamefile()
{
	//destroy the previous map
	ds_map_destroy(global.map_file)
	
	//open and read the file
	var _file = file_text_open_read(FILE_NAME);
	var _string = file_text_read_string(_file)
	
	//load the map from the string
	global.map_file = json_decode(_string);
	
	//close the file
	file_text_close(_file);
	
	//update data
	global.music_volume = global.map_file[? "music"];
	global.sfx_volume	= global.map_file[? "sfx"];
	global.high_score	= global.map_file[? "score"];
}
function spawnset_save(spawnset,file_path)
{
	//create a map and write it to a string
	var _map = ds_map_create();
	_map[? "0"] = spawnset;
	var _string = json_encode(_map);
	ds_map_destroy(_map);
	
	//delete the file if one exists
	if(file_exists(file_path))
		file_delete(file_path);
	
	//create and write to the new file
	var _file = file_text_open_write(file_path);
	file_text_write_string(_file,_string);
	file_text_close(_file);

	show_debug_message("saved spawnset to " + file_path);
}
function spawnset_load(file_path)
{
	//abort if file doesn't exists
	if(!file_exists(file_path))
	{
		show_message("File " + file_path + " does not exists.\nLoading default spawnset.");
		var _arr = spawnset_load(DEFAULT_SPAWNSET);
		return _arr;
	}
	
	//read file to string
	var _file = file_text_open_read(file_path);
	var _string = file_text_read_string(_file);
	file_text_close(_file);
	
	//extract array 
	var _map = json_decode(_string);
	var _list = _map[? "0"];	
	
	//for some reason the ds gets out as a list and not as an array, so it must be converted.
	var _arr = list_to_array(_list)
	ds_list_destroy(_list);
	ds_map_destroy(_map);
	return _arr
}



















