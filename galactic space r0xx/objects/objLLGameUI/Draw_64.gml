/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 0D4862B4
/// @DnDComment : Draw the score if $(13_10)we are playing the game
/// @DnDArgument : "var" "global.gameState"
/// @DnDArgument : "value" "GameState.playing"
if(global.gameState == GameState.playing)
{
	/// @DnDAction : YoYo Games.Drawing.Set_Color
	/// @DnDVersion : 1
	/// @DnDHash : 70459206
	/// @DnDParent : 0D4862B4
	/// @DnDArgument : "alpha" "false"
	draw_set_colour($FFFFFFFF & $ffffff);draw_set_alpha(1);

	/// @DnDAction : YoYo Games.Drawing.Set_Alignment
	/// @DnDVersion : 1.1
	/// @DnDHash : 5A8D84BF
	/// @DnDParent : 0D4862B4
	/// @DnDArgument : "halign" "fa_center"
	/// @DnDArgument : "valign" "fa_middle"
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	/// @DnDAction : YoYo Games.Drawing.Set_Font
	/// @DnDVersion : 1
	/// @DnDHash : 510F0921
	/// @DnDParent : 0D4862B4
	/// @DnDArgument : "font" "fontLLFontHighscore"
	/// @DnDSaveInfo : "font" "fontLLFontHighscore"
	draw_set_font(fontLLFontHighscore);

	/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
	/// @DnDVersion : 1
	/// @DnDHash : 6AD78506
	/// @DnDComment : Draw the score with the scale of$(13_10)yScale (which is animated with an animationCurve)$(13_10)in Step
	/// @DnDParent : 0D4862B4
	/// @DnDArgument : "x" "640-(yScale/2)"
	/// @DnDArgument : "y" "64-(yScale/2)"
	/// @DnDArgument : "xscale" "4+yScale"
	/// @DnDArgument : "yscale" "4+yScale"
	/// @DnDArgument : "caption" ""
	/// @DnDArgument : "text" "global.playerScore"
	draw_text_transformed(640-(yScale/2), 64-(yScale/2), "" + string(global.playerScore), 4+yScale, 4+yScale, 0);
}

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 1D7D271E
/// @DnDComment : If we are in the menu state,$(13_10)show the leaderboards
/// @DnDArgument : "var" "global.gameState"
/// @DnDArgument : "value" "GameState.menu"
if(global.gameState == GameState.menu)
{
	/// @DnDAction : YoYo Games.Loops.For_Loop
	/// @DnDVersion : 1
	/// @DnDHash : 02A9018C
	/// @DnDParent : 1D7D271E
	for(i = 0; i < 10; i += 1) {
		/// @DnDAction : YoYo Games.Common.If_Variable
		/// @DnDVersion : 1
		/// @DnDHash : 23B8F1F9
		/// @DnDComment : Are there any scores to show?
		/// @DnDParent : 02A9018C
		/// @DnDArgument : "var" "LLHighscoresTopRankList()[i]"
		/// @DnDArgument : "not" "1"
		/// @DnDArgument : "value" """"
		if(!(LLHighscoresTopRankList()[i] == ""))
		{
			/// @DnDAction : YoYo Games.Common.Variable
			/// @DnDVersion : 1
			/// @DnDHash : 54ACF474
			/// @DnDParent : 23B8F1F9
			/// @DnDArgument : "expr" "LLHighscoresTopRankList()[i]+". ""
			/// @DnDArgument : "var" "text"
			text = LLHighscoresTopRankList()[i]+". ";
		
			/// @DnDAction : YoYo Games.Common.If_Variable
			/// @DnDVersion : 1
			/// @DnDHash : 2B205893
			/// @DnDComment : If the players have a name$(13_10)output that
			/// @DnDParent : 23B8F1F9
			/// @DnDArgument : "var" "LLHighscoresTopNamesList()[i]"
			/// @DnDArgument : "not" "1"
			/// @DnDArgument : "value" """"
			if(!(LLHighscoresTopNamesList()[i] == ""))
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 162C264B
				/// @DnDParent : 2B205893
				/// @DnDArgument : "expr" "LLHighscoresTopNamesList()[i]"
				/// @DnDArgument : "expr_relative" "1"
				/// @DnDArgument : "var" "text"
				text += LLHighscoresTopNamesList()[i];
			}
		
			/// @DnDAction : YoYo Games.Common.Else
			/// @DnDVersion : 1
			/// @DnDHash : 3D9B6912
			/// @DnDComment : Otherwise, output their ID instead
			/// @DnDParent : 23B8F1F9
			else
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 3B805F54
				/// @DnDParent : 3D9B6912
				/// @DnDArgument : "expr" "LLHighscoresTopIDList()[i]"
				/// @DnDArgument : "expr_relative" "1"
				/// @DnDArgument : "var" "text"
				text += LLHighscoresTopIDList()[i];
			}
		
			/// @DnDAction : YoYo Games.Drawing.Set_Alignment
			/// @DnDVersion : 1.1
			/// @DnDHash : 06006A02
			/// @DnDParent : 23B8F1F9
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		
			/// @DnDAction : YoYo Games.Common.If_Variable
			/// @DnDVersion : 1
			/// @DnDHash : 66D293A1
			/// @DnDComment : If the score is the players score$(13_10)change the font color to highlight it
			/// @DnDParent : 23B8F1F9
			/// @DnDArgument : "var" "LLHighscoresTopRankList()[i]"
			/// @DnDArgument : "value" "LLPlayerRank()"
			if(LLHighscoresTopRankList()[i] == LLPlayerRank())
			{
				/// @DnDAction : YoYo Games.Drawing.Set_Color
				/// @DnDVersion : 1
				/// @DnDHash : 7C35EBB1
				/// @DnDParent : 66D293A1
				/// @DnDArgument : "color" "$FF1EACFF"
				draw_set_colour($FF1EACFF & $ffffff);
				var l7C35EBB1_0=($FF1EACFF >> 24);
				draw_set_alpha(l7C35EBB1_0 / $ff);
			}
		
			/// @DnDAction : YoYo Games.Common.Else
			/// @DnDVersion : 1
			/// @DnDHash : 7ED500A5
			/// @DnDParent : 23B8F1F9
			else
			{
				/// @DnDAction : YoYo Games.Drawing.Set_Color
				/// @DnDVersion : 1
				/// @DnDHash : 2C3F5C83
				/// @DnDParent : 7ED500A5
				draw_set_colour($FFFFFFFF & $ffffff);
				var l2C3F5C83_0=($FFFFFFFF >> 24);
				draw_set_alpha(l2C3F5C83_0 / $ff);
			}
		
			/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
			/// @DnDVersion : 1
			/// @DnDHash : 6243E0C4
			/// @DnDComment : The text variable here is formatted as:$(13_10)Rank+". "+PlayerName/PlayerID$(13_10)Example:$(13_10)10. PlayerName
			/// @DnDParent : 23B8F1F9
			/// @DnDArgument : "x" "850"
			/// @DnDArgument : "y" "100+(i*60)"
			/// @DnDArgument : "xscale" "3"
			/// @DnDArgument : "yscale" "3"
			/// @DnDArgument : "caption" ""
			/// @DnDArgument : "text" "text"
			draw_text_transformed(850, 100+(i*60), "" + string(text), 3, 3, 0);
		
			/// @DnDAction : YoYo Games.Drawing.Set_Alignment
			/// @DnDVersion : 1.1
			/// @DnDHash : 4D9538A2
			/// @DnDParent : 23B8F1F9
			/// @DnDArgument : "halign" "fa_right"
			draw_set_halign(fa_right);
			draw_set_valign(fa_top);
		
			/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
			/// @DnDVersion : 1
			/// @DnDHash : 6E9CF50E
			/// @DnDComment : Draw the score on the right side
			/// @DnDParent : 23B8F1F9
			/// @DnDArgument : "x" "1250"
			/// @DnDArgument : "y" "100+(i*60)"
			/// @DnDArgument : "xscale" "3"
			/// @DnDArgument : "yscale" "3"
			/// @DnDArgument : "caption" ""
			/// @DnDArgument : "text" "LLHighscoresTopScoreList()[i]"
			draw_text_transformed(1250, 100+(i*60), "" + string(LLHighscoresTopScoreList()[i]), 3, 3, 0);
		}
	}
}

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 61002CE4
/// @DnDComment : If we are in the dead state$(13_10)Show the players score highlighted
/// @DnDArgument : "var" "global.gameState"
/// @DnDArgument : "value" "GameState.dead"
if(global.gameState == GameState.dead)
{
	/// @DnDAction : YoYo Games.Loops.For_Loop
	/// @DnDVersion : 1
	/// @DnDHash : 09574C66
	/// @DnDParent : 61002CE4
	for(i = 0; i < 10; i += 1) {
		/// @DnDAction : YoYo Games.Common.If_Variable
		/// @DnDVersion : 1
		/// @DnDHash : 18D055E4
		/// @DnDComment : Are there any scores to show?
		/// @DnDParent : 09574C66
		/// @DnDArgument : "var" "LLHighscoresCenteredRankList()[i]"
		/// @DnDArgument : "not" "1"
		/// @DnDArgument : "value" """"
		if(!(LLHighscoresCenteredRankList()[i] == ""))
		{
			/// @DnDAction : YoYo Games.Common.Variable
			/// @DnDVersion : 1
			/// @DnDHash : 30EC5FB2
			/// @DnDParent : 18D055E4
			/// @DnDArgument : "expr" "LLHighscoresCenteredRankList()[i]+". ""
			/// @DnDArgument : "var" "text"
			text = LLHighscoresCenteredRankList()[i]+". ";
		
			/// @DnDAction : YoYo Games.Common.If_Variable
			/// @DnDVersion : 1
			/// @DnDHash : 5B57FC97
			/// @DnDComment : If the players have a name$(13_10)output that
			/// @DnDParent : 18D055E4
			/// @DnDArgument : "var" "LLHighscoresCenteredNamesList()[i]"
			/// @DnDArgument : "not" "1"
			/// @DnDArgument : "value" """"
			if(!(LLHighscoresCenteredNamesList()[i] == ""))
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 7EA9C431
				/// @DnDParent : 5B57FC97
				/// @DnDArgument : "expr" "LLHighscoresCenteredNamesList()[i]"
				/// @DnDArgument : "expr_relative" "1"
				/// @DnDArgument : "var" "text"
				text += LLHighscoresCenteredNamesList()[i];
			}
		
			/// @DnDAction : YoYo Games.Common.Else
			/// @DnDVersion : 1
			/// @DnDHash : 789A2499
			/// @DnDComment : Otherwise, output their ID instead
			/// @DnDParent : 18D055E4
			else
			{
				/// @DnDAction : YoYo Games.Common.Variable
				/// @DnDVersion : 1
				/// @DnDHash : 0F964D36
				/// @DnDParent : 789A2499
				/// @DnDArgument : "expr" "LLHighscoresCenteredIDList()[i]"
				/// @DnDArgument : "expr_relative" "1"
				/// @DnDArgument : "var" "text"
				text += LLHighscoresCenteredIDList()[i];
			}
		
			/// @DnDAction : YoYo Games.Drawing.Set_Alignment
			/// @DnDVersion : 1.1
			/// @DnDHash : 781CB918
			/// @DnDParent : 18D055E4
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		
			/// @DnDAction : YoYo Games.Common.If_Variable
			/// @DnDVersion : 1
			/// @DnDHash : 78466DFD
			/// @DnDComment : If the score is the players score$(13_10)change the font color to highlight it
			/// @DnDParent : 18D055E4
			/// @DnDArgument : "var" "LLHighscoresCenteredRankList()[i]"
			/// @DnDArgument : "value" "LLPlayerRank()"
			if(LLHighscoresCenteredRankList()[i] == LLPlayerRank())
			{
				/// @DnDAction : YoYo Games.Drawing.Set_Color
				/// @DnDVersion : 1
				/// @DnDHash : 26033C26
				/// @DnDParent : 78466DFD
				/// @DnDArgument : "color" "$FF1EACFF"
				draw_set_colour($FF1EACFF & $ffffff);
				var l26033C26_0=($FF1EACFF >> 24);
				draw_set_alpha(l26033C26_0 / $ff);
			}
		
			/// @DnDAction : YoYo Games.Common.Else
			/// @DnDVersion : 1
			/// @DnDHash : 6DF06F29
			/// @DnDParent : 18D055E4
			else
			{
				/// @DnDAction : YoYo Games.Drawing.Set_Color
				/// @DnDVersion : 1
				/// @DnDHash : 5ED1FB76
				/// @DnDParent : 6DF06F29
				draw_set_colour($FFFFFFFF & $ffffff);
				var l5ED1FB76_0=($FFFFFFFF >> 24);
				draw_set_alpha(l5ED1FB76_0 / $ff);
			}
		
			/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
			/// @DnDVersion : 1
			/// @DnDHash : 18F6CACC
			/// @DnDComment : The text variable here is formatted as:$(13_10)Rank+". "+PlayerName/PlayerID$(13_10)Example:$(13_10)10. PlayerName
			/// @DnDParent : 18D055E4
			/// @DnDArgument : "x" "850"
			/// @DnDArgument : "y" "100+(i*60)"
			/// @DnDArgument : "xscale" "3"
			/// @DnDArgument : "yscale" "3"
			/// @DnDArgument : "caption" ""
			/// @DnDArgument : "text" "text"
			draw_text_transformed(850, 100+(i*60), "" + string(text), 3, 3, 0);
		
			/// @DnDAction : YoYo Games.Drawing.Set_Alignment
			/// @DnDVersion : 1.1
			/// @DnDHash : 1160A436
			/// @DnDParent : 18D055E4
			/// @DnDArgument : "halign" "fa_right"
			draw_set_halign(fa_right);
			draw_set_valign(fa_top);
		
			/// @DnDAction : YoYo Games.Drawing.Draw_Value_Transformed
			/// @DnDVersion : 1
			/// @DnDHash : 5CE2D283
			/// @DnDComment : Draw the score on the right side
			/// @DnDParent : 18D055E4
			/// @DnDArgument : "x" "1250"
			/// @DnDArgument : "y" "100+(i*60)"
			/// @DnDArgument : "xscale" "3"
			/// @DnDArgument : "yscale" "3"
			/// @DnDArgument : "caption" ""
			/// @DnDArgument : "text" "LLHighscoresCenteredScoreList()[i]"
			draw_text_transformed(1250, 100+(i*60), "" + string(LLHighscoresCenteredScoreList()[i]), 3, 3, 0);
		}
	}
}