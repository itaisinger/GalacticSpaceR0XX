for(var i=0; i < MAX_ENEMY_NUM; i++)
{
	instance_destroy(arr_elements[SPAWNLIST_ELEM.others][i])	
}

//update all of the elements x and y according to mine
for(var i=0; i < array_length(arr_elements)-1; i++)
{
	instance_destroy(arr_elements[i]);
}