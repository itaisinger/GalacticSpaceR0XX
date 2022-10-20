/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 7ABC5716
/// @DnDArgument : "expr" "-1"
/// @DnDArgument : "expr_relative" "1"
/// @DnDArgument : "var" "currentPage"
currentPage += -1;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 0C794AB7
/// @DnDArgument : "var" "currentPage"
/// @DnDArgument : "op" "1"
if(currentPage < 0)
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 3AE5EB38
	/// @DnDParent : 0C794AB7
	/// @DnDArgument : "expr" "sprite_get_number(sprLLGuidePages)-1"
	/// @DnDArgument : "var" "currentPage"
	currentPage = sprite_get_number(sprLLGuidePages)-1;
}