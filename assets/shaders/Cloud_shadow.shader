shader_type canvas_item;

uniform sampler2D fog_texture : hint_black;

void fragment() {
	
	vec2 uv = -UV + TIME * 0.005;
	COLOR.r = 0.0;
	COLOR.g = 0.0;
	COLOR.b = 0.0;
	COLOR.a = texture(fog_texture,uv).b * 0.2;
}