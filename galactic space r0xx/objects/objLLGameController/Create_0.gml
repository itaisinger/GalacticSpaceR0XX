/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 37920611
/// @DnDInput : 2
/// @DnDArgument : "var" "global.bgHspeed"
/// @DnDArgument : "var_1" "global.playerScore"
global.bgHspeed = 0;
global.playerScore = 0;

/// @DnDAction : YoYo Games.Instances.Create_Instance
/// @DnDVersion : 1
/// @DnDHash : 18D8AF2C
/// @DnDArgument : "xpos" "320"
/// @DnDArgument : "ypos" "124"
/// @DnDArgument : "objectid" "objLLRock"
/// @DnDSaveInfo : "objectid" "objLLRock"
instance_create_layer(320, 124, "Instances", objLLRock);

/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 67472C15
/// @DnDArgument : "code" "// Game logic enums$(13_10)enum GameState$(13_10){$(13_10)	menu,$(13_10)	playing,$(13_10)	dead$(13_10)}$(13_10)$(13_10)global.gameState = GameState.menu;"
// Game logic enums
enum GameState
{
	menu,
	playing,
	dead
}

global.gameState = GameState.menu;