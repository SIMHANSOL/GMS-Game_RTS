/// return_str_number(string);
var _string = argument0;
var _return_value = -1;

switch(_string)
{
    case "name": _return_value = 0; break; // 이름.
    case "hp": _return_value = 1; break; // 체력.
    case "atk": _return_value = 4; break; // 공격.
    case "def": _return_value = 14; break; // 방어.
    case "atk_type": _return_value = 3; break; // 공격 타입.
    case "def_type": _return_value = 13; break; // 방어 타입.
    case "atk_range": _return_value = 7; break; // 공격 사거리.
    case "atk_speed": _return_value = 6; break; // 공격 속도.
    case "move_speed": _return_value = 17; break; // 이동 속도.
    case "sight": _return_value = 16; break; // 시야.
    case "gui_sprite": _return_value = 23; break; // 스프라이트 번호.
    case "create_resource_1": _return_value = 24; break; // 필요 광석.
    case "create_resource_2": _return_value = 25; break; // 필요 원유.
    case "create_resource_3": _return_value = 26; break; // 필요 인구.
    case "create_time": _return_value = 27; break; // 건설에 걸리는 시간.
    case "info": _return_value = 29; break; // 설명.
}

return _return_value;
