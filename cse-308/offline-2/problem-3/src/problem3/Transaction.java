package problem3;

class Transaction extends State
{
    public Transaction(VendingMachine vendingMachine)
    {
        super(vendingMachine);
    }

    @Override
    public void Simulate()
    {
        System.out.println("Extracting product");
        vendingMachine.SetCount(vendingMachine.GetCount() - 1);
        vendingMachine.SetState(new TakeOrder(vendingMachine));
    }
}
