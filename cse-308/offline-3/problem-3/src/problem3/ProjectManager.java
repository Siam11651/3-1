package problem3;

public class ProjectManager extends Component
{
    private Project project;

    public ProjectManager(String name, Project project)
    {
        super(name);

        this.project = project;
    }

    public void PrintDetails()
    {
        System.out.println("Name: " + GetName());
        System.out.println("Role: Project Manager");
        System.out.println("Current Project: " + project.GetName());
        System.out.println("Number of Supervisees: " + GetChildren().size());
    }

    public Project GetProject()
    {
        return project;
    }

    protected void PrintHeirarchyHelper(int depth)
    {
        System.out.print("\t".repeat(depth));
        System.out.println(" - " + GetName() + " (" + project.GetName() + ")");

        for(int i = 0; i < GetChildren().size(); ++i)
        {
            GetChildren().get(i).PrintHeirarchyHelper(depth + 1);
        }
    }
}
