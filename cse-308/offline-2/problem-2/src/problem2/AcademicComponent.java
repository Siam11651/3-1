package problem2;

abstract class AcademicComponent
{
    protected IController controller;

    public AcademicComponent(IController controller)
    {
        this.controller = controller;
    }

    public abstract void RecieveScript(Script script);
}
