varying vec3 normalVector;
varying vec3 positionVector;
varying vec3 lightVector;

uniform vec3 lightDirection;

void main() {

	vec3 toLight = normalize(lightVector);
	vec3 normalVec = normalize(normalVector);
	vec3 positionVec = normalize(-positionVector);

	//TOTAL INTENSITY
	//TODO PART 1D: calculate light intensity (diffuse)
	
	float lightIntensity = dot(toLight, normalVec); 

   	vec4 resultingColor = vec4(0.0,0.0,0.0,0.0);

   	//TODO PART 1D: change resultingColor based on lightIntensity (toon shading)

   	//TODO PART 1D: change resultingColor to silhouette objects
	
	if (lightIntensity > 0.4)
		resultingColor = vec4(1.0, 1.0, 1.0, 1.0);
	else if (lightIntensity > 0.2)
		resultingColor = vec4(0.8, 0.8, 0.99, 1.0);
	else if (lightIntensity > 0.0)
		resultingColor = vec4(0.5, 0.5, 0.88, 1.0);
	else if (lightIntensity > -0.2)
		resultingColor = vec4(0.3, 0.3, 0.66, 1.0);
	else
		resultingColor = vec4(0.1, 0.1, 0.33, 1.0);
		
	// check for silhouette edges
	float silhouette = abs(dot(normalVec, positionVec));
	if (silhouette < 0.15)
		resultingColor = vec4(0.05, 0.05, 0.15, 1.0);
	
	
	gl_FragColor = resultingColor;
}
