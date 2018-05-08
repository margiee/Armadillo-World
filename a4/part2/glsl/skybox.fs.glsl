// UNIFORMS
uniform samplerCube skybox;

varying vec3 Normal_V;
varying vec3 Position_V;
varying vec3 cameraPos;
varying vec3 texCoords;

void main() {
	vec3 normalVec = normalize(Normal_V);
	vec3 positionVec = normalize(-Position_V);
	
//	vec3 reflectVec = -positionVec + normalVec * (dot(positionVec, normalVec) * 2.0);
//	vec4 texColor = textureCube(skybox, reflectVec);
	vec3 R = reflect(positionVec, normalVec);
	vec4 texColor = textureCube(skybox, R);
	
	vec4 fragColor = textureCube(skybox, texCoords);
	
//	gl_FragColor = vec4(texColor.r, texColor.g, texColor.b, 1.0);
	gl_FragColor = fragColor;
}