/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 4610B3DF
/// @DnDArgument : "var" "enteringName"
/// @DnDArgument : "value" "false"
if(enteringName == false)
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 16712D2B
	/// @DnDParent : 4610B3DF
	/// @DnDArgument : "expr" "true"
	/// @DnDArgument : "var" "enteringName"
	enteringName = true;

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 657F5A25
	/// @DnDParent : 4610B3DF
	/// @DnDArgument : "expr" """"
	/// @DnDArgument : "var" "keyboard_string"
	keyboard_string = "";
}