package problem1.User;

import java.util.Scanner;

import problem1.Server.Server;
import problem1.State.ServerState;
import problem1.State.UserState;

public class RegularUser extends User
{
    private Scanner scanner;

    public RegularUser(Server server, String name)
    {
        super(server, name);

        scanner = new Scanner(System.in);
    }

    public void Notify()
    {
        System.out.println("Notifying regular user " + name);

        ServerState previousState = server.GetPreviousState();
        ServerState currenState = server.GetCurrentState();

        if(previousState == ServerState.OPERATIONAL && currenState == ServerState.PARTIALLY_DOWN)
        {
            System.out.println("Choices:");
            System.out.println("[1] Use limited service from ABC");
            System.out.println("[2] Pay $20/hour and get service from DEF");

            while(true)
            {
                char option = scanner.next().charAt(0);

                if(option == '1')
                {
                    state = UserState.PARTIAL_USAGE;

                    break;
                }
                else if(option == '2')
                {
                    state = UserState.FULL_USAGE_OTHER;

                    break;
                }
                else
                {
                    System.out.println("Invalid Input, Retry");
                }
            }
        }
        else if(previousState == ServerState.OPERATIONAL && currenState == ServerState.FULLY_DOWN)
        {
            System.out.println("Choices:");
            System.out.println("[1] Pay $20/hour and use service from DEF");
            System.out.println("[2] Do not pay");

            while(true)
            {
                char option = scanner.next().charAt(0);

                if(option == '1')
                {
                    state = UserState.FULL_USAGE_OTHER;

                    break;
                }
                else if(option == '2')
                {
                    state = UserState.NO_SERVICE;

                    break;
                }
                else
                {
                    System.out.println("Invalid Input, Retry");
                }
            }
        }
        else if(previousState == ServerState.PARTIALLY_DOWN && currenState == ServerState.FULLY_DOWN)
        {
            if(state == UserState.PARTIAL_USAGE)
            {
                System.out.println("Choices:");
                System.out.println("[1] Pay $20/hour and use service from DEF");
                System.out.println("[2] Do not pay");

                while(true)
                {
                    char option = scanner.next().charAt(0);

                    if(option == '1')
                    {
                        state = UserState.FULL_USAGE_OTHER;

                        break;
                    }
                    else if(option == '2')
                    {
                        state = UserState.NO_SERVICE;

                        break;
                    }
                    else
                    {
                        System.out.println("Invalid Input, Retry");
                    }
                }
            }
        }
        else if((previousState == ServerState.PARTIALLY_DOWN || previousState == ServerState.FULLY_DOWN) && currenState == ServerState.OPERATIONAL)
        {
            if(state == UserState.FULL_USAGE_OTHER)
            {
                System.out.println("Total bill of regular user " + name + " is \'x\'");
            }

            state = UserState.FULL_USAGE;
        }
        else if(previousState == ServerState.FULLY_DOWN && currenState == ServerState.PARTIALLY_DOWN)
        {
            if(state == UserState.NO_SERVICE)
            {
                System.out.println("Choices:");
                System.out.println("[1] Use limited service from ABC");
                System.out.println("[2] Use no service");

                while(true)
                {
                    char option = scanner.next().charAt(0);

                    if(option == '1')
                    {
                        state = UserState.PARTIAL_USAGE;

                        break;
                    }
                    else if(option == '2')
                    {
                        break;
                    }
                    else
                    {
                        System.out.println("Invalid Input, Retry");
                    }
                }
            }
        }

        if(state == UserState.FULL_USAGE)
        {
            System.out.println("Regular user " + name + " using ABC fully");
        }
        else if(state == UserState.PARTIAL_USAGE)
        {
            System.out.println("Regular user " + name + " using partially down ABC");
        }
        else if(state == UserState.FULL_USAGE_OTHER)
        {
            System.out.println("Regular user " + name + " using DEF fully");
        }
        else
        {
            System.out.println("Regular user " + name + " under no service");
        }
    }

    public void Close()
    {
        scanner.close();
    }
}