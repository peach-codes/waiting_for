#ifdef GL_ES
precision mediump float;
#endif
// some base functions from below (book of shaders examples)
// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com
#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform float u_time;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

mat2 scale(vec2 _scale){
    return mat2(_scale.x,0.0,
                0.0,_scale.y);
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

float cross(in vec2 _st, float _size){
    return  box(_st, vec2(_size,_size/4.)) +
            box(_st, vec2(_size/4.,_size));
}

vec3 draw_rect(in vec3 in_color, in float width, in float height, in float weight){
    // NOTE THIS IS CURRENLTY HARDCODED FOR A 1.0 x 1.0 DOMAIN
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = in_color;
    float s_margin = (1.0 - width) / 2.0;
    float h_margin = (1.0 - height) / 2.0;
	
    bvec4 l_vec = bvec4(false); // left, bottom, right, top
    l_vec[0] = bool(step(s_margin, st.x));
    l_vec[1] = bool(step(h_margin, st.y));
	l_vec[2] = bool(step(s_margin, 1.0 - st.x));
    l_vec[3] = bool(step(h_margin, 1.0 - st.y));
    
    // multiplication for the "in"
    float pct = float(l_vec[0]);
    pct *= float(l_vec[1]);  
    pct *= float(l_vec[2]);
    pct *= float(l_vec[3]);
    
    bvec4 bbl = bvec4(true); // left, bottom, right, top
    bbl[0] = !bool(step(s_margin - weight, st.x));
    bbl[1] = !bool(step(h_margin - weight, st.y));
    bbl[2] = !bool(step(s_margin - weight, 1.0 - st.x));
    bbl[3] = !bool(step(h_margin - weight, 1.0 - st.y));
    // interestingly has to be addition here for the cutout
    pct += float(bbl[0]);
    pct += float(bbl[1]);
    pct += float(bbl[2]);
    pct += float(bbl[3]);

    //gl_FragColor = vec4(in_color * float(!bool(pct)),1.0);
    return in_color * float(!bool(pct));
}

vec3 draw_multi_rect(in vec3 in_color, in float slow){
    vec2 st = gl_FragCoord.xy/u_resolution;
    st.x *= u_resolution.x/u_resolution.y;
  	vec3 ret_color = vec3(0);
    vec3 color = vec3(0.0);
  	float d = 0.0;
  	// Remap the space to -1. to 1.
  	st = st * 2.0 -1.0;
    st.x -= 0.05; // hmm, seems to be right, although it was first guess
  	// Angle and radius from the current pixel
  	float a = atan(st.x,st.y)+PI;
  	float r = TWO_PI/float(4); // hardcoded change from "N"
  	// Shaping function that modulate the distance (magic still)
  	d = cos(floor(.5+a/r)*r-a)*length(st);
    
    float incr = 1.0 / 4.0;
    float tmp = 0.0;
    for(float i = 1.0; i < 5.0; i++){
        tmp = i * incr;
        color += vec3(1.0 - smoothstep(tmp, tmp + 0.01, fract(d - u_time / slow)));
    	color -= vec3(1.0 - smoothstep(tmp - 0.008, tmp - 0.007, fract(d - u_time / slow)));
    }
    
    ret_color = color * in_color;;
    return ret_color;
}

vec3 draw_my_shakey_shape(in vec3 in_color, in int N, in float base_rot, in float shake_rot, in float speed, in vec2 squash, in vec2 offset){
    vec2 st = gl_FragCoord.xy/u_resolution;
    st.x *= u_resolution.x/u_resolution.y;
  	vec3 ret_color = vec3(0);
    vec3 mask = vec3(0.0);
  	float d = 0.0;
  	// Remap the space to -1. to 1.
  	st = st * 2.0 -1.0;
   	st += offset;
    // rotations. base, then shake
    st = rotate2d(base_rot) * st;
    st = rotate2d(shake_rot * cos(u_time / speed)) * st;
    st = scale(squash) * st;
  	// Angle and radius from the current pixel
  	float a = atan(st.x,st.y)+PI;
  	float r = TWO_PI/float(N);
  	// Shaping function that modulate the distance (magic still)
  	d = cos(floor(.5+a/r)*r-a)*length(st);
    // mask
    mask += vec3(1.0 - smoothstep(0.54, 0.541, d));
    mask -= vec3(1.0 - smoothstep(0.52, 0.521, d));
    
    ret_color = mask * in_color;
    return ret_color;
}

vec3 draw_circ(in vec3 in_color, in float radius, in vec2 center){
    vec2 st = gl_FragCoord.xy/u_resolution;
    float pct = 0.0;
    
    pct = float(!bool(step(radius, distance(st, center))));
    vec3 color = pct * in_color;
    return color;
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution;
    st = st * 2.0 -1.0;
    vec3 color = vec3(abs(cos(u_time * 0.35)), 0.2, 0.65); // boxes
    vec3 my_color = vec3(0.087, 0.035, 0.11) * 0.5 * (1.0 + cos(15.0 * distance(st, vec2(0.0)) + u_time)); // background
    vec3 sway_color = vec3(0.1, 0.6, 0.2 + 0.2 * cos(u_time)); // hud
    vec3 ind_color = vec3(0.4, 0.2, 0.3);; // circles
    vec2 tri_offset = vec2(-0.05, -0.20);
    vec2 aim_offset = vec2(-0.05, -0.04);
    vec2 cross_coords = st * rotate2d(PI / 4.0) + vec2(0.5);
    float var = 0.041 * cos(2.3 * u_time); 

    my_color += draw_circ(ind_color, 0.03, vec2(0.5, 0.075)); // bottom
    my_color += draw_circ(ind_color, 0.027, vec2(0.06, 0.87)); // left
    my_color += draw_circ(ind_color, 0.027, vec2(0.94, 0.87)); // right
    my_color += draw_rect(vec3(0.0, 0.073, 0.057) * abs(cos(u_time / 3.0)), 0.0175 + var * 0.5, 0.0135, 0.25); // rect
    my_color += draw_multi_rect(color, 12.0); // zooooom
    my_color += draw_my_shakey_shape(sway_color, 3, PI, PI / 60.0, 0.6, vec2(1.0), tri_offset); // sway tri
    my_color += draw_my_shakey_shape(sway_color - vec3(0.2), 4, PI / 2.0, PI / 30.0, 0.6, vec2(5.0, 0.778), aim_offset); // squat box
    my_color += draw_my_shakey_shape(sway_color + vec3(0.9, 0.3, 0.1), 4, PI / 2.0, PI / 25.0, 0.6, vec2(0.5, 12.0), aim_offset); // tall box
    cross_coords += 0.025 * vec2(-cos(u_time), cos(u_time)); // middle cross sway
    my_color += cross(cross_coords, 0.05) * vec3(0.87, 0.03, 0.2);
    
    my_color = clamp(my_color, vec3(0.0), vec3(0.9));
    gl_FragColor = vec4( my_color, 1.0 );
}