varying vec3 interpolatedNormal;
varying float brightness;
varying float distance;

uniform vec3 lightPosition; 


void main() {

    interpolatedNormal = normal;
	
	// make position into world coordinates
	vec4 globalPosition = modelMatrix * vec4(position, 1.0);
	vec3 directionVector = lightPosition - globalPosition.xyz;
	distance = length(directionVector);

	// brightness is cos(angle)	
	brightness = dot(normal, directionVector) / (distance * length(normal));

    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}