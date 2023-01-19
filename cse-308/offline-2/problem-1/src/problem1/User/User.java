package problem1.User;

import problem1.Server.Server;
import problem1.State.UserState;

public abstract class User
{
    protected Server server;
    protected UserState state;
    protected String name;

    public User(Server server, String name)
    {
        this.server = server;
        this.name = name;
        state = UserState.FULL_USAGE;
    }

    public Server GetServer()
    {
        return server;
    }

    public void SetState(UserState state)
    {
        this.state = state;
    }

    public UserState GetState()
    {
        return state;
    }

    public String GetName()
    {
        return name;
    }

    public abstract void Notify();
}