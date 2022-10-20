/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 367FD134
/// @DnDArgument : "var" "enteringName"
/// @DnDArgument : "value" "true"
if(enteringName == true)
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 5FF39EA2
	/// @DnDParent : 367FD134
	/// @DnDArgument : "expr" "false"
	/// @DnDArgument : "var" "enteringName"
	enteringName = false;

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 4D98D5D7
	/// @DnDParent : 367FD134
	/// @DnDArgument : "expr" """"
	/// @DnDArgument : "var" "keyboard_string"
	keyboard_string = "";
}