shader_type spatial;

void vertex() {
	VERTEX.x += sin(TIME / 2.0);
	VERTEX.z += 0.5 * (sin(TIME / 1.5) + 1.0) / 2.0;
	VERTEX.y += cos(TIME / PI) / 5.0;
}

void fragment() {
	ALBEDO = mix(vec3(1.0, 0.9, 0.3), vec3(0.0, 0.4, 0.7), sin(TIME));
}
