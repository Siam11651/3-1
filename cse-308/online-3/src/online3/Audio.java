package online3;

import java.util.Scanner;

public abstract class Audio
{
    protected String audio;
    protected String language;

    public void SetAudio()
    {
        Scanner scanner = new Scanner(System.in);

        audio = scanner.nextLine();
    }

    public abstract String GetAudio();
}