shader_type canvas_item;
render_mode unshaded;
 
uniform bool active = true;
uniform float strength = 8.0;
uniform float width : hint_range(0.0, 16.0);
uniform vec4 outline_color : hint_color;
const float DIAG = 0.707;
 
void fragment()
{
    if(!active) {
		COLOR = texture(TEXTURE, UV);
	}
	else {
		vec2 size = vec2(width) / vec2(textureSize(TEXTURE, 0));
	   
	    vec4 sprite_color = texture(TEXTURE, UV);
	   
	    float alpha = sprite_color.a;
	    alpha += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
	    alpha += texture(TEXTURE, UV + vec2(size.x*DIAG, -size.y*DIAG)).a;
	    alpha += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
	    alpha += texture(TEXTURE, UV + vec2(size.x*DIAG, size.y*DIAG)).a;
	    alpha += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
	    alpha += texture(TEXTURE, UV + vec2(-size.x*DIAG, size.y*DIAG)).a;
	    alpha += texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
	    alpha += texture(TEXTURE, UV + vec2(-size.x*DIAG, -size.y*DIAG)).a;
	   
	    vec3 final_color = mix(outline_color.rgb, sprite_color.rgb, sprite_color.a*outline_color.a);
	    COLOR = vec4(final_color.rgb, clamp(alpha/8.0*strength, 0.0, 1.0));
	}
}