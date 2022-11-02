//get gui size
_res = [display_get_gui_width(),display_get_gui_height()];

//initiate bars lists
if(list_bars == -1)
{
	if(!instance_exists(obj_player)) exit;
	else
	{
		list_bars = obj_player.list_bars;
		list_bar_max = obj_player.list_bar_max;
		list_flash_a[|ds_list_size(list_bars)] = 0;
	}
}

switch(state)
{
	#region natural
	case UI_STATES.natural:

	//draw score
	draw_set_all(font_score,fa_center,fa_top,c_white,1);
	var _ocol = make_color_rgb(20,20,30);
	if(global.double_score) draw_set_color(global.orange_col);

	var _y = 5;
	draw_text_outlined(_res[0]/2,_y,_ocol,draw_get_color(),global.score,1,1,1);

	//draw time
	_y += string_height("98") - 2;
	draw_set_all(font_timer,fa_center,fa_top,c_white,1);
	var _x = _res[0]/2;// - string_width("45:54")/2;
	var _sec = obj_game.game_time[1] < 10 ? "0" + string(obj_game.game_time[1]) : string(obj_game.game_time[1]);
	var _min = obj_game.game_time[2] < 10 ? "0" + string(obj_game.game_time[2]) : string(obj_game.game_time[2]);
	draw_text(_x,_y,_min + ":" + _sec);
	draw_text_outlined(_x,_y,_ocol,draw_get_color(),_min + ":" + _sec,1,1,1);
	
	/// bars ///
	var _max = ds_list_size(global.player_inst.list_bars)
	var _s		= 0.5;
	var _w		= _s*sprite_get_width(spr_hp);
	var _y		= _res[1] - 10;
	var _xx		= (_res[0] - (_max*_w) - bars_gap)/2;

	//hp
	var _remain = global.player_inst.hp;
	var _maxhp	= global.player_inst.hp_max;
	_xx += _w/2;
	draw_set_all(font_bars,fa_center,fa_bottom,c_white,1);

	for(var i=0; i < _maxhp; i++)
	{
		//bar
		draw_sprite_ext(spr_hp,0 + 1*(_remain<=i),_xx,_y,_s,_s,0,c_white,1);
	
		//progress
		if(_remain == i)
		{
			var _prec = list_bars[|i]/list_bar_max[|i];
			var _width = _prec*_s*62;
			draw_sprite_ext(spr_bar_progress,0,_xx - _w/2,_y,_width,_s,0,c_white,1);
		}
		draw_sprite_ext(spr_hp,2,_xx,_y,_s,_s,0,c_white,list_flash_a[|i]);		//flash
		_xx += _w;
	
		//text progress
		draw_text(_xx - _w,_y+2,string(list_bars[|i]));
	
		//exeption for the level 3 bars animation
		if(i == 2)
			_xx += bars_gap;
	}

	var _num = _max - global.player_inst.hp_max;
	var _level = global.player_inst.level;
	for(var i=_maxhp; i < _maxhp+_num; i++)
	{
		var _prec = list_bars[|i]/list_bar_max[|i];
	
		//empty bars
		draw_sprite_ext(spr_bar,0 + _level*(_prec == 1),_xx,_y,_s,_s,0,c_white,1);
	
		//progress
		if(_prec > 0 and _prec < 1)
		{
			var _width = _prec*_s*62;
			draw_sprite_ext(spr_bar_progress,_level,_xx - _w/2 + 0.5,_y,_width,_s,0,c_white,1);
		}
	
		//text progress
		draw_set_color(c_white);
		draw_text(_xx,_y+2,string(list_bars[|i]));	//its not _xx-_w here bc the xx is incremented at the end of this loop so its offseted at the start of the loop
	
		//flash
		draw_sprite_ext(spr_hp,2,_xx,_y,_s,_s,0,c_white,list_flash_a[|i]);
		_xx += _w;
	}
	
	break;
	#endregion
	/////////////
	#region death
	case UI_STATES.death:

	//draw black death overlay
	draw_set_color(c_black);
	draw_set_alpha(arr_curves[UI_ELEM.overlay])
	draw_rectangle(0,0,_res[0],_res[1],0);

	//draw score
	draw_set_all(font_score,fa_center,fa_top,c_white,1);
	var _ocol = make_color_rgb(20,20,30);
	if(global.double_score) draw_set_color(global.orange_col);

	var _y = 5 + arr_curves[UI_ELEM.scor] * _res[1]*0.5;
	draw_text_outlined(_res[0]/2,_y,_ocol,draw_get_color(),global.score,1,1,1);

	//draw time
	_y += string_height("98") - 2;
	draw_set_all(font_timer,fa_center,fa_top,c_white,1);
	var _x = _res[0]/2;// - string_width("45:54")/2;
	var _sec = obj_game.game_time[1] < 10 ? "0" + string(obj_game.game_time[1]) : string(obj_game.game_time[1]);
	var _min = obj_game.game_time[2] < 10 ? "0" + string(obj_game.game_time[2]) : string(obj_game.game_time[2]);
	draw_text(_x,_y,_min + ":" + _sec);
	draw_text_outlined(_x,_y,_ocol,draw_get_color(),_min + ":" + _sec,1,1,1);

	//continute
	draw_set_all(font_continue,fa_center,fa_top,c_white,arr_curves[UI_ELEM.continu])
	_y = _res[1]*0.6 + 3;
	draw_text(_res[0]/2,_y,"press space to continue");

	//high score
	if(high_score)
	{
		//high score text
		draw_set_all(font_score,fa_center,fa_top,c_white,arr_curves[UI_ELEM.highscore]);
		//_y = _res[1]*0.38;
		_y = _res[1]*0.27;
		draw_text(_res[0]/2,_y,"NEW HIGH SCORE!");
		_y += string_height("HI") + 2;
	}

	//upload to leaderboards text
	if(instance_exists(obj_upload_score))
	{
		draw_set_all(font_continue,fa_center,fa_top,c_white,arr_curves[UI_ELEM.name]);
	
		//enter your name
		//_y = _res[1]*0.3;
		var _text = "enter your name and press enter:";
		draw_text(_x,_y,_text);
	
		//name
		draw_set_halign(fa_left)
		_text = obj_upload_score.player_name;
		_y += string_height("hi") + 2;
		_x = _res[0]/2 - string_width(_text)/2;
		if(typer_a) _text += "|";
		draw_text(_x,_y,_text);
	}
	
	
	/// bars ///
	var _max = ds_list_size(global.player_inst.list_bars)
	var _s		= 0.5;
	var _w		= _s*sprite_get_width(spr_hp);
	var _y		= _res[1] - 10 + 20 * arr_curves[UI_ELEM.bars];
	var _xx		= (_res[0] - (_max*_w) - bars_gap)/2;

	//hp
	var _remain = global.player_inst.hp;
	var _maxhp	= global.player_inst.hp_max;
	_xx += _w/2;
	draw_set_all(font_bars,fa_center,fa_bottom,c_white,1);

	for(var i=0; i < _maxhp; i++)
	{
		//bar
		draw_sprite_ext(spr_hp,0 + 1*(_remain<=i),_xx,_y,_s,_s,0,c_white,1);
	
		//progress
		if(_remain == i)
		{
			var _prec = list_bars[|i]/list_bar_max[|i];
			var _width = _prec*_s*62;
			draw_sprite_ext(spr_bar_progress,0,_xx - _w/2,_y,_width,_s,0,c_white,1);
		}
		draw_sprite_ext(spr_hp,2,_xx,_y,_s,_s,0,c_white,list_flash_a[|i]);		//flash
		_xx += _w;
	
		//text progress
		draw_text(_xx - _w,_y+2,string(list_bars[|i]));
	
		//exeption for the level 3 bars animation
		if(i == 2)
			_xx += bars_gap;
	}

	var _num = _max - global.player_inst.hp_max;
	var _level = global.player_inst.level;
	for(var i=_maxhp; i < _maxhp+_num; i++)
	{
		var _prec = list_bars[|i]/list_bar_max[|i];
	
		//empty bars
		draw_sprite_ext(spr_bar,0 + _level*(_prec == 1),_xx,_y,_s,_s,0,c_white,1);
	
		//progress
		if(_prec > 0 and _prec < 1)
		{
			var _width = _prec*_s*62;
			draw_sprite_ext(spr_bar_progress,_level,_xx - _w/2 + 0.5,_y,_width,_s,0,c_white,1);
		}
	
		//text progress
		draw_set_color(c_white);
		draw_text(_xx,_y+2,string(list_bars[|i]));	//its not _xx-_w here bc the xx is incremented at the end of this loop so its offseted at the start of the loop
	
		//flash
		draw_sprite_ext(spr_hp,2,_xx,_y,_s,_s,0,c_white,list_flash_a[|i]);
		_xx += _w;
	}

	break;
	#endregion
	/////////////
	#region tutorial
	
	case UI_STATES.tutorial:
	
	//draw score
	draw_set_all(font_score,fa_center,fa_top,c_white,1);
	var _ocol = make_color_rgb(20,20,30);
	if(global.double_score) draw_set_color(global.orange_col);

	var _y = 5 - 40*(1-arr_curves[1]);
	draw_text_outlined(_res[0]/2,_y,_ocol,draw_get_color(),global.score,1,1,1);

	//draw time
	_y += string_height("98") - 2;
	draw_set_all(font_timer,fa_center,fa_top,c_white,1);
	var _x = _res[0]/2;// - string_width("45:54")/2;
	var _sec = obj_game.game_time[1] < 10 ? "0" + string(obj_game.game_time[1]) : string(obj_game.game_time[1]);
	var _min = obj_game.game_time[2] < 10 ? "0" + string(obj_game.game_time[2]) : string(obj_game.game_time[2]);
	draw_text(_x,_y,_min + ":" + _sec);
	draw_text_outlined(_x,_y,_ocol,draw_get_color(),_min + ":" + _sec,1,1,1);
	
	/// bars ///
	var _max = ds_list_size(global.player_inst.list_bars)
	var _s		= 0.5;
	var _w		= _s*sprite_get_width(spr_hp);
	var _y		= lerp(_res[1]/2-3,_res[1] - 10,arr_curves[1]);
	var _gap	= lerp(bars_gap*1.2,bars_gap,arr_curves[1])
	var _xx		= (_res[0] - (_max*_w) - _gap)/2;
	
	//hp
	var _remain = global.player_inst.hp;
	var _maxhp	= global.player_inst.hp_max;
	_xx += _w/2;
	draw_set_all(font_bars,fa_center,fa_bottom,c_white,1);

	for(var i=0; i < _maxhp; i++)
	{
		//bar
		draw_sprite_ext(spr_hp,0 + 1*(_remain<=i),_xx,_y,_s,_s,0,c_white,1);
	
		//progress
		if(_remain == i)
		{
			var _prec = list_bars[|i]/list_bar_max[|i];
			var _width = _prec*_s*62;
			draw_sprite_ext(spr_bar_progress,0,_xx - _w/2,_y,_width,_s,0,c_white,1);
		}
		draw_sprite_ext(spr_hp,2,_xx,_y,_s,_s,0,c_white,list_flash_a[|i]);		//flash
		_xx += _w;
	
		//text progress
		draw_text(_xx - _w,_y+2,string(list_bars[|i]));
	
		//exeption for the level 3 bars animation
		if(i == 2)
			_xx += _gap;
	}

	var _num = _max - global.player_inst.hp_max;
	var _level = 1//global.player_inst.level;
	for(var i=_maxhp; i < _maxhp+_num; i++)
	{
		var _prec = list_bars[|i]/list_bar_max[|i];
		
		//empty bars
		draw_sprite_ext(spr_bar,0 + _level*(_prec == 1),_xx,_y,_s,_s,0,c_white,1);
	
		//progress
		if(_prec > 0 and _prec < 1)
		{
			var _width = _prec*_s*62;
			draw_sprite_ext(spr_bar_progress,_level,_xx - _w/2 + 0.5,_y,_width,_s,0,c_white,1);
		}
	
		//text progress
		draw_set_color(c_white);
		draw_text(_xx,_y+2,string(list_bars[|i]));	//its not _xx-_w here bc the xx is incremented at the end of this loop so its offseted at the start of the loop
	
		//flash
		draw_sprite_ext(spr_hp,2,_xx,_y,_s,_s,0,c_white,list_flash_a[|i]);
		_xx += _w;
	}
	break;
	#endregion
}



//draw effect
with(my_effect)
{
	image_alpha = 1;
	draw_self();
	image_alpha = 0;
}
with(my_effect2)
{
	image_alpha = 1;
	draw_self();
	image_alpha = 0;
}