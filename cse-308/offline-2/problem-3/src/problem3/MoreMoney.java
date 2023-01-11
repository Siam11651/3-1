package problem3;

class MoreMoney extends State
{
    private int extra;

    public MoreMoney(VendingMachine vendingMachine, int extra)
    {
        super(vendingMachine);

        this.extra = extra;
    }

    @Override
    public void InsertMoney()
    {

    }

    @Override
    public void ReturnMoney()
    {
        System.out.println("Extra by: " + extra + ", returning...");

        vendingMachine.SetState(new Transaction(vendingMachine));
    }

    @Override
    public void Dispense()
    {
        
    }
}
