shader_type spatial;

uniform vec3 colors[2];
//uniform vec2 wave_direction;
uniform float ripple_seed;
uniform float time_bias;

varying float func_val;

void vertex() {
	// cos sum
	//float wave_pos = (wave_direction.x * VERTEX.x) + (wave_direction.y * VERTEX.z);
	//func_val = 0.5 * cos( ((2.0 * TIME) + wave_pos) / (2.0 * PI));

	// ripple
	float d = sqrt(VERTEX.x * VERTEX.x + VERTEX.z * VERTEX.z);
	func_val = sin(PI * (ripple_seed * d + (time_bias * TIME) ) );
	// this step is related to the REAL SIZE of the object
	VERTEX.y = 0.3 * func_val;
	VERTEX.y /= 0.04 + 0.030 * d;
	
	// cos sum
	//float f_x = -0.5 * wave_direction.x * sin( (2.0 * TIME + wave_pos) / (2.0 * PI));
	//float f_z = -0.5 * wave_direction.y * sin( (2.0 * TIME + wave_pos) / (2.0 * PI));
	
	// ripple
	float chain_rule_step = cos( PI * ( (ripple_seed * d) + (time_bias * TIME) ) );
	float f_x = ( (PI * ripple_seed * VERTEX.x) / d ) * chain_rule_step;
	float f_z = ( (PI * ripple_seed * VERTEX.z) / d ) * chain_rule_step;
	float mag = sqrt(1.0 + f_x * f_x + f_z * f_z);
	NORMAL = vec3(f_x/mag, 1.0/mag, f_z);
}

void fragment() {
	METALLIC = 0.0;
	ROUGHNESS = 0.1;
	ALBEDO = mix(colors[0], colors[1], func_val + 0.5);
}
