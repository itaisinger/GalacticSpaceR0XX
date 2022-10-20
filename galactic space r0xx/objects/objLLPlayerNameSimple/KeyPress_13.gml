/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 239A7491
/// @DnDArgument : "var" "enteringName"
/// @DnDArgument : "value" "true"
if(enteringName == true)
{
	/// @DnDAction : YoYo Games.Common.Execute_Code
	/// @DnDVersion : 1
	/// @DnDHash : 727B6FAC
	/// @DnDParent : 239A7491
	/// @DnDArgument : "code" "LootLockerSetPlayerName(keyboard_string);"
	LootLockerSetPlayerName(keyboard_string);

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 54ADC026
	/// @DnDParent : 239A7491
	/// @DnDArgument : "expr" "false"
	/// @DnDArgument : "var" "enteringName"
	enteringName = false;
}