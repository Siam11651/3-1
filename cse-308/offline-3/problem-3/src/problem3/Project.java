package problem3;

public class Project extends Component
{
    private SoftwareCompany softwareCompany;

    public Project(String name, SoftwareCompany softwareCompany)
    {
        super(name);

        this.softwareCompany = softwareCompany;
    }

    public void PrintDetails()
    {
        if(GetChildren().size() == 1)
        {
            System.out.println("Project Name: " + GetName());
            System.out.println("Software Company Name: " + softwareCompany.GetName());
            System.out.println("Project Manager Name: " + GetChildren().get(0).GetName());
            System.out.println("Number of Developers: " + GetChildren().get(0).GetChildren().size());
        }
        else if(GetChildren().size() > 1)
        {
            System.err.println("Project cannot have more than one manager");
        }
        else
        {
            System.err.println("Project must have atleast one manager");
        }
    }

    public SoftwareCompany GetSoftwareCompany()
    {
        return softwareCompany;
    }

    protected void PrintHeirarchyHelper(int depth)
    {
        GetChildren().get(0).PrintHeirarchyHelper(depth);
    }
}
