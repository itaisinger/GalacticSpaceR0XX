/// @description Insert description here
// You can write your code in this editor
iframes_alpha = !iframes_alpha;
alarm[1] = iframes_flicker_speed


//stop flickering
if(iframes <= 0)
{
	iframes_alpha = 1;
	alarm[1] = -1;
}