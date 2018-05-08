//VARYING VAR
varying vec3 Normal_V;
varying vec3 Position_V;
varying vec4 PositionFromLight_V;
varying vec2 Texcoord_V;
varying vec4 shadowCoord;

//UNIFORM VAR
uniform vec3 lightColorUniform;
uniform vec3 ambientColorUniform;
uniform vec3 lightDirectionUniform;

uniform float kAmbientUniform;
uniform float kDiffuseUniform;
uniform float kSpecularUniform;

uniform float shininessUniform;

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform sampler2D aoMap;
uniform sampler2D shadowMap;

// PART D)
// Use this instead of directly sampling the shadowmap, as the float
// value is packed into 4 bytes as WebGL 1.0 (OpenGL ES 2.0) doesn't
// support floating point bufffers for the packing see depth.fs.glsl
float getShadowMapDepth(vec2 texCoord)
{
	vec4 v = texture2D(shadowMap, texCoord);
	const vec4 bitShift = vec4(1.0, 1.0/256.0, 1.0/(256.0 * 256.0), 1.0/(256.0*256.0*256.0));
	return dot(v, bitShift);
}

void main() {
	// PART B) TANGENT SPACE NORMAL
	vec3 N_1 = normalize(texture2D(normalMap, Texcoord_V).xyz * 2.0 - 1.0);

	// PRE-CALCS
	vec3 N = normalize(Normal_V);
	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirectionUniform, 0.0)));
	vec3 V = normalize(-Position_V);
	vec3 H = normalize(V + L);	
	
	vec3 upVector = vec3(0.0, 1.0, 0.0);
	vec3 horizontalTangent = normalize(cross(N, upVector));
	vec3 binormalDirection = normalize(cross(N, horizontalTangent));
	
	vec3 vertexNormal = N;
	vec3 vertexTangent = horizontalTangent;
	vec3 vertexBitangent = binormalDirection;
	
	mat3 TBN = mat3(vertexTangent,
					vertexBitangent,
					vertexNormal);
	
	vec3 L_1 = normalize(L * TBN);
	vec3 V_1 = normalize(V * TBN);
	vec3 H_1 = normalize(V_1 + L_1);
	
	vec4 texAmbient = texture2D(aoMap, Texcoord_V);
	vec4 texColor = texture2D(colorMap, Texcoord_V);
	
	// TEXTURE AMBIENT
	vec3 tex_AMB = ambientColorUniform * kAmbientUniform;
	tex_AMB *= vec3(texAmbient);
	
	// TEXTURE DIFFUSE
	vec3 tex_DFF = kDiffuseUniform * lightColorUniform;
	vec3 lightTex_DFF = tex_DFF * max(0.0, dot(N_1, L_1));
	lightTex_DFF *= vec3(texColor);
	
	// TEXTURE SPECULAR
	vec3 tex_SPC = kSpecularUniform * lightColorUniform;
	vec3 lightTex_SPC = tex_SPC * pow(max(0.0, dot(H_1, N_1)), shininessUniform);


	// SHADOW
	vec2 shadowTex = vec2(shadowCoord.x/shadowCoord.w, shadowCoord.y/shadowCoord.w);
	
	float hasShadow = getShadowMapDepth(shadowTex);
	float error = 0.0001;
	float visibility = 1.0;
	if (hasShadow < shadowCoord.z/shadowCoord.w - error) {
		visibility = 0.2;
	}
	
	vec3 TOTAL = tex_AMB + visibility * lightTex_DFF + visibility * lightTex_SPC;
	
	gl_FragColor = vec4(TOTAL, 1.0);
}
