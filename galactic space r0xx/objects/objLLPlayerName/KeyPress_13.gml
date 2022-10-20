/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 56AB884D
/// @DnDArgument : "expr" "insertingName"
if(insertingName)
{
	/// @DnDAction : YoYo Games.Common.Execute_Code
	/// @DnDVersion : 1
	/// @DnDHash : 0E46E7B7
	/// @DnDParent : 56AB884D
	/// @DnDArgument : "code" "// Set the name of the logged in player$(13_10)// to what the player has typed on the keyboard$(13_10)// when enter was pressed$(13_10)LootLockerSetPlayerName(keyboard_string);"
	// Set the name of the logged in player
	// to what the player has typed on the keyboard
	// when enter was pressed
	LootLockerSetPlayerName(keyboard_string);

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 6654B63E
	/// @DnDComment : Reset the variables
	/// @DnDInput : 2
	/// @DnDParent : 56AB884D
	/// @DnDArgument : "expr" """"
	/// @DnDArgument : "expr_1" "false"
	/// @DnDArgument : "var" "keyboard_string"
	/// @DnDArgument : "var_1" "insertingName"
	keyboard_string = "";
	insertingName = false;
}