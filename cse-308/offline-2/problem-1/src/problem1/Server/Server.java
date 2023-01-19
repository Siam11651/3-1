package problem1.Server;

import java.util.Vector;
import problem1.User.User;
import problem1.State.ServerState;

public abstract class Server
{
    protected Vector<User> users;
    protected ServerState previousState;
    protected ServerState currentState;

    public Server()
    {
        users = new Vector<>();
    }

    public abstract void Attach(User user);
    public abstract boolean Detach(String name);
    public abstract void NotifyAllUsers();

    public void SetCurrentState(ServerState state)
    {
        previousState = currentState;
        currentState = state;

        NotifyAllUsers();
    }

    public ServerState GetCurrentState()
    {
        return currentState;
    }

    public ServerState GetPreviousState()
    {
        return previousState;
    }
}
