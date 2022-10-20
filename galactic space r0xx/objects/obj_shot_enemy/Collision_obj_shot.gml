/// @description Insert description here
// You can write your code in this editor
exit;
if(hp <= 0)
{
	hit = 1;
	other.hit = 1;
	instance_destroy(other);
	instance_destroy();
}
else hp--;