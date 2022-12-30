package problem2;

import java.util.Vector;

class Controller
{
    private Examiner examiner;
    private Vector<Student> students;

    public Controller()
    {
        examiner = new Examiner(this);
        students = new Vector<>();
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

    public void Examine()
    {
        examiner.Examine(students);
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