shader_type spatial;

void vertex() {
	VERTEX.x += 0.35 * sin(TIME) * (1.0 / (1.2 - VERTEX.y) );
}
void fragment() {
	ALBEDO = vec3(0.3, 0.2, 0.2);
	ROUGHNESS = 0.9;
	METALLIC = 0.0;
}
