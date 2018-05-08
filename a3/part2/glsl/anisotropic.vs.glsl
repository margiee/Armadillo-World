varying vec3 normalVector;
varying vec3 positionVector;
varying vec3 lightVector;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
uniform float alphaX;
uniform float alphaY;

void main() {
	// pass normal and position to fragment shader
	normalVector = normalMatrix * normal;
	positionVector = vec3(modelViewMatrix * vec4(position, 1.0));
	lightVector = vec3(viewMatrix * vec4(lightDirection, 0.0));
	
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}