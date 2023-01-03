package problem1.User;

import java.util.Scanner;

import problem1.Server.Server;
import problem1.State.ServerState;
import problem1.State.UserState;

public class PremiumUser extends User
{
    public PremiumUser(Server server, String name)
    {
        super(server, name);
    }

    public void Notify()
    {
        ServerState previousState = server.GetPreviousState();
        ServerState currentState = server.GetCurrentState();
        
        if(previousState == ServerState.OPERATIONAL && currentState == ServerState.PARTIALLY_DOWN)
        {
            System.out.println("Choices:");
            System.out.println("[1] Use service from ABC and DEF");
            System.out.println("[2] Use service from DEF");

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
        else if(previousState == ServerState.OPERATIONAL && currentState == ServerState.FULLY_DOWN)
        {
            state = UserState.FULL_USAGE_OTHER;
        }
        else if(previousState == ServerState.PARTIALLY_DOWN && currentState == ServerState.FULLY_DOWN)
        {
            if(state == UserState.PARTIAL_USAGE)
            {
                state = UserState.FULL_USAGE_OTHER;
            }
        }
        else if((previousState == ServerState.PARTIALLY_DOWN || previousState == ServerState.FULLY_DOWN) && currentState == ServerState.OPERATIONAL)
        {
            state = UserState.FULL_USAGE;
        }

        if(state == UserState.FULL_USAGE)
        {

        }
        else if(state == UserState.PARTIAL_USAGE)
        {

        }
        else
        {

        }
    }
}