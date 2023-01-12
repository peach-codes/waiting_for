shader_type spatial;
// did the editor freeze?

void vertex() {
	VERTEX.x += 0.15 * sin(TIME * VERTEX.y);
	VERTEX.z += 0.15 * cos(TIME * VERTEX.y);
}

void fragment() {
	METALLIC = 0.0;
	ROUGHNESS = 0.1;
	ALBEDO = vec3(0.32, 0.766, 0.21);
	ALPHA = 0.84;
}
