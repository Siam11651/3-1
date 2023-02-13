package online3;

public class Main
{
    public static void main(String[] args)
    {
        BanglaAudio banglaAudio = new BanglaAudio();

        banglaAudio.SetAudio();

        AudioAdapter audioAdapter = new AudioAdapter(banglaAudio);
        SpeechToText speechToText = new SpeechToText(audioAdapter);

        System.out.println(speechToText.SpeechToTextGenerator());
    }
}
