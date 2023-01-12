shader_type spatial;
// lol, "brick"
// guess I would actually neeed to parameterize the surface
const int resolution = 10;
//const float height = 1.6; // sloppppyyyy
const float epsilon = 0.25;
//const float my_step = height / float(resolution);

bool is_in_line(float y_val) {
	//float lines[resolution];
	//for (int i = 0; i < resolution; i++) {
	//	lines[i] = float((i+1)) * my_step; 
	//}
	bool retval = false;
	float scaled_y = abs(y_val + 0.05) * float(resolution);
	if ( (scaled_y - floor(scaled_y)) < epsilon) {
		retval = true;
	}
	return retval;
}

void vertex() {
	if (is_in_line(VERTEX.y)) {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}
	else {
		COLOR = vec4(0.65, 0.0, 0.0, 1.0);
	}
}

void fragment() {
	ALBEDO = COLOR.rgb; // will have to do for now
}
