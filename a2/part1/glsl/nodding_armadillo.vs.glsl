// Shared variable passed to the fragment shader
varying vec3 color;

// rotation angle gets updated 
// Constant set via your javascript code
uniform float rotationAngle;


void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);
	
	vec4 newPosition = vec4(position, 1.0);
	
	// Identifying the head
	// origin for the next (0.0, 1.0, -0.3)
	if (position.z < -0.33 && abs(position.x) < 0.46) {
		// color = vec3(1.0, 0.0, 1.0); purple, all vertices are in the head
		
		// v' = TRT^-1v (position)
		
		mat4 translationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
							          0.0, 1.0, 0.0, 0.0, 
							          0.0, 0.0, 1.0, 0.0,
							          0.0, 2.5, -0.25, 1.0);
    	
		float s = sin(rotationAngle);
		float c = cos(rotationAngle);
        mat4 xRotationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
									0.0, c,    -s, 0.0, 
									0.0, s,     c, 0.0,
									0.0, 0.0, 0.0, 1.0);									  
		
		mat4 translationInverseMatrix = mat4(1.0, 0.0, 0.0, 0.0,
											 0.0, 1.0, 0.0, 0.0, 
											 0.0, 0.0, 1.0, 0.0,
											 0.0, -2.5, 0.25, 1.0);

		newPosition = translationMatrix * xRotationMatrix * translationInverseMatrix * newPosition;					  
	}
	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * newPosition;
}
