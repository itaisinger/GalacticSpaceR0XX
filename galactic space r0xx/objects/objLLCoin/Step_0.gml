/// @DnDAction : YoYo Games.Movement.Set_Speed
/// @DnDVersion : 1
/// @DnDHash : 00E540C7
/// @DnDComment : Move with the same speed$(13_10)as the background
/// @DnDArgument : "speed" "global.bgHspeed"
/// @DnDArgument : "type" "1"
hspeed = global.bgHspeed;

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 434E146E
/// @DnDComment : Coins moves faster, the faster the game moves
/// @DnDArgument : "expr" "(-1*global.bgHspeed*0.0025)"
/// @DnDArgument : "expr_relative" "1"
/// @DnDArgument : "var" "coinPathPosition"
coinPathPosition += (-1*global.bgHspeed*0.0025);

/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 013C20B5
/// @DnDArgument : "code" "// Move the coin up and down with the animationCurve coinCurve$(13_10)var channel = animcurve_get_channel(anmCrvLLCoinCurve, 0);$(13_10)var value = animcurve_channel_evaluate(channel, coinPathPosition);$(13_10)self.y = 90-(value*10);"
// Move the coin up and down with the animationCurve coinCurve
var channel = animcurve_get_channel(anmCrvLLCoinCurve, 0);
var value = animcurve_channel_evaluate(channel, coinPathPosition);
self.y = 90-(value*10);

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 1EAFA0CF
/// @DnDComment : Reset when reaching 1
/// @DnDArgument : "var" "coinPathPosition"
/// @DnDArgument : "op" "4"
/// @DnDArgument : "value" "1"
if(coinPathPosition >= 1)
{
	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 644F8471
	/// @DnDParent : 1EAFA0CF
	/// @DnDArgument : "var" "coinPathPosition"
	coinPathPosition = 0;
}