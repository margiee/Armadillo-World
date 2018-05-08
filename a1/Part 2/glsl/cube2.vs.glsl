varying vec3 interpolatedNormal;
varying float brightness;
varying float distance;

uniform vec3 cube2Position;
uniform vec3 lightPosition;
uniform float cube2Angle;

void main() {
	float s = sin(cube2Angle);
	float c = cos(cube2Angle);
	
	// rotate cube around x-axis
	mat3 rotationMatrix = mat3(1, 0, 0,
	                           0, c, s, 
					           0, -s, c);
	vec3 rotatePosition = (rotationMatrix * position) + cube2Position;
	
	interpolatedNormal = normal;

	vec3 directionVector = lightPosition - cube2Position;
	distance = length(directionVector);

	// brightness is cos(angle)	
	brightness = dot(normal, directionVector) / (distance * length(normal));
	
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * (vec4(rotatePosition, 1.0) +  vec4(cube2Position, 0.0));

}