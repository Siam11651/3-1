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
}