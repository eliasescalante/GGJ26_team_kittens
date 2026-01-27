shader_type canvas_item;

// Cambiamos 'hint_color' por 'source_color'
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flash_amount : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    // Mezclamos el color original con el color del flash basado en la intensidad
    color.rgb = mix(color.rgb, flash_color.rgb, flash_amount);
    COLOR = vec4(color.rgb, color.a);
}