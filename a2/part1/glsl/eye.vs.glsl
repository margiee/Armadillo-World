// Shared variable passed to the fragment shader
varying vec3 color;
uniform vec3 eyePosition;
uniform vec3 lightPosition;
#define MAX_EYE_DEPTH 0.15

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  // position is in local space, assuming radius 1
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);
  
  
  // translate the eye
  mat4 translationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
								0.0, 1.0, 0.0, 0.0,
								0.0, 0.0, 1.0, 0.0, 
								vec4(eyePosition, 1.0)); 
  
  // scale the eye
  mat4 scaleMatrix = mat4(0.07, 0.0, 0.0, 0.0,
						  0.0, 0.07, 0.0, 0.0, 
						  0.0, 0.0, 0.07, 0.0,
						  0.0, 0.0, 0.0,  1.0);
  
  // rotate the eye
  float angle = 1.5708;
  float s = sin(angle);
  float c = cos(angle);

  // rotate around x-axis
  mat4 xRotationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
							  0.0, c,    -s, 0.0, 
							  0.0, s,     c, 0.0,
							  0.0, 0.0, 0.0, 1.0);
  // rotate around y-axis
  mat4 yRotationMatrix = mat4(  c, 0.0,  -s, 0.0,
							  0.0, 1.0, 0.0, 0.0, 
							    s, 0.0,   c, 0.0,
							  0.0, 0.0, 0.0, 1.0);
  mat4 rotationMatrix = xRotationMatrix * yRotationMatrix;
  
  
  // lookAt Matrix
  vec3 up = vec3(0.0, 1.0, 0.0);
  vec3 z = normalize(eyePosition - lightPosition);
  vec3 x = normalize(cross(up, z));
  vec3 y = cross(z, x);
  mat4 lookAtMatrix = mat4(vec4(x,0.0), vec4(y,0.0), vec4(z,0.0), vec4(eyePosition, 1.0));
  
  
  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  // projectionMatrix * modelViewMatrix * translationMatrix  * lookAtMatrix * rotationMatrix * scaleMatrix
  gl_Position = projectionMatrix * viewMatrix * lookAtMatrix * rotationMatrix * scaleMatrix * vec4(position, 1.0) ;
}
