package problem2;

public class Student extends AcademicComponent
{
    private int id;
    private int marks;

    public Student(int id, Controller controller)
    {
        super(controller);
        SetMarks(101); // 101 means not set yet, kinda null
    }

    public void Notify(String command, String params)
    {
        controller.Notify(this, command, params);
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
        controller.Notify(this, "reexamine", Integer.toString(claim));
    }
}
