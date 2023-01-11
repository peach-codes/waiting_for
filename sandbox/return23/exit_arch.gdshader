shader_type spatial;
render_mode specular_toon;

void fragment() {
	ROUGHNESS = 0.3;
	METALLIC = 0.0;
	ALBEDO = vec3(0.54, 0.4, 0.14);
}
