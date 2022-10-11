shader_type particles;

float rand_from_seed(in uint seed) {
  int k;
  int s = int(seed);
  if (s == 0)
    s = 305420679;
  k = s / 127773;
  s = 16807 * (s - k * 127773) - 2836 * k;
  if (s < 0)
    s += 2147483647;
  seed = uint(s);
  return float(seed % uint(65536)) / 65535.0;
}

uint hash(uint x) {
  x = ((x >> uint(16)) ^ x) * uint(73244475);
  x = ((x >> uint(16)) ^ x) * uint(73244475);
  x = (x >> uint(16)) ^ x;
  return x;
}

uniform float SCALE = 0.1;
uniform vec3 START_POS = vec3(0.0, 0.0, 0.0);

void start() {
	// sloppy as hell
	//TRANSFORM[3].xyz = vec3(0.0, 0.0, 15.0 * rand_from_seed(INDEX + hash(INDEX)));
	TRANSFORM[3].xyz = START_POS;
	TRANSFORM[0].x = SCALE;
	TRANSFORM[1].y = SCALE;
	TRANSFORM[2].z = SCALE;
	
	VELOCITY.x = cos(float(NUMBER)) * SCALE;
	VELOCITY.z = sin(float(NUMBER)) * SCALE;
	VELOCITY.y = -2.0 * SCALE;
}

void process() {
	vec3 my_color = vec3(0.0, 0.9, 0.0);
	if (! RESTART) {
		VELOCITY.y += 0.0095 * SCALE;
		// height masking
		float n_dist = distance(TRANSFORM[3].y, 10.0) / 10.0;
		float mask = smoothstep(0.0, 0.5, 1.0 - n_dist);
		COLOR = vec4(mask * my_color, 1.0);
	}
}
