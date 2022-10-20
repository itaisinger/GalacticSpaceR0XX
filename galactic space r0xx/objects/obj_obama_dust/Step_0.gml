
//if destroy == true, fade out then destroy myself.
image_alpha = approach(image_alpha,!destroy,0.02);
if(image_alpha == 0 and destroy)
	instance_destroy();


var _hole = instance_find(obj_obama,0);

//abort if hole is empty
if(_hole == noone)
{
	destroy = 1;
	exit;
}

if(!destroy) destroy = global.obama_dust_destroy;


direction += turn_spd;