shader_type canvas_item;

uniform sampler2D u_dither_texture   : source_color, repeat_enable, filter_nearest;
uniform sampler2D u_palette_texture  : source_color;

uniform int   u_color_level : hint_range(1, 64) = 32;
uniform int   u_dither_size : hint_range(1, 8) = 2;
uniform float u_contrast    : hint_range(0.0, 5.0) = 1.0;
uniform float u_offset      : hint_range(-1.0, 1.0) = 0.0;

void fragment()
{
    float color_level = float(u_color_level);

    vec2 dither_grid_size = vec2(textureSize(TEXTURE, 0)) / float(u_dither_size);
    vec2 snapped_uv       = floor(UV * dither_grid_size) / dither_grid_size;
    vec3 input_color      = texture(TEXTURE, snapped_uv).rgb;

    vec2  dither_texture_size = vec2(textureSize(u_dither_texture, 0));
    vec2  dither_uv           = UV * (vec2(1.0) / dither_texture_size) * dither_grid_size;
    float threshold           = texture(u_dither_texture, dither_uv).r * 0.99 + 0.005;

    ivec2 palette_texture_size = textureSize(u_palette_texture, 0);
    int   palette_color_count  = (palette_texture_size / palette_texture_size.y).x;
    float palette_intervals    = float(palette_color_count) - 1.0;
    float palette_color_width  = 1.0 / palette_intervals;

    float luminance = dot(
        input_color ,
        vec3(0.299, 0.587, 0.114)
    );
    luminance = (luminance - 0.5 + u_offset) * u_contrast + 0.5;
    luminance = clamp(luminance, 0.0, 1.0);
    luminance = floor(luminance * color_level) / color_level;
    luminance = max(luminance, 0.0);

    float color_sample = mix(
        palette_color_width *  floor(luminance * palette_intervals),
        palette_color_width * (floor(luminance * palette_intervals) + 1.0),
        luminance * palette_intervals - floor(luminance * palette_intervals) < threshold ? 0.0 
                                                                                         : 1.0
    );

    COLOR = texture(u_palette_texture, vec2(color_sample, 0.5));
}
