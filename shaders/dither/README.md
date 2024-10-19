# Uniforms

| uniform | description | range | default |
| ------- | ----------- | ----- | ------- |
| u_color_level | Number of distinct color levels (1-64, default 32)                 | [1, 64]     | 32  |
| u_dither_size | Size of dithering pattern grid (1-8, default 2)                    | [1, 8]      | 2   |
| u_contrast    | Adjusts image contrast before dithering (0.0-5.0, default 1.0)     | [0.0, 5.0]  | 1.0 |
| u_offset      | Shifts overall brightness before dithering (-1.0-1.0, default 0.0) | [-1.0, 1.0] | 0.0 |

# Examples

| palette texture | dither texture | color levels | dither size | contrast | offset |
| --------------- | -------------- | ------------ | ----------- | -------- |------- |
| aqua            | bayer2         | 32           | 4           | 2.125    | 0      | 
| okami           | bayer2         | 32           | 4           | 1.305    | -0.125 |
| wood            | bayer2         | 64           | 4           | 1.0      | 0      |
