/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 610C35CF
/// @DnDArgument : "var" "global.gameState"
/// @DnDArgument : "value" "GameState.playing"
if(global.gameState == GameState.playing)
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 748B7280
	/// @DnDComment : Increase the speed of the game$(13_10)
	/// @DnDParent : 610C35CF
	/// @DnDArgument : "expr" "-0.005"
	/// @DnDArgument : "expr_relative" "1"
	/// @DnDArgument : "var" "global.bgHspeed"
	global.bgHspeed += -0.005;
}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 72B77A15
else
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 3157A9BF
	/// @DnDParent : 72B77A15
	/// @DnDArgument : "var" "global.bgHspeed"
	global.bgHspeed = 0;
}

/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 78BC6839
/// @DnDArgument : "code" "// Set the speed of the different layers$(13_10)layer_hspeed("Ground", global.bgHspeed);$(13_10)layer_hspeed("TitleText", global.bgHspeed);"
// Set the speed of the different layers
layer_hspeed("Ground", global.bgHspeed);
layer_hspeed("TitleText", global.bgHspeed);