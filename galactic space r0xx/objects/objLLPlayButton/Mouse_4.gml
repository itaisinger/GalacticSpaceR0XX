/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 39481C6F
/// @DnDComment : Set state to playing.$(13_10)Set the speed to start the game.
/// @DnDInput : 2
/// @DnDArgument : "expr" "GameState.playing"
/// @DnDArgument : "expr_1" "-3"
/// @DnDArgument : "var" "global.gameState"
/// @DnDArgument : "var_1" "global.bgHspeed"
global.gameState = GameState.playing;
global.bgHspeed = -3;

/// @DnDAction : YoYo Games.Instances.Call_User_Event
/// @DnDVersion : 1
/// @DnDHash : 2F9A6371
/// @DnDComment : Call Event 0 on the PlayerObject.$(13_10)This changes the players sprite to the run sprite.
/// @DnDApplyTo : {objLLPlayer}
with(objLLPlayer) {
event_user(0);
}

/// @DnDAction : YoYo Games.Instances.Destroy_Instance
/// @DnDVersion : 1
/// @DnDHash : 2CF6D3DE
/// @DnDComment : Destroy the PlayerName input field
/// @DnDApplyTo : {objLLPlayerName}
with(objLLPlayerName) instance_destroy();

/// @DnDAction : YoYo Games.Instances.Destroy_Instance
/// @DnDVersion : 1
/// @DnDHash : 0B05A8B7
/// @DnDComment : Destroy self
instance_destroy();