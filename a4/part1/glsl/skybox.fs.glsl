// UNIFORMS
uniform samplerCube skybox;

varying vec3 Normal_V;
varying vec3 Position_V;
varying vec3 cameraPos;
varying vec3 texCoords;

void main() {
	vec3 normalVec = normalize(Normal_V);
	vec3 positionVec = normalize(-Position_V);
	vec4 fragColor = textureCube(skybox, texCoords);
	gl_FragColor = fragColor;
}