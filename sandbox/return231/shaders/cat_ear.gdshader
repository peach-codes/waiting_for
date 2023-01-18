shader_type spatial;

void fragment() {
	ALBEDO = vec3(0.5, 0.2, 0.2);
	ALPHA = 0.7;
	ROUGHNESS = 0.9;
	METALLIC = 0.0;
	IRRADIANCE = vec4(0.9, 0.0, 0.0, 0.9);
}
