// Shared variable passed to the fragment shader
varying vec3 color;

// rotation angle gets updated 
// Constant set via your javascript code
uniform float rotationAngle;
uniform float armRotationAngle;
uniform float leftLegRotationAngle;
uniform float rightLegRotationAngle;

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
		  // rotate around x-axis
		mat4 xRotationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
									0.0, c,    -s, 0.0, 
									0.0, s,     c, 0.0,
									0.0, 0.0, 0.0, 1.0);
        mat4 yRotationMatrix = mat4(  c, 0.0,  -s, 0.0,
									0.0, 1.0, 0.0, 0.0, 
									  s, 0.0,   c, 0.0,
									0.0, 0.0, 0.0, 1.0);	
		mat4 rotationMatrix = xRotationMatrix * yRotationMatrix;
		
		mat4 translationInverseMatrix = mat4(1.0, 0.0, 0.0, 0.0,
											 0.0, 1.0, 0.0, 0.0, 
											 0.0, 0.0, 1.0, 0.0,
											 0.0, -2.5, 0.25, 1.0);

		newPosition = translationMatrix * rotationMatrix * translationInverseMatrix * newPosition;					  
	}
	
	// Identifying the arms
	if (abs(position.x) > 0.55 && position.y > 1.5) {

		mat4 armTranslationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
									     0.0, 1.0, 0.0, 0.0,
										 0.0, 0.0, 1.0, 0.0,
										 0.55, 2.0, 0.2, 1.0);

		float s = sin(armRotationAngle);
		float c = cos(armRotationAngle);
		
		mat4 xRotateArm = mat4(1.0, 0.0, 0.0, 0.0,
							   0.0, c,    -s, 0.0, 
							   0.0, s,     c, 0.0,
							   0.0, 0.0, 0.0, 1.0);

	    mat4 armTranslationInverseMatrix = mat4(1.0, 0.0, 0.0, 0.0,
												0.0, 1.0, 0.0, 0.0,
												0.0, 0.0, 1.0, 0.0,
												-0.55, -2.0, -0.2, 1.0);


		newPosition = armTranslationMatrix * xRotateArm * armTranslationInverseMatrix * newPosition;
	}
	
	
	// Identifying the left leg
	if (position.x < 0.23 && position.y < 0.9) {

			
		mat4 leftLegTranslationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
											 0.0, 1.0, 0.0, 0.0,
										 	 0.0, 0.0, 1.0, 0.0,
										     0.15, 0.5, 0.1, 1.0);

		float s = sin(leftLegRotationAngle);
		float c = cos(leftLegRotationAngle);
		
							 
		mat4 xRotateLeftLeg = mat4(1.0, 0.0, 0.0, 0.0,
							   0.0, c,    s, 0.0, 
							   0.0, -s,     c, 0.0,
							   0.0, 0.0, 0.0, 1.0);
							   
	    mat4 leftLegTranslationInverseMatrix = mat4(1.0, 0.0, 0.0, 0.0,
												0.0, 1.0, 0.0, 0.0,
												0.0, 0.0, 1.0, 0.0,
												-0.15, -0.5, -0.1, 1.0);


		newPosition = leftLegTranslationMatrix *xRotateLeftLeg * leftLegTranslationInverseMatrix * newPosition;
	}
	
	// Identifying the right leg
	if (position.x > 0.23 && position.y < 0.9) {

		mat4 rightLegTranslationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
											 0.0, 1.0, 0.0, 0.0,
										 	 0.0, 0.0, 1.0, 0.0,
										     0.15, 0.5, 0.1, 1.0);

		float s = sin(rightLegRotationAngle);
		float c = cos(rightLegRotationAngle);
		
							 
		mat4 xRotateRightLeg = mat4(1.0, 0.0, 0.0, 0.0,
							   0.0, c,    s, 0.0, 
							   0.0, -s,     c, 0.0,
							   0.0, 0.0, 0.0, 1.0);
							   
	    mat4 rightLegTranslationInverseMatrix = mat4(1.0, 0.0, 0.0, 0.0,
												0.0, 1.0, 0.0, 0.0,
												0.0, 0.0, 1.0, 0.0,
												-0.15, -0.5, -0.1, 1.0);


		newPosition = rightLegTranslationMatrix *xRotateRightLeg * rightLegTranslationInverseMatrix * newPosition;
	}

	
	
	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * newPosition;
}
