/// @description shoot

if(state == STATES.shoot)
{
	alarm[0] = shot_cd_max;
	if(random(10) < 3) alarm[0] *= 0.5;
	
	shoot();
}
else
	alarm[0] = -1;