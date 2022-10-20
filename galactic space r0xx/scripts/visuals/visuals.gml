// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_effect(spr,scale,angle,xx,yy){
	var inst = instance_create_depth(x,y,depth,obj_vfx)
	with(inst)
	{
		sprite_index = spr;
		
		if(!is_undefined(scale))
		{
			image_xscale = scale;
			image_yscale = scale;
		}
		
		if(!is_undefined(angle))
			image_angle = angle;
			
		if(!is_undefined(xx))
			x = xx;
			
		if(!is_undefined(yy))
			y = yy;
	}
	
	return inst;
}
function create_after_image(alpha,xscale)
{
	var _inst = instance_create_depth(x,y,depth,obj_after_image)
	with(_inst)
	{
		sprite_index	= other.sprite_index;
		image_index		= other.image_index;
		image_speed		= 0;
		image_xscale	= xscale;
		image_alpha		= alpha;
	}
	
	return _inst;
}
function draw_text_outlined(x, y, outline_color, color, str, width, xscale, yscale)  
{
	
if(is_undefined(xscale)) xscale = 1;
if(is_undefined(yscale)) yscale = 1;

var xx,yy;  
xx = argument[0];  
yy = argument[1];  
  
//outline  
draw_set_color(argument[2]);  


draw_text_transformed(xx+width, yy+width,	argument[4],	xscale,	yscale, 0);  
draw_text_transformed(xx-width, yy-width,	argument[4],	xscale,	yscale, 0);  
draw_text_transformed(xx,		yy+width,	argument[4],	xscale,	yscale, 0);  
draw_text_transformed(xx+width, yy,			argument[4],	xscale,	yscale, 0);  
draw_text_transformed(xx,		yy-width,	argument[4],	xscale,	yscale, 0);  
draw_text_transformed(xx-width, yy,			argument[4],	xscale,	yscale, 0);  
draw_text_transformed(xx-width, yy+width,	argument[4],	xscale,	yscale, 0);  
draw_text_transformed(xx+width, yy-width,	argument[4],	xscale,	yscale, 0);  

//Text
draw_set_color(argument[3]);  
draw_text_transformed(xx, yy, argument[4], xscale, yscale, 0);

}
function create_text(xx,yy,str,col,o_col,o_widthh)
{
	var _t = instance_create_depth(xx,yy,0,obj_text);
	
	with(_t)
	{
		text = str;
		color = col;
		o_color = o_col;
		o_width = o_widthh;
	}
	
	return _t;
}
function draw_set_all(font,halign,valign,color,alpha)
{
	draw_set_font(font);
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_color(color);
	draw_set_alpha(alpha);
}
function draw_reset()
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_set_alpha(1);
}