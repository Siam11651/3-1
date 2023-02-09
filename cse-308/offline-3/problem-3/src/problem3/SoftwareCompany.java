package problem3;

public class SoftwareCompany extends Component
{
    public SoftwareCompany(String name)
    {
        super(name);
    }

    public void PrintDetails()
    {
        System.out.println("Software Company Name: " + GetName());
        System.out.println("Number of Projects: " + GetChildren().size());
    }

    protected void PrintHeirarchyHelper(int depth)
    {
        System.out.print("\t".repeat(depth));
        System.out.println(" - " + GetName());

        for(int i = 0; i < GetChildren().size(); ++i)
        {
            GetChildren().get(i).PrintHeirarchyHelper(depth + 1);
        }
    }
}
