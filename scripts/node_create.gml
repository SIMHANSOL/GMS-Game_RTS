/// node_create()
var _i = 3; repeat(4) {node[_i] = noone; _i --;}

var _x, _y, _grid_size = 32;
for(var _i = 0; _i < 4; _i ++)
{
    switch(_i)
    {
        case 0: _x = bbox_left - _grid_size; _y = bbox_top - _grid_size; break;
        case 1: _x = bbox_left - _grid_size; _y = bbox_bottom + _grid_size; break;
        case 2: _x = bbox_right + _grid_size; _y = bbox_top - _grid_size; break;
        case 3: _x = bbox_right + _grid_size; _y = bbox_bottom + _grid_size; break;
    }

    if (bbox_left >= 0) && (bbox_top >= 0) && (bbox_right <= room_width) && (bbox_bottom <= room_height)
    && (position_meeting(_x, _y, Obj_Block) == false)
    && (position_meeting(_x, _y, Obj_Building) == false)
    && (position_meeting(_x, _y, Obj_Resource) == false)
    && (position_meeting(_x, _y, Obj_Node) == false)
    {
        node[_i] = instance_create(_x, _y, Obj_Node);
    }
}
