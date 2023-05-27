/// draw_text_general(x, y string);
var _x = argument0 + 4;
var _y = argument1;
var _pos_x = _x;
var _pos_y = _y;
var _string = argument2;

var _at = "";
var _add_at = "";
var _width = string_width("가");
var _height = string_height("가");
var _length = string_length(_string);

shader_set(shader_set_font);        
shader_enable_corner_id(true);
shader_set_uniform_f(texture, texel_width, texel_height);

for(var _i = 1; _i < _length + 1; _i ++)
{
    if (_i > text_number) {break;}
    
    _at = string_char_at(_string, _i);
    _width = string_width(_at);
    _height = string_height(_at);

    _add_at = string_insert(_add_at, _at, 0); // 꽉 찼는지 검사.
    if (string_width(_add_at) >= text_w - 18) // 꽉 차면 뛰어 쓰기.
    || (_at == "#") // 뛰어쓰기 구문이 있을 경우.
    {
        _pos_x = _x;
        _pos_y += _height;
        _add_at = "";
    }
    
    draw_text(_pos_x, _pos_y, _at);
    
    if (_i == _length)
    {
        draw_circle(_pos_x + _width, _pos_y + _height + end_y, 4, false);    
        end_y = 4 * sin(end_sin);
        if (end_sin >= 359) {end_sin = 0;} else {end_sin += end_speed;}
    }
    
    _pos_x += _width;
}
shader_reset();
shader_enable_corner_id(false);

if (delay <= 0) // 시간이 되면 한 글자 드로우.
{
    delay = delay_max;
    if (text_number != _length) {text_number ++;}
}
else {delay --;}

// 텍스트 넘기기.
if (Obj_Game_System.mbr_L[0] == true)
&& (Obj_Game_System.mx_gui[0] > text_x)
&& (Obj_Game_System.my_gui[0] > text_y)
&& (Obj_Game_System.mx_gui[0] < text_x + text_w)
&& (Obj_Game_System.my_gui[0] < text_y + text_h)
{
    if (text_number == _length)
    {
        text_number = 0;
        text_string ++;
        text_switch ++;
    }
    else {text_number = _length;}
}
