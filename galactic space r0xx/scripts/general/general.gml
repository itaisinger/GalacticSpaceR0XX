function get_digit_at(num,pos)
{
	//returns the digit at the desired place in the number
}
function digit_count_str(num)
{
	//return how many digits relying on string convertor.
	//count up until 7
	return string_length(string(num));
}
function digit_count(num)
{
	//return how many digits a number has
	var _cnt = 0;
	var _temp = num;
	
	//count digits above 0.1
	while(_temp > 1)
	{
		_cnt++;
		_temp /= 10;
	}
	
	//count digits bellow 0.1
	_temp = num;
	while(_temp != floor(_temp))
	{
		_cnt++;
		_temp *= 10;
	}
	
	return _cnt;
}
function text_effect(xx,yy,_text,_font)
{
	var _i = instance_create_depth(xx,yy,depth,obj_text)
	
	_i.text = _text;
	
	if(_font != undefined)
		_i.font = _font;
	return _i;
}
function play_sfx(_sfx,_prio,_loop)
{
	if(room == rm_main and global.player_inst.state == STATES.dead)
		audio_sound_pitch(_sfx,0.6);
	
	//loop
	var _l = 0;
	if(!is_undefined(_loop))
		_l = _loop;
	
	//priority
	var _p = 0;
	if(!is_undefined(_prio))
		_p = _prio;
	
	//play
	var _o_gain = audio_sound_get_gain(_sfx);
	var _s = audio_play_sound(_sfx,_p,_l);
	audio_sound_gain(_s,_o_gain*global.sfx_volume,0);	
	
	if(audio_get_name(_sfx) == "sfx_boost")
		show_debug_message("playing " + audio_get_name(_sfx))
		
	return _s;
}
function list_to_array(list)
{
	var _length = ds_list_size(list);
	var arr = [];
	
	for(var i=0; i < _length; i++)
	{
		if(ds_list_is_list(list,i))
			arr[i] = list_to_array(list[|i])
		else
			arr[i] = list[|i];
	}
	
	
	
	return arr;
}