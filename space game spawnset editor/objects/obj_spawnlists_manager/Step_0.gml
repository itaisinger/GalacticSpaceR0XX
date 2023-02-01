//move myself
var _yadd = mouse_wheel_up() - mouse_wheel_down();
//ystart = clamp(-taskbar_bottom,ystart+ _yadd * gap,99999);
ystart += _yadd * gap;

//set destenations of spawnlists
y = ystart;

var _length = ds_list_size(list_spawnlists);
var _sl_height = list_spawnlists[|0].height + 5;
var _sl_width  = list_spawnlists[|0].image_xscale-20;
for(var i=0; i < _length; i++)
{
	list_catchers[|i].xdest = x + 10;
	list_catchers[|i].ydest = y;
	list_catchers[|i].image_xscale = _sl_width;
	
	y += gap - _sl_height;
	
	list_spawnlists[|i].xdest = x;
	list_spawnlists[|i].ydest = y;
	
	y += _sl_height;
}
list_catchers[|_length].xdest = x + 10;
list_catchers[|_length].ydest = y;
list_catchers[|i].image_xscale = _sl_width;

y += gap/3;

//fixate plus button 
with(button_plus)
{
	y = lerp(y,other.y,global.lerp_spd);
}
with(button_dup)
{
	y = lerp(y,other.y-2,global.lerp_spd);
}

//clamp to not go too low
ystart = clamp(ystart,taskbar_bottom-(gap)*(_length-1),gap)

///total time
//every couple of frames recount the length of the entire spawnset
if(current_time%5 == 0)
{
	var _length = ds_list_size(list_spawnlists);
	var _total  = 0;
	
	//loop through spawnlists
	for(var i=0; i < _length; i++)
	{
		//add current spawnlist's duration to the time total
		_total += list_spawnlists[|i].duration; 
	}
	
	//insert into the button
	var _mins = string(floor(_total/60));
	var _secs = string(_total%60);
	button_time.text = "total time: " + _mins + "m, " + _secs + "s";
}





