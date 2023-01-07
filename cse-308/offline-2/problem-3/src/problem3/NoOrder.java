package problem3;

class NoOrder extends State
{
    public NoOrder(VendingMachine vendingMachine)
    {
        super(vendingMachine);
    }

    @Override
    public void Simulate()
    {
        System.out.println("No Product Left. Returning money");
        vendingMachine.SetState(new TakeOrder(vendingMachine));
    }
}
