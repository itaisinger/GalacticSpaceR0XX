alarm[0] = 30;
if(instance_number(obj_obama) > 3) exit;

for(var i=0; i < 10; i++)
	with(instance_create_depth(x,y,depth,obj_obama_dust))
		direction = (360/10)*i;
		
