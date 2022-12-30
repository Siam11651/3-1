package problem2;

import java.util.Random;
import java.util.Vector;

class Controller
{
    private Examiner examiner;
    private Vector<Student> students;
    private Vector<Script> scripts;
    private Random random;

    public Controller(Vector<Student> students, Examiner examiner)
    {
        this.students = students;
        this.examiner = examiner;
        random = new Random();
    }

    Vector<Student> GetStudents()
    {
        return students;
    }

    public void SendToController(Vector<Script> scripts)
    {
        this.scripts = scripts;

        System.out.print("Script and marks of student id ");

        for(int i = 0; i < scripts.size(); ++i)
        {
            if(i > 0)
            {
                System.out.println(", ");
            }

            System.out.print(i + 1);
        }

        System.out.println(" sent to exam controller office");
    }

    public void Scrutinize()
    {
        Vector<Integer> mistakes = new Vector<>();

        for(int i = 0; i < scripts.size(); ++i)
        {
            if(random.nextInt(100) < 55)
            {
                mistakes.add(i);
            }
        }

        if(mistakes.size() == 0)
        {
            mistakes.add(random.nextInt(scripts.size()));
        }

        System.out.println("Mistakes:");

        for(int i = 0; i < mistakes.size(); ++i)
        {
            int index = mistakes.get(i);
            int corrected = random.nextInt(101);

            System.out.println("id: " + scripts.get(index).GetID() + "; previous: " + scripts.get(index).GetMarks() + "; corrected: " + corrected);

            scripts.get(index).SetMarks(corrected);
        }
    }

    public void Publish()
    {
        for(int i = 0; i < scripts.size(); ++i)
        {
            for(int j = 0; j < students.size(); ++j)
            {
                if(scripts.get(i).GetID() == students.get(j).GetID())
                {
                    students.get(j).SetMarks(scripts.get(i).GetMarks());
                }
            }
        }

        for(int i = 0; i < students.size(); ++i)
        {
            System.out.println("id: " +  students.get(i).GetID() + "; marks: " + students.get(i).GetMarks());
        }
    }

    public void Reexamine(int id, int claim)
    {
        System.out.println("Reexamine request got from student id " + id);

        examiner.Reexamine(id, claim);

        for(int i = 0; i < scripts.size(); ++i)
        {
            for(int j = 0; j < students.size(); ++j)
            {
                if(scripts.get(i).GetID() == students.get(j).GetID())
                {
                    
                }
            }
        }
    }
}