package problem3;

class TakeOrder extends State
{
    public TakeOrder(VendingMachine vendingMachine)
    {
        super(vendingMachine);
    }

    @Override
    public void Simulate()
    {
        System.out.println("Taking money: ");

        int money = Scanner.stdin.nextInt();

        if(vendingMachine.GetCount() > 0)
        {
            if(money > vendingMachine.GetPrice())
            {
                vendingMachine.SetState(new MoreMoney(vendingMachine, money - vendingMachine.GetPrice()));
            }
            else if(money == vendingMachine.GetPrice())
            {
                vendingMachine.SetState(new Transaction(vendingMachine));
            }
            else
            {
                vendingMachine.SetState(new LessMoney(vendingMachine, vendingMachine.GetPrice() - money));
            }
        }
        else
        {
            vendingMachine.SetState(new NoOrder(vendingMachine));
        }
    }
}
