//vars
var _xmid = display_get_gui_width()/2;
//var _ymid = display_get_gui_height()/2;
var _yfull = display_get_gui_height();

//black overlay
draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(0,0, _xmid*2,_yfull,0);

//menu options
var _str = "";
var _ystart = _yfull*0.4;
draw_set_all(font_menu,fa_center,fa_middle,c_white,1);

for(var i=0; i <  ds_list_size(menu_current); i++)
{
	_str = menu_current[|i][0];
	if(pointer == i)
		_str = "> " + _str + " <";
	
	draw_text(_xmid,_ystart + i*(5 + string_height(_str)) + (i==pointer)*(wave_ui(-wave_height,wave_height,1.5,0)),_str);
}	
draw_reset();


