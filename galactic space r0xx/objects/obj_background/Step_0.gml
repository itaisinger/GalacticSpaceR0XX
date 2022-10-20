/// @description seeds mainly

var _x = obj_camera.x, _y = obj_camera.y;
var _ox = _x - _x%BGW, _oy = _y - _y%BGH;
_ox /= BGW;
_oy /= BGH;
var _cs = 0;

//check wether the player is in the same tile as before
if(coords_prev[0] != _ox or coords_prev[1] != _oy or !setup_phase_over)
{
	//recalculate seeds
	for(var i=0; i < xamount*2; i++)
	{
		for(var j=0; j < yamount*2; j++)
		{
			//seed generator
			_cs = 1.11 * seed*(1 + (3*_ox+i) + (3*_oy+j));
			if(_cs < 0)	_cs = -_cs * 1.111;
			
			//assign seed into the current grid
			current_seeds[i][j] = _cs;
			
			//show_debug_message("digit count of " + string(_cs) + ":\n" + string(digit_count_str(_cs)) + ", " + string(digit_count(_cs)))
		}
	}
	
	first_seeds_created = 1;
}

coords_prev = [_ox,_oy];