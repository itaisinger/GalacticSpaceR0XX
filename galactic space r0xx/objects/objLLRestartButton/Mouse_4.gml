/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 35EE3F8B
/// @DnDComment : If we are in the dead state
/// @DnDArgument : "var" "global.gameState"
/// @DnDArgument : "value" "GameState.dead"
if(global.gameState == GameState.dead)
{
	/// @DnDAction : YoYo Games.Instances.Call_User_Event
	/// @DnDVersion : 1
	/// @DnDHash : 2F9A6371
	/// @DnDComment : Call Event 0 on the GameController.$(13_10)This will restart the room/restart the game.
	/// @DnDApplyTo : {objLLGameController}
	/// @DnDParent : 35EE3F8B
	with(objLLGameController) {
	event_user(0);
	}
}