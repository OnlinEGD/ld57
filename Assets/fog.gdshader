shader_type canvas_item;

uniform float top_y = 0.0;
uniform float bottom_y = 1000.0;
uniform float darkness_strength = 0.7;

void fragment() {
    float y = SCREEN_UV.y;
    float factor = clamp((UV.y - top_y) / (bottom_y - top_y), 0.0, 1.0);
    float darkness = mix(0.0, darkness_strength, factor);
    COLOR = vec4(vec3(1.0 - darkness), 1.0);
}

