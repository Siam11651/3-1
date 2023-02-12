package problem1;

import problem1.Adapters.Adapter;
import problem1.Crewmates.MaintenanceCrewmate;
import problem1.Crewmates.StudyCrewmate;
import problem1.Imposters.PoisonImposter;
import problem1.Imposters.SabotageImposter;

public class Main
{
    public static void main(String[] args)
    {
        MaintenanceCrewmate maintenanceCrewmate = new MaintenanceCrewmate();
        StudyCrewmate studyCrewmate = new StudyCrewmate();
        PoisonImposter poisonImposter = new PoisonImposter();
        SabotageImposter sabotageImposter = new SabotageImposter();
        Adapter poisonImposterAdapter = new Adapter(poisonImposter);
        Adapter sabotageImposterAdapter = new Adapter(sabotageImposter);

        maintenanceCrewmate.DoTask();
        studyCrewmate.DoTask();
        poisonImposterAdapter.DoTask();
        sabotageImposterAdapter.DoTask();
    }
}