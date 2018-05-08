// The uniform variable is set up in the javascript code and the same for all vertices
// lightPosition is in world space
// Position is in Local/object space 

uniform vec3 lightPosition;
uniform vec3 cubePosition;
uniform vec3 cube2Position;
uniform vec3 cube3Position;
uniform vec3 cube4Position;

varying float cubeDist;
varying float cube2Dist;
varying float cube3Dist;
varying float cube4Dist;

void main() {
	/* HINT: WORK WITH lightPosition HERE! */
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	
	vec3 cubeDirection = lightPosition - cubePosition;
	cubeDist = length(cubeDirection);
	vec3 cube2Direction = lightPosition - cube2Position;
	cube2Dist = length(cube2Direction);
	vec3 cube3Direction = lightPosition - cube3Position;
	cube3Dist = length(cube3Direction);	
	vec3 cube4Direction = lightPosition - cube4Position;
	cube4Dist = length(cube4Direction);	
	
    gl_Position = projectionMatrix * modelViewMatrix * (vec4(position, 1.0) + vec4(lightPosition, 0.0));
}
