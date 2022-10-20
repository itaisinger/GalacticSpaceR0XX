draw_self();

//boost
draw_sprite_ext(spr_rocket_boost,irandom(3),x,y,boost_xs,boost_ys,image_angle,c_white,boost_a);

//laser
if(chase and random(10) > 6-boost_ys*2.5)
{
	draw_set_color(merge_color(c_red,c_black,0.4 - boost_ys));
	draw_set_alpha(0.6 + boost_ys);
	draw_line(x+lengthdir_x(128*image_yscale,direction),y+lengthdir_y(128*image_yscale,direction),
			global.player_inst.x,global.player_inst.y)
	
	draw_reset();
}