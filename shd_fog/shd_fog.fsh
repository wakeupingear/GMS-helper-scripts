 varying vec2 v_vTexcoord;
    uniform float time;
	uniform vec3 fog_color;
	uniform float alpha;
	uniform float stepNum;
    //velocity vectors
    const vec2 A_dir = vec2(0.76604,0.64279);
    const vec2 B_dir = vec2(0.58207,-0.48841);
    const vec2 C_dir = vec2(0.54253,0.19747);
    const vec2 D_dir = vec2(0.41224,-0.15004);
    const vec2 E_dir = vec2(0.33333,0.00000);
    void main() {
		float tP=time;
        float A = texture2D( gm_BaseTexture, (v_vTexcoord + A_dir * tP) * 1.000000000).r;
        float B = texture2D( gm_BaseTexture, (v_vTexcoord + B_dir * tP) * 0.759835686).r;
        float C = texture2D( gm_BaseTexture, (v_vTexcoord + C_dir * tP) * 0.577350269).r;
        float D = texture2D( gm_BaseTexture, (v_vTexcoord + D_dir * tP) * 0.438691338).r;
        float E = texture2D( gm_BaseTexture, (v_vTexcoord + E_dir * tP) * 0.333333333).r;
 
        //changes how much each component affects the fog density.
        E = pow(max(0.0,E),1.000000000); //affects most
        D = pow(max(0.0,D),0.759835686);
        C = pow(max(0.0,C),0.577350269);
        B = pow(max(0.0,B),0.438691338);
        A = pow(max(0.0,A),0.333333333); //affects least
 
        float fog = A*B*C*D*E;
		fog=floor(fog*stepNum)/stepNum;
 
        //At this point there are any number of operations you can perform on "float fog"
        //in order to increase or reduce the level of fog
        //or to make the fog appear more patchy or more uniform
        //For example, to make the fog much thinner, you could multiply "fog" by itself a few times:
        //fog = fog * fog * fog;
 
        gl_FragColor = vec4(fog_color,fog*alpha);
    }