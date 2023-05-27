/// draw_text_create();
text_w = 800;
text_h = 200;
text_x = (display_get_gui_width() / 2) - (text_w / 2);
text_y = display_get_gui_height() - (text_h + 48);

text_switch = -1; // 진행 순서.
text_string = 0; // 스트링 순서.
text_number = 0; // 글자 타이핑 순서.
delay_max = (0.05 * room_speed); // 한 글자씩 넘기는 속도.
delay = delay_max;
end_y = 0;
end_sin = 0;
end_speed = 0.2;

var _font = font_string; draw_set_font(_font);
var _font = font_get_texture(_font);
texel_width = texture_get_texel_width(_font);
texel_height = texture_get_texel_height(_font);
texture = shader_get_uniform(shader_set_font, "v_TexturePixelSize");
