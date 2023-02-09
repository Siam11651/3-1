package problem1.Adapters;

import problem1.Crewmates.Crewmate;
import problem1.Imposters.Imposter;

public class Adapter implements Crewmate
{
    private Imposter imposter;

    public Adapter(Imposter imposter)
    {
        this.imposter = imposter;
    }

    @Override
    public void DoTask()
    {
        imposter.FakeTask();
    }
}
