// Create shared variable. The value is given as the interpolation between normals computed in the vertex shader
varying vec3 interpolatedNormal;
varying float brightness;
varying float distance;


/* HINT: YOU WILL NEED MORE SHARED/UNIFORM VARIABLES TO COLOR ACCORDING TO COS(ANGLE) */

void main() {
  // Set final rendered color according to the surface normal
  // normalize returns a vector with the same direction as its parameter
  
  //gl_FragColor = vec4(normalize(interpolatedNormal), 1.0); // REPLACE ME

   if (distance < 3.0) {
      gl_FragColor = vec4(0, -brightness, 0, 1.0);
	  } else {
	  gl_FragColor = vec4(-brightness, -brightness, -brightness, 1.0);
	  } 
}
