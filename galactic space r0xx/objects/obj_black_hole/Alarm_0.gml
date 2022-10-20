/// @description spawn space dust
var _num = space_dust_num;
var _dis = max_space_dust_dis;
for(var i=0; i < _num; i++)
{
	var _dir = (360/_num)*i;
	var _x = x + lengthdir_x(_dis,_dir);
	var _y = y + lengthdir_y(_dis,_dir);
	
	var _inst = instance_create_depth(_x,_y,50,obj_space_dust);
	_inst.direction = _dir + 90;
}
alarm[0] = 80;