///ai_target_serch();
var _target = -1;

ai_ran = random_set_seed(ai_ran);
ai_ran = floor(random(ai_value));

var _list = ds_list_create();
for(var _i = 0; _i < global.max_player; _i ++)
{
    if (global.get_player[_i] == -1)
    && (global.get_player[_i] != set_player)
    && (global.get_team[_i] != set_team)
    {
        ds_list_add(_list, _i);
    }
}
_target = irandom_range(0, ds_list_size(_list));
ds_list_destroy(_list);

return _target;
