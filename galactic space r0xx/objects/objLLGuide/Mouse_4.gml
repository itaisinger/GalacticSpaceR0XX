/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 7ABC5716
/// @DnDArgument : "expr" "1"
/// @DnDArgument : "expr_relative" "1"
/// @DnDArgument : "var" "currentPage"
currentPage += 1;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 50C48371
/// @DnDArgument : "var" "currentPage"
/// @DnDArgument : "op" "4"
/// @DnDArgument : "value" "sprite_get_number(sprLLGuidePages)"
if(currentPage >= sprite_get_number(sprLLGuidePages))
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 7F42E846
	/// @DnDParent : 50C48371
	/// @DnDArgument : "var" "currentPage"
	currentPage = 0;
}