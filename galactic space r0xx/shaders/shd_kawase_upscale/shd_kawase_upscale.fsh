//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 texel;

void main()
{
	const vec2 z = vec2(0);
	const vec2 s = vec2(-1,1);
	const vec2 a = vec2(0,2);
    gl_FragColor = (texture2D(gm_BaseTexture, clamp(v_vTexcoord + texel.xy*s.xx, z, texel.zw))+
					texture2D(gm_BaseTexture, clamp(v_vTexcoord + texel.xy*s.yx, z, texel.zw))+
					texture2D(gm_BaseTexture, clamp(v_vTexcoord + texel.xy*s.xy, z, texel.zw))+
					texture2D(gm_BaseTexture, clamp(v_vTexcoord + texel.xy*s.yy, z, texel.zw)))/6.+
				   (texture2D(gm_BaseTexture, clamp(v_vTexcoord + texel.xy*a.xy, z, texel.zw))+
					texture2D(gm_BaseTexture, clamp(v_vTexcoord - texel.xy*a.xy, z, texel.zw))+
					texture2D(gm_BaseTexture, clamp(v_vTexcoord + texel.xy*a.yx, z, texel.zw))+
					texture2D(gm_BaseTexture, clamp(v_vTexcoord - texel.xy*a.yx, z, texel.zw)))/12.;
}