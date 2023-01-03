package problem2;

import java.util.Scanner;
import java.util.Vector;

class Main
{
    public static void main(String[] args)
    {
        Controller controller = new Controller();
        Vector<Student> students = new Vector<>();
        Examiner examiner = new Examiner(controller);

        for(int i = 0; i < 5; ++i)
        {
            students.add(new Student(i + 1, controller));
            examiner.RecieveScript(new Script(i + 1));
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

            if(id == -1)
            {
                break;
            }

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

        scanner.close();
    }
}
