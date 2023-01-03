package problem2;

abstract class AcademicPerson
{
    protected IController controller;

    public AcademicPerson(IController controller)
    {
        this.controller = controller;
    }

    public abstract void RecieveScript(Script script);
}
