parent.hp -= other.damage;
other.hit = 1;
play_sfx(global.hitmark_sfx,0,0);
instance_destroy(other);