shader_type canvas_item;

uniform sampler2D noise;
uniform int pixelSize = 2;

uniform vec4 tint_color : hint_color;

void fragment() {
	ivec2 size = textureSize(TEXTURE, 0);
	
	int xRes = size.x;
	int yRes = size.y;
	
	float xFactor = float(xRes) / float(pixelSize);
	float yFactor = float(yRes) / float(pixelSize);
	
	float grid_uv_x = round(UV.x * xFactor) / xFactor;
	float grid_uv_y = round(UV.y * yFactor) / yFactor;
	vec4 rand_green = texture(noise, vec2(grid_uv_x, grid_uv_y)).rgba;
    vec4 cur_pixel = texture(TEXTURE, UV);
	vec4 color = mix(tint_color, rand_green, 0.3);
	
	COLOR = color;
	COLOR.a = cur_pixel.a;
}