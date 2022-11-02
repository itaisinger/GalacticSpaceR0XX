
if(--time < 0)
{
	image_alpha = lerp(image_alpha,-0.05,0.05);
	
	if(image_alpha <= 0)
		instance_destroy();
}
else
{
	image_alpha = lerp(image_alpha,1.05,0.05);
}