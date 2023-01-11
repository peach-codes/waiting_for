shader_type spatial;

const float height = 1.0;
const float radius = 1.0;

// yellow center, pink/lavendar petals
// i used 5 petals (each rotated from the pivot) to make this effect

void vertex() {
	// these numbers, espeically the color blending, is basically random
	// went off of look instead of real math, sorryyy
	VERTEX.y = sqrt(2.0 * VERTEX.x * VERTEX.x + VERTEX.z * VERTEX.z);
	VERTEX.x += sin(TIME + VERTEX.x) * (VERTEX.y) / 3.0;
	VERTEX.z += sin(2.0 * TIME + VERTEX.x) * VERTEX.y / 3.0;
	COLOR = ((VERTEX.y - 0.6) / 2.0) * vec4(0.0, 0.0, 1.0, 1.0);
}

void fragment() {
	ALPHA = 0.5;
	ALBEDO = COLOR.xyz + vec3(0.3, 0.15, 0.1);
}
