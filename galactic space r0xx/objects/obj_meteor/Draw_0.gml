//draw normal
draw_self();


//draw with shader
shader_set(sh_hit);
shader_set_uniform_f(uniform_hit,shader_val*shader_a*0.6);

draw_self();

shader_reset();

draw_set_all(font_ingame, fa_center, fa_middle, c_black, 1);
//draw_text(x,y,shader_val*shader_a);
draw_reset();