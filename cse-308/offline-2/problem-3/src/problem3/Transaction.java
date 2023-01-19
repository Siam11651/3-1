package problem3;

class Transaction extends State
{
    public Transaction(VendingMachine vendingMachine)
    {
        super(vendingMachine);
    }

    @Override
    public void InsertMoney()
    {

    }

    @Override
    public void ReturnMoney()
    {

    }

    @Override
    public void Dispense()
    {
        System.out.println("Dispensing product");
        vendingMachine.SetCount(vendingMachine.GetCount() - 1);

        if(vendingMachine.GetCount() > 0)
        {
            vendingMachine.SetState(new TakeOrder(vendingMachine));
        }
        else
        {
            vendingMachine.SetState(new NoOrder(vendingMachine));
        }
    }
}
