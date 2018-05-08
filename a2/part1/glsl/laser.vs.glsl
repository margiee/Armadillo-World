// Shared variable passed to the fragment shader

uniform vec3 laserPosition;
uniform vec3 lightPosition;

void main() {
  
  vec3 directionVector = laserPosition - lightPosition;
  float d = length(directionVector) * 0.5;
  // scale the laser
  mat4 scaleMatrix = mat4(1, 0.0, 0.0, 0.0,
						  0.0, d, 0.0, 0.0, 
						  0.0, 0.0, 1, 0.0,
						  0.0, 0.0, 0.0,  1.0);
  
  // rotate the laser
  // 90 degrees is 1.5708rad
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
  // rotate around z-axis
  mat4 zRotationMatrix = mat4(  c,   s, 0.0, 0.0,
							   -s,   c, 0.0, 0.0, 
							  0.0, 0.0, 1.0, 0.0,
							  0.0, 0.0, 0.0, 1.0);
							  
  mat4 rotationMatrix = xRotationMatrix * yRotationMatrix;
  
  
  // lookAt Matrix
  vec3 up = vec3(0.0, 1.0, 0.0);
  vec3 z = normalize(laserPosition - lightPosition);
  vec3 x = normalize(cross(up, z));
  vec3 y = cross(z, x);
  mat4 lookAtMatrix = mat4(vec4(x,0.0), vec4(y,0.0), vec4(z,0.0), vec4(laserPosition, 1.0));
  
  
  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position

  gl_Position = projectionMatrix * viewMatrix *lookAtMatrix * rotationMatrix * scaleMatrix * vec4(position, 1.0);
}
