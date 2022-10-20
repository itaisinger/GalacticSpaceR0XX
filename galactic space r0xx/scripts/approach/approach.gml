///@desc approach()
///@arg0val
///@arg1goal
///@arg2speed
function approach(argument0, argument1, argument2) {

	var val = argument0;
	var spd = argument2;
	var goal = argument1;

	if(val<goal) return min(val+spd, goal);
	if(val>goal) return max(val-spd, goal);
	return val;


}
