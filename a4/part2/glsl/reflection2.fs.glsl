// UNIFORMS
uniform samplerCube skybox;

varying vec3 Normal_V;
varying vec3 Position_V;
varying vec3 cameraPos;
varying vec3 texCoords;
varying mat4 viewM;

void main() {
	vec3 normalVec = normalize(Normal_V);
	vec3 positionVec = normalize(-Position_V);
	
	vec3 I = normalize(positionVec - cameraPos);
	vec3 R = reflect(I, normalVec); 
	
	vec4 texColor = textureCube(skybox, R);
	
	gl_FragColor = vec4(texColor.r, texColor.g, texColor.b, 1.0);
}