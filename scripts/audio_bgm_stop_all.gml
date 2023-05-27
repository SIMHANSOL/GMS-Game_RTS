/// audio_bgm_stop_all();
var _sound = Sou_Main_BGM;
if (audio_is_playing(_sound) == true)
{
    audio_pause_sound(_sound);
}
