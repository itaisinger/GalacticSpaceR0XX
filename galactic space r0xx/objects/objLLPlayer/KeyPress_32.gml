/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 0D49F9E0
/// @DnDComment : Only allowed to jump if not currently jumping
/// @DnDArgument : "expr" "jumping"
/// @DnDArgument : "not" "1"
if(!(jumping))
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 14D034D8
	/// @DnDComment : Start jumping
	/// @DnDInput : 2
	/// @DnDParent : 0D49F9E0
	/// @DnDArgument : "expr" "true"
	/// @DnDArgument : "var" "jumping"
	/// @DnDArgument : "var_1" "jumpPathPosition"
	jumping = true;
	jumpPathPosition = 0;

	/// @DnDAction : YoYo Games.Instances.Set_Sprite
	/// @DnDVersion : 1
	/// @DnDHash : 004EFF95
	/// @DnDParent : 0D49F9E0
	/// @DnDArgument : "spriteind" "sprLLPlayerJump"
	/// @DnDSaveInfo : "spriteind" "sprLLPlayerJump"
	sprite_index = sprLLPlayerJump;
	image_index = 0;
}