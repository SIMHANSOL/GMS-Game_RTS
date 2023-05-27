/// ai_create();

var _ins = noone;
if (global.get_player[set_player] != -1)
{
    switch(global.get_player[set_player])
    {
        case 100: _ins = instance_create(0, 32, Obj_AI_Number_100); break;
    }
    
    if (instance_exists(_ins) == true)
    {
        _ins.set_player = set_player;
        _ins.set_team = global.get_team[set_player];
        _ins.set_colour = global.get_colour[set_player];
    }
}
return _ins;
