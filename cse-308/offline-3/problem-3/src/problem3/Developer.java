package problem3;

public class Developer extends Component
{
    private ProjectManager projectManager;

    public Developer(String name, ProjectManager projectManager)
    {
        super(name);

        this.projectManager = projectManager;
    }

    public void PrintDetails()
    {
        System.out.println("Name: " + GetName());
        System.out.println("Role: Developer");
        System.out.println("Current Project: " + projectManager.GetProject().GetName());
        System.out.println("Project Manager: " + projectManager.GetName());
    }

    public ProjectManager GetProjectManager()
    {
        return projectManager;
    }

    protected void PrintHeirarchyHelper(int depth)
    {
        System.out.print("\t".repeat(depth));
        System.out.println(" - " + GetName());
    }
}
