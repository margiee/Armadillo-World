varying float cubeDist;
varying float cube2Dist;
varying float cube3Dist;
varying float cube4Dist;


void main() {

	if (cubeDist < 3.0) {
		gl_FragColor = vec4(1, 0, 0, 1);
	} else if (cube2Dist < 3.0) {
		gl_FragColor = vec4(1, 0, 1, 1);
	} else if (cube3Dist < 3.0) {
		gl_FragColor = vec4(0, 0, 1, 1);
	} else if (cube4Dist < 3.0) {
		gl_FragColor = vec4(0, 1, 1, 1);
	} else {
	// Set constant color
	gl_FragColor = vec4(1, 1, 0, 1);
	}
}