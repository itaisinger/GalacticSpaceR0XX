/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 7D64FA50
/// @DnDArgument : "code" "// If we are playing, and the player is alive$(13_10)if(global.gameState == GameState.playing && alive == true)$(13_10){$(13_10)	// If we hit a rock$(13_10)	if(place_meeting(x+(-1*global.bgHspeed),y, objLLRock))$(13_10)	{		$(13_10)		// Stop the game$(13_10)		global.gameState = GameState.dead;$(13_10)		alive = false;$(13_10)		$(13_10)		// Upload the score to the leaderboard$(13_10)		LootLockerSubmitScore("1834", global.playerScore);$(13_10)		$(13_10)		// Show the restart button$(13_10)		objLLRestartButton.visible = true;$(13_10)	}$(13_10)}"
// If we are playing, and the player is alive
if(global.gameState == GameState.playing && alive == true)
{
	// If we hit a rock
	if(place_meeting(x+(-1*global.bgHspeed),y, objLLRock))
	{		
		// Stop the game
		global.gameState = GameState.dead;
		alive = false;
		
		// Upload the score to the leaderboard
		LootLockerSubmitScore("1834", global.playerScore);
		
		// Show the restart button
		objLLRestartButton.visible = true;
	}
}

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 080A79F0
/// @DnDArgument : "var" "global.gameState"
/// @DnDArgument : "value" "GameState.playing"
if(global.gameState == GameState.playing)
{
	/// @DnDAction : YoYo Games.Instances.Sprite_Animation_Speed
	/// @DnDVersion : 1
	/// @DnDHash : 58162941
	/// @DnDComment : Make the animation speed$(13_10)be higher, the faster the speeed$(13_10)of the level is
	/// @DnDParent : 080A79F0
	/// @DnDArgument : "speed" "1+(-(global.bgHspeed*0.01))"
	image_speed = 1+(-(global.bgHspeed*0.01));

	/// @DnDAction : YoYo Games.Common.If_Expression
	/// @DnDVersion : 1
	/// @DnDHash : 5421F608
	/// @DnDParent : 080A79F0
	/// @DnDArgument : "expr" "jumping"
	if(jumping)
	{
		/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 36D1F33A
		/// @DnDParent : 5421F608
		/// @DnDArgument : "expr" "(-1*global.bgHspeed*0.01)"
		/// @DnDArgument : "expr_relative" "1"
		/// @DnDArgument : "var" "jumpPathPosition"
		jumpPathPosition += (-1*global.bgHspeed*0.01);
	
		/// @DnDAction : YoYo Games.Common.Execute_Code
		/// @DnDVersion : 1
		/// @DnDHash : 0146B76E
		/// @DnDParent : 5421F608
		/// @DnDArgument : "code" "// Move the player along Y with the output of the animationCurve jumpCurve$(13_10)var channel = animcurve_get_channel(anmCrvLLJumpCurve, 0);$(13_10)var value = animcurve_channel_evaluate(channel, jumpPathPosition);$(13_10)self.y = 124-(value*50);"
		// Move the player along Y with the output of the animationCurve jumpCurve
		var channel = animcurve_get_channel(anmCrvLLJumpCurve, 0);
		var value = animcurve_channel_evaluate(channel, jumpPathPosition);
		self.y = 124-(value*50);
	
		/// @DnDAction : YoYo Games.Common.If_Variable
		/// @DnDVersion : 1
		/// @DnDHash : 1D594B4D
		/// @DnDParent : 5421F608
		/// @DnDArgument : "var" "jumpPathPosition"
		/// @DnDArgument : "op" "4"
		/// @DnDArgument : "value" "1"
		if(jumpPathPosition >= 1)
		{
			/// @DnDAction : YoYo Games.Common.Variable
			/// @DnDVersion : 1
			/// @DnDHash : 210C0C65
			/// @DnDParent : 1D594B4D
			/// @DnDArgument : "expr" "false"
			/// @DnDArgument : "var" "jumping"
			jumping = false;
		
			/// @DnDAction : YoYo Games.Instances.Set_Sprite
			/// @DnDVersion : 1
			/// @DnDHash : 49FBFC76
			/// @DnDComment : Change back to the run sprite
			/// @DnDParent : 1D594B4D
			/// @DnDArgument : "spriteind" "sprLLPlayerRun"
			/// @DnDSaveInfo : "spriteind" "sprLLPlayerRun"
			sprite_index = sprLLPlayerRun;
			image_index = 0;
		}
	}
}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 60E94730
else
{
	/// @DnDAction : YoYo Games.Instances.Sprite_Animation_Speed
	/// @DnDVersion : 1
	/// @DnDHash : 6E368026
	/// @DnDParent : 60E94730
	/// @DnDArgument : "speed" "0"
	image_speed = 0;
}