shader_type spatial;

void fragment() {
	ALBEDO = vec3(0.2, 0.4, 0.3);
	if(sin(TIME * VERTEX.x) > 0.98){
		ALBEDO += vec3(0.3, 0.0, 0.0);
	}
}
