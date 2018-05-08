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

	vec3 toLight = normalize(lightVector);
	vec3 normalVec = normalize(normalVector);
	float diffuse = max(0.0, dot(normalVec, toLight));
	
	vec3 toV = normalize(-positionVector);
	vec3 halfVector = normalize(toLight + toV);
	
	vec3 upVector = vec3(0.0, 1.0, 0.0);
	vec3 horizontalTangent = normalize(cross(normalVec, upVector));
	vec3 binormalDirection = normalize(cross(normalVec, horizontalTangent));
	
	float dotLN = dot(toLight, normalVec);
	float dotVN = dot(toV, normalVec);
	float dotHT = dot(halfVector, horizontalTangent);
	float dotHB = dot(halfVector, binormalDirection);
	float dotHN = dot(halfVector, normalVec);
	float dotHTAlphaX = dotHT/alphaX;
	float dotHBAlphaY = dotHB/alphaY;
	
	float specular = sqrt(max(0.0, dotLN/dotVN)) * exp(-2.0 * (dotHTAlphaX * dotHTAlphaX + dotHBAlphaY * dotHBAlphaY) / (1.0 + dotHN));
	
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