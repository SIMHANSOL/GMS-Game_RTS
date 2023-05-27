/// audio_volume_set();
var _volume = (global.set_sound_volume / 100);

audio_sound_gain(Sou_Main_Button_Click, _volume, 0);
audio_sound_gain(Sou_Main_Button_Cancel, _volume, 0);
audio_sound_gain(Sou_Warning_Message, _volume, 0);
audio_sound_gain(Sou_Build_Click, _volume, 0);
audio_sound_gain(Sou_Build_Cancel, _volume, 0);
audio_sound_gain(Sou_Attack_Ore, (_volume / 4), 0);
audio_sound_gain(Sou_Attack_Building, (_volume / 4), 0);

audio_sound_gain(Sou_Main_BGM, _volume, 0);
