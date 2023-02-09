package problem3;

import java.util.Scanner;

public class Main
{
    public static void main(String[] args)
    {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Set project name:");

        String name = scanner.nextLine();
        SoftwareCompany softwareCompany = new SoftwareCompany(name);

        while(true)
        {
            System.out.println("Add project? [y/n]");

            name = scanner.nextLine();

            if(name.equalsIgnoreCase("y"))
            {
                System.out.println("Set project name:");

                name = scanner.nextLine();
                Project project = new Project(name, softwareCompany);

                System.out.println("Set project manager:");

                name = scanner.nextLine();
                ProjectManager projectManager = new ProjectManager(name, project);
                project.AddChild(projectManager);
                softwareCompany.AddChild(project);

                while(true)
                {
                    System.out.println("Add developer? [y/n]");

                    name = scanner.nextLine();

                    if(name.equalsIgnoreCase("y"))
                    {
                        System.out.println("Set developer name:");

                        name = scanner.nextLine();

                        Developer developer = new Developer(name, projectManager);

                        projectManager.AddChild(developer);
                    }
                    else
                    {
                        break;
                    }
                }
            }
            else
            {
                break;
            }
        }

        scanner.close();
    }
}
