package problem3;

class NoOrder extends State
{
    public NoOrder(VendingMachine vendingMachine)
    {
        super(vendingMachine);
    }

    @Override
    public void Next()
    {
        System.out.println("No Product Left");
    }
}
