hp_text = "";
hp_text_a = 0;
depth = DEPTH.ui;

//alarm[0] is intialized from the high score object
typer_a = 0;	//typing a | in the highscore typer

dead = 0;
trans_prec = 0;	//transition to death screen 
arr_curves = [0,0,0,0,0,0]
high_score = 0;	//whether there is a new highscore

my_effect = noone;
my_effect2 = noone;
bars_gap_max = 40;
bars_gap = bars_gap_max;			//distance between the hp and the upgrade bars.
bars_anim_prec = -1;	//approaches 1 when isnt -1.

state = UI_STATES.tutorial;
tutorial_done = 0;

function flash_hp(index)
{
	list_flash_a[|index] = 1;
}
function flash_hp_score(text)
{
	hp_text_a = 2;
	hp_text = text;
}
function play_bars_anim()
{
	bars_anim_prec = 0;
	play_sfx(sfx_bars_anim_start);
}

list_bars = -1;
list_flash_a = ds_list_create();

enum UI_ELEM{
	overlay,
	scor,
	bars,
	continu,
	highscore,
	name,
}

enum UI_STATES{
	natural,
	death,		//includes the transition in
	tutorial,	//includes the transition out
}