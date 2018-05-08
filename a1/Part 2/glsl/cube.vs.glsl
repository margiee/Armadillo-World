varying vec3 interpolatedNormal;
varying float brightness;
varying float distance;

uniform vec3 cubePosition;
uniform vec3 lightPosition;
uniform float cubeAngle;

varying vec3 color;

void main() {
	float s = sin(cubeAngle);
	float c = cos(cubeAngle);
	
	// rotate around z-axis
	mat3 rotationMatrix = mat3(c, s, 0,
	                          -s, c, 0, 
					           0, 0, 1);
	vec3 rotatePosition = (rotationMatrix * position) + cubePosition;
	
	interpolatedNormal = normal;

	vec3 directionVector = lightPosition - cubePosition;
	distance = length(directionVector);

	// brightness is cos(angle)	
	brightness = dot(normal, directionVector) / (distance * length(normal));
	
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * (vec4(rotatePosition, 1.0) +  vec4(cubePosition, 0.0));

}
