package problem1.User;

import java.util.Scanner;

import problem1.Server.Server;
import problem1.State.ServerState;
import problem1.State.UserState;

public class RegularUser extends User
{
    public RegularUser(Server server, String name)
    {
        super(server, name);
    }

    public void Notify()
    {
        ServerState previousState = server.GetPreviousState();
        ServerState currenState = server.GetCurrentState();

        if(previousState == ServerState.OPERATIONAL && currenState == ServerState.PARTIALLY_DOWN)
        {
            System.out.println("Choices:");
            System.out.println("[1] Use limited service from ABC");
            System.out.print("[2] Pay $20/hour and get service from DEF");

            Scanner scanner = new Scanner(System.in);

            while(true)
            {
                char option = (char)scanner.nextByte();

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

            scanner.close();
        }
        else if(previousState == ServerState.OPERATIONAL && currenState == ServerState.FULLY_DOWN)
        {
            System.out.println("Choices:");
            System.out.println("[1] Pay $20/hour and use service from DEF");
            System.out.println("[2] Do not pay");

            Scanner scanner = new Scanner(System.in);

            while(true)
            {
                char option = (char)scanner.nextByte();

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
                    System.out.print("Invalid Input, Retry");
                }
            }

            scanner.close();
        }
        else if(previousState == ServerState.PARTIALLY_DOWN && currenState == ServerState.FULLY_DOWN)
        {
            if(state == UserState.PARTIAL_USAGE)
            {
                System.out.println("Choices:");
                System.out.println("[1] Pay $20/hour and use service from DEF");
                System.out.println("[2] Do not pay");

                Scanner scanner = new Scanner(System.in);

                while(true)
                {
                    char option = (char)scanner.nextByte();

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
                        System.out.print("Invalid Input, Retry");
                    }
                }

                scanner.close();
            }
        }
        else if((previousState == ServerState.PARTIALLY_DOWN || previousState == ServerState.FULLY_DOWN) && currenState == ServerState.OPERATIONAL)
        {
            if(state == UserState.FULL_USAGE_OTHER)
            {
                // total bill
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

                Scanner scanner = new Scanner(System.in);

                while(true)
                {
                    char option = (char)scanner.nextByte();

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

                scanner.close();
            }
        }

        if(state == UserState.FULL_USAGE)
        {

        }
        else if(state == UserState.PARTIAL_USAGE)
        {

        }
        else if(state == UserState.FULL_USAGE_OTHER)
        {

        }
        else
        {
            
        }
    }
}