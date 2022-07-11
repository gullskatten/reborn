shader_type canvas_item;

uniform sampler2D fog_texture : hint_black;

void fragment() {
	vec2 uv = -UV + TIME * 0.01;
	vec4 ccolor = texture(fog_texture,uv);
	COLOR = ccolor;
	COLOR.a = ccolor.b * 0.7;
}