package problem2;

import java.util.Scanner;
import java.util.Vector;

class Main
{
    public static void main(String[] args)
    {
        Vector<Script> scripts = new Vector<>();

        for(int i = 0; i < 5; ++i)
        {
            scripts.add(new Script(i + 1));
        }

        Controller controller = new Controller();
        Vector<Student> students = new Vector<>();
        Examiner examiner = new Examiner(controller, scripts);

        for(int i = 0; i < 5; ++i)
        {
            students.add(new Student(i + 1, controller));
        }

        controller.SetExaminer(examiner);
        controller.SetStudents(students);
        examiner.Examine();
        examiner.SendToController();
        controller.Scrutinize();
        controller.Publish();

        Scanner scanner = new Scanner(System.in);

        System.out.println("Taking reexamine requests: [id claim]");

        while(true)
        {
            int id = scanner.nextInt();
            int claim = scanner.nextInt();

            for(int i = 0; i < students.size(); ++i)
            {
                Student student = students.get(i);

                if(student.GetID() == id)
                {
                    student.ReexamineRequest(claim);

                    break;
                }
            }
        }
    }
}
