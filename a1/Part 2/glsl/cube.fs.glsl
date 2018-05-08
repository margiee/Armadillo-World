varying vec3 interpolatedNormal;
varying float brightness;
varying float distance;

void main() {

   if (distance < 3.0) {
      gl_FragColor = vec4(brightness, 0, 0, 1.0);
	  } else {
	  gl_FragColor = vec4(brightness, brightness, brightness, 1.0);
	  } 

}