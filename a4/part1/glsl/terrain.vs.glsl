//VARYING VAR
varying vec3 Normal_V;
varying vec3 Position_V;
varying vec4 PositionFromLight_V;
varying vec2 Texcoord_V;
varying vec4 shadowCoord;


//UNIFORM VAR
// Inverse world matrix used to render the scene from the light POV
uniform mat4 lightViewMatrix;
// Projection matrix used to render the scene from the light POV
uniform mat4 lightProjectMatrix;


void main() {
	Normal_V = normalMatrix * normal;
	Position_V = vec3(modelViewMatrix * vec4(position, 1.0));
	Texcoord_V = uv;
	
	// translates coordinates from [-1, 1] to [0, 1]
	mat4 biasMatrix = mat4(0.5, 0.0, 0.0, 0.0, 
					       0.0, 0.5, 0.0, 0.0, 
					       0.0, 0.0, 0.5, 0.0,
					       0.5, 0.5, 0.5, 1.0);
	
	// texture coordinates
	shadowCoord = biasMatrix * lightProjectMatrix * lightViewMatrix * modelMatrix * vec4(position, 1.0);
	
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}