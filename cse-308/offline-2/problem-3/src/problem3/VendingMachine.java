package problem3;

class VendingMachine
{
    private State state;
    private int count, price;
    
    public VendingMachine(int price, int count)
    {
        this.price = price;

        SetCount(count);

        if(count > 0)
        {
            SetState(new TakeOrder(this));
        }
        else
        {
            SetState(new NoOrder(this));
        }
    }

    public int GetPrice()
    {
        return price;
    }

    public void SetCount(int count)
    {
        this.count = count;
    }

    public int GetCount()
    {
        return count;
    }

    public void Simulate()
    {
        while(true)
        {
            state.Simulate();
        }
    }

    public void SetState(State state)
    {
        this.state = state;
    }
}
