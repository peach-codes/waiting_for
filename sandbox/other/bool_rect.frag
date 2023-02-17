#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

void draw_rect(in vec3 in_color, in float width, in float height, in float weight){
    // NOTE THIS IS CURRENLTY HARDCODED FOR A 1.0 x 1.0 SQUARE
    // THIS WILL NOT WORK OUTSIDE OF THAT
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

    gl_FragColor = vec4(in_color * float(!bool(pct)),1.0);
}

void main(){
    draw_rect(vec3(0.9, 0.1, 0.8), 0.365, 0.719, 0.0053);
}