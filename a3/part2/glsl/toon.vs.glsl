varying vec3 normalVector;
varying vec3 positionVector;
varying vec3 lightVector;


uniform vec3 lightDirection;

void main() {
	normalVector = normalMatrix * normal;
	positionVector = vec3(modelViewMatrix * vec4(position, 0.0));
	lightVector = vec3(viewMatrix * vec4(lightDirection, 0.0));
	
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}