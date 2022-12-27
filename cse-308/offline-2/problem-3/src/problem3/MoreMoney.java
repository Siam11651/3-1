package problem3;

class MoreMoney extends State
{
    private int extra;

    public MoreMoney(VendingMachine vendingMachine, int extra)
    {
        super(vendingMachine);
    }

    @Override
    public void Next()
    {
        System.out.println("Extra by: " + extra + ", returning...");

        vendingMachine.SetState(new Transaction(vendingMachine));
    }
}
