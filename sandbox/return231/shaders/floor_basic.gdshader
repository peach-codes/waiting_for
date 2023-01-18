shader_type spatial;

void vertex() {
	float dist = sqrt(VERTEX.x * VERTEX.x + VERTEX.z * VERTEX.z);
	COLOR = vec4(0.5 * (cos(dist + TIME) + 1.0) , 0.1, 0.2, 1.0);
}

void fragment() { 
	ALBEDO = COLOR.xyz;
	ROUGHNESS = 0.1;
	METALLIC = 1.0;
}
