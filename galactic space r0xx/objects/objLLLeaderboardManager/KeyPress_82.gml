/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 6B6DDF12
/// @DnDComment : Can not reset while changing name
/// @DnDArgument : "var" "objLLPlayerNameSimple.enteringName"
/// @DnDArgument : "value" "false"
if(objLLPlayerNameSimple.enteringName == false)
{
	/// @DnDAction : YoYo Games.Common.Execute_Code
	/// @DnDVersion : 1
	/// @DnDHash : 5B5C4DFD
	/// @DnDParent : 6B6DDF12
	/// @DnDArgument : "code" "// This resets the current player$(13_10)LootLockerReset();"
	// This resets the current player
	LootLockerReset();
}