#region background

var _bg_s = 1;
var _x = obj_camera.xdest, _y = obj_camera.ydest;
var _ox = _x - _x%(BGW)*_bg_s, _oy = _y - _y%(BGH)*_bg_s;

for(var i=-amounts[0][0]; i < amounts[0][1]; i++)
{
	for(var j=1-amounts[1][0]; j < amounts[1][1]; j++)
	{
		//draw the background sprite
		draw_sprite_ext(sprite_index,image_index,_ox + i*(BGW)*_bg_s,_oy + j*(BGH)*_bg_s,	_bg_s,_bg_s,0,c_white,1);
		
		//planets
		if(setup_phase_over and first_seeds_created)
		{
			//draw_planets(_ox + i*(BGW)*_bg_s,_oy + j*(BGH)*_bg_s, current_seeds[i + xamount/2][j + yamount/2]);
		}
	}
}

#endregion
#region planets

//loop through current_seeds and use each of them to draw planets
//in the corresponding background tile   

#endregion