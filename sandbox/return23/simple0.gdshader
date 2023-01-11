shader_type spatial;
render_mode blend_mix;

uniform vec3 color_in[2];
// + color_in * (sin(TIME / 10.0) + 1.0) / 2.0;
uniform float progress;
render_mode specular_toon;

void fragment() {
	ROUGHNESS = 0.1;
	METALLIC = 0.1;
	ALBEDO = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 0.8, 0.75), progress);
	//
	//ALBEDO += color_in[0];
	//ALBEDO += color_in[1] * ((sin(TIME + sqrt(VERTEX.x * VERTEX.x + VERTEX.y * VERTEX.y)) + 1.0) / 2.0);
}
