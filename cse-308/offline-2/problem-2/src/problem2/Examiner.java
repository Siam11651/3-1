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
        int scriptIndex = -1;

        for(int i = 0; i < scripts.size(); ++i)
        {
            if(scripts.get(i).GetID() == id)
            {
                scriptIndex = i;

                break;
            }
        }

        if(scriptIndex > -1)
        {
            if(action < 3)
            {
                System.out.println("Claim accepted");

                scripts.get(scriptIndex).SetMarks(claim);
            }
            else if(action < 4)
            {
                System.out.println("Claim rejected and marks reduced");

                scripts.get(scriptIndex).SetMarks(random.nextInt(scripts.get(scriptIndex).GetMarks()));
            }
            else
            {
                System.out.println("Claim rejected");
            }
        }
    }

    public Vector<Script> GetScripts()
    {
        return scripts;
    }
}