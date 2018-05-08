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

void main() {

	vec3 toLight = normalize(lightVector);
	vec3 normalVec = normalize(normalVector);
	float diffuse = max(0.0, dot(normalVec, toLight));
	
	vec3 toV = normalize(-positionVector);
	vec3 halfVector = normalize(toLight + toV);
	
	float specular = pow(max(0.0, dot(halfVector, normalVec)), shininess);
	
	//AMBIENT
	vec3 light_AMB = kAmbient * ambientColor;

	//DIFFUSE
	vec3 light_DFF = diffuse * lightColor * kDiffuse;

	//SPECULAR
	vec3 light_SPC = specular * lightColor * kSpecular;

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);

}