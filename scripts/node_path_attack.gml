/// node_path_attack(path, x, y);
// return path;


/* (2019 - 09 - 15)
1. 해당 지점(처음은 시작 지점)을 닫힌 노드에 넣습니다.
2. 해당 지점(처음은 시작 지점)에서부터 주변 지점들을 검색합니다.
3. 각각 주변 지점에서 G, H, F 비용을 연산합니다.
4. 가장 작은 F 비용을 지닌 지점이 다음으로 선택될 지점이 됩니다.
5. 다음으로 선택될 지점의 부모는 해당 지점(처음은 시작 지점)이 됩니다.

    1 ~ 5번 반복....

6. 주변 지점 이동을 통해 목표 지점에 다다르면 반복을 중지합니다.

7. 해당 지점(처음은 목표 지점)의 좌표를 패스에 삽입합니다.
8. 해당 지점(처음은 목표 지점)의 부모를 불러와 7번 내용을 반복합니다.
9. 부모 - 자식 - 부모 - 자식 - 부모를 반복하면 길이 만들어지고 시작 지점에 도착하면 반복을 중지합니다.
10. 삽입된 패스를 반전시키고 완성된 패스를 반환합니다. (목표 지점에서부터 연결했기 때문에 반대이기 때문)
*/

var _start_x = x; // pos.
var _start_y = y; // pos.
var _end_x = argument1; // pos.
var _end_y = argument2; // pos.
var _node = Obj_Node;

_path = argument0;
path_clear_points(_path);

var _check = instance_position(_end_x, _end_y, Obj_Block);
if (_check != noone) || (_end_x < 0) || (_end_x > room_width) || (_end_y < 0) || (_end_y > room_height)
{return _path;}

var _pick_x = _start_x; // 현재 선택된 좌표.
var _pick_y = _start_y; // 현재 선택된 좌표.

var _parent_list = ds_map_create(); // 열린 노드들. (부모 자식, 연결 관계)
var _close_list = ds_list_create(); // 닫힌 노드들.
var _f = ds_priority_create(); // G, H의 총합 비용.

// 시작하기 전에 초기화.
var _prev_ins = self.id; // 전 노드 삽입.
var _my_pos = instance_position(x, y, Obj_Building);
if (instance_exists(_my_pos) == true) {_my_pos = _my_pos.id;}
var _position = instance_position(move_x, move_y, Obj_Building);
if (instance_exists(_position) == true) {_position = _position.id;}
var _serch = true, _found = false;
while(_serch) // 목표 지점까지의 길을 찾을 때까지 루프.
{
    while(true)
    {
        var _ins = instance_nearest(_pick_x, _pick_y, _node); // 가까운 노드 검색.
        if (instance_exists(_ins) == true)
        {
            var _line = collision_line(_pick_x, _pick_y, _end_x, _end_y, Obj_Block, false, true);
            if (_line == noone) {_line = collision_line(_pick_x, _pick_y, _end_x, _end_y, Obj_Resource, false, true);}
            if (_line == noone) 
            {
                var _ds_check = ds_list_create();
                while(true)
                {
                    _line = collision_line(_pick_x, _pick_y, _end_x, _end_y, Obj_Building, false, true);
                    if (instance_exists(_line) == true)
                    {
                        if (_line.build > 0)
                        && (_line.id != _my_pos)
                        && (_line.id != _position)
                        {
                            for(var _i = 0; _i < ds_list_size(_ds_check); _i ++)
                            {
                                var _obj = ds_list_find_value(_ds_check, _i);
                                instance_activate_object(_obj);
                            }
                            break;
                        }
                        else 
                        {
                            ds_list_add(_ds_check, _line);
                            instance_deactivate_object(_line); 
                            _line = noone;
                        }
                    }
                    else
                    {
                        for(var _i = 0; _i < ds_list_size(_ds_check); _i ++)
                        {
                            var _obj = ds_list_find_value(_ds_check, _i);
                            instance_activate_object(_obj);
                        }
                        break;
                    }
                }
                ds_list_destroy(_ds_check);
            }
            
            // 다 도착했을 경우.
            if (_line == noone)
            || (air == 1)
            {
                _serch = false;
                _found = true;
                break;
            }
            
            var _line = collision_line(_pick_x, _pick_y, _ins.x, _ins.y, Obj_Block, false, true);
            if (_line == noone) {_line = collision_line(_pick_x, _pick_y, _ins.x, _ins.y, Obj_Resource, false, true);}
            if (_line == noone)
            {
                var _ds_check = ds_list_create();
                while(true)
                {
                    _line = collision_line(_pick_x, _pick_y, _ins.x, _ins.y, Obj_Building, false, true);
                    if (instance_exists(_line) == true)
                    {
                        if (_line.build > 0)
                        && (_line.id != _my_pos)
                        && (_line.id != _position)
                        {
                            for(var _i = 0; _i < ds_list_size(_ds_check); _i ++)
                            {
                                var _obj = ds_list_find_value(_ds_check, _i);
                                instance_activate_object(_obj);
                            }
                            break;
                        }
                        else 
                        {
                            ds_list_add(_ds_check, _line);
                            instance_deactivate_object(_line); 
                            _line = noone;
                        }
                    }
                    else
                    {
                        for(var _i = 0; _i < ds_list_size(_ds_check); _i ++)
                        {
                            var _obj = ds_list_find_value(_ds_check, _i);
                            instance_activate_object(_obj);
                        }
                        break;
                    }
                }
                ds_list_destroy(_ds_check);
            }
            
            var _closed = ds_list_find_index(_close_list, _ins.id) == -1; // 닫힌 노드인지 확인.
            if (_line == noone) && (_closed == true)
            {
                ds_list_add(_close_list, _ins.id); // 지정된 노드는 일단 닫아둔다.
                
                var _temp_g = point_distance(_start_x, _start_y, _ins.x, _ins.y); // 거리 계산.
                var _temp_h = point_distance(_ins.x, _ins.y, _end_x, _end_y); // 거리 계산.
                var _temp_f = _temp_g + _temp_h;
                ds_priority_add(_f, _ins.id, _temp_f); // 루프 돌고 있는 지점에 F 비용을 추가.
                ds_map_add(_parent_list, _ins.id, _prev_ins);
            }
            instance_deactivate_object(_ins);
        }
        else
        {
            instance_activate_all();
            break;
        }
    }
    
    if (_serch == true)
    {
        if (ds_priority_empty(_f) == false) // F 비용 목록이 비어있지 않다면 가장 작은 F 비용을 찾아 대입.
        {
            _min = ds_priority_delete_min(_f); // 가장 작은 F 비용의 지점을 _min에 기록하고 목록에서 삭제한다.
            if (instance_exists(_min) == true)
            {
                _pick_x = _min.x; // 가장 작은 F 비용을 가진 지점의 X를 대입. 
                _pick_y = _min.y; // 가장 작은 F 비용을 가진 지점의 Y를 대입.
                _prev_ins = _min.id;
            }
        }
        else // 더 이상 찾을 수 없다면 종료.
        {
            _serch = false;
            _found = false;
        }
    }
}

if (_found == true) // 길이 연결되어 있다면.
{
    path_add_point(_path, _end_x, _end_y, 100);
    while(true)
    {
        if (_prev_ins == self.id) {break;}
        path_add_point(_path, _prev_ins.x, _prev_ins.y, 100);
        _prev_ins = ds_map_find_value(_parent_list, _prev_ins);
    }
    path_add_point(_path, _start_x, _start_y, 100);
    path_reverse(_path);
    path_set_closed(_path, false);
}

ds_map_destroy(_parent_list);
ds_list_destroy(_close_list);
ds_priority_destroy(_f);

return _path;
