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

	vec3 toLight = normalize(lightVector);
	vec3 normalVec = normalize(normalVector);
	vec3 toV = normalize(-positionVector);
	
	float diffuse = max(0.0, dot(normalVec, toLight));
	float interpolationValue = (1.0 + diffuse) / 2.0;
	
	vec3 warmColorMod = warmColor + objectColor * 0.1;
	vec3 coolColorMod = coolColor + objectColor * 0.5;
	
	// the lower the light intensity, the larger of coolColor is used 
	vec3 TOTAL = mix(coolColorMod, warmColorMod, interpolationValue);
	
	gl_FragColor = vec4(TOTAL, 0.0);

}