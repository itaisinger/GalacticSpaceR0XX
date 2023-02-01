function dropdown_menu(_x,_y,_width,_height,func,data_arr)
{
	var _dir = 1;
	var _total_height = array_length(data_arr)*(_height+2*OUTLINE_W);
	if(_y + _total_height > room_height)
		_y -= _total_height;

		
	var _inst = instance_create_depth(_x,_y,0,obj_dropdown)
	with(_inst)
	{
		width = _width;
		height = _height;
		my_function = func;
		
		//create the buttons
		for(var i=0; i < array_length(data_arr); i++)
		{
			arr_buttons[i] = instance_create_depth(_x,_y + i*(_height+2*OUTLINE_W),0,obj_button)
			arr_buttons[i].text = data_arr[i][0];
			//arr_buttons[i].my_function = data_arr[i][1];
			arr_buttons[i].my_function = dropdown_button_function;
			arr_buttons[i].return_value = data_arr[i][1];
			arr_buttons[i].fix_bbox = 0;
			arr_buttons[i].parent = self;
			arr_buttons[i].set_size(_width,_height);
			arr_buttons[i].index = i;	//its here becuase its widely used and cant be put anywhere else.
		}
	}
	
	return _inst;
}
function dropdown_button_function()
{
	parent.return_value = return_value;
}
function spawnlist_create(_x,_y,data_arr)
{
	var _inst = instance_create_depth(_x,_y,0,obj_spawnlist);
	_inst.set_data(data_arr);
}
function list_to_array(list)
{
	var _length = ds_list_size(list);
	var arr = [];
	
	for(var i=0; i < _length; i++)
	{
		if(ds_list_is_list(list,i))
			arr[i] = list_to_array(list[|i])
		else
			arr[i] = list[|i];
	}
	
	
	
	return arr;
}
function array_to_int(arr)
{
	var _length = array_length(arr);
	var new_arr = [];
	
	for(var i=0; i < _length; i++)
	{
		if(is_array(arr[i]))
			arr[i] = array_to_int(arr[i])
		else
			new_arr[i] = int64(arr[i]);
	}

	return new_arr;
}
function approach(val,goal,spd){
	if(val > goal) return max(goal,val-spd);
	if(val < goal) return min(goal,val+spd);
	return goal;
}