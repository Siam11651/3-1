package problem2;

public class Student
{
    private int id;
    private int marks;
    private Controller controller;

    public Student(int id, Controller controller)
    {
        this.controller = controller;

        SetMarks(101); // 101 means not set yet, kinda null
    }

    public void SetID(int id)
    {
        this.id = id;
    }

    public int GetID()
    {
        return id;
    }

    public void SetMarks(int marks)
    {
        this.marks = marks;
    }

    public int GetMarks()
    {
        return marks;
    }

    public void ReexamineRequest(int claim)
    {
        System.out.println("Reexamine request sent to student id " + id);

        controller.Reexamine(id, claim);
    }
}
