/// @DnDAction : YoYo Games.Movement.Set_Speed
/// @DnDVersion : 1
/// @DnDHash : 00E540C7
/// @DnDArgument : "speed" "global.bgHspeed"
/// @DnDArgument : "type" "1"
hspeed = global.bgHspeed;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 177BDE35
/// @DnDComment : Did we pass the player?
/// @DnDArgument : "var" "self.x"
/// @DnDArgument : "op" "1"
/// @DnDArgument : "value" "48"
if(self.x < 48)
{
	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 7F1357D3
	/// @DnDComment : Can we give score?
	/// @DnDParent : 177BDE35
	/// @DnDArgument : "var" "canGiveScore"
	/// @DnDArgument : "value" "true"
	if(canGiveScore == true)
	{
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 729AC674
		/// @DnDComment : Got score
		/// @DnDInput : 3
		/// @DnDParent : 7F1357D3
		/// @DnDArgument : "expr" "1"
		/// @DnDArgument : "expr_relative" "1"
		/// @DnDArgument : "expr_1" "true"
		/// @DnDArgument : "expr_2" "false"
		/// @DnDArgument : "var" "global.playerScore"
		/// @DnDArgument : "var_1" "global.gotScore"
		/// @DnDArgument : "var_2" "canGiveScore"
		global.playerScore += 1;
		global.gotScore = true;
		canGiveScore = false;
	}
}