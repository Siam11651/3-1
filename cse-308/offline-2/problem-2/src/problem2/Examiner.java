package problem2;

import java.util.Random;
import java.util.Vector;

class Examiner
{
    private Random random;
    private Controller controller;

    public Examiner(Controller controller)
    {
        random = new Random();
        this.controller = controller;
    }

    public void SetMarks(Vector<Student> students)
    {
        for(int i = 0; i < students.size(); ++i)
        {
            students.get(i).SetMarks(random.nextInt(101));
        }
    }

    public int Reexamine(Student student, int claim)
    {
        int action = random.nextInt(5);

        if(action < 3)
        {
            return claim;
        }
        else if(action < 4)
        {
            return -1; // no change
        }
        else
        {
            return random.nextInt(student.GetMarks());
        }
    }
}