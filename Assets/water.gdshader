shader_type canvas_item;

uniform float wave_speed = 1.5;
uniform float wave_strength = 1.5;
uniform float pixel_size = 0.01; 

void fragment() {
    vec2 uv = UV;
    
    uv = floor(uv / pixel_size) * pixel_size;

    uv.y += sin(UV.x * 20.0 + TIME * wave_speed) * (wave_strength / 100.0);

    COLOR = texture(TEXTURE, uv);
}
