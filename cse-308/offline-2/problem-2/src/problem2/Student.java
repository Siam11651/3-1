package problem2;

public class Student extends AcademicComponent
{
    private int id;
    private Script script;

    public Student(int id, Controller controller)
    {
        super(controller);

        this.id = id;
    }

    public void Notify(String command, String params)
    {
        controller.Notify(this, command, params);
    }

    public int GetID()
    {
        return id;
    }

    public void RecieveScript(Script script)
    {
        if(this.script == null)
        {
            this.script = script;
        }
    }

    public Script GetScript()
    {
        return script;
    }

    public void ReexamineRequest(int claim)
    {
        System.out.println("Reexamine request sent to student id " + id);
        controller.Notify(this, "reexamine", Integer.toString(claim));
    }
}
