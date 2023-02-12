package problem3;

import java.util.Scanner;

public class Main
{
    public static void main(String[] args)
    {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Set company name:");

        String name = scanner.nextLine();
        SoftwareCompany softwareCompany = new SoftwareCompany(name);

        while(true)
        {
            System.out.println("[1] Add project");
            System.out.println("[2] Remove project");

            name = scanner.nextLine();

            if(name.equalsIgnoreCase("1"))
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
                    System.out.println("[1] Add Developer");
                    System.out.println("[2] Remove Developer");

                    name = scanner.nextLine();

                    if(name.equalsIgnoreCase("1"))
                    {
                        System.out.println("Set developer name:");

                        name = scanner.nextLine();

                        Developer developer = new Developer(name, projectManager);

                        projectManager.AddChild(developer);
                    }
                    else if(name.equalsIgnoreCase("2"))
                    {
                        System.out.println("Set developer index:");

                        int index = scanner.nextInt();

                        projectManager.RemoveChild(index);
                    }
                    else
                    {
                        break;
                    }
                }
            }
            else if(name.equals("2"))
            {
                System.out.println("Set project index:");
                
                int index = scanner.nextInt();

                softwareCompany.RemoveChild(index);
            }
            else
            {
                break;
            }
        }

        softwareCompany.PrintHeirarchy();

        scanner.close();
    }
}
