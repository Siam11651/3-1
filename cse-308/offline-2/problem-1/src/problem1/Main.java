package problem1;

import java.util.Scanner;

import problem1.Server.ABCServer;
import problem1.State.ServerState;
import problem1.User.PremiumUser;
import problem1.User.RegularUser;

public class Main
{
    public static void main(String[] args)
    {
        ABCServer abcServer = new ABCServer();
        RegularUser regularUser = new RegularUser(abcServer, "regular user");
        PremiumUser premiumUser = new PremiumUser(abcServer, "premium user");

        abcServer.Attach(premiumUser);
        abcServer.Attach(regularUser);

        boolean run = true;
        Scanner scanner = new Scanner(System.in);
        
        while(run)
        {
            System.out.println("Change server state:");
            System.out.println("[1] Operational");
            System.out.println("[2] Partially Down");
            System.out.println("[3] Fully Down");
            System.out.println("[4] Exit");

            while(true)
            {
                char option = scanner.next().charAt(0);

                if(option == '1')
                {
                    
                    abcServer.SetCurrentState(ServerState.OPERATIONAL);

                    break;
                }
                else if(option == '2')
                {   
                    abcServer.SetCurrentState(ServerState.PARTIALLY_DOWN);

                    break;
                }
                else if(option == '3')
                {
                    abcServer.SetCurrentState(ServerState.FULLY_DOWN);

                    break;
                }
                else if(option == '4')
                {
                    run = false;

                    break;
                }
                else
                {
                    System.out.println("Invalid Input, Retry");
                }
            }
        }

        regularUser.Close();
        premiumUser.Close();
        scanner.close();
    }
}
