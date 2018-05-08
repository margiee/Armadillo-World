varying vec3 interpolatedNormal;
varying float brightness;
varying float distance;

uniform vec3 cube4Position;
uniform vec3 lightPosition;
uniform float cube4Angle;

void main() {
	float s = sin(cube4Angle);
	float c = cos(cube4Angle);

	// rotate cube around x-axis
	mat3 rotationMatrix = mat3(1, 0, 0,
	                           0, c, s, 
					           0, -s, c);
					   
	// rotate around y-axis
	mat3 rotationMatrix2 = mat3(c, 0, -s,
						        0, 1, 0,
						        s, 0, c);

	vec3 rotatePosition =  rotationMatrix2 * (rotationMatrix * position) + cube4Position; 
	
	interpolatedNormal = normal;

	vec3 directionVector = lightPosition - cube4Position;
	distance = length(directionVector);

	// brightness is cos(angle)	
	brightness = dot(normal, directionVector) / (distance * length(normal));
	
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * (vec4(rotatePosition, 1.0) +  vec4(cube4Position, 0.0));

}