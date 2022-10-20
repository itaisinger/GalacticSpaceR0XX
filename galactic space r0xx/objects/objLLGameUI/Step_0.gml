/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 381B5D1E
/// @DnDComment : If the score was updated$(13_10)we restart the animation
/// @DnDArgument : "var" "previousScore"
/// @DnDArgument : "not" "1"
/// @DnDArgument : "value" "global.playerScore"
if(!(previousScore == global.playerScore))
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 07D54A25
	/// @DnDComment : Animate the score with an animationCurve
	/// @DnDParent : 381B5D1E
	/// @DnDArgument : "expr" "false"
	/// @DnDArgument : "var" "global.gotScore"
	global.gotScore = false;

	/// @DnDAction : YoYo Games.Common.Execute_Code
	/// @DnDVersion : 1
	/// @DnDHash : 5528785F
	/// @DnDParent : 381B5D1E
	/// @DnDArgument : "code" "//Set  yScale to be that of the animationCurve$(13_10)var channel = animcurve_get_channel(anmCrvLLGetScoreCurve, 0);$(13_10)var value = animcurve_channel_evaluate(channel, scoreAnimPos);$(13_10)yScale = 1+(value*2);"
	//Set  yScale to be that of the animationCurve
	var channel = animcurve_get_channel(anmCrvLLGetScoreCurve, 0);
	var value = animcurve_channel_evaluate(channel, scoreAnimPos);
	yScale = 1+(value*2);

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 0A799118
	/// @DnDParent : 381B5D1E
	/// @DnDArgument : "expr" "0.05"
	/// @DnDArgument : "expr_relative" "1"
	/// @DnDArgument : "var" "scoreAnimPos"
	scoreAnimPos += 0.05;

	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 3ACF1F1A
	/// @DnDComment : Was the animation finished?
	/// @DnDParent : 381B5D1E
	/// @DnDArgument : "var" "scoreAnimPos"
	/// @DnDArgument : "op" "4"
	/// @DnDArgument : "value" "1"
	if(scoreAnimPos >= 1)
	{
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 5BE6A198
		/// @DnDComment : Reset all variables
		/// @DnDInput : 4
		/// @DnDParent : 3ACF1F1A
		/// @DnDArgument : "expr" "false"
		/// @DnDArgument : "expr_1" "global.playerScore"
		/// @DnDArgument : "expr_3" "1"
		/// @DnDArgument : "var" "global.gotScore"
		/// @DnDArgument : "var_1" "previousScore"
		/// @DnDArgument : "var_2" "scoreAnimPos"
		/// @DnDArgument : "var_3" "yScale"
		global.gotScore = false;
		previousScore = global.playerScore;
		scoreAnimPos = 0;
		yScale = 1;
	}
}