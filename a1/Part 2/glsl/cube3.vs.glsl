varying vec3 interpolatedNormal;
varying float brightness;
varying float distance;

uniform vec3 cube3Position;
uniform vec3 lightPosition;
uniform float cube3Angle;

void main() {
	float s = sin(cube3Angle);
	float c = cos(cube3Angle);

	// rotate cube around y-axis
	mat3 rotationMatrix = mat3(c, 0, -s,
	                           0, 1, 0, 
					           s, 0, c);
	vec3 rotatePosition = (rotationMatrix * position) + cube3Position;
	
	interpolatedNormal = normal;

	vec3 directionVector = lightPosition - cube3Position;
	distance = length(directionVector);

	// brightness is cos(angle)	
	brightness = dot(normal, directionVector) / (distance * length(normal));
	
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * (vec4(rotatePosition, 1.0) +  vec4(cube3Position, 0.0));
	
	

}