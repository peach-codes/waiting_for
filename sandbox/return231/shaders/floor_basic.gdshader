shader_type spatial;

uniform float test;
uniform float points[10]; // MUST be even

void vertex() {
	float dist_array[5]; // MUST be half of points length
	float min_dist = 10000.0; // wayyy too high
	
	// unique clustering points for the ripples combined, kinda...
	for(int i = 0; i < dist_array.length(); i++) {
		float raw_dist = ( ( VERTEX.x - points[(2 * i)] ) * ( VERTEX.x - points[(2 * i)] ) );
		raw_dist += ( ( VERTEX.z - points[(2 * i) + 1] ) * ( VERTEX.z - points[(2 * i) + 1] ) );
		dist_array[i] = sqrt(raw_dist);
	}
	for (int i = 0; i < dist_array.length(); i ++) {
		if (dist_array[i] < min_dist) {
			min_dist = dist_array[i];
		}
	}
	float dist = sqrt(VERTEX.x * VERTEX.x + VERTEX.z * VERTEX.z);
	COLOR = vec4(0.5 * (cos(min_dist + TIME) + 1.0) , 0.1, 0.2, 1.0);
}

void fragment() { 
	ALBEDO = COLOR.xyz;
	ROUGHNESS = 0.8;
	METALLIC = 0.1;
	ALPHA = 1.0;
}
