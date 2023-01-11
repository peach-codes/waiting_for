shader_type spatial;
render_mode blend_mix;

uniform vec3 color_in[2];
// + color_in * (sin(TIME / 10.0) + 1.0) / 2.0;
uniform float exit_progress;
uniform float start_progress;
render_mode specular_toon;

void fragment() {
	ROUGHNESS = 0.1;
	METALLIC = 0.1;
	//ALBEDO = mix(vec3(0.0, 0.0, 0.0), color_in[0], exit_progress);
	ALBEDO = vec3(0.0, 0.0, 0.0);
	ALBEDO += color_in[1] * 0.5 * (sin(start_progress * TIME * 2.0));
	//
	//ALBEDO += color_in[0];
	//ALBEDO += color_in[1] * ((sin(TIME + sqrt(VERTEX.x * VERTEX.x + VERTEX.y * VERTEX.y)) + 1.0) / 2.0);
}
