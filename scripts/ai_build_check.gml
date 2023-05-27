/// ai_build_check(_x, _y, _range, build_obj, work_obj);
// _x: center.x; 어느 X 좌표 중심지로부터 검색하는지
// _y: center.y; 어느 Y 좌표 중심지로부터 검색하는지
// build_x, build_y, ai_ran, safe_range, set_player는 선언되어 있어야 한다.

var _x = argument0;
var _y = argument1;
var _b_obj = argument2;
var _w_obj = argument3;
var _res_max = (global.get_resource[set_player, 3] - global.get_resource_value[set_player, 3]);
if (global.get_resource[set_player, 0] - global.get_resource_value[set_player, 0] >= real(global.sight_table[return_csv_number(_b_obj), return_str_number("create_resource_1")]))
&& (global.get_resource[set_player, 1] - global.get_resource_value[set_player, 1] >= real(global.sight_table[return_csv_number(_b_obj), return_str_number("create_resource_2")]))
&& (global.get_resource[set_player, 2] - global.get_resource_value[set_player, 2] + real(global.sight_table[return_csv_number(_b_obj), return_str_number("create_resource_3")]) <= _res_max)
{
    var _check = false;
    if (_b_obj != Obj_101)
    {
        var _spr = object_get_sprite(_b_obj);
        var _bbox_left = sprite_get_bbox_left(_spr);
        var _bbox_right = sprite_get_bbox_right(_spr);
        var _bbox_top = sprite_get_bbox_top(_spr);
        var _bbox_bottom = sprite_get_bbox_bottom(_spr);
        var _x_offset = sprite_get_xoffset(_spr);
        var _y_offset = sprite_get_yoffset(_spr)
        var _fog_scale = Obj_Game_System.fog_scale;
        var _grid = Obj_Game_System.build_grid;
        
        ai_ran = random_set_seed(ai_ran);
        ai_ran = floor(random(ai_value));
        for (var _i = 0; _i < serch_num_max; _i ++)
        {
            if (_i == (serch_num_max - 1)) {safe_range += safe_range_plus;}
            
            var _build_x = (_fog_scale / 2) + (floor(irandom_range(_x - safe_range, _x + safe_range) / _grid) * _grid);
            var _build_y = (_fog_scale / 2) + (floor(irandom_range(_y - safe_range, _y + safe_range) / _grid) * _grid);
            var _check_left = _build_x - (_x_offset - _bbox_left);
            var _check_right = _build_x + (_bbox_right - _x_offset);
            var _check_top = _build_y - (_y_offset - _bbox_top);
            var _check_bottom = (_build_y + _fog_scale) + (_bbox_bottom - _y_offset);
            
            if (_check_left >= 0) && (_check_top >= 0) && (_check_right <= room_width) && (_check_bottom <= (room_height))
            {
                if (collision_rectangle(_check_left, _check_top, _check_right, _check_bottom, Obj_Building, false, true) == noone)
                && (collision_rectangle(_check_left, _check_top, _check_right, _check_bottom, Obj_Block, false, true) == noone)
                && (collision_rectangle(_check_left, _check_top, _check_right, _check_bottom, Obj_Resource, false, true) == noone)
                {
                    build_x = _build_x;
                    build_y = _build_y;
                    _check = true;
                    break;
                }
            }
        }
    }
    else
    {
        var _ins = instance_nearest(_x, _y, Obj_Oil);
        if (abs(_x - _ins.x) <= safe_range) && (abs(_y - _ins.y) <= safe_range)
        {
            build_x = _ins.x;
            build_y = _ins.y;
            _check = true;
        }
    }
      
    if (_check == true)
    {     
        while(true)
        {
            var _ins = instance_nearest(build_x, build_y, _w_obj);
            if (instance_exists(_ins) == true)
            {
                if (set_player == _ins.set_player)
                && ((_ins.action == 0) || (_ins.action == 9))
                {
                    _ins.action = return_action_number(_b_obj);
                    _ins.move_x = build_x;
                    _ins.move_y = build_y;
                    _ins.moving = true;
    
                    return true;
                } else {instance_deactivate_object(_ins);}
             } else {instance_activate_all(); break;}
        }
    }
}
return false;
