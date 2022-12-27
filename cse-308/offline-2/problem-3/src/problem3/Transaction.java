package problem3;

class Transaction extends State
{
    public Transaction(VendingMachine vendingMachine)
    {
        super(vendingMachine);
    }

    @Override
    public void Next()
    {
        vendingMachine.SetCount(vendingMachine.GetCount() - 1);

        if(vendingMachine.GetCount() == 0)
        {
            vendingMachine.SetState(new NoOrder(vendingMachine));
        }
        else
        {
            vendingMachine.SetState(new TakeOrder(vendingMachine));
        }
    }
}
