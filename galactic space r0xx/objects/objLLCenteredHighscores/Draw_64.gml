draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(x + 0, y + -20, string("[Only visible if a score has been uploaded]") + "");

draw_text(x + 0, y + 0, string("Highscores Centered on Player\n") + string(LLHighscoresCenteredFormatted()));