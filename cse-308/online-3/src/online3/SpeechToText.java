package online3;

public class SpeechToText
{
    private Audio audio;

    public SpeechToText(Audio audio)
    {
        this.audio = audio;
    }

    public String SpeechToTextGenerator()
    {
        return audio.GetAudio();
    }
}
