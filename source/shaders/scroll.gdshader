shader_type canvas_item;

uniform float scroll_speed = 10;

void vertex() {
}

void fragment() {
vec2 uv = UV;

uv.x += scroll_speed * TIME;

uv = mod(uv, 1.0);

COLOR = texture(TEXTURE, uv);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
