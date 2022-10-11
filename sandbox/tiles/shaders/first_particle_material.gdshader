shader_type spatial;

void vertex() {
	VERTEX = VERTEX;
}

void fragment() {
	METALLIC = 1.0;
	ROUGHNESS = 0.0;
	ALBEDO = COLOR.xyz; // comes from the particle shader!
	//EMISSION = vec3(0.05, 0.0, 0.0);
	RADIANCE = vec4(0.9, 0.2, 0.6, 0.3);
}
