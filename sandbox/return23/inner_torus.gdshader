shader_type spatial;

uniform vec3 heyo;

void vertex() {
	VERTEX.x += sin(TIME) * 0.55;
	VERTEX.z += cos(TIME) * 0.55;
}

void fragment() {
	ALPHA = 0.3;
	METALLIC = 0.0;
	ALBEDO = vec3(0.13, 0.0, 0.3);
	ALBEDO += heyo;
	
	FOG = vec4(1.0, 0.0, 0.0, 0.3);
	EMISSION = vec3(0.3, 0.1, 0.3);
}
