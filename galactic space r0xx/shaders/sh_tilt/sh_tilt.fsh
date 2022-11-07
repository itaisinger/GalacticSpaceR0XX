// 
// Simple passthrough fragment shader
// 
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float angle;
uniform bool iff;
uniform float prec;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + (v_vTexcoord.x-0.5)*angle*0.01));
	gl_FragColor.xyz += vec3(prec,prec,prec);
}	