shader_type spatial;

uniform float progress;

void vertex() {
	VERTEX.x += abs(sin(TIME * (1.0 - VERTEX.y)) / 10.0);
	VERTEX.y += abs(cos(TIME * (1.0 - VERTEX.y)) / 10.0);
}

void fragment() {
	ALPHA = 1.0 - progress;
	ALBEDO = vec3(0.9, 0.20, 0.13);
}
