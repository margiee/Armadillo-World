varying vec3 normalVector;
varying vec3 positionVector;
varying vec3 lightVector;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;
uniform vec3 objectColor;
uniform vec3 coolColor;
uniform vec3 warmColor;


void main() {

	// pass normal and position to fragment shader
	normalVector = normalMatrix * normal;
	positionVector = vec3(modelViewMatrix * vec4(position, 1.0));
	lightVector = vec3(viewMatrix * vec4(lightDirection, 0.0));
	
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}