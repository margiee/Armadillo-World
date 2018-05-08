varying vec3 Normal_V;
varying vec3 Position_V;
varying vec3 cameraPos;
varying vec3 texCoords;
varying mat4 viewM;

void main() {
	Normal_V = normalMatrix * normal;
	Position_V = vec3(modelViewMatrix * vec4(position, 1.0));
	cameraPos = cameraPosition;
	viewM = viewMatrix;
	gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}