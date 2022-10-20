state = 0;
trans_prec = 0;
update_sprite = 0;
trans_spr = -1;
room_dest = -1;
depth = DEPTH.trans;

enum TRANS_STATES{
	off,
	active,
}

sur = -1;
function transition(rm)
{
	draw_set_circle_precision(128);
	state = 1;
	trans_prec = 0;
	
	//if(surface_exists(sur))
	//	surface_free(sur);
	
	
	//surface_create(_res[0],_res[1]);
	//surface_copy(sur,0,0,application_surface);
	update_sprite = 1;
	room_dest = rm;
}