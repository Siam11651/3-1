package problem1.Server;

import problem1.User.User;
import problem1.State.ServerState;

public class ABCServer extends Server
{
    public ABCServer()
    {
        currentState = ServerState.OPERATIONAL;
    }

    public void Attach(User user)
    {
        users.add(user);
    }

    public boolean Detach(String name)
    {
        for(int i = 0; i < users.size(); ++i)
        {
            if(name.equalsIgnoreCase(users.get(i).GetName()))
            {
                users.remove(i);

                return true;
            }
        }

        return false;
    }

    public void NotifyAllUsers()
    {
        for(int i = 0; i < users.size(); ++i)
        {
            users.get(i).Notify();
        }
    }
}
