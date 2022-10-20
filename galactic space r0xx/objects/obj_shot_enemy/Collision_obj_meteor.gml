if(!active) exit;

other.hp -= damage;

//if(other.hp <= 0)
//	other.no_reward = 1;
	
hit = 1;
play_sfx(global.hitmark_sfx,0,0);
instance_destroy();