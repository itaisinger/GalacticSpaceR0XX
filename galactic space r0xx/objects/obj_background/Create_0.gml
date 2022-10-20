/// @description Insert description here
// You can write your code in this editor
depth = 100;
image_speed = 2;
xamount = 8;	//how many tiles to render
yamount = 8;

amounts = [[floor(xamount/2),ceil(xamount/2)],[floor(yamount/2),ceil(yamount/2)]];	//used to shortcut the for loops

setup_phase_over = 0;	//used to prevent drawing planets in the setup
first_seeds_created = 0;

//planets
randomise();
seed = random(100);
current_seeds[xamount][yamount] = 0;
coords_prev = [-2,-2];
list_planets = ds_list_create();
planets_sprites = [spr_planet1, spr_planet2, spr_planet3]

function draw_planets(xx,yy,seed)
{
	//this function recieves the x,y of the 0,0 of the background tile and a seed,
	//and it uses the seed to generate a few planets and draws them.
	
	/*/forumla by digit pos:
	0 - ceil(digit/3) is number of stars to draw (0-3)
	{
	1 - sprite index
	2 - size
	3 - x
	4 - y
	}
	loop last 3 for each star
	/*/
	
	//create a useable seed
	var _seedstr = string(seed);
	_seedstr = string_delete(_seedstr,string_last_pos(".",_seedstr),1);	//remove the dot
	_seedstr = _seedstr + _seedstr + _seedstr + _seedstr;
	
	var _pointer = 1;
	var _pmax = string_length(_seedstr);
	
	//calculate number of planets
	var _planets_num = ceil(int64(string_char_at(_seedstr,0) / 3));
	
	//loop through every planet
	for(var i=0; i < _planets_num; i++)
	{
		//giving defualt stats to use incase the seed runs out of digits
		var _pindex = 0, _size = 1, _x = 1, _y;
		
		//check if enough digits left
		if(_pointer + 3 <= _pmax)
		{
			//use seed
			_pindex = max(0,ceil(int64(string_char_at(_seedstr,_pointer) / 3)) - 1);
			
			_pointer++;
			_size = int64(string_char_at(_seedstr,_pointer));
			
			_pointer++;
			_x = sprite_width  * (int64(string_char_at(_seedstr,_pointer))/10);
			
			_pointer++;
			_y = sprite_height * (int64(string_char_at(_seedstr,_pointer))/10);
		}
		
		//draw planet
		draw_sprite_ext(planets_sprites[_pindex],0,xx +_x, yy + _y,_size,_size,0,c_white,0.7);
		
	}
}

/*/drawing planets
at the start of the game a seed will be generated. 
that seed will be combined togther with the x and y coordinate of the current background "tile",
and from that it will generate planets.
something like:
last digit/2 - num of planets (max 4)
then loop through the next digits to determine:
	planet size
	planet sprite
	planet turn speed (image speed)
	maybe even colors.
	
seeds will be calculated only when the player leaves a tile to reduce performance cost.
they will be stored in a 2d array.

