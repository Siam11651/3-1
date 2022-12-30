package problem2;

import java.util.Random;
import java.util.Vector;

class Controller
{
    private Examiner examiner;
    private Vector<Student> students;
    private Random random;

    public Controller()
    {
        examiner = new Examiner(this);
        students = new Vector<>();
        random = new Random();
    }

    public boolean AddStudent(int id)
    {
        for(int i = 0; i < students.size(); ++i)
        {
            if(students.get(i).GetID() == id)
            {
                return false;
            }
        }

        students.add(new Student(id, this));

        return true;
    }

    public boolean RemoveStudent(int id)
    {
        for(int i = 0; i < students.size(); ++i)
        {
            if(students.get(i).GetID() == id)
            {
                students.remove(i);

                return true;
            }
        }

        return false;
    }

    Vector<Student> GetStudents()
    {
        return students;
    }

    public void ExamineAndScrutinize()
    {
        examiner.SetMarks(students);

        System.out.print("Script and marks of student id ");

        for(int i = 0; i < students.size(); ++i)
        {
            if(i > 0)
            {
                System.out.println(", ");
            }

            System.out.print(i + 1);
        }

        System.out.println(" sent to exam controller office");

        Vector<Integer> mistakes = new Vector<>();

        for(int i = 0; i < students.size(); ++i)
        {
            if(random.nextInt(100) < 55)
            {
                mistakes.add(i);
            }
        }

        if(mistakes.size() == 0)
        {
            mistakes.add(random.nextInt(students.size()));
        }

        System.out.println("Mistakes:");

        for(int i = 0; i < mistakes.size(); ++i)
        {
            int index = mistakes.get(i);
            int corrected = random.nextInt(101);

            System.out.println("id: " + students.get(index).GetID() + "; previous: " + students.get(index).GetMarks() + "; corrected: " + corrected);

            students.get(index).SetMarks(corrected);
        }
    }

    public void Reexamine(Student student, int claim)
    {
        int reexamine = examiner.Reexamine(student, claim);

        if(reexamine != -1)
        {
            student.SetMarks(reexamine);
        }
    }
}