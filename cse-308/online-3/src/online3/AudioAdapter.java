package online3;

public class AudioAdapter extends EnglishAudio
{
    private Audio banglaAudio;

    public AudioAdapter(Audio banglaAudio)
    {
        this.banglaAudio = banglaAudio;
    }

    @Override
    public String GetAudio()
    {
        String newAudio = banglaAudio.GetAudio();

        newAudio = newAudio.substring(1, newAudio.length() - 1);

        String[] words = newAudio.split(" ");
        boolean found = true;

        for(int i = 0; i < words.length; ++i)
        {
            if(words[i].equalsIgnoreCase("ami"))
            {
                words[i] = "I";
            }
            else if(words[i].equalsIgnoreCase("amra"))
            {
                words[i] = "we";
            }
            else if(words[i].equalsIgnoreCase("bhat"))
            {
                words[i] = "rice";
            }
            else if(words[i].equalsIgnoreCase("roti"))
            {
                words[i] = "bread";
            }
            else if(words[i].equalsIgnoreCase("khai"))
            {
                words[i] = "eat";
            }
            else if(words[i].equalsIgnoreCase("banai"))
            {
                words[i] = "prepare";
            }
            else
            {
                found = false;

                break;
            }
        }

        if(found)
        {
            newAudio = "";

            // for(int i = 0; i < words.length; ++i)
            // {
            //     newAudio += words[i] + " ";
            // }

            newAudio = words[0] + " " + words[2] + " " + words[1];
        }

        return newAudio;
    }
}
