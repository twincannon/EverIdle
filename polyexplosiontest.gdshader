shader_type spatial;

uniform vec3 u_cameraPos;
uniform vec4 u_farColor;
uniform vec4 u_nearColor;
uniform float u_scaleFactor;
uniform float u_startDistance;

varying vec2 v_uv;
varying vec4 v_color;

float rand(vec2 seed) {
    return fract(sin(dot(seed, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex() {
    v_uv = UV;
    vec3 center = VERTEX; // Using VERTEX directly
    vec4 worldPos = MODELVIEW_MATRIX * vec4(center, 1.0);
    float dist = length(u_cameraPos - worldPos.xyz);
    
    vec3 normal = NORMAL; // Use NORMAL instead of VTX_NORMAL

    float destruction = clamp(u_startDistance - dist, 0.0, 1.0);
    float gradient = clamp(dist - u_startDistance, 0.0, 1.0);
    float random = rand(center.xy);
    vec3 random3 = vec3(random);
    
    VERTEX += normal * destruction * u_scaleFactor * random3;
    v_color = mix(u_nearColor, u_farColor, gradient);
}

