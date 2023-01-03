package problem2;

import java.util.Random;
import java.util.Vector;

class Examiner extends AcademicComponent
{
    private Random random;
    private Vector<Script> scripts;

    public Examiner(Controller controller, Vector<Script> scripts)
    {
        super(controller);

        random = new Random();
        this.scripts = scripts;
    }

    public void SendToController()
    {
        controller.Notify(this, "send_to_controller", null);
    }

    public void Examine()
    {
        for(int i = 0; i < scripts.size(); ++i)
        {
            scripts.get(i).SetMarks(random.nextInt(101));
        }
    }

    public void Reexamine(int id, int claim)
    {
        int action = random.nextInt(5);

        if(action < 3)
        {
            for(int i = 0; i < scripts.size(); ++i)
            {
                if(scripts.get(i).GetID() == id)
                {
                    scripts.get(i).SetMarks(claim);

                    break;
                }
            }
        }
        else if(action < 4)
        {
            for(int i = 0; i < scripts.size(); ++i)
            {
                if(scripts.get(i).GetID() == id)
                {
                    scripts.get(i).SetMarks(random.nextInt(scripts.get(i).GetMarks()));

                    break;
                }
            }
        }
    }

    public Vector<Script> GetScripts()
    {
        return scripts;
    }
}