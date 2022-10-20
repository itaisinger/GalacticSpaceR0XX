//vars
var _xmid = camera_get_view_width(view_get_camera(view_current))/2;
var _ymid = camera_get_view_height(view_get_camera(view_current))/2;
var _yfull = camera_get_view_height(view_get_camera(view_current));

//planet
draw_sprite_ext(sprite_index,image_index,_xmid,_ymid*0.6,2,2,0,c_white,0.9);

//title
draw_set_all(font_title,fa_center,fa_middle,c_white,1);
draw_text(_xmid,_ymid*1.1,string_title);


//menu options
var _str = "";
var _ystart = ((_yfull/3)*2) * 0.95;
draw_set_font(font_menu);

for(var i=0; i <  ds_list_size(menu_current); i++)
{
	_str = menu_current[|i][0];
	if(pointer == i)
		_str = "> " + _str + " <";
		
	draw_text(_xmid,_ystart + i*(5 + string_height(_str)) + (i==pointer)*(wave_ui(-wave_height,wave_height,1.5,0)),_str);
}	
draw_reset();

draw_set_all(font_small,fa_left,fa_bottom,c_white,1);
draw_text(5,_yfull-5,"version: " + string(global.version));

#region leaderboards

if(menu_current == menu_leaderboards)
{
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	//draw_set_font(font_menu)
	var _str = LLHighscoresTopFormatted();
	
	draw_leaderboard(_xmid*1.4	,_ymid*0.8,1,"Highscores Top"		,LLHighscoresTopRankList(),LLHighscoresTopNamesList(),LLHighscoresTopScoreList());
	draw_leaderboard(_xmid*0.24	,_ymid*0.8,1,"Highscores Centered"	,LLHighscoresCenteredRankList(),LLHighscoresCenteredNamesList(),LLHighscoresCenteredScoreList());
	
	//draw_text(_xmid*1.45,		_ymid*0.8, string("Highscores Top\n") + string(LLHighscoresTopFormatted()));
	//draw_text(_xmid/4,			_ymid*0.8, string("Highscores Centered\n") + string(LLHighscoresCenteredFormatted()));
}

#endregion


