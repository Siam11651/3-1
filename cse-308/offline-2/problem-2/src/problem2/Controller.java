package problem2;

import java.util.Random;
import java.util.Vector;

class Controller implements IController
{
    private Examiner examiner;
    private Vector<Student> students;
    private Vector<Script> scripts;
    private Random random;

    public Controller()
    {
        random = new Random();
    }

    public void SetExaminer(Examiner examiner)
    {
        this.examiner = examiner;
    }

    public void SetStudents(Vector<Student> students)
    {
        this.students = students;
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
                System.out.print(", ");
            }

            System.out.print(i + 1);
        }

        System.out.println(" sent to exam controller office");
    }

    public void Notify(AcademicComponent notifier, String command, String params)
    {
        if(notifier instanceof Examiner)
        {
            if(command.equalsIgnoreCase("send_to_controller"))
            {
                SendToController(((Examiner)notifier).GetScripts());
            }
        }
        else if(notifier instanceof Student)
        {
            if(command.equalsIgnoreCase("reexamine"))
            {
                int claim = Integer.parseInt(params);

                examiner.Reexamine(((Student)notifier).GetID(), claim);

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
            }
        }
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
            int corrected = random.nextInt(100);

            if(corrected >= scripts.get(index).GetMarks())
            {
                ++corrected;
            }

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

        System.out.println("Final marks:");

        for(int i = 0; i < students.size(); ++i)
        {
            System.out.println("id: " +  students.get(i).GetID() + "; marks: " + students.get(i).GetMarks());
        }
    }
}