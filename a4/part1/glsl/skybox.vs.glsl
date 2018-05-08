varying vec3 Normal_V;
varying vec3 Position_V;
varying vec3 cameraPos;
varying vec3 texCoords;

void main() {
	Normal_V = normalMatrix * normal;
	Position_V = vec3(modelViewMatrix * vec4(position, 1.0));
	cameraPos = cameraPosition;
	vec3 worldPosition = vec3(modelMatrix * vec4(position, 1.0));
	texCoords = worldPosition;
	
	// make skybox static
	gl_Position = projectionMatrix * viewMatrix * vec4(worldPosition + cameraPosition, 1.0);
	
	// to bind the vertices from -1 to 1
	gl_Position.z = gl_Position.w;
}