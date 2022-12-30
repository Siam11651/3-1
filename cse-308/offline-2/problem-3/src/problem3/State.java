package problem3;

abstract class State
{
    protected VendingMachine vendingMachine;

    public State(VendingMachine vendingMachine)
    {
        this.vendingMachine = vendingMachine;
    }

    public abstract void Simulate();
}
