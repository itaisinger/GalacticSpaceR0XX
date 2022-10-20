if(state == TRANS_STATES.active)
{
	if(!update_sprite and room != room_dest)
		room_goto(room_dest);
		
	trans_prec = approach(trans_prec,1,0.013 * (1+1*(room == rm_menu)));
	trans_prec = lerp(trans_prec,1,0.001);
	
	if(trans_prec == 1)
	{
		//sprite_delete(trans_spr);
		state = 0;
		draw_set_circle_precision(26);
	}
}
draw_reset();