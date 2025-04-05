shader_type canvas_item;

uniform float depth_factor : hint_range(0.0, 1.0);

void fragment() {
    vec4 color = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);
    
    float alpha = 1.0 - depth_factor;
    
    color.a *= alpha;
    
    COLOR = color;
}
