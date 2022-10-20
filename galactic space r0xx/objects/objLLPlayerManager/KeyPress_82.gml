/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 6BD00F1F
/// @DnDComment : This checks if the playerName$(13_10) object is not currently inputting the name and is on the menu state.$(13_10)Otherwise you wouldn't be able to have a $(13_10)name with an R in it.
/// @DnDArgument : "code" "/*$(13_10)This checks if the playerName$(13_10) object is not currently inputting the name and is on the menu state.$(13_10)Otherwise you wouldn't be able to have a $(13_10)name with an R in it.$(13_10)*/$(13_10)if(global.gameState == GameState.menu &&objLLPlayerName.insertingName == false)$(13_10){$(13_10)	LootLockerReset();$(13_10)}"
/*
This checks if the playerName
 object is not currently inputting the name and is on the menu state.
Otherwise you wouldn't be able to have a 
name with an R in it.
*/
if(global.gameState == GameState.menu &&objLLPlayerName.insertingName == false)
{
	LootLockerReset();
}/**/